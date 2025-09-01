-- Path scripthooked:lua\\weapons\\weapon_hk21.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "HK21"
SWEP.Author = "Heckler & Koch"
SWEP.Instructions = "Machine gun chambered in 7.62x51 mm\n\nRate of fire 900 rounds per minute. That thing is quite serious if you might ask."
SWEP.Category = "Weapons - Machineguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_hk23e.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/hk23e.png")
SWEP.IconOverride = "entities/weapon_pwb_hk23e.png"

SWEP.CustomShell = "762x51"
SWEP.CustomSecShell = "mc51len"
--SWEP.EjectPos = Vector(-5,0,-5)
--SWEP.EjectAng = Angle(-45,-80,0)

SWEP.ScrappersSlot = "Primary"
SWEP.weight = 5

SWEP.ShockMultiplier = 2

SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 150
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 65
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 65
SWEP.Primary.Sound = {"homigrad/weapons/rifle/pdr-2.wav", 75, 80, 90}
SWEP.Primary.Wait = 0.066
SWEP.ReloadTime = 3
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-4.15, 0.17, 42)
SWEP.RHandPos = Vector(-14, -1, 4)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 150 do
	SWEP.Spray[i] = Angle(-0.04 - math.cos(i) * 0.03, math.cos(i * i) * 0.05, 0) * 2
end

SWEP.ShellEject = "EjectBrass_762Nato"
SWEP.Ergonomics = 0.6
SWEP.OpenBolt = true
SWEP.Penetration = 20
SWEP.WorldPos = Vector(14, -1, 4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.AimHands = Vector(0, 1.8, -4.5)
SWEP.lengthSub = 15
SWEP.DistSound = "m249/m249_dist.wav"
SWEP.bipodAvailable = true