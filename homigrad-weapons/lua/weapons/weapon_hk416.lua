-- Path scripthooked:lua\\weapons\\weapon_hk416.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "HK416"
SWEP.Author = "Heckler & Koch"
SWEP.Instructions = "Automatic rifle chambered in 5.56x45 mm\n\nRate of fire 850 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_hk416.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/hk416.png")
SWEP.IconOverride = "entities/weapon_pwb_hk416.png"

SWEP.CustomShell = "556x45"
--SWEP.EjectPos = Vector(-5,0,-5)
--SWEP.EjectAng = Angle(-45,-80,0)
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
SWEP.Primary.Sound = {"homigrad/weapons/rifle/aug-1.wav", 75, 90, 100}
SWEP.Primary.Wait = 0.063
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor2", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-3,0.75,0),
	},
	sight = {
		["mount"] = Vector(-25, 1.5, -0.18),
		["mountType"] = "picatinny",
		["empty"] = {
			"empty",
			--Vector(0,0,0),
			{
				[1] = "null",
				[2] = "null"
			}
		},
		["removehuy"] = {
			[1] = "null",
			[2] = "null"
		},
	},
	grip = {
		["mount"] = Vector(0, 0, 0),
		["mountType"] = "picatinny"
	},
	underbarrel = {
		["mount"] = Vector(6, 1.5, -1.5),
		["mountAngle"] = Angle(0, 0, -90),
		["mountType"] = "picatinny"
	}
}

SWEP.holsteredPos = Vector(-8, -2.5, -10)
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-2.95, 0.13, 34)
--SWEP.RHandPos = Vector(-14,-3,3.5)
--SWEP.LHandPos = Vector(4,-4,-2)
SWEP.AimHands = Vector(0, 1, -4)
SWEP.RHandPos = Vector(-14, -1, 4)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.03 - math.cos(i) * 0.02, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.Ergonomics = 1
SWEP.Penetration = 13
SWEP.WorldPos = Vector(14, -1, 3.7)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
if CLIENT then end
--[[local rtmat = GetRenderTarget("pwb/models/weapons/v_hk416/glass", ScrW(), ScrH(), false)
    local mat = Material("pwb/models/weapons/v_hk416/glass")
    function SWEP:DrawHUDAdd()
        --self:DoHolo()
    end--]]
SWEP.lengthSub = 20
SWEP.handsAng = Angle(6, -1, 0)