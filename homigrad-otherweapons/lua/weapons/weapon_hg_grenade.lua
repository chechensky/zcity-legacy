-- Path scripthooked:lua\\weapons\\weapon_hg_grenade.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.PrintName = "F1"
SWEP.Category = "Weapons - Explosive"
SWEP.Instructions = "A famous soviet WWII offensive grenade. It's still widely exported and used to this day. It has a pyrotechnic delay of 3.2-4.2 seconds."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Wait = 1
SWEP.Primary.Next = 0
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HoldType = "grenade"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_f1.mdl"

SWEP.ScrappersSlot = "Other"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("pwb/sprites/f1.png")
	SWEP.IconOverride = "pwb/sprites/f1.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.ENT = "ent_hg_grenade"
local function eyeTrace(ply)
	local att = ply:LookupAttachment("eyes")
	if att then
		att = ply:GetAttachment(att)
	else
		local tr = {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:GetAimVector() * 60,
			filter = ply
		}
		return util.TraceLine(tr)
	end

	local tr = {}
	tr.start = att.Pos -- - ply:GetAimVector() * 5
	tr.endpos = att.Pos + ply:GetAimVector() * 60
	tr.filter = ply
	return util.TraceLine(tr)
end

function SWEP:GetEyeTrace()
	return eyeTrace(self:GetOwner())
end

SWEP.offsetVec = Vector(-7, -3, -3)
SWEP.offsetAng = Angle(145, 0, 0)

SWEP.spoon = "models/codww2/equipment/mk,ii hand grenade spoon.mdl"

function SWEP:DrawWorldModel()
	self.model = self.model or ClientsideModel(self.WorldModel)
	local WorldModel = self.model
	local owner = self:GetOwner()
	WorldModel:SetNoDraw(true)
	WorldModel:SetModelScale(1)
	if IsValid(owner) then
		local offsetVec = self.offsetVec
		local offsetAng = self.offsetAng
		local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
		if not boneid then return end
		local matrix = owner:GetBoneMatrix(boneid)
		if not matrix then return end
		local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
		WorldModel:SetPos(newPos)
		WorldModel:SetAngles(newAng)
		WorldModel:SetupBones()
	else
		WorldModel:SetPos(self:GetPos())
		WorldModel:SetAngles(self:GetAngles())
		WorldModel:DrawModel()
	end

	if IsValid(owner.FakeRagdoll) or not IsValid(owner) or (IsValid(owner:GetActiveWeapon()) and owner:GetActiveWeapon() ~= self) then return end
	WorldModel:DrawModel()

	if self.lefthandmodel then
		self.model2 = self.model2 or ClientsideModel(self.lefthandmodel)
		local WorldModel = self.model2
		local owner = self:GetOwner()
		WorldModel:SetNoDraw(true)
		WorldModel:SetModelScale(1)
		if IsValid(owner) then
			local offsetVec = self.offsetVec2
			local offsetAng = self.offsetAng2
			local boneid = owner:LookupBone("ValveBiped.Bip01_L_Hand")
			if not boneid then return end
			local matrix = owner:GetBoneMatrix(boneid)
			if not matrix then return end
			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)
			WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
			WorldModel:DrawModel()
		end
	
		if IsValid(owner.FakeRagdoll) or not IsValid(owner) or (IsValid(owner:GetActiveWeapon()) and owner:GetActiveWeapon() ~= self) then return end
		WorldModel:DrawModel()
	end
end

function SWEP:Initialize()
	self:SetHold(self.HoldType)
	hg.weapons2[self] = true
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

function SWEP:Animation()
	self:SetHold(self.HoldType)

	self:BoneSetAdd(1, "r_upperarm", Vector(0,0,0), Angle(-90,0,-60))

	if self.startedattack then
		local animpos = math.max((self.startedattack + 0.5) - CurTime(),0) * 2
		
		self:BoneSetAdd(1, "l_upperarm", Vector(0,0,0), Angle(-90 * animpos,-60 * animpos,0))
		self:BoneSetAdd(1, "r_upperarm", Vector(0,0,0), Angle(-20 * animpos,-40 * animpos,0))
	end

	if self.starthold then
		local animpos = math.max((self.starthold + 0.5) - CurTime(),0) * 2

		self:BoneSetAdd(1, "r_finger0", Vector(0,0,0), Angle(70 * animpos,-10 * animpos,0))
		self:BoneSetAdd(1, "r_hand", Vector(0,0,0), Angle(20 * animpos,0,0))
	end
end

function SWEP:SetHold(value)
	self:SetWeaponHoldType(value)
	self.holdtype = value
end

function SWEP:PrimaryAttack()
	local time = CurTime()
	--time the throw!
	--self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	--if SERVER and not self.removed then self:Throw(800, time) end
end
if SERVER then
	util.AddNetworkString("hg_started_attack")
	util.AddNetworkString("hg_started_spoon")
else
	net.Receive("hg_started_attack",function()
		net.ReadEntity().startedattack = CurTime()
	end)
	net.Receive("hg_started_spoon",function()
		net.ReadEntity().starthold = CurTime()
	end)
end

