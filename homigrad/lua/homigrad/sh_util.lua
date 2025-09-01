-- Path scripthooked:lua\\homigrad\\sh_util.lua"
-- Scripthooked by ???
local queue = {} -- i follow you
hg.prechachesound = hg.prechachesound or {}
function hg.GetCurrentCharacter(ent)
	if ent:IsPlayer() then
		if ent:GetNWBool("fake", false) then
			if IsValid(ent:GetNWEntity("Ragdoll", nil)) then
				return ent:GetNWEntity("Ragdoll", nil)
			else
				return ent
			end
		else
			return ent
		end
	end
end
function hg.RagdollOwner(ent)
	if ent:IsRagdoll() then
		if IsValid(ent:GetNWEntity("RagdollOwner", nil)) then
			return ent:GetNWEntity("RagdollOwner", nil)
		else
			return ent
		end
	end
	if ent:IsPlayer() then
		return ent
	end
end
function hg.PrecahceSound(name)
	if hg.prechachesound[name] then return end
	if not hg.initents then
		queue[#queue + 1] = name
	else
		game.GetWorld():EmitSound(name, 75, 100, 1, CHAN_AUTO, SND_STOP)
	end
	--hg.prechachesound[name] = true
end

hook.Add("Initialize", "homigrad-prechache", function()
	for i, name in pairs(queue) do
		game.GetWorld():EmitSound(name)
	end
end)

local mul = 1
smooth_frameTime = 1
local FrameTime, TickInterval = FrameTime, engine.TickInterval
local sv_cl_mul = 1
hook.Add("Think", "Mul lerp", function()
	mul = FrameTime() / TickInterval()
	if CLIENT then smooth_frameTime = Lerp(0.01, smooth_frameTime or 0, mul) end
	sv_cl_mul = SERVER and 1 or 66.7 / (1 / engine.AbsoluteFrameTime())
end)

local perf = physenv.GetPerformanceSettings()
perf.MaxVelocity = 100000 --default 2000
physenv.SetPerformanceSettings(perf)
--physenv.SetAirDensity(2)
--PrintTable(physenv.GetPerformanceSettings())
local Lerp, LerpVector, LerpAngle = Lerp, LerpVector, LerpAngle
local math_min = math.min
function LerpFT(lerp, source, set)
	return Lerp(math_min(lerp * mul, 1), source, set)
end

function LerpSVCL(lerp, source, set)
	return Lerp(math_min(lerp * sv_cl_mul, 1), source, set)
end

function LerpVectorFT(lerp, source, set)
	return LerpVector(math_min(lerp * mul, 1), source, set)
end

function LerpAngleFT(lerp, source, set)
	return LerpAngle(math_min(lerp * mul, 1), source, set)
end

local max, min = math.max, math.min
function util.halfValue(value, maxvalue, k)
	k = maxvalue * k
	return max(value - k, 0) / k
end

function util.halfValue2(value, maxvalue, k)
	k = maxvalue * k
	return min(value / k, 1)
end

function util.safeDiv(a, b)
	if a == 0 and b == 0 then
		return 0
	else
		return a / b
	end
end

function player.GetListByName(name)
	local list = {}
	if name == "^" then
		return
	elseif name == "*" then
		return player.GetAll()
	end

	for i, ply in pairs(player.GetAll()) do
		if string.find(string.lower(ply:Name()), string.lower(name)) then list[#list + 1] = ply end
	end
	return list
end

if CLIENT then
	local PUNCH_DAMPING = 9
	local PUNCH_SPRING_CONSTANT = 65
	local vp_punch_angle = Angle()
	local vp_punch_angle_velocity = Angle()
	local vp_punch_angle_last = vp_punch_angle
	hook.Add("Think", "viewpunch_think", function()
		if not vp_punch_angle:IsZero() or not vp_punch_angle_velocity:IsZero() then
			vp_punch_angle = vp_punch_angle + vp_punch_angle_velocity * FrameTime()
			local damping = 1 - (PUNCH_DAMPING * FrameTime())
			if damping < 0 then damping = 0 end
			vp_punch_angle_velocity = vp_punch_angle_velocity * damping
			local spring_force_magnitude = math.Clamp(PUNCH_SPRING_CONSTANT * FrameTime(), 0, 0.2 / FrameTime())
			vp_punch_angle_velocity = vp_punch_angle_velocity - vp_punch_angle * spring_force_magnitude
			local x, y, z = vp_punch_angle:Unpack()
			vp_punch_angle = Angle(math.Clamp(x, -89, 89), math.Clamp(y, -179, 179), math.Clamp(z, -89, 89))
		else
			vp_punch_angle = Angle()
			vp_punch_angle_velocity = Angle()
		end

		if vp_punch_angle:IsZero() and vp_punch_angle_velocity:IsZero() then return end
		if LocalPlayer():InVehicle() then return end
		LocalPlayer():SetEyeAngles(LocalPlayer():EyeAngles() + vp_punch_angle - vp_punch_angle_last)
		vp_punch_angle_last = vp_punch_angle
	end)

	function SetViewPunchAngles(angle)
		if not angle then
			print("[Local Viewpunch] SetViewPunchAngles called without an angle. wtf?")
			return
		end

		vp_punch_angle = angle
	end

	function SetViewPunchVelocity(angle)
		if not angle then
			print("[Local Viewpunch] SetViewPunchVelocity called without an angle. wtf?")
			return
		end

		vp_punch_angle_velocity = angle * 20
	end

	function Viewpunch(angle)
		if not angle then
			print("[Local Viewpunch] Viewpunch called without an angle. wtf?")
			return
		end

		vp_punch_angle_velocity = vp_punch_angle_velocity + angle * 20
	end

	function ViewPunch(angle)
		Viewpunch(angle)
	end

	function GetViewPunchAngles()
		return vp_punch_angle
	end

	function GetViewPunchVelocity()
		return vp_punch_angle_velocity
	end

	local angle_hitground = Angle(0, 0, 0)
	hook.Add("OnPlayerHitGround", "sadsafsafas", function(ply, water, floater, speed)
		--[[if ply == LocalPlayer() then
			angle_hitground.p = speed / 50
			ViewPunch(angle_hitground)
		end--]]
	end)

	local prev_on_ground,current_on_ground,speedPrevious,speed = false,false,0,0
	local angle_hitground = Angle(0,0,0)
	hook.Add("Think", "CP_detectland", function()
		prev_on_ground = current_on_ground
		current_on_ground = LocalPlayer():OnGround()
	
		speedPrevious = speed
		speed = -LocalPlayer():GetVelocity().z
	
		if prev_on_ground != current_on_ground and current_on_ground and LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP then
			angle_hitground.p = math.Clamp(speedPrevious / 25, 0, 20)
	
			ViewPunch(angle_hitground)
		end
	end)
end

function GAMEMODE:HandlePlayerLanding( ply, velocity, WasOnGround )
	if SERVER then return end
	if ply == LocalPlayer() and ply == GetViewEntity() then return end

	if ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then return end

	if ( ply:IsOnGround() && !WasOnGround ) then
		ply:AnimRestartGesture( GESTURE_SLOT_JUMP, ACT_LAND, true )
	end

end

local vecOffsetDuck = Vector(0, 0, 38)
local hull = 10
gameevent.Listen("player_spawn")
hook.Add("player_spawn", "homigrad-spawn3", function(data)
	local ply = Player(data.userid)
	if not IsValid(ply) then return end
	if CLIENT then vp_punch_angle = Angle() vp_punch_angle_last = Angle() end

	timer.Simple(0, function()
		ply:SetWalkSpeed(200)
		ply:SetRunSpeed(400)
		ply:SetSlowWalkSpeed(30)
		ply:SetLadderClimbSpeed(150)
		ply:SetDuckSpeed(0.4)
		ply:SetUnDuckSpeed(0.4)
		ply:SetViewOffsetDucked(vecOffsetDuck)
		ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
	end)

	ply:SetNWEntity("spect",NULL)
	if CLIENT and ply:Alive() then ply:BoneScaleChange() end
	
	ply:SetHull(Vector(-hull,-hull,0),Vector(hull,hull,72))
	ply:SetHullDuck(Vector(-hull,-hull,0),Vector(hull,hull,36))
	--ply:SetEyeAngles(Angle(0,0,0))
	ply.suiciding = false
	hook.Run("Player Spawn", ply)
end)

hook.Add("Player Spawn","default-thingies",function(ply)
	if OverrideSpawn then return false end
	if SERVER then
		ply:StripWeapons()
		ply:SetNetVar("Armor",{})
		ply:SetNetVar("Inventory",{})
		ply:RemoveAllAmmo()
		ply:Give("weapon_hands_sh")
		ply:ResetOrganism()
	end
end)

gameevent.Listen("player_disconnect")
hook.Add("player_disconnect", "hg-disconnect", function(data)
	hook.Run("Player Disconnected",data)
end)

gameevent.Listen( "player_activate" )
hook.Add("player_activate","player_activatehg",function(data) 
	local ply = Player(data.userid)
	if not IsValid(ply) then return end
	
	hook.Run("Player Activate", ply)
	if SERVER and ply.SyncVars then ply:SyncVars() end
end)

gameevent.Listen("entity_killed")
hook.Add("entity_killed", "homigrad-death", function(data)
	local ply = Entity(data.entindex_killed)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	hook.Run("Player Death", ply)
end)

if CLIENT then
	suppressionVec = Vector(0, 0, 0)
	suppressionDist = 0
	suppressionDistAdd = 0
	local angSupr = Angle(0, 0, 0)
	net.Receive("add_supression", function()
		local pos = net.ReadVector()
		local eyePos = LocalPlayer():EyePos()
		local dist = pos:Distance(eyePos)
		local side = (LocalPlayer():EyePos() - pos):GetNormalized()
		local ang = angSupr
		ang:Zero()
		ang[3] = math.Clamp(LocalPlayer():EyeAngles():Right():Dot(side) * 90, -360, 360)
		net.Start("return_supression")
		net.WriteFloat(dist)
		net.WriteAngle(ang)
		net.SendToServer()
	end)

	net.Receive("bullet_fell", function()
		local tr = net.ReadTable()
		local self = net.ReadEntity()
		local npcdmg = net.ReadFloat() or 0
		--if true then return end
		if not IsValid(self) then return end
		if self:GetOwner() == LocalPlayer() then return end
		local eyePos = LocalPlayer():EyePos()
		local dis, pos = util.DistanceToLine(tr.StartPos, tr.HitPos, eyePos)
		local isVisible = not util.TraceLine({
			start = pos,
			endpos = eyePos,
			filter = {self, LocalPlayer(), self:GetOwner()},
			mask = MASK_SHOT
		}).Hit

		if not isVisible then return end
		local dist = pos:Distance(eyePos)
		local mr = math.random(7)
		if dist < 300 then EmitSound("snd_jack_hmcd_bc_" .. mr .. ".wav", pos, 0, CHAN_AUTO, 1,60) end
		if dist > 120 then return end
		EmitSound("snd_jack_hmcd_bc_" .. mr .. ".wav", pos, 0, CHAN_AUTO, 1, 60)
		
		dist = dist * math.abs((tr.HitPos - tr.StartPos):GetNormalized():Dot((tr.StartPos - eyePos):GetNormalized()))
		--suppressionVec:Add((eyePos - pos):GetNormalized())
		--suppressionDistAdd = suppressionDistAdd + math.min(1 / dist, 0.25) / 8
		net.Start("return_bullet")
		net.WriteFloat(dist - (npcdmg/100) )
		net.WriteFloat((self.Primary and self.Primary.Damage or npcdmg))
		net.SendToServer()
	end)
else
	hook.Add("PlayerSay", "gd,mfgkdfg", function(ply,text)
		if text == "*drop" and ply:GetActiveWeapon():GetClass() != "weapon_hands_sh" then
			ply:DropWeapon()
			return ""
		end
	end)
	util.AddNetworkString("return_bullet")
	util.AddNetworkString("add_supression")
	util.AddNetworkString("return_supression")
	net.Receive("return_supression", function(len, ply)
		local dist = net.ReadFloat()
		local ang = net.ReadAngle()
		ply:ViewPunch(ang / (dist / 80))
		local org = ply.Organism
		if not org.Otrub then
			org.adrenaline = org.adrenaline + 200 / dist
			org.disorientation = org.disorientation + 400 / dist
		end
	end)

	net.Receive("return_bullet", function(len, ply)
		local dist = net.ReadFloat()
		local dmg = net.ReadFloat()
		local org = ply.Organism
		if not org.Otrub then org.adrenaline = math.min(org.adrenaline + dmg / (dist * 9), 1.5) end
	end)
end

local hook_Run = hook.Run
local CurTime = CurTime
local player_GetAll = player.GetAll
hook.Add("Think", "hg-playerthink", function()
	local players = player_GetAll()
	local time = CurTime()
	for i = 1,#players do
		hook_Run("Player Think", players[i], time)
	end
end)

if CLIENT then
	concommand.Add("suicide", function(ply)
		ply.suiciding = not (ply.suiciding or false)
		net.Start("suicidehg")
		net.WriteBool(ply.suiciding)
		net.SendToServer()
	end)
	net.Receive("suicidehg", function() 
		ply = net.ReadEntity()
		ply.suiciding = net.ReadBool() 
	end)
else
	util.AddNetworkString("suicidehg")
	net.Receive("suicidehg", function(len, ply) 
		ply.suiciding = net.ReadBool() 
		net.Start("suicidehg")
		net.WriteEntity(ply)
		net.WriteBool(ply.suiciding)
		net.Broadcast()
	end)
end

function hg.CalculateWeight(ply,maxweight)
	local weight = 0

	local weps = ply:GetWeapons()

	for i,wep in ipairs(weps) do
		weight = weight + (wep.weight or 1)
	end

	weight = math.max(weight - 1,0)

	local ammo = ply:GetAmmo()
	for id,count in pairs(ammo) do
		weight = weight + (game.GetAmmoForce(id) * count) / 1500
	end
	
	ply.armors = ply:GetNetVar("Armor",{})
	for plc,arm in pairs(ply.armors) do
		weight = weight + (hg.armor[plc][arm].mass or 1)
	end

	local weightmul = (1 / (weight / maxweight + 1))
	return weightmul
end

local k = 1
local vecZero = Vector(0, 0, 0)
hook.Add("SetupMove", "homigrad-move", function(ply, mv, cmd)
	if not IsValid(ply) or not ply:Alive() then return end

	local org = ply.Organism
	if not org or table.IsEmpty(org) then return end

	if ply:GetMoveType() == MOVETYPE_NOCLIP then return end

	local wep = ply:GetActiveWeapon()
	local vel = mv:GetVelocity()
	local velLen = vel:Length()

	local fm = mv:GetForwardSpeed()
	local sm = mv:GetSideSpeed()

	ply.lerprunning = Lerp(0.9, ply.lerprunning or 0, ply:IsSprinting() and velLen > 20 and (fm <= 5 and 75 or 175) or ply:KeyDown(IN_WALK) and 200 or 0)
	local move = 100 + (ply:IsSprinting() and 300 or 0)

	local weightmul = hg.CalculateWeight(ply,140)

	weightmul = weightmul > 0.9 and 1 or weightmul / 0.9
	
	k = 1 * weightmul
	k = k * math.Clamp(org.stamina[1] / 90,0.4,1)
	k = k * math.Clamp(15 / (org.immobilization + 1),0.5,1)
	k = k * math.Clamp(20 / (org.pain + 1),0.5,1)
	k = k * (math.min((org.adrenaline or 0) / 16, 0.2) + 1)
	--k = k * math.min((wep.Ergonomics or 1) + 0.1, 1)
	k = k * 2 / (((org.lleg or 0) < 0.5 and 0 or org.lleg - 0.5) + ((org.rleg or 0) < 0.5 and 0 or org.rleg - 0.5) + 2)
	k = k * (IsValid(ply:GetNWEntity("carryent")) and math.Clamp(15 / math.max(ply:GetNWFloat("carrymass"),1),0.5,1) or 1)
	move = move * k

	ply.move = move

	local huy = math.abs(cmd:GetMouseX() + cmd:GetMouseY())

	if (ply:KeyDown(IN_ATTACK2) or (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().GetFists and ply:GetActiveWeapon():GetFists())) and math.abs(mv:GetForwardSpeed()) <= 15 then--huy > 0 and math.abs(mv:GetForwardSpeed()) <= 5 then
		mv:SetForwardSpeed((7 * (math.Round(CurTime() * 1)%2==0 and 1 or -1) or 0))
	end--надо модельки менять...

	ply:SetJumpPower(200 * k)

	mv:SetMaxSpeed(move)
	mv:SetMaxClientSpeed(move)
end)

if CLIENT then
	hook.Add("AdjustMouseSensitivity", "AdjustRunSencivity", function(defaultSensitivity)
		if not LocalPlayer():Alive() then return end
		local organism = LocalPlayer().organism or {}

		local isrunning = LocalPlayer():KeyDown(IN_SPEED) and LocalPlayer():GetVelocity():Length() >= 10 and not LocalPlayer():Crouching()
		local eyeAngles = LocalPlayer():EyeAngles()
		local self = LocalPlayer():GetActiveWeapon()
		self = IsValid(self) and self
		local wepMul = self and self.IsZoom and self:IsZoom() and (math.min(self.ZoomFOV / 10, 0.5) or 0.5) or 1
		eyeAngles[1] = 0
		local forwardMoving = math.max(LocalPlayer():GetVelocity():GetNormalized():Dot(eyeAngles:Forward()), 0.6)
		if isrunning and LocalPlayer():GetMoveType() ~= MOVETYPE_NOCLIP then
			return 0.4 * math.max(1 / ((organism.immobilization or 0) / 30 + 1),0.4) * wepMul
		end
		return math.max(1 / ((organism.immobilization or 0) / 30 + 1),0.4) * wepMul
	end)
end

hook.Add("PlayerStepSoundTime", "hguhuy", function(ply, type, walking) if CLIENT and ply == LocalPlayer() then return (500 - (ply.move or 500)) * 1.17 end end)
if SERVER then
	function hg.ExplosionEffect(pos, dis, dmg)
		net.Start("add_supression")
		net.WriteVector(pos)
		net.Broadcast()
	end
	-- MANUAL PICKUP
	hook.Add( "PlayerCanPickupWeapon", "CanPickup", function( ply, weapon )
		if weapon.IsSpawned then
			if not ply:KeyPressed(IN_USE) then
				return false 
			end
			local ductcount = hgCheckDuctTapeObjects(weapon)
			local nailscount = hgCheckBindObjects(weapon)
			if (ductcount and ductcount > 0) or (nailscount and nailscount > 0) then return false end
		end
		if ( ply:HasWeapon( weapon:GetClass() ) ) then
			return false
		end
	end )

	hook.Add("PlayerDroppedWeapon", "ManualPickup", function(owner, wep)
		wep.IsSpawned = true
	end)

	hook.Add("PlayerSpawnedSWEP", "ManualPickup", function(ply, wep) wep.IsSpawned = true end)

end

hook.Add("StartCommand", "asd2345", function(ply, cmd)
	if not ply:OnGround() then --cmd:AddKey(IN_SPEED)
	end
end)

hook.Add("PlayerFootstep", "CustomFootstep2sad", function(ply, pos, foot, sound, volume, rf)
end)

hook.Add("OnPlayerJump", "eblan_debil", function(ply, speed)
	local vel = ply:GetVelocity()
	vel[3] = 0
	vel:Normalize()
	vel:Mul(1)
	--ply:SetVelocity(-vel / 6)
end)

hook.Add("PlayerDeathSound", "removesound", function() return true end)
hook.Add("PlayerSwitchFlashlight", "removeflashlights", function(ply, enabled)
	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) or not wep.attachments then --custom flashlight
		return false
	end
end)

if SERVER then
	hook.Add("SetupMove", "SV_SYNC", function(ply)
		if not ply.sync then
			ply.sync = true
			hook.Run("PlayerSync", ply)
		end
	end)
end
local surface_hardness = {
	[MAT_METAL] = 0.9,
	[MAT_COMPUTER] = 0.9,
	[MAT_VENT] = 0.9,
	[MAT_GRATE] = 0.9,
	[MAT_FLESH] = 0.5,
	[MAT_ALIENFLESH] = 0.3,
	[MAT_SAND] = 0.1,
	[MAT_DIRT] = 0.9,
	[74] = 0.1,
	[85] = 0.2,
	[MAT_WOOD] = 0.5,
	[MAT_FOLIAGE] = 0.5,
	[MAT_CONCRETE] = 0.9,
	[MAT_TILE] = 0.8,
	[MAT_SLOSH] = 0.05,
	[MAT_PLASTIC] = 0.3,
	[MAT_GLASS] = 0.6,
}
local BulletEffects
if SERVER then
	BulletEffects = function(tr, self, dmg)
		net.Start("bullet_fell")
		net.WriteTable(tr)
		net.WriteEntity(self)
		net.WriteFloat(dmg)
		net.Broadcast()
	end
end
local bulletHit
local function callbackBullet(self, tr, ply, fleshPen, damage)
	if not self.penetrated then return end
	if self.penetrated > 5 then return end
	self.penetrated = self.penetrated + 1
	
	local dir, hitNormal, hitPos = tr.Normal, tr.HitNormal, tr.HitPos
	if SERVER then BulletEffects(tr, self, damage) end
	local hardness = surface_hardness[tr.MatType] or 0.5
	local ApproachAngle = -math.deg(math.asin(hitNormal:DotProduct(dir)))
	local MaxRicAngle = 60 * hardness
	-- all the way through
	if ApproachAngle > MaxRicAngle * 1.2 then
		local Pen = (self.PenetrationCopy or 5) * 1 or self.Primary.Damage
		local MaxDist, SearchPos, SearchDist, Penetrated = Pen / hardness * 0.15 * 5, hitPos, 5, false
		while not Penetrated and SearchDist < MaxDist do
			SearchPos = hitPos + dir * SearchDist
			local PeneTrace = util.QuickTrace(SearchPos, -dir * SearchDist)
			if not PeneTrace.StartSolid and PeneTrace.Hit then
				Penetrated = true
				self.PenetrationCopy = self.PenetrationCopy - Pen * SearchDist / MaxDist / 3
			else
				SearchDist = SearchDist + 5
			end
		end

		if Penetrated then
			self:FireBullets({
				Attacker = self:GetOwner(),
				Damage = 1,
				Force = 0,
				Num = 1,
				Tracer = 0,
				TracerName = "",
				Dir = -dir,
				Spread = Vector(0, 0, 0),
				Src = SearchPos + dir,
				--Callback = bulletHit
			})

			self:FireBullets({
				Attacker = self:GetOwner(),
				Damage = damage * 0.65,
				Force = damage / 3,
				Num = 1,
				Tracer = 0,
				TracerName = "",
				Dir = dir,
				Spread = Vector(0, 0, 0),
				Src = SearchPos + dir,
				Callback = bulletHit--fleshPen and BloodTr or nil
			})
		end
	elseif ApproachAngle < MaxRicAngle * .2 then
		-- ping whiiiizzzz
		sound.Play("snd_jack_hmcd_ricochet_" .. math.random(1, 2) .. ".wav", hitPos, 75, math.random(90, 100))
		local NewVec = dir:Angle()
		NewVec:RotateAroundAxis(hitNormal, 180)
		NewVec = NewVec:Forward()
		self:FireBullets({
			Attacker = self:GetOwner(),
			Damage = (damage or 1) * .85,
			Force = damage  / 3,
			Num = 1,
			Tracer = 0,
			TracerName = "",
			Dir = -NewVec,
			Spread = Vector(0, 0, 0),
			Src = hitPos + hitNormal,
			Callback = bulletHit--fleshPen and BloodTr or nil
		})
	end
end

--не нахуй
bulletHit = function(ply, tr, dmgInfo, damage)
	local damage = damage or Entity(0).PenetrationCopy
	--if tr.HitSky then return end
	if CLIENT then return false end
	local fleshPen = false
	if tr.MatType == MAT_FLESH then
		util.Decal("Impact.Flesh", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		--[[local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos )
		util.Effect( "BloodImpact", effectdata )]]--
		fleshPen = true
	end
	
	local inflictor = Entity(0) --dmgInfo:GetInflictor()
	timer.Simple(0,function()
		callbackBullet(inflictor, tr, ply, fleshPen, damage)
	end)
end

local function PlaySnd(self, snd, server, chan)
	if SERVER and not server then return end
	local owner = self
	if CLIENT then
		local view = render.GetViewSetup(true)
		local time = owner:GetPos():Distance(view.origin) / 17836
		timer.Simple(time, function()
			local owner = IsValid(self:GetOwner().FakeRagdoll) and self:GetOwner().FakeRagdoll or self:GetOwner() or self
			owner = IsValid(owner) and owner or self
			if type(snd) == "table" then
				EmitSound(snd[1], owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, snd[5] or 1, snd[2] or (self.Supressor and 75 or 75), 0, math_random(snd[3] or 100, snd[4] or 100), 0, nil)
			else
				EmitSound(snd, owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, 1, self.Supressor and 75 or 75, 0, 100, 0, nil)
			end
		end)
	else
		local owner = IsValid(self:GetOwner().FakeRagdoll) and self:GetOwner().FakeRagdoll or self:GetOwner() or self
		owner = IsValid(owner) and owner or self
		if type(snd) == "table" then
			EmitSound(snd[1], owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, snd[5] or 1, snd[2] or (self.Supressor and 75 or 75), 0, math_random(snd[3] or 100, snd[4] or 100), 0, nil)
		else
			EmitSound(snd, owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, 1, self.Supressor and 75 or 75, 0, 100, 0, nil)
		end
	end
end

local npcs = {
	["npc_metropolice"] = {multi = 1,force = 1},
	["npc_combine_s"] = {multi = 1,force = 1},
	["npc_strider"] = {multi = 5,snd = "npc/strider/strider_minigun.wav",force = 4},
	["npc_combinegunship"] = {multi = 20,snd = "npc/strider/strider_minigun.wav",force = 1},
	["lunasflightschool_ah6"] = {multi = 20}
}

hook.Add("EntityFireBullets", "NPC_Boolets", function(ent,bullet)
	if npcs[ent:GetClass()] then
		--PrintTable(bullet)
		bullet.Damage = game.GetAmmoPlayerDamage(game.GetAmmoID(bullet.AmmoType)) * 5 * npcs[ent:GetClass()].multi
		bullet.Force = bullet.Force * (npcs[ent:GetClass()].force or 1)
		
		function bullet.Callback(ent,tr,dmginfo)
			Entity(0).penetrated = 0
			Entity(0).PenetrationCopy = bullet.Damage
			bulletHit(ent,tr,dmginfo,bullet.Damage)
		end
		if npcs[ent:GetClass()].snd then
			PlaySnd( ent, npcs[ent:GetClass()].snd)
		end
		--print(bullet.Damage)
		return true
	end
end)



hook.Add("PlayerUse","nouseinfake",function(ply,ent)
	local class = ent:GetClass()
	local ductcount = hgCheckDuctTapeObjects(ent)
	local nailscount = hgCheckBindObjects(ent)
	if (ductcount and ductcount > 0) or (nailscount and nailscount > 0) then return false end
	if class == "prop_physics" or class == "prop_physics_multiplayer" or class == "func_physbox" then
		local PhysObj = ent:GetPhysicsObject()
		if PhysObj and PhysObj.GetMass and PhysObj:GetMass() > 14 then return false end
	end

	if IsValid(ply.FakeRagdoll) then return false end
end)

hook.Add("Player Activate","SetHull",function(ply)
	ply:SetHull(Vector(-hull,-hull,0),Vector(hull,hull,72))
	ply:SetHullDuck(Vector(-hull,-hull,0),Vector(hull,hull,36))
end)

hook.Add("Player Spawn","SetHull",function(ply)
	ply:SetNWEntity("FakeRagdoll",NULL)
	ply:SetObserverMode(OBS_MODE_NONE)
end)

function GAMEMODE:PlayerShouldTaunt( ply, actid )
	
	return true

end

function GAMEMODE:PlayerStartTaunt( ply, actid, length )
end

if SERVER then
	
	local WreckBlacklist = {"gmod_lamp", "gmod_cameraprop", "gmod_light", "ent_jack_gmod_nukeflash"}

	function hgWreckBuildings(blaster, pos, power, range, ignoreVisChecks)
		local origPower = power
		power = power * 1
		local maxRange = 250 * power * (range or 1) -- todo: this still doesn't do what i want for the nuke
		local maxMassToDestroy = 10 * power ^ .8
		local masMassToLoosen = 30 * power
		local allProps = ents.FindInSphere(pos, maxRange)

		for k, prop in pairs(allProps) do
			if not (table.HasValue(WreckBlacklist, prop:GetClass()) or hook.Run("hg_CanDestroyProp", prop, blaster, pos, power, range, ignore) == false or prop.ExplProof == true) then
				local physObj = prop:GetPhysicsObject()
				local propPos = prop:LocalToWorld(prop:OBBCenter())
				local DistFrac = 1 - propPos:Distance(pos) / maxRange
				local myDestroyThreshold = DistFrac * maxMassToDestroy
				local myLoosenThreshold = DistFrac * masMassToLoosen

				if DistFrac >= .85 then
					myDestroyThreshold = myDestroyThreshold * 7
					myLoosenThreshold = myLoosenThreshold * 7
				end

				if (prop ~= blaster) and physObj:IsValid() then
					local mass, proceed = physObj:GetMass(), ignoreVisChecks

					if not proceed then
						local tr = util.QuickTrace(pos, propPos - pos, blaster)
						proceed = IsValid(tr.Entity) and (tr.Entity == prop)
					end

					if proceed then
						if mass <= myDestroyThreshold then
							SafeRemoveEntity(prop)
						elseif mass <= myLoosenThreshold then
							physObj:EnableMotion(true)
							constraint.RemoveAll(prop)
							physObj:ApplyForceOffset((propPos - pos):GetNormalized() * 1000 * DistFrac * power * mass, propPos + VectorRand() * 10)
						else
							physObj:ApplyForceOffset((propPos - pos):GetNormalized() * 200 * DistFrac * origPower * mass, propPos + VectorRand() * 10)
						end
					end
				end
			end
		end
	end

	function hgIsDoor(ent)
		local Class = ent:GetClass()
	
		return (Class == "prop_door") or (Class == "prop_door_rotating") or (Class == "func_door") or (Class == "func_door_rotating")
	end

	function hgBlastDoors(blaster, pos, power, range, ignoreVisChecks)
		for k, door in pairs(ents.FindInSphere(pos, 40 * power * (range or 1))) do
			if hgIsDoor(door) and hook.Run("hg_CanDestroyDoor", door, blaster, pos, power, range, ignore) ~= false then
				local proceed = ignoreVisChecks

				if not proceed then
					local tr = util.QuickTrace(pos, door:LocalToWorld(door:OBBCenter()) - pos, blaster)
					proceed = IsValid(tr.Entity) and (tr.Entity == door)
				end

				if proceed then
					hgBlastThatDoor(door, (door:LocalToWorld(door:OBBCenter()) - pos):GetNormalized() * 1000)
				end
			end
			if door:GetClass() == "func_breakable_surf" then
				door:Fire("Break")
			end
		end
	end

	function hgBlastThatDoor(ent, vel)
		ent.JModDoorBreachedness = nil
		local Moddel, Pozishun, Ayngul, Muteeriul, Skin = ent:GetModel(), ent:GetPos(), ent:GetAngles(), ent:GetMaterial(), ent:GetSkin()
		sound.Play("Wood_Crate.Break", Pozishun, 60, 100)
		sound.Play("Wood_Furniture.Break", Pozishun, 60, 100)
		ent:Fire("unlock", "", 0)
		ent:Fire("open", "", 0)
		ent:SetNoDraw(true)
		ent:SetNotSolid(true)

		if Moddel and Pozishun and Ayngul then
			local Replacement = ents.Create("prop_physics")
			Replacement:SetModel(Moddel)
			Replacement:SetPos(Pozishun + Vector(0, 0, 1))
			Replacement:SetAngles(Ayngul)

			if Muteeriul then
				Replacement:SetMaterial(Muteeriul)
			end

			if Skin then
				Replacement:SetSkin(Skin)
			end

			Replacement:SetModelScale(.9, 0)
			Replacement:Spawn()
			Replacement:Activate()

			if vel then
				Replacement:GetPhysicsObject():SetVelocity(vel)

				timer.Simple(0, function()
					if IsValid(Replacement) then
						Replacement:GetPhysicsObject():ApplyForceCenter(vel * 100)
					end
				end)
			end

			timer.Simple(5, function()
				if IsValid(Replacement) then
					Replacement:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				end
			end)
		end
	end
end

hook.Add("WeaponEquip","pickupHuy",function(wep,ply)
	--if not wep.init then return end
	timer.Simple(0,function()
		if wep.DontEquipInstantly then return end
		if not ply.noSound and IsValid(wep) then
			local oldwep = ply:GetActiveWeapon()
			timer.Simple(0,function()
				
				ply:SetActiveWeapon(wep)
				if wep.Deploy then
					wep:Deploy()
				end
			end)
		end
	end)
end)

hook.Add("AllowPlayerPickup","pickupWithWeapons",function(ply,ent)
    if ent:IsPlayerHolding() then return false end
end)

hook.Add("PlayerSwitchWeapon","switchghuy",function(ply,old,new)
	if SERVER then
		if old.dropAfterHolster then
			if not old.IsSpawned then return end
			--ply:DropWeapon(old)
		end
		--old:Holster()
	end
end)

if CLIENT then
	hook.Add("Think", "CanBeSeenOrNot", function()
		local entities = ents.FindByClass("prop_ragdoll")
		table.Add(entities, player.GetAll())

		for _, v in pairs(entities) do
			if v == LocalPlayer() then v.NotSeen = false continue end
			local diff = v:GetPos() - GetViewEntity():EyePos()
			if LocalPlayer():GetAimVector():Dot(diff) / diff:Length() <= 0 then v.NotSeen = true else v.NotSeen = false end
		end
	end)
end

local hullVec = Vector(15,15,15)
hook.Add("FindUseEntity","findhguse",function(ply,heldent)
	local att = ply:LookupAttachment("eyes")

	if att then
		att = ply:GetAttachment(att)
		
		if not att then return end

		local tr = {}
		tr.start = att.Pos
		tr.endpos = tr.start + ply:EyeAngles():Forward() * 72
		tr.filter = ply
		tr.mins = -hullVec
		tr.maxs = hullVec
		tr.mask = MASK_SOLID + CONTENTS_DEBRIS + CONTENTS_PLAYERCLIP
		tr.ignoreworld = true

		tr = util.TraceLine(tr)
		local ent = tr.Entity
		
		if not IsValid(ent) then
			--tr = util.TraceHull(tr)
			ent = heldent--tr.Entity
		end

		return ent
	end
end)
if CLIENT then
	hook.Add("Think","mouthanims",function()
		for i, ply in pairs(player.GetAll()) do
			local ent = hg.GetCurrentCharacter(ply)
			if LocalPlayer():GetPos():Distance(ent:GetPos()) > 2000 then continue end
			local flexes = {
				ent:GetFlexIDByName( "jaw_drop" ),
				ent:GetFlexIDByName( "left_part" ),
				ent:GetFlexIDByName( "right_part" ),
				ent:GetFlexIDByName( "left_mouth_drop" ),
				ent:GetFlexIDByName( "right_mouth_drop" )
			}

			local weight = ply:IsSpeaking() && math.Clamp( ply:VoiceVolume() * 3, 0, 3 ) || 0

			for k, v in pairs( flexes ) do
				ent:SetFlexWeight( v, weight )
			end
			if not ply.organism then continue end

			if ply:Alive() and not ply.organism.Otrub then
				ent.Blink = ent.Blink or 0
				ent.Blink = ent.Blink + 0.1
				ent.LastBlinking = ent.Blinking or 0
				if ent.Blink > 150 then
					ent.Blinking = Lerp(FrameTime() * 65,ent.Blinking or 0,1)
					if ent.Blink > 151 then
						ent.Blink = 0
					end
				else
					ent.Blinking = Lerp(FrameTime() * 65,ent.Blinking or 0,0)
				end
			elseif ply.organism.Otrub and (ent.Blinking or 0) < 0.95 then
				ent.Blinking = Lerp(FrameTime() * 5,ent.Blinking or 0,1)
			end

			if ent:IsRagdoll() then
				ent:SetFlexWeight(ent:GetFlexIDByName("blink"),ent.Blinking or 0)
			end
		end
	end)
end