-- Path scripthooked:lua\\weapons\\weapon_m4a1.lua"
-- Scripthooked by ???
SWEP.Base = "weapon_ar15"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.PrintName = "M4A1"
SWEP.Author = "Colt’s Manufacturing Company"
SWEP.Instructions = "Automatic rifle chambered in 5.56x45 mm\n\nRate of fire 950 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_upperarm", Vector(0, 0, 0), Angle(-5, 5, 0))
	self:BoneSetAdd(1, "l_finger0", Vector(0, -0.5, 0), Angle(0, -10, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 40, 0))
end
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/drgordon/weapons/ar-15/m4/colt_m4.mdl"

SWEP.Primary.Automatic = true