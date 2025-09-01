-- Path scripthooked:lua\\weapons\\weapon_l85a1.lua"
-- Scripthooked by ???
if true then return end
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "L85A1"
SWEP.Author = "Royal Small Arms Factory / Royal Ordnance"
SWEP.Instructions = "Automatic rifle chambered in 5.56x45 mm\n\nRate of fire 650 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_l85a1.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/l85a1.png")
SWEP.IconOverride = "entities/weapon_pwb_l85a1.png"

SWEP.ShockMultiplier = 3

SWEP.weight = 3
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 44
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 44
SWEP.Primary.Sound = {"homigrad/weapons/rifle/l85a1.wav", 75, 90, 100}
SWEP.Primary.Wait = 0.09
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-3.18, 0.325, 27)
SWEP.RHandPos = Vector(-12, -1, 4)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.03 - math.cos(i) * 0.02, math.cos(i * i) * 0.03, 0) * 2
end

SWEP.Ergonomics = 0.8
SWEP.Penetration = 13
SWEP.WorldPos = Vector(15, 0, 4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, -0.5)
SWEP.attAng = Angle(-0, 0.4, 0)
SWEP.AimHands = Vector(1, 2, -3.5)
SWEP.lengthSub = 20
SWEP.handsAng = Angle(2, 2, 0)