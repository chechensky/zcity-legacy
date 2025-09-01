-- Path scripthooked:lua\\weapons\\weapon_melee.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.PrintName = "Combat Knife"
SWEP.Instructions = "A military grade combat knife designed to neutralize the enemy during combat operations and special operations. E+LMB to change mode to slash/stab. RMB to interact with environment."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 15
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Wait = 2
SWEP.Primary.Next = 0
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.ScrappersSlot = "Melee"

--__settings__--
SWEP.fastHitAllow = true
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_SLASH
SWEP.Penetration = 2
SWEP.traceOffsetAng = Angle(60, 0, 0)
SWEP.traceOffsetVec = Vector(2.5, 1, 0)
SWEP.traceLen = 12
SWEP.offsetVec = Vector(2, -1, 0)
SWEP.offsetAng = Angle(120, 180, 0)
SWEP.attacktime = 1
SWEP.HitSound = "snd_jack_hmcd_knifestab.wav"
SWEP.HitSound2 = "snd_jack_hmcd_slash.wav"
SWEP.HitWorldSound = "snd_jack_hmcd_knifehit.wav"
--
SWEP.weaponInvCategory = 5
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/combatknife/tactical_knife_iw7_wm.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_iw7_tactical_knife")
	SWEP.IconOverride = "vgui/hud/tfa_iw7_tactical_knife.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 1
SWEP.SlotPos = 1
local hullVec = Vector(5,5,5)

local function eyeTrace(self, ply)
	local ent = hg.GetCurrentCharacter(ply)
	if not IsValid(ent) then return end
	local att = ent:LookupAttachment("eyes")
	if att then
		att = ent:GetAttachment(att)
	else
		local tr = {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:GetAimVector() * 24 * self.traceLen ^ 0.25,
			filter = ent
		}
		return util.TraceLine(tr)
	end
	local dist,point = util.DistanceToLine(att.Pos,att.Pos-ply:GetAimVector() * 50,ply:EyePos())

	local tr = {}
	tr.start = point
	tr.endpos = point + ply:GetAimVector() * 40 * self.traceLen ^ 0.25
	tr.filter = {ent,ply,self.fakeGun}
	tr.maxs = hullVec
	tr.mins = -hullVec
	return util.TraceHull(tr)
end

function SWEP:GetEyeTrace()
	return eyeTrace(self, self:GetOwner())
end

local realTrace = CreateConVar("hg_melee_realtrace", 0, FCVAR_REPLICATED, "Use melee trace or eyetrace", 0, 1)
local vecZero = Vector(0, 0, 0)
function SWEP:GetWeaponTrace()
	local ply = self:GetOwner()
	local ply = hg.GetCurrentCharacter(ply)
	if realTrace:GetBool() or ply ~= self:GetOwner() then
		local bon = ply:LookupBone("ValveBiped.Bip01_R_Hand")
		if not bon then return end
		local matrix = ply:GetBoneMatrix(bon)
		local pos, ang = matrix:GetTranslation(), matrix:GetAngles()
		pos:Add(ang:Forward() * self.traceOffsetVec[1] + ang:Right() * self.traceOffsetVec[2] + ang:Up() * self.traceOffsetVec[3])
		local _, ang = LocalToWorld(self.traceOffsetVec, self.traceOffsetAng, pos, ang)
		local tr = {}
		tr.start = pos
		tr.endpos = pos + ang:Forward() * self.traceLen
		tr.filter = {self:GetOwner(),ply,self.fakeGun}
		tr.maxs = hullVec
		tr.mins = -hullVec
		return util.TraceHull(tr)
	else
		return self:GetEyeTrace()
	end
end

local function Circle(x, y, radius, seg)
	local cir = {}
	table.insert(cir, {
		x = x,
		y = y,
		u = 0.5,
		v = 0.5
	})

	for i = 0, seg do
		local a = math.rad((i / seg) * -360)
		table.insert(cir, {
			x = x + math.sin(a) * radius,
			y = y + math.cos(a) * radius,
			u = math.sin(a) / 2 + 0.5,
			v = math.cos(a) / 2 + 0.5
		})
	end

	local a = math.rad(0)
	table.insert(cir, {
		x = x + math.sin(a) * radius,
		y = y + math.cos(a) * radius,
		u = math.sin(a) / 2 + 0.5,
		v = math.cos(a) / 2 + 0.5
	})

	surface.DrawPoly(cir)
