-- Path scripthooked:lua\\weapons\\weapon_m249.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "M249"
SWEP.Author = "FN Herstal"
SWEP.Instructions = "Machine gun chambered in 5.56x45 mm\n\nRate of fire 775 rounds per minute"
SWEP.Category = "Weapons - Machineguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_m249paratrooper.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/m249paratrooper.png")
SWEP.IconOverride = "entities/weapon_pwb2_m249paratrooper.png"

SWEP.CustomShell = "556x45"
SWEP.CustomSecShell = "m249len"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)

SWEP.ScrappersSlot = "Primary"

SWEP.weight = 5

SWEP.ShockMultiplier = 3

SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 150
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 44
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 44
SWEP.Primary.Sound = {"m249/m249_fp.wav", 75, 90, 100}
SWEP.Primary.Wait = 0.06
SWEP.ReloadTime = 3
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.65, 0.15, 34)
SWEP.RHandPos = Vector(-5, -2, 0)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 150 do
	SWEP.Spray[i] = Angle(-0.03 - math.cos(i) * 0.02, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.Ergonomics = 0.75
SWEP.OpenBolt = true
SWEP.Penetration = 15
SWEP.WorldPos = Vector(4, 0, 0)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, -1, 0)
SWEP.attAng = Angle(0, -0.2, 0)
SWEP.AimHands = Vector(0, 1.65, -3.65)
SWEP.lengthSub = 15
SWEP.DistSound = "m249/m249_dist.wav"
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor2", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-2,-0.2+1,0),
	},
	sight = {
		["mount"] = Vector(-21, 1.9, -0.15),
		["mountType"] = "picatinny",
	}
}

SWEP.bipodAvailable = true