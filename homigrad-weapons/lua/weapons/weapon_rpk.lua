-- Path scripthooked:lua\\weapons\\weapon_rpk.lua"
-- Scripthooked by ???
if true then return end
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "RPK"
SWEP.Author = "Vyatsko-Polyansky Machine-Building Plant \"Molot\""
SWEP.Instructions = "Automatic rifle chambered in 7.62x39 mm\n\nRate of fire 600 rounds per minute"
SWEP.Category = "Weapons - Machineguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_rpk.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/rpk.png")
SWEP.IconOverride = "entities/weapon_pwb2_rpk.png"
SWEP.weight = 4
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 45
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 50
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 50
SWEP.Primary.Sound = {"ak74/ak74_fp.wav", 85, 90, 100}
SWEP.SupressedSound = {"ak74/ak74_suppressed_fp.wav", 65, 90, 100}
SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-4.19, 0.21, 38)
SWEP.RHandPos = Vector(-2, -2, 3)
SWEP.LHandPos = Vector(7, 6, -2)
SWEP.ShellEject = "EjectBrass_338Mag"
SWEP.Spray = {}
for i = 1, 45 do
	SWEP.Spray[i] = Angle(-0.04 - math.cos(i) * 0.03, math.cos(i * i) * 0.05, 0) * 2
end

SWEP.ShockMultiplier = 2

SWEP.ScrappersSlot = "Primary"

SWEP.Ergonomics = 0.75
SWEP.Penetration = 15
SWEP.WorldPos = Vector(2, -1, 1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(0, -1.6, 0)
SWEP.AimHands = Vector(0, 0.8, -0.9)
SWEP.lengthSub = 15
SWEP.handsAng = Angle(0, 2, 0)
SWEP.DistSound = "ak74/ak74_dist.wav"
SWEP.bipodAvailable = true