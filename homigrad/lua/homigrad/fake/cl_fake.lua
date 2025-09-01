-- Path scripthooked:lua\\homigrad\\fake\\cl_fake.lua"
-- Scripthooked by ???
local lply = LocalPlayer()
local att, ent, oldEntView
follow = follow or nil
local vecZero, vecFull, angZero = Vector(0, 0, 0), Vector(1, 1, 1), Angle(0, 0, 0)
local vecPochtiZero = Vector(0.1, 0.1, 0.1)
local view = {}
local math_Clamp = math.Clamp
local ang
local att_Ang, ot
local angEye = Angle(0, 0, 0)
local firstPerson
hook.Add("InputMouseApply", "asdasd", function(cmd, x, y, angle)
	if math.abs(x + y) > 0 and cmd:GetForwardMove() == 0 and LocalPlayer():Alive() and LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP then
		--cmd:SetForwardMove(-7)
	end
	if not IsValid(LocalPlayer()) or not LocalPlayer():Alive() then return end
	if not IsValid(follow) then return end
	att = follow:GetAttachment(follow:LookupAttachment("eyes"))
	local attang = att.Ang
	local angRad = math.rad(attang[3])
	local newX = x * math.cos(angRad) - y * math.sin(angRad)
	local newY = x * math.sin(angRad) + y * math.cos(angRad)
	--angle.pitch = math.Clamp( angle.pitch + newY / 50, -89, 89 )
	--angle.yaw = angle.yaw - newX / 50
	ot = angle - attang
	ot:Normalize()
	ot[2] = math.Clamp(ot[2], -45, 45)
	ot[1] = math.Clamp(ot[1], -45, 45)
	angle = attang + ot
	angle.pitch = math.Clamp(angle.pitch + newY / 50, -89, 89)
	angle.yaw = angle.yaw - newX / 50
	--cmd:SetViewAngles(angle)
	--return true
end)
local fakeTimer = CurTime()
local hg_cshs_fake = ConVarExists("hg_cshs_fake") and GetConVar("hg_cshs_fake") or CreateConVar("hg_cshs_fake", 1, FCVAR_REPLICATED, "fake from cshs", 0, 1)

local k = 0
local wepPosLerp = Vector(0,0,0)
local CalcView

CalcView = function(ply, origin, angles, fov, znear, zfar)
	if not ply:Alive() and ((fakeTimer and fakeTimer < CurTime()) or ply:KeyPressed(IN_RELOAD)) then
		fakeTimer = nil
		follow = nil
		if IsValid(ply.FakeRagdoll) then
			ply.FakeRagdoll.ply = nil
			ply.FakeRagdoll = nil
		end
		ply:BoneScaleChange()
		return
	end
	if not ply:Alive() and hg.DeathCam and hg.DeathCamAvailable(ply) then return hg.DeathCam(ply,origin,angles,fov,znear,zfar) end
	if not IsValid(ply) then return end
	if not IsValid(follow) then return end
	if not follow:LookupBone("ValveBiped.Bip01_Head1") then return end
	
	view.fov = GetConVar("hg_fov"):GetInt()
	ent = GetViewEntity()
	firstPerson = ent == lply
	follow:ManipulateBoneScale(follow:LookupBone("ValveBiped.Bip01_Head1"), firstPerson and vecZero or vecFull, true)
	
	if not firstPerson then return end

	att = follow:GetAttachment(follow:LookupAttachment("eyes"))
	ang = lply:EyeAngles()
	ang:Normalize()
	
	att_Ang = att.Ang
	att_Ang:Normalize()
	
	ot = ang - att_Ang
	ot:Normalize()

	ot[2] = math.Clamp(ot[2], -45, 45)
	ot[1] = math.Clamp(ot[1], -45, 45)

	angEye = att_Ang + ot
	angEye:Normalize()
	--att_Ang[1] = angEye[1]
	angEye[3] = att_Ang[3]
	
	if hg_cshs_fake:GetBool() then
		view.angles = att_Ang--angEye
	else
		view.angles = angEye
	end
	view.origin = att.Pos + att_Ang:Up() * -3
	view.angles:Add(LocalPlayer():GetViewPunchAngles())
	view.origin, view.angles = HGAddView(lply, view.origin, view.angles)
	view.znear = 1
	
	local wep = ply:GetActiveWeapon()
	k = Lerp(0.25,k,ply:KeyDown(IN_JUMP) and 1 or 0)
	if IsValid(wep) and wep.GetMuzzleAtt and ply:KeyDown(IN_ATTACK2) then
		local atta = wep:GetMuzzleAtt(nil,wep:HasAttachment("sight"),false)
		local wepAng,wepPos = atta.Ang,atta.Pos
		wepAng:RotateAroundAxis(wepAng:Forward(), -90)
		local up, right, forward = wepAng:Up(), wepAng:Right(), wepAng:Forward()
		local addPos = wep.Anim_RecoilCameraZoom * (wep.holdtype == "revolver" and 4 or 2) / 2
		local recoilZoomPos = up * addPos[1] + right * addPos[2] + forward * addPos[3]
	
		local posZoom = wep:GetZoomPos(wepAng,wepPos,vector_origin,view)
		
		wep.Anim_RecoilCameraZoom = LerpVector(0.05, wep.Anim_RecoilCameraZoom, wep.Anim_RecoilCameraZoomSet)
		wep.Anim_RecoilCameraZoomSet = LerpVector(0.3, vector_origin, wep.Anim_RecoilCameraZoomSet)
		local animpos = -(wep.weaponAngLerp or Angle(0, 0, 0))[1] / 20
		local eyeSpray = -(-wep.EyeSpray)
		local animposSpray, spray = wep:GetCameraSprayValues(ply, eyeSpray, animpos)
		
		view.origin = LerpVector(k,att.Pos + att_Ang:Up() * -3,view.origin - posZoom + animposSpray * 150 + spray * 100)
		view.angles = view.angles - eyeSpray * 10 - GetViewPunchAngles()
	end

	return view
