-- Path scripthooked:lua\\homigrad\\cl_camera.lua"
-- Scripthooked by ???
local view = render.GetViewSetup()
local whitelist = {
	weapon_physgun = true,
	gmod_tool = true,
	gmod_camera = true,
	weapon_crowbar = true,
	weapon_pistol = true,
	weapon_crossbow = true
}

local vecZero, vecFull = Vector(0.001, 0.001, 0.001), Vector(1, 1, 1)
local lply = LocalPlayer()
local CameraTransformApply
local hook_Run = hook.Run
local result
local util_TraceLine, util_TraceHull = util.TraceLine, util.TraceHull
local math_Clamp = math.Clamp
local Round, Max, abs = math.Round, math.max, math.abs
local compression = 12
local traceBuilder = {
	filter = lply,
	mins = -Vector(5, 5, 5),
	maxs = Vector(5, 5, 5),
	mask = MASK_SOLID,
	collisiongroup = COLLISION_GROUP_DEBRIS
}

local anglesYaw = Angle(0, 0, 0)
local vecVel = Vector(0, 0, 0)
local angVel = Angle(0, 0, 0)
local limit = 4
local sideMul = 5
local eyeAngL = Angle(0, 0, 0)
local IsValid = IsValid
local hg_fov = ConVarExists("hg_fov") and GetConVar("hg_fov") or CreateClientConVar("hg_fov", "70", true, false, "changes fov to value", 75, 100)
local oldview = render.GetViewSetup()
local breathingMul = 0
local curTime = CurTime()
local curTime2 = CurTime()
diffpos = Vector(0, 0, 0)
diffang = Angle(0, 0, 0)
diffang2 = Angle(0, 0, 0)
diffvec = Vector(0, 0, 0)
diffvec2 = Vector(0, 0, 0)
diffvec3 = Vector(0, 0, 0)
offsetView = offsetView or Angle(0, 0, 0)
local swayAng = Angle(0, 0, 0)
hook.Add("Camera", "Weapon", function(...)
	wep = lply:GetActiveWeapon()
	if wep.Camera then return wep:Camera(...) end
end)

local TickInterval = engine.TickInterval
local function clamp(vecOrAng, val)
	vecOrAng[1] = math.Clamp(vecOrAng[1], -val, val)
	vecOrAng[2] = math.Clamp(vecOrAng[2], -val, val)
	vecOrAng[3] = math.Clamp(vecOrAng[3], -val, val)
end