end

local colWhite = Color(255, 255, 255, 255)
local colGray = Color(200, 200, 200, 200)
hook.Add("HUDPaint", "asdasdasd", function()
	local lply = LocalPlayer()
	if not IsValid(lply or lply:GetActiveWeapon()) or lply:GetActiveWeapon().Base ~= "weapon_melee" then return end
	if not GetConVar("hg_show_hitposmuzzle"):GetBool() then return end
	local self = lply:GetActiveWeapon()
	local Tr = self:GetWeaponTrace()
	cam.Start3D()
	render.DrawLine(Tr.StartPos, Tr.HitPos, color_white)
	cam.End3D()
end)
local lerpthing = 0
function SWEP:DrawHUD()
	local owner = LocalPlayer()
	if GetViewEntity() ~= owner then return end
	if owner:InVehicle() then return end
	local Tr = self:GetWeaponTrace()
	local Size = math.max(math.min(1 - Tr.Fraction, 1), 0.1)
	local x, y = Tr.HitPos:ToScreen().x, Tr.HitPos:ToScreen().y
	if Tr.Hit then
		lerpthing = Lerp(0.1, lerpthing, 1)
		colWhite.a = 255 * Size
		surface.SetDrawColor(colGray)
		draw.NoTexture()
		surface.SetDrawColor(colWhite)
		draw.NoTexture()
		surface.DrawRect(x - 25 * lerpthing, y - 2.5, 50 * lerpthing, 5)
		surface.DrawRect(x - 2.5, y - 25 * lerpthing, 5, 50 * lerpthing)
		local col = Tr.Entity:GetPlayerColor():ToColor()
		local coloutline = (col.r < 50 and col.g < 50 and col.b < 50) and Color(255,255,255) or Color(0,0,0)
		coloutline.a = 255 * Size * 2
		draw.DrawText(Tr.Entity:IsPlayer() and Tr.Entity:GetPlayerName() or Tr.Entity:IsRagdoll() and Tr.Entity:GetPlayerName() or "", "HomigradFontLarge", x + 1, y + 31, coloutline, TEXT_ALIGN_CENTER)
		draw.DrawText(Tr.Entity:IsPlayer() and Tr.Entity:GetPlayerName() or Tr.Entity:IsRagdoll() and Tr.Entity:GetPlayerName() or "", "HomigradFontLarge", x, y + 30, col, TEXT_ALIGN_CENTER)
	end
end

function SWEP:DrawWorldModel()
	self.model = self.model or ClientsideModel(self.WorldModel)
	local WorldModel = self.model
	local owner = self:GetOwner()
	local ent = hg.GetCurrentCharacter(owner)
	WorldModel:SetNoDraw(true)
	WorldModel:SetModelScale(self.ModelScale or 1)
	if IsValid(owner) then
		local offsetVec = self.offsetVec
		local offsetAng = self.offsetAng
		local boneid = ent:LookupBone("ValveBiped.Bip01_R_Hand")
		if not boneid then return end
		local matrix = ent:GetBoneMatrix(boneid)
		if not matrix then return end
		local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
		WorldModel:SetPos(newPos)
		WorldModel:SetAngles(newAng)
		WorldModel:SetupBones()
	else
		WorldModel:SetPos(self:GetPos())
		WorldModel:SetAngles(self:GetAngles())
	end

	WorldModel:DrawModel()
end

SWEP.FallSnd = {
	"physics/metal/weapon_impact_hard1.wav",
	"physics/metal/weapon_impact_hard2.wav",
	"physics/metal/weapon_impact_hard3.wav"
}

hg.huyhuyhuy = hg.huyhuyhuy or {}

function SWEP:Initialize()
	self:SetHold(self.HoldType)
	self.nextAttack = 0

	util.PrecacheSound(self.DeploySnd)
	util.PrecacheSound(self.HolsterSnd)
	--util.PrecacheSound(self.FallSnd)

	self:AddCallback("PhysicsCollide",function(ent,data)
		if data.Speed > 200 then
			ent:EmitSound(istable(self.FallSnd) and table.Random(self.FallSnd) or self.FallSnd or self.DeploySnd,65)
		end
	end)

	hg.huyhuyhuy[self] = true
