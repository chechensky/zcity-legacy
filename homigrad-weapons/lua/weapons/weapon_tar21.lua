-- Path scripthooked:lua\\weapons\\weapon_tar21.lua"
-- Scripthooked by ???
if true then return end
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "TAR-21"
SWEP.Author = "Israel Weapon Industries"
SWEP.Instructions = "Automatic rifle chambered in 5.56×45 mm\n\nRate of fire 900 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_tar21.mdl"
SWEP.ScrappersSlot = "Primary"
SWEP.WepSelectIcon2 = Material("pwb/sprites/tar21.png")
SWEP.IconOverride = "entities/weapon_pwb_tar21.png"
SWEP.weight = 3
SWEP.CustomShell = "556x45"
--SWEP.EjectPos = Vector(0,5,5)
--SWEP.EjectAng = Angle(-5,180,0)

SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 44
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 44
SWEP.Primary.Sound = {"m16a4/m16a4_fp.wav", 75, 90, 100}
SWEP.Primary.Wait = 0.066
SWEP.ReloadTime = 1.5
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.48, 0.225, 21)
SWEP.RHandPos = Vector(-12, -1, 4)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.03 - math.cos(i) * 0.02, math.cos(i * i) * 0.03, 0) * 2
end

SWEP.ShockMultiplier = 3

SWEP.Ergonomics = 0.8
SWEP.Penetration = 13
SWEP.WorldPos = Vector(19, -0.4, 3.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, -2, 0)
SWEP.attAng = Angle(-0, 0.2, 0)
SWEP.AimHands = Vector(0, 2, -3)
SWEP.lengthSub = 28
SWEP.handsAng = Angle(0, 2, -10)