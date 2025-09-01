-- "addons\\homigrad-weapons\\lua\\weapons\\weapon_ak74u.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "AKS-74U"
SWEP.Author = "Izhevsk Machine-Building Plant"
SWEP.Instructions = "Automatic rifle chambered in 5.45x39 mm\n\nRate of fire 700 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_aks74u.mdl"
SWEP.weaponInvCategory = 1
SWEP.CustomEjectAngle = Angle(0, 0, 90)
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "5.45x39 mm"

SWEP.CustomShell = "545x39"
SWEP.ScrappersSlot = "Primary"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 35
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 35
SWEP.Primary.Sound = {"weapons/aks74u/aks_fp.wav", 75, 120, 140}
SWEP.Primary.Wait = 0.085
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-0.8, 0.25, 29)
SWEP.RHandPos = Vector(-12, -1, 4)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Penetration = 11
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.03 - math.cos(i) * 0.04, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.WepSelectIcon2 = Material("pwb/sprites/aks74u.png")
SWEP.IconOverride = "entities/weapon_pwb_aks74u.png"

SWEP.Ergonomics = 1
SWEP.WorldPos = Vector(13, -1, 4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, -1.5, -0.2)
SWEP.attAng = Angle(-0.05, 0.15, 0)
SWEP.lengthSub = 25
SWEP.handsAng = Angle(1, -1.5, 0)
SWEP.DistSound = "ak74/ak74_dist.wav"

SWEP.availableAttachments = {
	sight = {
		["mountType"] = {"picatinny", "dovetail"},
		["mount"] = Vector(-20, 2.2, -0.25),
	},
	mount = {
		["picatinny"] = {
			"mount1",
			Vector(-16.5, -0.5, -1.2),
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

SWEP.weight = 3