end

function SWEP:SetHold(value)
	self:SetWeaponHoldType(value)
	self.holdtype = value
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "LastAttack")
	if SERVER then self:NetworkVarNotify("LastAttack", self.AttackEvent) end
end

function SWEP:AttackEvent()
end

SWEP.animation = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
SWEP.animationfast = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.attackWait = 0.7
function SWEP:PrimaryAttack()
	if CLIENT and not IsFirstTimePredicted() then return end
	if self:KeyDown(IN_USE) and not IsValid(self:GetOwner().FakeRagdoll) then return end

	if self.mode then
		if self:LastShootTime() + self.attackWait * math.Clamp((180 - 100) / 90,1,2) > CurTime() then return end

		self:SetLastAttack(CurTime())
		self:SetLastShootTime(CurTime())
		self.shouldHit = true
		self.shouldHit2 = true
		self.power = 1
		self.attacksound = self.HitSound
		self:EmitSound("weapons/slam/throw.wav", 50, 100, 0.1)
		self:GetOwner():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.animation, true)
		if SERVER then
			net.Start("hg_attack")
			net.WriteEntity(self)
			net.WriteInt(self.animation,32)
			net.Broadcast()
		end
		if SERVER and IsValid(self:GetOwner().FakeRagdoll) then
			local ragdoll = self:GetOwner().FakeRagdoll
			local rh = ragdoll:GetPhysicsObjectNum(ragdoll:TranslateBoneToPhysBone(ragdoll:LookupBone( "ValveBiped.Bip01_R_Hand" )))

			rh:ApplyForceCenter(self:GetOwner():EyeAngles():Forward() * 5000)
		end
	else
		local owner = self:GetOwner()
		if IsValid(owner.FakeRagdoll) then return end
		if not self.fastHitAllow then return end

		if self:LastShootTime() + self.attackWait / 2 * math.Clamp((180 - 100) / 90,1,2) > CurTime() then return end
		
		self:SetLastAttack(CurTime())
		self:SetLastShootTime(CurTime())
		
		self.shouldHit = true
		self.shouldHit2 = true
		self.power = 0.5
		self.attacksound = self.HitSound2
		self:EmitSound("weapons/slam/throw.wav", 50, 100, 0.1)
		owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.animationfast, true)
		if SERVER then
			net.Start("hg_attack")
			net.WriteEntity(self)
			net.WriteInt(self.animationfast,32)
			net.Broadcast()
		end
	end
end

if SERVER then
	util.AddNetworkString("hg_attack")
else
	net.Receive("hg_attack", function()
		local self = net.ReadEntity()
		local anim = net.ReadInt(32)
		
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end
		if IsValid(self) and self:GetOwner() == LocalPlayer() then return end
		self:GetOwner():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, anim, true)
	end)
end

SWEP.mode = true
SWEP.canchangemodes = true

function SWEP:Think()
	if CLIENT then return end
	local ply = self:GetOwner()
	
	if IsValid(ply) then
		if ply:KeyDown(IN_USE) and self.canchangemodes and not IsValid(self:GetOwner().FakeRagdoll) then
			if ply:KeyPressed(IN_ATTACK) then
				self.mode = not self.mode
				net.Start("changemode_melee")
				net.WriteEntity(self)
				net.WriteBool(self.mode)
				net.Broadcast()
			end
		end
	end
end

function SWEP:ThinkHUY()
	if not IsValid(self:GetOwner()) or CLIENT then return end
	if self.dropAfterHolster then
		local wep = self:GetOwner():GetActiveWeapon()
		if IsValid(wep) and wep ~= self then
			timer.Simple(0.1,function()
				if IsValid(self:GetOwner()) and self:GetOwner():GetActiveWeapon() != self then
					self:GetOwner():DropWeapon(self)
				end
			end)
		end
	end
end

SWEP.modeNames = {[true] = "stabbing",[false] = "slashing"}

if SERVER then
	util.AddNetworkString("changemode_melee")
