-- Path scripthooked:lua\\weapons\\weapon_painkillers.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_bandage_sh"
SWEP.PrintName = "Painkillers"
SWEP.Instructions = "Can be used to relieve pain (thanks Mr. Obvious). RMB to use on someone else."
SWEP.Category = "Medicine"
SWEP.Spawnable = true
SWEP.Primary.Wait = 1
SWEP.Primary.Next = 0
SWEP.HoldType = "slam"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/bloocobalt/l4d/items/w_eq_pills.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_painpills")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_painpills.png"
	SWEP.BounceWeaponIcon = false
end
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.offsetVec = Vector(2.5, -2.5, 0)
SWEP.offsetAng = Angle(-30, 20, 180)
SWEP.modeNames = {
	[1] = "painkiller"
}

function SWEP:InitializeAdd()
	self:SetHold(self.HoldType)
	self.modeValues = {
		[1] = 1
	}
end

SWEP.modeValuesdef = {
	{[1] = 1,false}
}

SWEP.showstats = false

SWEP.DeploySnd = "snd_jack_hmcd_pillsbounce.wav"
SWEP.FallSnd = "snd_jack_hmcd_pillsbounce.wav"

if SERVER then
	local rndsounds = {"snd_jack_hmcd_pillsuse.wav"}
	function SWEP:Heal(ent, mode)
		local org = ent.Organism
		if not org then return end
		self:SetBodygroup(1, 1)
		local owner = self:GetOwner()
		local entOwner = IsValid(owner.FakeRagdoll) and owner.FakeRagdoll or owner
		entOwner:EmitSound(table.Random(rndsounds), 60, math.random(95, 105))
		--org.adrenaline = math.min(org.adrenaline + self.modeValues[1] / 4, 3)
		org.anesthetics = math.Clamp(org.anesthetics + 1, 0, 1000000)
		org.pain = math.Clamp(org.pain - 20, 0, 1000000)
		self.modeValues[1] = 0
		if self.modeValues[1] == 0 then
			owner:SelectWeapon("weapon_hands_sh")
			self:Remove()
		end
	end
end