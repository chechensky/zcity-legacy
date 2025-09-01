-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\sh_worldmodel.lua"
-- Scripthooked by ???
AddCSLuaFile()
--
hook.Add("PhysgunPickup", "homigrad-weapons", function(ply, ent) if ent:GetNWBool("nophys") then return false end end)
SWEP.WorldPos = Vector(13, -0.3, 3.4)
SWEP.WorldAng = Angle(5, 0, 180)
SWEP.UseCustomWorldModel = false

if SERVER then
	util.AddNetworkString("give-me-guns")

	--[[local entityMeta = FindMetaTable("Entity")
	function entityMeta:SyncArmor()
		if self.armors then
			self:SetNetVar("Armor", self.armors)
		end
	end]]-- ОНО В ИНИТЕ БРОНИ

	hook.Add("PlayerSync", "sync_weapons", function(ply)
		--hg.SyncWeapons(ply)

		timer.Simple(1, function()
			if ply.SyncVars then ply:SyncVars() end
		end)
	end)
end

SWEP.weaponAng = Angle(0, 0, 0)
local angZero = Angle(0, 0, 0)
local math_max, math_Clamp = math.max, math.Clamp
function SWEP:GetAnimPos_Shoot2(time, timeSpan, timeAddEnd)
	local timeSpan = timeSpan or 0.2
	local timeAddEnd = timeAddEnd or 0
	local shootAnim = (timeSpan / 2 - math_Clamp(math.abs(CurTime() - (time + timeAddEnd)), 0, timeSpan / 2)) / 0.3
	return shootAnim
end

function SWEP:GetAnimShoot2()
	local animpos = self:GetAnimPos_Shoot2(self:LastShootTime(), 0.3, 0) * 2
	--if animpos > 0 and CLIENT then print(animpos) end
	animpos = math.ease.OutSine(animpos)
	if animpos > 0 then
		animpos = animpos * math.max(self.Primary.Force / 110, 0)
		animpos = animpos * self.AnimShootMul or 1
		animpos = animpos / 4 * self:GetPrimaryMul()
		animpos = animpos * self.AnimShootHandMul or 1
		animpos = animpos * (self.LHandPos and 1 or 4)
	end
	return animpos
end

local angZero, vecZero = Angle(0, 0, 0), Vector(0, 0, 0) -- а неиспользуется потому что глуалин подчеркнул это
local angPosture3 = Angle(-30, 10, -20)
local angPosture4 = Angle(30, 20, 0)
local angSuicide = Angle(-30, 120, 0)
local angReload = Angle(-30, 20, 0)

SWEP.AllowedInspect = true

if SERVER then
	util.AddNetworkString("hg_viewgun")
	concommand.Add("hg_inspect", function(ply, cmd, args)
		local gun = ply:GetActiveWeapon()
		if not IsValid(gun) or not gun or not gun.AllowedInspect then return end
		ply.viewingGun = CurTime() + 4
		net.Start("hg_viewgun")
		net.WriteEntity(ply)
		net.WriteFloat(ply.viewingGun)
		net.Broadcast()
	end)