else
	net.Receive("changemode_melee",function(len)
		local self = net.ReadEntity()
		self.mode = net.ReadBool()
		if not self:GetOwner() then return end
		if LocalPlayer() == self:GetOwner() then
			self:GetOwner():PrintMessage(4,"Changed mode to "..self.modeNames[self.mode])
		end
		if self.ChangedMode then
			self:ChangedMode(self.mode)
		end
	end)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end

	if self.DamageType == DMG_SLASH then
		if not IsValid(self:GetOwner().FakeRagdoll) then
			if self:LastShootTime() + 0.5 > CurTime() then return end
			local tr = self:GetEyeTrace()
			
			if IsValid(tr.Entity) and tr.Entity.DuctTape then
				if tr.Entity.DuctTape[tr.PhysicsBone] and IsValid(tr.Entity.DuctTape[tr.PhysicsBone][1]) then
					tr.Entity.DuctTape[tr.PhysicsBone][2] = tr.Entity.DuctTape[tr.PhysicsBone][2] - 1
					if tr.Entity.DuctTape[tr.PhysicsBone][2] <= 0 then
						tr.Entity.DuctTape[tr.PhysicsBone][1]:Remove()
						tr.Entity.DuctTape[tr.PhysicsBone] = nil
					end
					tr.Entity:EmitSound("tape_friction"..math.random(3)..".mp3")
					self:SetLastAttack(CurTime())
					self:SetLastShootTime(CurTime())
				else
					tr.Entity.DuctTape[tr.PhysicsBone] = nil
				end
			end
		end
	end
end

function SWEP:IsLocal()
	return CLIENT and self:GetOwner() == LocalPlayer()
end

function SWEP:KeyDown(key)
	local owner = self:GetOwner()
	local localKey
	if CLIENT then
		if self:IsLocal() then
			localKey = owner:KeyDown(key)
		else
			localKey = owner.keydown[key]
		end
	end
	return SERVER and owner:KeyDown(key) or CLIENT and localKey
end

hook.Add("Player Think", "homigrad-eblan", function(ply)
	local wep = ply:GetActiveWeapon()
	local func = wep.Huy
	if func then func(wep, ply) end
end)
local waittimehuy = CurTime()
hook.Add("Think","FUCKYOUUUUU",function()
	if waittimehuy > CurTime() then return end
	waittimehuy = waittimehuy + 0.25
	for ent in pairs(hg.huyhuyhuy) do
		if not IsValid(ent) then continue end

		if ent.ThinkHUY then ent:ThinkHUY() end
	end--мне лень делать нормальное продумывание для выбрасывания оружия, поэтому хуй
end)--поинт поплачь об этом названии

SWEP.attacktime = 0.1
SWEP.staminamul = 3
function SWEP:Huy()
	local owner = self:GetOwner()
	if self:GetLastAttack() + self.attacktime > CurTime() then if SERVER then self:Attack() end end
end

function SWEP:Attack()
	local owner = self:GetOwner()
	self:GetOwner():LagCompensation(true)
	local tr = self:GetWeaponTrace()
	self:GetOwner():LagCompensation(false)
	self.PenetrationCopy = -(-self.Penetration)
	if tr.Hit then
		if self.shouldHit then
			self.shouldHit = false
			local dmg = DamageInfo()
			local mul = (math.max(tr.Normal:Dot(tr.Entity:IsPlayer() and tr.Entity:GetAimVector() or tr.Entity:GetAngles():Forward()),0) * 2 + 1)
			
			dmg:SetDamage(self.Primary.Damage * self.power * mul)
			dmg:SetAttacker(owner)
			dmg:SetDamagePosition(tr.HitPos)
			dmg:SetDamageType(self.DamageType)
			dmg:SetInflictor(self)
			dmg:SetDamageForce(tr.Normal * 100 * self.Primary.Damage / 40)
			self.Penetration = 3
			tr.Entity:TakeDamageInfo(dmg)
			hg.GetCurrentCharacter(owner):EmitSound(self.attacksound, 65)
		elseif self.shouldHit2 then
			self.shouldHit2 = false
			local dmg = DamageInfo()
			dmg:SetDamage(self.Primary.Damage * self.power)
			dmg:SetAttacker(owner)
			dmg:SetDamagePosition(tr.HitPos)
			dmg:SetDamageType(self.DamageType)
			dmg:SetInflictor(self)
			dmg:SetDamageForce(tr.Normal * 100 * self.Primary.Damage / 40)
			tr.Entity:TakeDamageInfo(dmg)
			hg.GetCurrentCharacter(owner):EmitSound(self.HitWorldSound, 65)
			if hgIsDoor(tr.Entity) and self.destroyDoors and (math.random(100) > self.destroyDoors * 100) then
				hgBlastThatDoor(tr.Entity, tr.Normal * 100 * self.Primary.Damage / 40)
			end
		end
	end
