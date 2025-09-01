-- Path scripthooked:lua\\weapons\\weapon_mp5.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "HK MP5"
SWEP.Author = "Heckler & Koch"
SWEP.Instructions = "Submachine gun chambered in 9x19 mm\n\nRate of fire 800 rounds per minute"
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_mp5.mdl"

SWEP.WepSelectIcon2 = Material("vgui/hud/tfa_ins2_mp5a4.png")
SWEP.IconOverride = "vgui/hud/tfa_ins2_mp5a4.png"

SWEP.CustomShell = "9x19"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)

SWEP.weight = 2.5
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 20
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 20
SWEP.Primary.Sound = {"homigrad/weapons/pistols/mp5-1.wav", 75, 120, 130}
SWEP.Primary.Wait = 0.07
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.16,0.32,30)
SWEP.RHandPos = Vector(4, -2, 0)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor4", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-2,0.45,0),
	},
	sight = {
		["mountType"] = "picatinny",
		["mount"] = Vector(-14,2.3,0.08),
	},
	grip = {
		["mount"] = Vector(8,0,0),
		["mountType"] = "picatinny"
	},
	underbarrel = {
		["mount"] = Vector(7,1.3,-1),
		["mountAngle"] = Angle(0, 0, -90),
		["mountType"] = "picatinny"
	}
}

SWEP.attPos = Vector(-3,-1.5,-0.3)
SWEP.attAng = Angle(-0.02,0,0)

SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.02 - math.cos(i) * 0.01, math.cos(i * i) * 0.01, 0) * 2
end

function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_upperarm", Vector(0, 0, 0), Angle(0, 10, -10))
	self:BoneSetAdd(1, "l_finger0", Vector(0, 0, 0), Angle(0, -20, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 20, 0))
end

SWEP.Ergonomics = 1
SWEP.Penetration = 7
SWEP.WorldPos = Vector(13, -0.5, 3.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.lengthSub = 30
SWEP.handsAng = Angle(7, 2, 0)
SWEP.DistSound = "mp5k/mp5k_dist.wav"