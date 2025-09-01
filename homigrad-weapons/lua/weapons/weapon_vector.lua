-- Path scripthooked:lua\\weapons\\weapon_vector.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "KRISS Vector"
SWEP.Author = "Transformational Defense Industries, Inc"
SWEP.Instructions = "Submachine gun chambered in 9x19 mm\n\nRate of fire 1500 rounds per minute"
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_vectorsmg.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/vectorsmg.png")
SWEP.IconOverride = "entities/weapon_pwb2_vectorsmg.png"

SWEP.weight = 2.5
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.CustomShell = "9x19"
--SWEP.EjectPos = Vector(-5,0,10)
--SWEP.EjectAng = Angle(-80,-90,0)
SWEP.WorldPos = Vector(1, -0.8, 0)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.Primary.ClipSize = 33
SWEP.Primary.DefaultClip = 33
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 23
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 23
SWEP.Primary.Sound = {"homigrad/weapons/pistols/p228-1.wav", 75, 120, 130}
SWEP.Primary.Wait = 0.04
SWEP.availableAttachments = {
	sight = {
		["mountType"] = "picatinny",
		["mount"] = Vector(-11, 2.8, -0.28),
		["empty"] = {
			"empty",
			{
				[8] = "pwb2/models/weapons/w_vectorsmg/sight"
			},
		},
		["removehuy"] = {
			[8] = "null"
		},
	},
	barrel = {
		[1] = {"supressor4", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-3.5 + 2,0.4 +0.65,1.3-1.45),
	}
}

SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "smg"
SWEP.ZoomPos = Vector(-4, 0.25, 22)
SWEP.RHandPos = Vector(-2, -2, 0)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 33 do
	SWEP.Spray[i] = Angle(-0.005 - math.cos(i) * 0.01, math.cos(i * i) * 0.07, 0) * 2
end

SWEP.Ergonomics = 1.1
function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_hand", Vector(0, 0, 0), Angle(-15, 5, -5))
end

SWEP.Penetration = 7
SWEP.lengthSub = 31
SWEP.handsAng = Angle(0, 1, 0)
SWEP.DistSound = "mp5k/mp5k_dist.wav"