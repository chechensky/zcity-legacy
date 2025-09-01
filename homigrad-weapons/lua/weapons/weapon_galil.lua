-- Path scripthooked:lua\\weapons\\weapon_galil.lua"
-- Scripthooked by ???
if true then return end
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Galil ACE23"
SWEP.Author = "Israel Weapon Industries"
SWEP.Instructions = "Automatic rifle chambered in 5.56×45 mm\n\nRate of fire 700 rounds per minute\n\nBRUH wtf is that model"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_ace23.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/ace23.png")
SWEP.IconOverride = "entities/weapon_pwb2_ace23.png"

SWEP.CustomShell = "556x45"
--SWEP.EjectPos = Vector(-5,2,10)
--SWEP.EjectAng = Angle(-55,80,0)

SWEP.ScrappersSlot = "Primary"

SWEP.weight = 3.5

SWEP.ShockMultiplier = 3

SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 44
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 44
SWEP.Primary.Sound = {"homigrad/weapons/rifle/famas2.wav", 85, 90, 100}
SWEP.Primary.Wait = 0.085
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-3.30, 0.27, 35)
SWEP.ZoomAng = Angle(0, 0, 0)
SWEP.RHandPos = Vector(2, -1, -1)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.02 - math.cos(i) * 0.01, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.Ergonomics = 0.9
SWEP.Penetration = 13
SWEP.WorldPos = Vector(-2, -1, 0)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(0, -1.5, 0)
SWEP.AimHands = Vector(0, 2, -4)
SWEP.lengthSub = 20
SWEP.handsAng = Angle(2, 0, 0)
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor2", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-3,0.65,-0.1),
	},
	sight = {
		["mountType"] = "picatinny",
		["mount"] = Vector(-21, 1.5, -0.3),
	},
}

SWEP.holsteredBone = "ValveBiped.Bip01_Spine2"
SWEP.holsteredPos = Vector(-8, -3.8, -9)
SWEP.holsteredAng = Angle(0, 0, 0)