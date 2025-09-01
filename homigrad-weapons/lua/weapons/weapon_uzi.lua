-- Path scripthooked:lua\\weapons\\weapon_uzi.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Uzi"
SWEP.Author = "Israel Military Industries"
SWEP.Instructions = "Submachine gun chambered in 9x19 mm\n\nRate of fire 1000 rounds per minute"
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_uzi.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/uzi.png")
SWEP.IconOverride = "entities/weapon_pwb_uzi.png"

SWEP.weight = 1.5
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.CustomShell = "9x19"
--SWEP.EjectPos = Vector(-5,0,10)
--SWEP.EjectAng = Angle(-80,-90,0)
SWEP.Primary.ClipSize = 32
SWEP.Primary.DefaultClip = 32
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 20
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 20
SWEP.Primary.Sound = {"homigrad/weapons/pistols/mp5-1.wav", 75, 120, 130}
SWEP.Primary.Wait = 0.06
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(-1.92, 0.225, 20)
SWEP.RHandPos = Vector(-15, 0, 3)
SWEP.LHandPos = false
SWEP.Spray = {}
for i = 1, 32 do
	SWEP.Spray[i] = Angle(-0.04 - math.cos(i) * 0.03, math.cos(i * 8) * 0.04, 0) * 2
end

SWEP.Ergonomics = 1.3
SWEP.OpenBolt = true
SWEP.Penetration = 7
SWEP.WorldPos = Vector(14, -1, 1.5)
SWEP.WorldAng = Angle(6.9, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(-2, -2, -0.16)
SWEP.attAng = Angle(-0.2, -6.9, 0)
SWEP.lengthSub = 25
SWEP.DistSound = "mp5k/mp5k_dist.wav"
SWEP.AnimShootMul = 0.5
SWEP.AnimShootHandMul = 0.5
SWEP.holsteredBone = "ValveBiped.Bip01_R_Thigh"
SWEP.holsteredPos = Vector(-5, 5, -6)
SWEP.holsteredAng = Angle(2, -5, 90)