end

local bone, name
function SWEP:BoneSetAdd(layerID, lookup_name, vec, ang)
	hg.bone.SetAdd(self:GetOwner(), layerID, lookup_name, vec, ang)
end

function SWEP:BoneAdd(layerID, lookup_name, vec, ang)
	hg.bone.Add(self:GetOwner(), layerID, lookup_name, vec, ang)
end

function SWEP:BoneApply(layerID, lookup_name, lerp)
	hg.bone.Apply(self:GetOwner(), layerID, lookup_name, lerp)
end

function SWEP:BoneGet(lookup_name)
	return hg.bone.Get(self:GetOwner(), lookup_name)
end

local math_max, math_Clamp = math.max, math.Clamp
function SWEP:GetAnimPos_Shoot2(time, timeSpan, timeAddEnd)
	local timeSpan = timeSpan or 0.6
	local timeAddEnd = timeAddEnd or 0
	local shootAnim = (timeSpan - math_Clamp(math.abs(CurTime() - (time + timeAddEnd)), 0, timeSpan)) / timeSpan
	return shootAnim
end

function SWEP:GetAnimShoot2()
	local attacktime = self.attacktime
	local animpos = self:GetAnimPos_Shoot2(self:GetLastAttack(), attacktime or 0.6, 0)
	return animpos
end

