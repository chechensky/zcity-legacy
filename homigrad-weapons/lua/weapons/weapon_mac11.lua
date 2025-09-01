-- Path scripthooked:lua\\weapons\\weapon_mac11.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "MAC-11"
SWEP.Author = "Military Armament Corporation"
SWEP.Instructions = "Submachine gun chambered in 9x17 mm\n\nRate of fire 1600 rounds per minute"--BRUH TOO LAZY MF TOO LAZY BROOO
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_mac11.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/mac11.png")
SWEP.IconOverride = "entities/weapon_pwb2_mac11.png"

SWEP.CustomShell = "9x19"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)

SWEP.weight = 1

SWEP.ScrappersSlot = "Secondary"

SWEP.weaponInvCategory = 2
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.Primary.ClipSize = 32
SWEP.Primary.DefaultClip = 32
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 16
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 16
SWEP.Primary.Sound = {"homigrad/weapons/pistols/mac10-1.wav", 75, 120, 130}
SWEP.Primary.Wait = 0.0375
SWEP.ReloadTime = 2
--SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(-2, 0.1, 23)
SWEP.RHandPos = Vector(3, -1, 2)
SWEP.LHandPos = false
SWEP.Spray = {}
for i = 1, 32 do
	SWEP.Spray[i] = Angle(-0.04 - math.cos(i) * 0.03, math.cos(i ^ 3) * 0.1, 0) * 2
end

SWEP.Ergonomics = 1.3
SWEP.OpenBolt = true
SWEP.Penetration = 6
SWEP.WorldPos = Vector(-3, -1, 2)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.lengthSub = 25
SWEP.DistSound = "m9/m9_dist.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_Pelvis"
SWEP.holsteredPos = Vector(-2, 5, 6)
SWEP.holsteredAng = Angle(25, -65, -90)
SWEP.shouldntDrawHolstered = true