end

hook.Add("CalcView", "zzFake", CalcView)

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

hook.Add("RenderScene", "jopa2", function(pos, angle, fov)
	if true then return end
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

--сделать чтобы в фейке можно было целиться?
local net_ReadEntity, net_ReadTable = net.ReadEntity, net.ReadTable
local hook_Run = hook.Run
net.Receive("Player Ragdoll", function()
	local ply = net_ReadEntity()
	local ragdoll = net_ReadEntity() --,net_ReadTable()
	ragdoll = IsValid(ragdoll) and ragdoll
	if ply == lply then follow = IsValid(follow) and follow or ragdoll end

	if ragdoll then
		--ragdoll:SetPredictable(true)--causes ragdoll to shake bruh lol
		ragdoll.ply = ply

		ragdoll:CallOnRemove("RagdollRemove",function()
			hook.Run("RagdollRemove",ply,ragdoll)
		end)

		ply.FakeRagdoll = ragdoll
	else
		ply.FakeRagdoll = nil
	end
	
	if IsValid(ply) and ply.BoneScaleChange then ply:BoneScaleChange() end

	hook_Run("Fake", ply, follow)
end)

local vec123 = Vector(0,0,0)
local entityMeta = FindMetaTable("Entity")

function entityMeta:GetPlayerColor()
	return self:GetNWVector("PlayerColor",vec123)
end

function entityMeta:GetPlayerName()
	return self:GetNWString("PlayerName","Unknown body")
end

local playerMeta = FindMetaTable("Player")

function playerMeta:GetPlayerViewEntity()
	return (IsValid(self:GetNWEntity("spect")) and self:GetNWEntity("spect")) or (IsValid(self.FakeRagdoll) and self.FakeRagdoll) or self
end

function playerMeta:GetPlayerName()
	return self:GetNWString("PlayerName","Unknown body")
end

function playerMeta:IsFirstPerson()
	if IsValid(self:GetNWEntity("spect",spect or NULL)) then
		return self:GetNWInt("viewmode",viewmode or 1) == 1
	else
		return (GetViewEntity() == self)
	end
end

local ents_FindByClass = ents.FindByClass
local player_GetAll = player.GetAll
function playerMeta:BoneScaleChange()
	local firstPerson = LocalPlayer():IsFirstPerson()
	local viewEnt = LocalPlayer():GetPlayerViewEntity()
	
	for i,ent in ipairs(ents_FindByClass("prop_ragdoll")) do
		if not ent:LookupBone("ValveBiped.Bip01_Head1") then continue end
		if ent == viewEnt then
			ent:ManipulateBoneScale(ent:LookupBone("ValveBiped.Bip01_Head1"),firstPerson and vecPochtiZero or vecFull)
		else
			ent:ManipulateBoneScale(ent:LookupBone("ValveBiped.Bip01_Head1"),vecFull)
		end
	end

	for i,ent in ipairs(player_GetAll()) do
		if not ent:LookupBone("ValveBiped.Bip01_Head1") then continue end
		if ent == viewEnt then
			ent:ManipulateBoneScale(ent:LookupBone("ValveBiped.Bip01_Head1"),firstPerson and vecPochtiZero or vecFull)
		else
			ent:ManipulateBoneScale(ent:LookupBone("ValveBiped.Bip01_Head1"),vecFull)
		end
	end
end

hook.Add("PostCleanupMap","wtfdude",function()
	LocalPlayer():BoneScaleChange()
end)

hook.Add("Player Spawn", "Fake", function(ply)
	if ply == lply then
		follow = nil

		timer.Simple(0.1 * math.max(ply:Ping() / 50,1),function()
			ply:BoneScaleChange()
		end)
	end
	if IsValid(ply.FakeRagdoll) then
		ply.FakeRagdoll.ply = nil
		ply.FakeRagdoll = nil
	end
end)

hook.Add("Player Death", "Fake", function(ply)
	--if not IsValid(ply.FakeRagdoll) then return end
	
	hook_Run("FakeDeath", ply, ply.FakeRagdoll)
	
	if ply != lply then return end

	fakeTimer = CurTime() + 4
	
	timer.Simple(0.1 * math.max(ply:Ping() / 50,1),function()
		ply:BoneScaleChange()
	end)
end)

local left = Material("vgui/gradient-l")
local white2 = Color(150, 150, 150)
local w, h
local math_Clamp = math.Clamp
local math_max, math_min = math.max, math.min
local k1, k2, k3, k4
local hg_show_hitposragdolleyes = ConVarExists("hg_show_hitposragdolleyes") and GetConVar("hg_show_hitposragdolleyes") or CreateClientConVar("hg_show_hitposragdolleyes", "0", false, false, "enables crosshair in ragdoll, only for admins")
local sv_cheats = GetConVar("sv_cheats")
local tr = {
	filter = {lply}
}

local util_TraceLine = util.TraceLine
local vecUp = Vector(1, 0, 0)
hook.Add("RenderScreenspaceEffects", "gg", function()
	if IsValid(follow) and hg_show_hitposragdolleyes:GetBool() and (sv_cheats:GetBool() or lply:IsAdmin() or lply:IsSuperAdmin()) then
		local att = follow:GetAttachment(follow:LookupAttachment("eyes"))
		tr.start = att.Pos
		local dir = vecZero
		dir:Set(vecUp)
		dir:Rotate(lply:EyeAngles())
		tr.endpos = att.Pos + dir * 8000
		tr.filter[2] = follow
		local pos = util_TraceLine(tr).HitPos:ToScreen()
		draw.RoundedBox(0, pos.x - 2, pos.y - 2, 4, 4, white2)
	end

	if not firstPerson or not IsValid(follow) then return end
	if true then return end
	ot = angEye - lply:EyeAngles()
	ot:Normalize()
	k1 = math_Clamp(ot[2] / -30, 0, 1)
	k2 = math_Clamp(ot[2] / 30, 0, 1)
	k1 = math_min(math_max(k1 - 0.2, 0) / 0.8 * 2, 1)
	k2 = math_min(math_max(k2 - 0.2, 0) / 0.8 * 2, 1)
	k3 = math_Clamp(ot[1] / 30, 0, 1)
	k4 = math_Clamp(ot[1] / -30, 0, 1)
	k3 = math_min(math_max(k3 - 0.2, 0) / 0.8 * 2, 1)
	k4 = math_min(math_max(k4 - 0.2, 0) / 0.8 * 2, 1)
	w, h = ScrW(), ScrH()
	--[[white.a = (k1 + k2) * 128
	s = h / 2 * (k1 + k2)

	draw.RoundedBox(s,w / 2 + k1 * -w / 2 + k2 * w / 2 - s / 2,h / 2 - s / 2,s,s,white)]]
	--
	surface.SetMaterial(left)
	surface.SetDrawColor(0, 0, 0, 255 * k1)
	surface.DrawTexturedRect(0, 0, w * 0.5, h)
	surface.SetDrawColor(0, 0, 0, 255 * k2)
	surface.DrawTexturedRectRotated(w - w * 0.5 / 2 + 1, h * 0.5, w * 0.5, h, 180)
	surface.SetDrawColor(0, 0, 0, 255 * k3)
	surface.DrawTexturedRectRotated(w * 0.5, h * 0.25 - 1, w * 0.5, h * 2, -90)
	surface.SetDrawColor(0, 0, 0, 255 * k4)
	surface.DrawTexturedRectRotated(w * 0.5, h * 0.75 + 1, w * 0.5, h * 2, 90)
end)

local override = {}
net.Receive("Override Spawn", function() override[net.ReadEntity()] = true end)
hook.Add("Player Spawn", "!Override", function(ply)
	if override[ply] then
		override[ply] = nil
		return false
	end
end)

hook.Add("Player Spawn", "zOverride", function(ply)
	if override[ply] then
		override[ply] = nil
		return false
	end
end)

hook.Add("PlayerFootstep", "CustomFootstep", function(ply) if IsValid(ply.FakeRagdoll) then return true end end)