-- Path scripthooked:lua\\weapons\\weapon_pkm.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "PKM"
SWEP.Author = "Degtyarev plant "
SWEP.Instructions = "Machine gun chambered in 7.62x54 mm\n\nRate of fire 650 rounds per minute"
SWEP.Category = "Weapons - Machineguns"
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "7.62x54 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 70
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 70
SWEP.Primary.Sound = {"homigrad/weapons/rifle/rifle4.wav", 75, 100, 110}
SWEP.Primary.Wait = 0.09
SWEP.ReloadTime = 3
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_pkm.mdl"
SWEP.ScrappersSlot = "Primary"
SWEP.weight = 4.5

SWEP.ShockMultiplier = 2

SWEP.CustomShell = "762x54"
SWEP.CustomSecShell = "m60len"
--SWEP.EjectPos = Vector(0,5,5)
--SWEP.EjectAng = Angle(0,-90,0)

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/pkm.png")
SWEP.IconOverride = "entities/weapon_pwb2_pkm.png"

SWEP.weaponInvCategory = 1
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-2.88, -0.135, 36)
SWEP.RHandPos = Vector(4, -2, 0)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.ShellEject = "EjectBrass_762Nato"
SWEP.Spray = {}
for i = 1, 100 do
	SWEP.Spray[i] = Angle(-0.05 - math.cos(i) * 0.04, math.cos(i * i) * 0.05, 0) * 2
end

SWEP.Ergonomics = 0.6
SWEP.OpenBolt = true
SWEP.Penetration = 20
SWEP.WorldPos = Vector(-2, -0.5, 0)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(-0.05, -0.2, 0)
SWEP.AimHands = Vector(0, 1, -3.5)
SWEP.lengthSub = 15
SWEP.DistSound = "m249/m249_dist.wav"
SWEP.bipodAvailable = true

SWEP.availableAttachments = {
	sight = {
		["mountType"] = {"picatinny", "dovetail"},
		["mount"] = Vector(-29.5, 2.8, -0.2),
	},
	mount = {
		["picatinny"] = {
			"mount1",
			Vector(-29.5, 1, -0.2),
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