local hook_Run = hook.Run
hg.weapons2 = hg.weapons2 or {}
hook.Add("Think", "homigrad-weaponsasdasd", function()
	for wep in pairs(hg.weapons2) do
		if not IsValid(wep) or not wep.Step1 then continue end
		wep:Step1()
	end
end)

local function createSpoon(self,entownr)
	local entasd
	if IsValid(entownr) then
		local hand = entownr:GetBoneMatrix(entownr:LookupBone("ValveBiped.Bip01_R_Hand"))

		entasd = ents.Create("prop_physics")
		entasd:SetModel(self.spoon)
		entasd:SetPos(hand:GetTranslation())
		entasd:SetAngles(hand:GetAngles())
		entasd:Spawn()
		entasd:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		entownr:EmitSound("weapons/m67/m67_spooneject.wav",65)
	else
		entasd = ents.Create("prop_physics")
		entasd:SetModel(self.spoon)
		entasd:SetPos(self:GetPos())
		entasd:SetAngles(self:GetAngles())
		entasd:Spawn()
		entasd:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		entasd:EmitSound("weapons/m67/m67_spooneject.wav",65)
	end

	return entasd
end

function SWEP:Step1()
	if SERVER and not self.removed then
		local time = CurTime()
		local ply = self:GetOwner()
		
		self.lastowner = ply:IsPlayer() and ply or self.lastowner

		local entownr
		if IsValid(ply) then
			entownr = hg.GetCurrentCharacter(ply)
		end
		
		local ent = scripted_ents.Get(self.ENT)--scripted_ents.Get("ent_"..string.sub(self:GetClass(),8))

		if IsValid(entownr) and ply:GetActiveWeapon()==self then
			if ply:KeyDown(IN_ATTACK) and not self.startedattack then
				if self.nofunnyfunctions then
					if not self.throwin then
						ply:EmitSound(self.throwsound,65)
					end
					self.startedattack = time
					self.throwin = self.throwin or time + self.timetothrow
					net.Start("hg_started_attack")
					net.WriteEntity(self)
					net.Broadcast()
					return
				end
				
				entownr:EmitSound("weapons/m67/m67_pullpin.wav",65)
				self.startedattack = time
				net.Start("hg_started_attack")
				net.WriteEntity(self)
				net.Broadcast()
			end

			if self.nofunnyfunctions then
				if self.throwin and self.throwin < time then
					self:Throw(800, time)
				end
				return
			end
			
			if self.startedattack and ply:KeyDown(IN_ATTACK2) and not self.starthold and entownr == ply then
				self.starthold = time
				net.Start("hg_started_spoon")
				net.WriteEntity(self)
				net.Broadcast()
				createSpoon(self,entownr)
			end

			if self.startedattack and not ply:KeyDown(IN_ATTACK) then
				self.endhold = time
			end

			if self.endhold and not self.starthold then
				self.starthold = self.endhold
				createSpoon(self,entownr)
			end
		else
			if self.startedattack then
				if not self.starthold then
					createSpoon(self)
				end
				self.starthold = self.starthold or time
			end
			if self.nofunnyfunctions then
				if self.throwin and self.throwin < time then
					self:Throw(800, time)
				end
				return
			end
		end

		if self.starthold and (((ent.timeToBoom - 0.1 + self.starthold) <= CurTime()) or self.endhold) then
			if self.endhold then
				local timeheld = math.max(self.endhold - self.starthold - 0.1,0)
				
				self:Throw(800, time - timeheld)
			else
				self:Throw(0, time - ent.timeToBoom,true)
			end
		end
	end
end

function SWEP:SecondaryAttack()
	local time = CurTime()
	if IsValid(self:GetNWEntity("fakeGun")) then return end
	--self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	--if SERVER and not self.removed then self:Throw(400, time) end
end

function SWEP:GetFakeGun()
	return self:GetNWEntity("fakeGun")
end

function SWEP:Throw(mul, time, nosound)
	if not self.ENT then return end
	local owner = self:GetOwner()
	local ent = ents.Create(self.ENT)
	local entOwner = IsValid(owner.FakeRagdoll) and owner.FakeRagdoll or IsValid(owner) and owner
	local hand = IsValid(entOwner) and owner:EyePos() or self:GetPos()
	if not nosound then
		if IsValid(entOwner) then
			entOwner:EmitSound("weapons/m67/m67_throw_01.wav", 90, math.random(95, 105))
		end
	end
	ent:Spawn()
	ent:SetPos(hand + self:GetAngles():Forward() * 5)
	ent:SetAngles(IsValid(owner) and owner:EyeAngles() or self:GetAngles())
	local phys = ent:GetPhysicsObject()
	if phys then phys:SetVelocity(IsValid(owner) and owner:GetAimVector() * mul or Vector(0,0,0)) end
	ent.timer = time
	ent.owner = self.lastowner
	
	self.removed = true
	self:Remove()
	if IsValid(owner) then
		owner:SelectWeapon("weapon_hands_sh")
	end
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
	pos:Add(angles:Forward() * 20)
	shadowControl(fakeGun, 0, 0.001, angles, 100, 90, pos, 1000, 900)
	angles:RotateAroundAxis(angles:Forward(), 180)
	shadowControl(ragdoll, 7, 0.001, angles, 55500, 30, pos, 1000, 100)
end