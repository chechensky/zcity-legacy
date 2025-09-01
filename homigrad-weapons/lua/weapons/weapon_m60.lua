-- Path scripthooked:lua\\weapons\\weapon_m60.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "M60"
SWEP.Author = "Saco Defense"
SWEP.Instructions = "Machine gun chambered in 7.62x51 mm\n\nRate of fire 550 rounds per minute"
SWEP.Category = "Weapons - Machineguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_m60.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/m60.png")
SWEP.IconOverride = "entities/weapon_pwb2_m60.png"

SWEP.CustomShell = "762x51"
SWEP.CustomSecShell = "m60len"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)

SWEP.weight = 5
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 65
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 65
SWEP.Primary.Sound = {"homigrad/weapons/rifle/hmg2.wav", 75, 100, 110}
SWEP.Primary.Wait = 0.11
SWEP.ReloadTime = 3
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-3.55, 0.05, 38)
SWEP.RHandPos = Vector(-4, -2, 0)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.ShellEject = "EjectBrass_762Nato"
SWEP.Spray = {}
for i = 1, 200 do
	SWEP.Spray[i] = Angle(-0.05 - math.cos(i) * 0.04, math.cos(i * i) * 0.05, 0) * 2
end

SWEP.ShockMultiplier = 2

SWEP.Ergonomics = 0.6
SWEP.OpenBolt = true
SWEP.Penetration = 20
SWEP.WorldPos = Vector(4, 0, 0)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(0, -0.1, 0)
SWEP.AimHands = Vector(0, 1.75, -4.2)
SWEP.lengthSub = 15
SWEP.DistSound = "m249/m249_dist.wav"
SWEP.bipodAvailable = true