function HGAddView(ply, origin, angles)
	if ply:Alive() then
		local organism = LocalPlayer().Organism or {}
		local adrenaline = organism.adrenaline or 0
		local brain = organism.brain or 0
		local disorientation = organism.disorientation or 0
		local pulse = organism.pulse or 70
		breathingMul = LerpFT(0.01, breathingMul, math.min(math.max(pulse / 100, 1) - 1, 3))
		local speedMul = breathingMul * 2 + 0.05 + brain * 5 + disorientation / 10
		curTime = curTime + (speedMul / 100 + 0.01) * FrameTime() / TickInterval()
		swayAng[3] = math.sin(curTime / 2) * speedMul + math.Rand(0, math.min(adrenaline, 0.5)) / 10
		swayAng[2] = math.cos(curTime / 2) * speedMul * math.sin(RealTime())
		swayAng[1] = math.sin(curTime * 2) * speedMul * math.cos(CurTime())
		suppressionVec = LerpVectorFT(0.01, suppressionVec, vecZero)
		suppressionDistAdd = suppressionDistAdd * 0.8
		suppressionDist = suppressionDist + suppressionDistAdd
		suppressionDist = LerpFT(0.01, suppressionDist, 0)
		origin:Add(suppressionVec * suppressionDist * 3)
		local dot = suppressionVec:GetNormalized():Dot(angles:Right())
		angles[3] = angles[3] + dot * suppressionDist * 60
		angles:Add(swayAng * 3)
		swayAng[3] = 0
		huyAng = AngleRand(-0.1, 0.1) * math.Rand(0, math.min(adrenaline, 10)) / 2
		huyAng[3] = 0
		ply:SetEyeAngles(ply:EyeAngles() + swayAng / 60 + huyAng)
		origin[3] = origin[3] + math.sin(curTime * 2) / 5 * speedMul
		origin[2] = origin[2] + math.cos(curTime / 4) / 10 * speedMul
		origin[1] = origin[1] + math.cos(curTime / 2) / 10 * speedMul
		local kachka = not IsValid(ply.FakeRagdoll) and math.min(diffvec:Length() / 6, 0.5) or 0
		kachka = kachka * ((organism.lleg or 0) + (organism.rleg or 0) + 2) * 0.5
		curTime2 = curTime2 + kachka / 20 * smooth_frameTime * (ply:OnGround() and 1 or 0.2)
		kachka = kachka * ((organism.lleg or 0) * 2 + (organism.rleg or 0) * 2 + 2) / 2
		swayAng[3] = 0 --math.cos(curTime2 * 4) * 2
		swayAng[2] = math.cos(curTime2 * 4) * 2
		swayAng[1] = math.sin(curTime2 * 8) * 2
		origin[3] = origin[3] + math.cos(curTime2 * 8) / 8 * kachka
		origin[2] = origin[2] + math.cos(curTime2 * 4) / 6 * kachka
		origin[1] = origin[1] + math.cos(curTime2 * 4) / 8 * kachka
		--if hg.weapons[ply:GetActiveWeapon()] then ply:SetEyeAngles(ply:EyeAngles() + swayAng / 60 * 2 * kachka) end
		--angles:Add(swayAng / 4)
	end
	return origin, angles
end

