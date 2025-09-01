-- "addons\\homigrad-weapons\\lua\\weapons\\weapon_ar15.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "AR-15"
SWEP.Author = "ArmaLite"
SWEP.Instructions = "Semi-automatic rifle chambered in 5.56x45 mm"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/drgordon/weapons/ar-15/m4/colt_m4.mdl"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 44
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 44
SWEP.ShockMultiplier = 3
SWEP.Primary.Sound = {"m16a4/m16a4_fp.wav", 75, 90, 100, 2}
SWEP.Primary.Wait = 0.063
function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_upperarm", Vector(0, 0, 0), Angle(-5, 5, 0))
	self:BoneSetAdd(1, "l_finger0", Vector(0, -0.5, 0), Angle(0, -10, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 40, 0))
end
SWEP.CustomShell = "556x45"
SWEP.EjectPos = Vector(-4,0,4)
SWEP.EjectAng = Angle(0,0,-65)
SWEP.ScrappersSlot = "Primary"
SWEP.WepSelectIcon2 = Material("vgui/hud/tfa_ins2_m4a1.png")
SWEP.IconOverride = "entities/weapon_insurgencym4a1.png"

SWEP.weight = 3

SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor2", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,-0.1), {}},
		["mount"] = Vector(-2,1 - 0.5,0),
	},
	sight = {
		["empty"] = {
			"empty",
			{
				[2] = "models/drgordon/weapons/colt/m4/m4_sights"
			},
		},
		["mount"] = Vector(-13 - 6, 1.8 - 0.4, -0.1),
		--["mountAngle"] = Angle(0,0,0),
		["mountType"] = "picatinny",
		["removehuy"] = {
			[2] = "null"
		}
	},
	grip = {
		["mount"] = Vector(2 + 8.6 - 6, -0.7 + 1, -0.1),
		["mountType"] = "picatinny"
	},
	underbarrel = {
		["mount"] = Vector(2 + 7 - 5, 0.2 + 1.3, -1.2 + 0.15 - 0.05),
		["mountAngle"] = Angle(0, 0, -90),
		["mountType"] = "picatinny"
	}
}

SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-0.15, -3, 7 - 8.5)
SWEP.RHandPos = Vector(-4, 0, -5)
SWEP.LHandPos = Vector(5, -2, -0)
SWEP.AimHands = Vector(-3, 0, -4.8)
SWEP.attPos = Vector(-1.5, 0, -25)
SWEP.attAng = Angle(90, -90, 0)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.02 - math.cos(i) * 0.01, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.Ergonomics = 1
SWEP.Penetration = 13
SWEP.WorldPos = Vector(4, -1, 0)
SWEP.WorldAng = Angle(0, 90, 0)
SWEP.UseCustomWorldModel = true
SWEP.handsAng = Angle(0, 0, 0)
SWEP.handsAng2 = Angle(0, 180, 0)