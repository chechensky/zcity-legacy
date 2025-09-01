-- Path scripthooked:lua\\weapons\\weapon_mp7.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "HK MP7"
SWEP.Author = "Heckler & Koch"
SWEP.Instructions = "Submachine gun chambered in 4.6x30 mm\n\nRate of fire 950 rounds per minute"
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_mp7.mdl"

SWEP.WepSelectIcon2 = Material("vgui/hud/tfa_ins2_mp7.png")
SWEP.IconOverride = "entities/weapon_pwb2_mp7.png"

SWEP.CustomShell = "556x45"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)

SWEP.ShockMultiplier = 2

SWEP.weight = 2.5
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.ShellEject = "EjectBrass_57"
SWEP.Primary.ClipSize = 40
SWEP.Primary.DefaultClip = 40
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "4.6x30 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 32
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 32
SWEP.Primary.Sound = {"homigrad/weapons/pistols/ump45-3.wav", 75, 120, 130}
SWEP.Primary.Wait = 0.05

SWEP.WepSelectIcon2 = Material("vgui/hud/tfa_ins2_mp7.png")

SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor2", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-2,1.3,0),
	},
	sight = {
		["mount"] = Vector(-9, 3, -0.18),
		["mountType"] = "picatinny",
		["empty"] = {"empty", {}},
		["removehuy"] = {},
	},
	underbarrel = {
		["mount"] = Vector(13, 2.05, -0.9),
		["mountAngle"] = Angle(0, 0, -90),
		["mountType"] = "picatinny"
	}
}

SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "smg"
SWEP.ZoomPos = Vector(-3.42, 0.22, 23)
SWEP.RHandPos = Vector(1, -1, 0)
SWEP.LHandPos = Vector(7, -1, 0)
SWEP.Spray = {}
for i = 1, 40 do
	SWEP.Spray[i] = Angle(-0.04 - math.cos(i) * 0.03, math.cos(i * 8) * 0.04, 0) * 2
end

function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_upperarm", Vector(0, 0, 0), Angle(-10, 0, 0))
end

SWEP.Ergonomics = 1.1
SWEP.Penetration = 9
SWEP.WorldPos = Vector(3.5, -0.6, 0)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.lengthSub = 30
SWEP.handsAng = Angle(-15, 9, 0)
SWEP.DistSound = "mp5k/mp5k_dist.wav"