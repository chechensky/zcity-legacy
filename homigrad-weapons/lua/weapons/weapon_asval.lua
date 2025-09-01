-- "addons\\homigrad-weapons\\lua\\weapons\\weapon_asval.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "AS «Val»"
SWEP.Author = "TsNIITochmash Tula arms plant"
SWEP.Instructions = "Automatic rifle for 9x39 mm caliber\n\nRate of fire 900 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_asval.mdl"
SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/asval.png")
SWEP.IconOverride = "entities/weapon_pwb2_asval.png"
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.dwr_customIsSuppressed = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "9x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 42
SWEP.Primary.Spread = 2
SWEP.Primary.Force = 42
SWEP.Primary.Sound = {"homigrad/weapons/rifle/m4a1-1.wav", 65, 90, 100}
SWEP.SupressedSound = {"homigrad/weapons/rifle/m4a1-1.wav", 65, 90, 100}
SWEP.Primary.Wait = 0.066
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.75, 0.43, 35)
SWEP.RHandPos = Vector(-5, -1, 1)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.ShockMultiplier = 3
SWEP.CustomShell = "762x39"
--SWEP.EjectPos = Vector(-4,0,4)
--SWEP.EjectAng = Angle(0,0,-65)

SWEP.weight = 4

SWEP.Spray = {}
for i = 1, 20 do
	SWEP.Spray[i] = Angle(-0.03 - math.cos(i) * 0.02, math.cos(i * i) * 0.06, 0) * 1
end

SWEP.Ergonomics = 0.9
SWEP.Penetration = 15
SWEP.WorldPos = Vector(3, -1, 1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, -0.5)
SWEP.attAng = Angle(-0, 0.05, 0)
SWEP.lengthSub = 15
SWEP.handsAng = Angle(0, 0, 0)
SWEP.Supressor = true
SWEP.SetSupressor = true
SWEP.availableAttachments = {
	sight = {
		["mountType"] = {"dovetail","picatinny"},
		["mount"] = Vector(-24, 2.3, 0),
	},
	mount = {
		["picatinny"] = {
			"mount3",
			Vector(-20.5, -0.4, -1),
			{},
			["mountType"] = "picatinny",
		},
		["dovetail"] = {
			"empty",
			Vector(0, 0, 0),
			{},
			["mountType"] = "dovetail",
		},
	},
}