else
	net.Receive("hg_viewgun", function() net.ReadEntity().viewingGun = net.ReadFloat() end)
	local function inspect() RunConsoleCommand("hg_inspect") end
	hook.Add("radialOptions", "!Mainus", function()
		local lply = LocalPlayer()
		local gun = lply:GetActiveWeapon()
		if not IsValid(gun) or not gun or not gun.AllowedInspect then return end
		local tbl = {inspect, "Inspect"}
		hg.radialOptions[#hg.radialOptions + 1] = tbl
	end)
end

local funcNil = function() end

hg.postureFuncWorldModel = {
	[3] = function(self,ply)
		self.weaponAng:Add(angPosture3)
	end,
	[5] = function(self,ply)
		self.weaponAng[3] = self.weaponAng[3] - 20
	end,
	[6] = function(self,ply)
		self.weaponAng[3] = self.weaponAng[3] - 35
	end,
}

local tickInterval = engine.TickInterval -- gde
local hook_Run = hook.Run
function SWEP:ChangeGunPos()
	local ply = self:GetOwner()

	if (self.frameTime or 0) > CurTime() then return end
	self.frameTime = CurTime() + 0.014

	local fakeRagdoll = IsValid(ply.FakeRagdoll)

	hook_Run("WeaponAnglesChange", self)
	self.weaponAng[1] = 0
	self.weaponAng[2] = 0
	self.weaponAng[3] = 0
	local animpos = self:GetAnimShoot2()
	animpos = animpos * (self.bipodPlacement and 0.25 or 1)
	animpos = animpos * ((self:IsLocal() or SERVER) and math.Clamp(self.SprayI / self:GetMaxClip1() * 2, not self.Primary.Automatic and 0.1 or 0.1, not self.Primary.Automatic and 0.1 or 1) or 1)
	self.weaponAng[1] = self.weaponAng[1] + animpos * -20 --* (self.holdtype == "revolver" and -20 or -20)
	if ply.viewingGun and ply.viewingGun > CurTime() then
		self.weaponAng:Add(Angle(math.sin(ply.viewingGun - CurTime()) * -5, math.sin(ply.viewingGun - CurTime()) * -5, math.cos(ply.viewingGun+1.5 - CurTime()) * 30))
		ply.viewingGun = not (self:KeyDown(IN_ATTACK2) or self:KeyDown(IN_ATTACK)) and ply.viewingGun or nil
	end

	if IsValid(ply.FakeRagdoll) then ply.lean = 0 end
	self.weaponAng[3] = self.weaponAng[3] + (ply.lean or 0) * 20
	if self.GetAnimPos_Draw and CLIENT then
		local animpos = math.Clamp(self:GetAnimPos_Draw(CurTime()),0,1)
		local sin = 1 - animpos
		if sin >= 0.5 then
			sin = 1 - sin
		else
			sin = sin * 1
		end
		sin = sin * 2
		sin = math.ease.InOutSine(sin)
		self.weaponAng[1] = self.weaponAng[1] - sin * 10
		self.weaponAng[2] = self.weaponAng[2] + sin * 20
		self.weaponAng[3] = self.weaponAng[3] + sin * -20
	end

	if not fakeRagdoll then

		local func = hg.postureFuncWorldModel[ply.posture] or funcNil
		func(self,ply)

		angPosture4[1] = 30 * (ply:EyeAngles()[1] > 60 and (90 - ply:EyeAngles()[1]) / 30 or 1)
		angPosture4[2] = 20 * (ply:EyeAngles()[1] > 60 and (90 - ply:EyeAngles()[1]) / 30 or 1)
		self.weaponAng:Add(ply.posture ~= 3 and self:IsSprinting() and angPosture4 or angZero)
		if ply.suiciding then self.weaponAng:Add(ply.suiciding and angSuicide or angZero) end
	end

	if ply.posture == 4 or ply.posture == 3 or ply.posture == 1 or ply.posture == 6 then ply.posture = (self:KeyDown(IN_ATTACK2) or (ply.posture ~= 1 and ply.posture ~= 6 and self:KeyDown(IN_ATTACK))) and 0 or ply.posture end
	
	local closeanim = self:CloseAnim(true)
	closeanim = (ply:InVehicle() or fakeRagdoll) and 0 or closeanim or 0
	local trace = ply:GetEyeTrace()
	local way = trace.HitNormal:Dot(ply:EyeAngles():Up())

	if not self.bipodPlacement then
		self.weaponAng[1] = self.weaponAng[1] - 60 * (closeanim > 0.75 and (closeanim - 0.75) * (way > 0 and 1 or -1) or 0)
		self.weaponAng[3] = self.weaponAng[3] - math.abs(90 * (closeanim > 0.75 and (closeanim - 0.75) * (way > 0 and 1 or -1) or 0))
	end

	local brokenArm = ply.organism and ((ply.organism.larm or 0) + (ply.organism.rarm or 0)) or 0
	
	if not self.bipodPlacement then
		brokenArm = brokenArm + math.max((0.4 - self.Ergonomics),0) * (ply.posture == 1 and 5 or 30)
	end

	self.weaponAng[1] = self.weaponAng[1] + (brokenArm >= 1 and (math.sin(CurTime()) + 1) * brokenArm or 0)
	
	if CLIENT and self:IsLocal() then
		self.weaponAng[3] = self.weaponAng[3] + diffang2[2] * 2
		self.weaponAng[3] = self.weaponAng[3] - diffvec2:Dot(self:GetOwner():EyeAngles():Right()) * 5
	end

	self.weaponAng:Add((self.reload and self.reload - 0.25 > CurTime()) and not fakeRagdoll and angReload or angZero)
	self.weaponAngLerp = Lerp(0.3 * self.Ergonomics ^ 1, self.weaponAngLerp or Angle(0, 0, 0), self.weaponAng)
end

if CLIENT then
end

function SWEP:PosAngChanges(owner,desiredPos,desiredAng)
	if self.HoldType != "revolver" and owner.suiciding then
		desiredAng:RotateAroundAxis(desiredAng:Forward(), 180)
		desiredAng:RotateAroundAxis(desiredAng:Right(), 100)
		desiredAng:RotateAroundAxis(desiredAng:Forward(), -105)
		desiredAng:RotateAroundAxis(desiredAng:Up(), -35)
		desiredAng:RotateAroundAxis(desiredAng:Forward(), 50)
		desiredAng:RotateAroundAxis(desiredAng:Right(), 5)
	end

	if self.HoldType != "revolver" and owner.suiciding then
		desiredPos:Add(desiredAng:Right() * -4)
		desiredPos:Add(desiredAng:Forward() * (self:KeyDown(IN_DUCK) and -8 or -10))
		desiredPos:Add(desiredAng:Up() * -1)
	end

	desiredPos:Add(desiredAng:Up() * 1)
	return desiredPos,desiredAng
end

if SERVER then return end

local function remove(self, model)
	model:Remove()
end

function SWEP:CreateWorldModel()
	local model = ClientsideModel(self.WorldModel)
	model:SetNoDraw(true)
	for i = 0, 6 do
		model:SetBodygroup(i, self:GetBodygroup(i))
	end

	self:CallOnRemove("clientsidemodel", function() model:Remove() end)
	model:CallOnRemove("removeAtts", function() hg.ClearAttModels(model) end)
	self.worldModel = model
	return model
end

function hg.CreateWorldModel_Ex(class, owner, self)
	local model = ClientsideModel(self.WorldModel)
	model:SetNoDraw(true)
	
	--owner:CallOnRemove("clientsidemodel", function() model:Remove() end)
	model:CallOnRemove("removeAtts", function() hg.ClearAttModels(model) end)
	owner.worldModel[class] = model
	return model
end

local vecZero = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
local math_max = math.max
hook.Add("NotifyShouldTransmit", "PvsThingy", function(ent, shouldTransmit) ent.shouldTransmit = shouldTransmit end)
function SWEP:WorldModel_Transform()
	local model, owner = self.worldModel, self:GetOwner()
	if not IsValid(model) then model = self:CreateWorldModel() end
	
	if IsValid(owner) then
		local ent = hg.GetCurrentCharacter(owner)
		local RHand = ent:LookupBone("ValveBiped.Bip01_R_Hand")
		local LHand = ent:LookupBone("ValveBiped.Bip01_L_Hand")

		if not RHand or not LHand then return end

		local matrixR = ent:GetBoneMatrix(RHand)
		local matrixL = ent:GetBoneMatrix(LHand)
		
		if not matrixR or not matrixL then return end

		self:ChangeGunPos()
		
		local matrixRAngRot = matrixR:GetAngles()
		matrixRAngRot:RotateAroundAxis(matrixRAngRot:Forward(),180)
		local desiredAng = (owner.suiciding or (ent~=owner and not self:KeyDown(IN_ATTACK2))) and matrixRAngRot or (owner:EyeAngles() + (LocalPlayer() == owner and owner:InVehicle() and owner:GetVehicle():GetAngles() or angZero))
		desiredAng:RotateAroundAxis(desiredAng:Forward(),180)
		local desiredPos = matrixR:GetTranslation()

		desiredPos,desiredAng = self:PosAngChanges(owner,desiredPos,desiredAng)

		if ent == owner then
			if not owner.suiciding then
				desiredAng:Add(self.weaponAngLerp or angZero)
			end
		elseif ent~=owner and self:KeyDown(IN_ATTACK2) then
			desiredAng:Add(self.weaponAngLerp or angZero)
			if self.HoldType ~= "revolver" then
				desiredPos:Add(matrixRAngRot:Up() * 2)
				desiredPos:Add(matrixRAngRot:Forward() * 1)
				desiredPos:Add(matrixRAngRot:Right() * 0)
			end
			desiredAng[3] = matrixRAngRot[3] + 180
		end

		local newPos,newAng = LocalToWorld(self.WorldPos,self.WorldAng,desiredPos,desiredAng)
		newAng:RotateAroundAxis(newAng:Forward(),180)
		
		if self.bipodPlacement then
			newPos = self.bipodPlacement
		end

		model:SetRenderOrigin(newPos)
		model:SetRenderAngles(newAng)
		model:SetupBones()
	else
		model:SetRenderOrigin(self:GetPos())
		model:SetRenderAngles(self:GetAngles())
		model:SetupBones()
	end
end

SWEP.holsteredBone = "ValveBiped.Bip01_Spine2"
SWEP.holsteredPos = Vector(-8, -3.8, -3)
SWEP.holsteredAng = Angle(0, 0, 0)
function SWEP:WorldModel_Transform_Holstered()
	local model, owner = self.worldModel, self:GetOwner()
	if not IsValid(model) then model = self:CreateWorldModel() end
	local ent = hg.GetCurrentCharacter(owner)
	if not IsValid(owner) then
		model:SetNoDraw(true)
		return
	end
	
	if IsValid(ent) then
		local matrix = ent:GetBoneMatrix(ent:LookupBone(self.holsteredBone))
		if not matrix then return end
		local localPos, localAng = self.holsteredPos + self.WorldPos, self.holsteredAng
		local newPos, newAng = LocalToWorld(localPos, localAng, matrix:GetTranslation(), matrix:GetAngles())
		model:SetAngles(newAng)
		local newAng = model:LocalToWorldAngles(self.WorldAng)
		model:SetRenderOrigin(newPos)
		model:SetRenderAngles(newAng)
		model:SetupBones()
	else
		model:SetRenderOrigin(self:GetPos())
		model:SetRenderAngles(self:GetAngles())
	end
end

--what the fuck is that function name...
function hg.WorldModel_Transform_Holstered_Ex(class, model, owner, self)
	local ent = hg.GetCurrentCharacter(owner)
	if IsValid(ent) and self and class and self.holsteredBone then
		local matrix = ent:GetBoneMatrix(ent:LookupBone(self.holsteredBone))
		if not matrix then return end
		local localPos, localAng = self.holsteredPos + self.WorldPos, self.holsteredAng
		local newPos, newAng = LocalToWorld(localPos, localAng, matrix:GetTranslation(), matrix:GetAngles())
		model:SetAngles(newAng)
		local newAng = model:LocalToWorldAngles(self.WorldAng)
		model:SetRenderOrigin(newPos)
		model:SetRenderAngles(newAng)
		model:SetupBones()
	end
end

function SWEP:ClearAttModels()
	if self.modelAtt then
		for atta, model in pairs(self.modelAtt) do
			if not atta or not IsValid(self.modelAtt[atta]) then continue end
			if IsValid(model) then model:Remove() end
			self.modelAtt[atta] = nil
		end
	end
end

function hg.ClearAttModels(model)
	if model.modelAtt then
		for atta, modela in pairs(model.modelAtt) do
			if not atta or not IsValid(modela) then continue end
			if IsValid(modela) then modela:Remove() end
			model.modelAtt[atta] = nil
		end
	end
end

function SWEP:DrawWorldModel()
end

local function removeFlashlights(self)
	if self.flashlight and self.flashlight:IsValid() then
		self.flashlight:Remove()
		self.flashlight = nil
	end
end

local function DrawWorldModel(self)
	if not IsValid(self) then return end
	local owner = self:GetOwner()
	if not IsValid(self.worldModel) then self.worldModel = self:CreateWorldModel() end

	local ent = IsValid(owner) and hg.GetCurrentCharacter(owner)
	if not (IsValid(ent) and ent.shouldTransmit or self.shouldTransmit) then
		self.worldModel:SetNoDraw(true) 
		self:ClearAttModels()
		removeFlashlights(self)
		return
	else
		self.worldModel:SetNoDraw(false)
	end

	if not IsValid(owner) and self:GetVelocity():LengthSqr() < 25 then
		self:WorldModel_Transform()
		return
	end
	
	if self.UseCustomWorldModel then
		if not IsValid(self.worldModel) then self.worldModel = self:CreateWorldModel() end
		
		if IsValid(owner) and (owner:GetActiveWeapon() ~= self) then
			if not self.shouldntDrawHolstered then
				self.worldModel:SetNoDraw(false)
				self:WorldModel_Transform_Holstered()
				self.worldModel:DrawModel()
				self:DrawAttachments()
			else
				self.worldModel:SetNoDraw(true)
				removeFlashlights(self)
				self:DrawAttachments()
			end
			return
		end
		
		self.worldModel:SetNoDraw(false)
		self:WorldModel_Transform()
		self.worldModel:DrawModel()
		self:DrawAttachments()
	else
		if IsValid(self:GetNWEntity("fakeGun")) then return end
		if self.DrawAttachments then
			self:DrawAttachments()
			self:DrawModel()
		end
	end
end

local function removeModels(owner)
	if not IsValid(owner) or not owner.worldModel then return end
	for i, model in pairs(owner.worldModel) do
		if IsValid(model) then
			model:Remove()
			model = nil
		end
	end
end

local function DrawWorldModel_Ex(class, atts, owner)
	local self = weapons.Get(class)

	if not IsValid(owner) then return end

	owner.worldModel = owner.worldModel or {}
	if not IsValid(owner.worldModel[class]) then
		owner.worldModel[class] = hg.CreateWorldModel_Ex(class, owner, self)
		owner:CallOnRemove("removehuys",function() removeModels(owner) end)
	end
	local model = owner.worldModel[class]
	if not owner.shouldTransmit then
		model:SetNoDraw(true)
		hg.DrawAttachments_Ex(class, model, owner, atts, self)
		return
	else
		model:SetNoDraw(false)
	end

	if not self.shouldntDrawHolstered then
		model:SetNoDraw(false)
		hg.WorldModel_Transform_Holstered_Ex(class, model, owner, self)
		model:DrawModel()
		hg.DrawAttachments_Ex(class, model, owner, atts, self)
	else
		model:SetNoDraw(true)
		hg.WorldModel_Transform_Holstered_Ex(class, model, owner, self)
		--model:DrawModel()
		hg.DrawAttachments_Ex(class, model, owner, atts, self)
	end
end

hook.Add("OnGlobalVarSet","hgragdoll",function(key,var)
	if key == "deadragdolls" then
		hg.deadRagdolls = var
	end
end)

hook.Add("PreDrawOpaqueRenderables", "huyCock", function()
	hg.weapons = hg.weapons or {}
	for self in pairs(hg.weapons) do
		if not IsValid(self) then continue end
		DrawWorldModel(self)
	end
	
	for i, ent in pairs(hg.deadRagdolls or {}) do
		local inv = ent:GetNetVar("Inventory",{})
		if not IsValid(ent) or not inv or not inv.Weapons then continue end
		for wep,tbl in pairs(inv.Weapons) do
			if weapons.Get(wep) and weapons.Get(wep).ishgwep then
				DrawWorldModel_Ex(wep,tbl[2],ent)
			end
		end

		if not ent.worldModel then continue end

		for class,model in pairs(ent.worldModel) do
			if not inv.Weapons[class] then
				if IsValid(model) then
					model:Remove()
					model = nil
				end
			end
		end
	end
end)

hook.Add("PreDrawEffects", "huyCock333", function()
	hg.weapons = hg.weapons or {}
	for self in pairs(hg.weapons) do
		if not self.attachments then continue end
		if not self.lasertoggle then removeFlashlights(self) end
		if not table.IsEmpty(self.attachments.underbarrel) and string.find(self.attachments.underbarrel[1], "laser") or self.laser then self:DrawLaser() end
	end
end)

function SWEP:ShouldDrawViewModel()
	return false
end