--LocalPlayer():ChatPrint(tostring(g_VR.active))
local lerpfovadd = 0
local CalcView
CalcView = function(ply, origin, angles, fov, znear, zfar)
	--if 1 then return end
	if g_VR and g_VR.active then return end
	if not IsValid(ply) or not ply:Alive() then return end
	--ply:SetMoveType(MOVETYPE_WALK)
	--ply:SetObserverMode(OBS_MODE_NONE)
	if not ply:LookupBone("ValveBiped.Bip01_Head1") then return end
	local firstPerson = GetViewEntity() == ply
	ply:ManipulateBoneScale(ply:LookupBone("ValveBiped.Bip01_Head1"), firstPerson and vecZero or vecFull)
	if not firstPerson or not ply:Alive() or IsValid(ply.FakeRagdoll) then return end
	local eye = ply:GetAttachment(ply:LookupAttachment("eyes"))
	if not eye then return end
	local eyePos, eyeAng = eye.Pos, eye.Ang
	if ply:InVehicle() then eyeAng = eyeAng + ply:GetVehicle():GetAngles() end
	local eyePos = eyePos + eyeAng:Forward() * -1 + vector_up * -2
	local vel = -ply:GetVelocity() / 200
	local velLen = vel:Length()
	eyePos:Add(VectorRand() * (velLen > 2 and (velLen - 2) / 10 or 0))
	clamp(vel, limit)
	vecVel = LerpFT(0.1, vecVel, vel)
	--eyePos:Add(vecVel)
	traceBuilder.start = origin
	traceBuilder.endpos = eyePos
	local trace = util_TraceHull(traceBuilder)
	local pos = origin - (lply:InVehicle() and eyePos or trace.HitPos)
	if not RENDERSCENE then
		local wep = ply:GetActiveWeapon()
		local eyeAngs = ply:EyeAngles()
		local oldviewa = oldview or view
		local oldorigin = originnew or ply:EyePos()
		oldviewa = not ply:Alive() and view or oldviewa
		local different = -(eyeAngs:Forward() - (eyeAnglesOld or eyeAngs):Forward()) / 2
		local _, localAng = WorldToLocal(vecZero, eyeAngs, vecZero, eyeAnglesOld or eyeAngs)
		diffpos = LerpVector(0.1 * (wep.Ergonomics or 1) ^ 2, diffpos, different / (FrameTime() / engine.TickInterval()))
		diffang = LerpAngle(0.1, diffang, localAng / (FrameTime() / engine.TickInterval()) / 1.5)
		diffang2 = LerpAngle(0.2, diffang2, localAng / (FrameTime() / engine.TickInterval()))
		diffvec = LerpVector(0.15, diffvec, (oldorigin - ply:EyePos()) / (FrameTime() / engine.TickInterval()))
		diffvec2 = LerpVector(0.8, diffvec2, (oldorigin - ply:EyePos()) / (FrameTime() / engine.TickInterval()))
		table.CopyFromTo(view, oldview)

		originnew = ply:EyePos()
		diffvec3[1] = 0
		diffvec3[3] = 0
		diffvec3[2] = diffvec:Dot(angles:Right())
		diffvec3:Rotate(view.angles)
		clamp(diffvec, 5)
		clamp(diffvec2, 1)
		clamp(diffvec3, 1)
		clamp(diffpos, 0.05)
		clamp(diffang, 2)
		clamp(diffang2, 5)
		offsetView[1] = math_Clamp(offsetView[1] + diffang2[1] / 12, -2, 2)
		offsetView[2] = math_Clamp(offsetView[2] + diffang2[2] / 12, -4, 4)
		eyeAnglesOld = eyeAngs
		local diffvecdot = diffvec:Dot(angles:Right()) * 2
		--angles[3] = angles[3] - diffang[2] * 2
		--angles[3] = angles[3] - diffvecdot
		angles[3] = angles[3] + (ply.lean or 0) * 10
		local asdAng = -(-diffang)
		asdAng[3] = 0
		--asdAng[2] = asdAng[2] + -diffvecdot / 2
		if IsValid(ply:GetActiveWeapon()) and hg.weapons[ply:GetActiveWeapon()] then
			local mul = 1 / math.Clamp(ply:GetActiveWeapon().Ergonomics or 1,1,1) / 3.5 * 1
			ply:SetEyeAngles(eyeAngs + asdAng * mul)
			angles:Add(asdAng * mul * 20)
		end
	end
	
	lerpfovadd = Lerp(0.01,lerpfovadd,(lply:IsSprinting() and lply:GetVelocity():LengthSqr() > 1500 and 10 or 0) - (lply.organism and ((lply.organism.immobilization / 4 or 0) - (lply.organism.adrenaline or 0) * 5) or 0) / 2)

	view.znear = 1
	view.zfar = zfar
	view.fov = hg_fov:GetInt() + lerpfovadd
	view.drawviewer = true
	view.origin = origin
	view.angles = angles

	result = hook_Run("Camera", pos, angles, view)
	view.origin:Add(diffvec3 * 0.1)
	--if not RENDERSCENE then
	view.origin, view.angles = HGAddView(ply, view.origin, view.angles)
	--end
	if result == view then
		traceBuilder.start = origin
		traceBuilder.endpos = view.origin
		local trace = util_TraceHull(traceBuilder)
		local pos = view.origin - (lply:InVehicle() and eyePos or trace.HitPos)
		view.origin = view.origin - pos
		return view
	end
	
	view.origin = origin - pos
	view.angles = angles
	wep = ply:GetActiveWeapon()
	if IsValid(wep) and whitelist[wep:GetClass()] then return end
	return view
end

hg.CalcView = CalcView
hook.Add("CalcView", "homigrad-view", CalcView)
local hook_Run = hook.Run
local render_RenderView = render.RenderView
local renderView = {
	x = 0,
	y = 0,
	drawhud = true,
	drawviewmodel = true,
	dopostprocess = true,
	drawmonitors = true,
	fov = 100
}

hook.Add("RenderScene", "jopa", function(pos, angle, fov)
	RENDERSCENE = true
	local view = CalcView(lply, pos, angle, fov)
	RENDERSCENE = nil
	if not view then return end
	renderView.w = ScrW()
	renderView.h = ScrH()
	renderView.fov = fov
	renderView.origin = view.origin
	renderView.angles = view.angle
	pcall(render_RenderView,renderView)
	return true
end)

