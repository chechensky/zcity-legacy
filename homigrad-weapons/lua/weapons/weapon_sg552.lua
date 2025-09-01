-- Path scripthooked:lua\\weapons\\weapon_sg552.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "SG 552 Commando"
SWEP.Author = "Swiss Arms AG"
SWEP.Instructions = "Automatic rifle chambered in 5.56×45 mm\n\nRate of fire 700 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_sg552.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/sg552.png")
SWEP.IconOverride = "entities/weapon_pwb_sg552.png"
SWEP.weight = 3
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 44
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 44
SWEP.Primary.Sound = {"m16a4/m16a4_fp.wav", 85, 80, 90}
SWEP.Primary.Wait = 0.07
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.05, 0.2, 30)
SWEP.ZoomAng = Angle(0, 0, 0)
SWEP.RHandPos = Vector(-12, -1, 4)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.EjectAng = Angle(180, 0, 0)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.02 - math.cos(i) * 0.01, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.ShockMultiplier = 3

SWEP.ScrappersSlot = "Primary"

SWEP.CustomShell = "556x45"
--SWEP.EjectPos = Vector(0,5,5)
SWEP.EjectAng = Angle(-5,180,0)

SWEP.Ergonomics = 0.9
SWEP.Penetration = 13
SWEP.WorldPos = Vector(13, -1, 4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, -0.5, 0)
SWEP.attAng = Angle(0, 0.2, 0)
SWEP.AimHands = Vector(0, 2, -3)
SWEP.lengthSub = 25
SWEP.handsAng = Angle(3, -0.5, 0)
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor2", Vector(-22, -1.5, -3.2), {}},
	},
	sight = {
		["mountType"] = "picatinny",
		["mount"] = Vector(-17, 1, -0.2),
	},
}