SWEP.animationAttackClavicle = {
	[1] = {Vector(0, 0, 0), Angle(0, 60, 30)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 50, 20)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 20, 10)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackTorso = {
	[1] = {Vector(0, 0, 0), Angle(0, 0, 15)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 0, 15)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 0, 2)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, -2)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackForearm = {
	[1] = {Vector(0, 0, 0), Angle(-20, 70, 0)},
	[0.9] = {Vector(0, 0, 0), Angle(-10, 30, 0)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 10, 0)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 00, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackHand = {
	[1] = {Vector(0, 0, 0), Angle(-80, 0, 0)},
	[0.9] = {Vector(0, 0, 0), Angle(-70, 0, 0)},
	[0.8] = {Vector(0, 0, 0), Angle(-20, 0, 0)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.r_forearm = Angle(10, 10, 0)
SWEP.r_upperarm = Angle(10, -40, -10)
SWEP.r_hand = Angle(0, 0, 0)
SWEP.l_forearm = Angle(-30, 20, 20)
SWEP.l_upperarm = Angle(0, -30, 0)
local vecZero = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
SWEP.angHold = Angle(0, 0, -10)
function SWEP:Animation()
	self:SetHold(self.HoldType)
	local animpos = self:GetAnimShoot2()
	local owner = self:GetOwner()
	if IsValid(owner.FakeRagdoll) or not IsValid(owner) or (IsValid(owner:GetActiveWeapon()) and owner:GetActiveWeapon() ~= self) then return end
	self:BoneSetAdd(1, "r_forearm", Vector(0, 0, 0), self.r_forearm)
	self:BoneSetAdd(1, "r_upperarm", Vector(0, 0, 0), self.r_upperarm)
	self:BoneSetAdd(1, "r_hand", Vector(0, 0, 0), self.r_hand)
	self:BoneSetAdd(1, "l_forearm", Vector(0, 0, 0), self.l_forearm)
	self:BoneSetAdd(1, "l_upperarm", Vector(0, 0, 0), self.l_upperarm)
	local angles = (owner:GetEyeTrace().HitPos - owner:EyePos()):Angle() --:EyeAngles()
	angles:Normalize()
	self:BoneSetAdd(1, "spine", vecZero, Angle(0, angles[1] / 2, 0))
	if true then return end
	local animClavicle = self.animationAttackClavicle[math.Round(animpos, 1)]
	if animClavicle then
		local vec, ang = animClavicle[1], animClavicle[2]
		self:BoneSetAdd(1, "r_clavicle", vec, ang)
	end

	local animTorso = self.animationAttackTorso[math.Round(animpos, 1)]
	if animTorso then
		local vec, ang = animTorso[1], animTorso[2]
		self:BoneSetAdd(1, "spine", vec, ang)
	end

	local animForearm = self.animationAttackForearm[math.Round(animpos, 1)]
	if animForearm then
		local vec, ang = animForearm[1], animForearm[2]
		self:BoneSetAdd(1, "r_forearm", vec, ang)
	end

	local animHand = self.animationAttackHand[math.Round(animpos, 1)]
	if animHand then
		local vec, ang = animHand[1], animHand[2]
		self:BoneSetAdd(1, "r_hand", vec, ang)
	end

	local animpos = self.holdTime
	if animpos then
		local ang = self.angHold
		local vec = vecZero
		self:BoneSetAdd(1, "spine", vec, ang * (animpos - 0.5) * 5)
		self:BoneSetAdd(1, "head", vec, -ang * (animpos - 0.5) * 5)
		self:BoneSetAdd(1, "r_clavicle", vec, -(self.swing and self.swingang or angZero) * (animpos - 0.5) * 5)
	end
end

--------------------------------------- фйек
function SWEP:GetFakeGun()
	return self:GetNWEntity("fakeGun")
end

SWEP.WorkWithFake = true
function SWEP:SetFakeGun(ent)
	self:SetNWEntity("fakeGun", ent)
	self.fakeGun = ent
end

function SWEP:RemoveFake()
	if not IsValid(self.fakeGun) then return end
	self.fakeGun:Remove()
	self:SetFakeGun()
end

function SWEP:CreateFake(ragdoll)
	if IsValid(self:GetNWEntity("fakeGun")) then return end
	local ent = ents.Create("prop_physics")

	local rh = ragdoll:GetPhysicsObjectNum(hg.realPhysNum(ragdoll, 7))
	
	local offsetVec = self.offsetVec
	local offsetAng = self.offsetAng

	local newPos, newAng = LocalToWorld(offsetVec, offsetAng, rh:GetPos(), rh:GetAngles())

	ent:SetModel(self.WorldModel)
	ent:Spawn()

	ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	ent:SetOwner(ragdoll)
	ent:GetPhysicsObject():SetMass(2)
	ent.dontPickup = true
	ent.fakeOwner = self
	ragdoll:DeleteOnRemove(ent)
	ragdoll.fakeGun = ent
	if IsValid(ragdoll.ConsRH) then ragdoll.ConsRH:Remove() end

	ent:SetPos(newPos)
	ent:SetAngles(newAng)
	local weld = constraint.Weld(ent,ragdoll,0,7,0,true,true)

	self:SetFakeGun(ent)
	ent:CallOnRemove("homigrad-swep", self.RemoveFake, self)
end

local shadowControl
function SWEP:RagdollFunc(pos, angles, ragdoll)
	shadowControl = shadowControl or hg.ShadowControl
	local fakeGun = ragdoll.fakeGun
	pos:Add(angles:Forward() * 18)
	shadowControl(fakeGun, 0, 0.001, angles, 100, 90, pos, 1000, 900)
	angles:RotateAroundAxis(angles:Forward(), 180)
	shadowControl(ragdoll, 7, 0.001, angles, 55500, 30, pos, 1000, 100)
end

SWEP.DeploySnd = "snd_jack_hmcd_knifedraw.wav"
SWEP.HolsterSnd = ""

function SWEP:Holster(wep)
	if SERVER then
		--[[timer.Simple(0,function()
			if self.dropAfterHolster then
				self:GetOwner():DropWeapon(self)
			end
		end)--]]
	end
	
	if not IsValid(wep) or wep == self then return true end
	
	if SERVER or CLIENT and self:IsLocal() then
		self:EmitSound(self.HolsterSnd,50)
	end
	
	return true
end

function SWEP:Deploy()
	if SERVER or CLIENT and self:IsLocal() then
		self:EmitSound(self.DeploySnd,50)
	end
	
	return true
end