-- Path scripthooked:lua\\weapons\\weapon_akm.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "AKM"
SWEP.Author = "Izhevsk Machine-Building Plant"
SWEP.Instructions = "Automatic rifle chambered in 7.62x39 mm\n\nRate of fire 600 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_akm.mdl"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 50
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 50
SWEP.ShockMultiplier = 2
SWEP.Primary.Sound = {"ak74/ak74_fp.wav", 85, 90, 100}
SWEP.SupressedSound = {"ak74/ak74_suppressed_fp.wav", 65, 90, 100}
SWEP.GripScotch = true
SWEP.WepSelectIcon2 = Material("pwb/sprites/akm.png")
SWEP.IconOverride = "entities/weapon_pwb_akm.png"
SWEP.ScrappersSlot = "Primary"
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor1", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-1,0,0),
	},
	sight = {
		["mountType"] = {"picatinny", "dovetail"},
		["mount"] = Vector(-23.5, 1.8, -0.4),
	},
	grip = {
		["mount"] = Vector(2 + 8.6 - 6, -0.7 + 1, -0.1),
		["mountType"] = "picatinny",
	},
	mount = {
		["picatinny"] = {
			"mount3",
			Vector(-20.5, -0.8, -1.36),
			{},
			["mountType"] = "picatinny",
		},
		["dovetail"] = {
			"empty",
			Vector(0, 0, 0),
			{},
			["mountType"] = "dovetail",
		},
	}
}

SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.66, 0.25, 35)
SWEP.RHandPos = Vector(-12, -1, 4)
SWEP.LHandPos = Vector(7, -3, -2)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.06 - math.cos(i) * 0.03, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.Ergonomics = 0.8
SWEP.HaveModel = "models/pwb/weapons/w_akm.mdl"
--SWEP.ShellEject = "EjectBrass_338Mag"
SWEP.CustomShell = "762x39"

SWEP.Penetration = 15
SWEP.WorldPos = Vector(13, -1, 4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
--https://youtu.be/I7TUHPn_W8c?list=RDEMAfyWQ8p5xUzfAWa3B6zoJg
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(-0, 0.05, 0)
SWEP.lengthSub = 20
SWEP.handsAng = Angle(3, -1, 0)
SWEP.AimHands = Vector(-4, 0.5, -4)
SWEP.DistSound = "ak74/ak74_dist.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_Spine2"
SWEP.holsteredPos = Vector(-8, -3.8, -9)
SWEP.holsteredAng = Angle(0, 0, 0)

SWEP.weight = 4

function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_upperarm", Vector(0, 0, 0), Angle(0, 5, -5))
	self:BoneSetAdd(1, "l_finger0", Vector(0.7, -0.3, 0), Angle(0, -20, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 40, 0))
end