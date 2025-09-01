-- Path scripthooked:lua\\weapons\\weapon_kord.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Cord"
SWEP.Author = "Degtyarev plant"
SWEP.Instructions = "Machine gun chambered in 12.7x108 mm\n\nRate of fire 650 rounds per minute"
SWEP.Category = "Weapons - Machineguns"
SWEP.Primary.ClipSize = 150
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "12.7x108 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 150
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 40
SWEP.Primary.Sound = {"homigrad/weapons/rifle/loud_awp3.wav", 75, 100, 110}
SWEP.Primary.Wait = 0.09
SWEP.ReloadTime = 6
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/kord/kord_gun.mdl"
SWEP.ScrappersSlot = "Primary"
SWEP.weight = 26

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/pkm.png")
SWEP.IconOverride = "entities/weapon_pwb2_pkm.png"

SWEP.CustomShell = "50cal"
SWEP.EjectPos = Vector(0,-20,5)
SWEP.EjectAng = Angle(0,90,0)

SWEP.weaponInvCategory = 1
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(0.025, -2.8, 70)
SWEP.RHandPos = Vector(4, -2, 0)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.ShellEject = "EjectBrass_762Nato"
SWEP.SprayRand = {Angle(-0.3, -0.9, 0), Angle(-0.3, 0.9, 0)}

SWEP.Ergonomics = 0.3
SWEP.OpenBolt = true
SWEP.Penetration = 60
SWEP.WorldPos = Vector(35, -0.5, -4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(-0.3,-0.04,090)
SWEP.AimHands = Vector(0, 1, -3.5)
SWEP.lengthSub = 15
SWEP.DistSound = "m249/m249_dist.wav"
SWEP.bipodAvailable = true

SWEP.availableAttachments = {
	sight = {
		["mountType"] = {"picatinny", "dovetail"},
		["mount"] = Vector(-64, 3.7, -0.7),
	},
	mount = {
		["picatinny"] = {
			"mount1",
			Vector(-64, 2, -0.5),
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