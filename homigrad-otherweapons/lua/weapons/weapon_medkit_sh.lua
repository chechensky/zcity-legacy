-- Path scripthooked:lua\\weapons\\weapon_medkit_sh.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_bandage_sh"
SWEP.PrintName = "Medkit"
SWEP.Instructions = "A small bag containing medical supplies. Has bandages, painkillers, tourniquets and internal bleeding medicine. RMB to apply on others, R to change use mode."
SWEP.Category = "Medicine"
SWEP.Spawnable = true
SWEP.Primary.Wait = 1
SWEP.Primary.Next = 0
SWEP.HoldType = "slam"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/w_models/weapons/w_eq_medkit.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_medkit")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_medkit.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.offsetVec = Vector(4, -0.5, -3)
SWEP.offsetAng = Angle(-30, 20, 90)
SWEP.modes = 4
SWEP.modeNames = {
	[1] = "bandaging",
	[2] = "painkiller",
	[3] = "internal bleeding medicine",
	[4] = "tourniquet",
}
SWEP.ofsV = Vector(-2,-10,8)
SWEP.ofsA = Angle(90,-90,90)
function SWEP:InitializeAdd()
	self:SetHold(self.HoldType)
	self.modeValues = {
		[1] = 70,
		[2] = 1,
		[3] = 50,
		[4] = 1
	}
end

SWEP.modeValuesdef = {
	[1] = {70,true},
	[2] = {1,false},
	[3] = {50,true},
	[4] = {1,true}
}
SWEP.ShouldDeleteOnFullUse = true

if SERVER then
	function SWEP:Heal(ent, mode, bone)
		local org = ent.Organism
		if not org then return end
		local owner = self:GetOwner()
		local entOwner = IsValid(owner.FakeRagdoll) and owner.FakeRagdoll or owner
		if self.mode == 2 then
			if self.modeValues[2] == 0 then return end
			org.anesthetics = math.Clamp(org.anesthetics + 1, 0, 1000000)
			org.pain = math.Clamp(org.pain - 20, 0, 1000000)
			self.modeValues[2] = 0
			entOwner:EmitSound("snds_jack_gmod/ez_medical/15.wav", 60, math.random(95, 105))
		elseif self.mode == 3 then
			if self.modeValues[3] == 0 then return end
			local val = org.o2[1]
			local healed = math.max(val - self.modeValues[3], 0)
			self.modeValues[3] = self.modeValues[3] - (val - healed)
			org.o2[1] = healed
			local val = org.o2[2]
			local healed = math.max(val - self.modeValues[3], 0)
			self.modeValues[3] = self.modeValues[3] - (val - healed)
			org.o2[2] = healed
			local internalBleed = org.internalBleed
			if internalBleed > 0 then
				local healed = math.max(internalBleed - self.modeValues[3], 0)
				self.modeValues[3] = self.modeValues[3] - (internalBleed - healed)
				org.internalBleed = org.internalBleed - (internalBleed - healed)
				entOwner:EmitSound("snds_jack_gmod/ez_medical/" .. math.random(16, 18) .. ".wav", 60, math.random(95, 105))
			end
		elseif self.mode == 1 then
			self:Bandage(ent, bone)
		elseif self.mode == 4 then
			if self.modeValues[4] == 0 then return end
			if self:Tourniquet(ent, bone) then 
				self.modeValues[4] = 0 
			end
		end

		if self.modeValues[1] == 0 and self.modeValues[2] == 0 and self.modeValues[3] == 0 and self.modeValues[4] == 0 and self.ShouldDeleteOnFullUse then
			owner:SelectWeapon("weapon_hands_sh")
			self:Remove()
		end
	end
end