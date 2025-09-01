-- Path scripthooked:lua\\weapons\\weapon_tourniquet.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_bandage_sh"
SWEP.PrintName = "Tourniquet"
SWEP.Instructions = "An esmarch tourniquet designed to stop large (arterial) bleedings. Can also be used to stop light bleedings, although it makes the limb ineffective."
SWEP.Category = "Medicine"
SWEP.Spawnable = true
SWEP.Primary.Wait = 1
SWEP.Primary.Next = 0
SWEP.HoldType = "slam"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/tourniquet/tourniquet.mdl"
if CLIENT then
	SWEP.WepSelectIcon2 = Material("scrappers/jgut.png")
	SWEP.IconOverride = "scrappers/jgut.png"
	SWEP.BounceWeaponIcon = false

	function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )


		surface.SetDrawColor( 255, 255, 255, alpha )
		surface.SetMaterial( self.WepSelectIcon2 )
	
		surface.DrawTexturedRect( x, y + 10,  256 * ScrW()/1920 , 128 * ScrH()/1080 )
	
		self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
	
	end
end

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.offsetVec = Vector(4, -1.5, 0)
SWEP.offsetAng = Angle(-30, 20, -90)
SWEP.ModelScale = 1
SWEP.modeNames = {
	[1] = "tourniquet"
}

function SWEP:InitializeAdd()
	self:SetHold(self.HoldType)
	self.modeValues = {
		[1] = 1,
	}
end

SWEP.showstats = false

SWEP.modeValuesdef = {
	{[1] = 1,true}
}

function SWEP:Heal(ent, mode, bone)
	local org = ent.Organism
	if not org then return end
	if self:Tourniquet(ent, bone) then self.modeValues[1] = 0 self:GetOwner():SelectWeapon("weapon_hands_sh") self:Remove() end
end