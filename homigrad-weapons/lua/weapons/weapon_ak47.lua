-- Path scripthooked:lua\\weapons\\weapon_ak47.lua"
-- Scripthooked by ???
if true then return end
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "AK-47"
SWEP.Author = "Izhevsk Machine-Building Plant"
SWEP.Instructions = "Automatic rifle chambered in 7.62x39 mm\n\nRate of fire 600 rounds per minute\n\nSince this AK-47 is mirrored for some reason, it is very convenient to catch hot cartridges with your left wrist."
SWEP.Category = "Weapons - Machineguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_rpk.mdl"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 75
SWEP.Primary.DefaultClip = 75
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 50
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 50
SWEP.Primary.Sound = {"ak74/ak74_fp.wav", 85, 90, 100}
SWEP.Primary.Wait = 0.1
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.34, 0.16, 35)
SWEP.RHandPos = Vector(-12, -1, 4)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.Spray = {}
for i = 1, 75 do
	SWEP.Spray[i] = Angle(-0.04 - math.cos(i) * 0.03, math.cos(i * i) * 0.05, 0) * 2
end
SWEP.ScrappersSlot = "Primary"
SWEP.Ergonomics = 0.8
SWEP.Penetration = 15
SWEP.ShellEject = "EjectBrass_338Mag"
SWEP.EjectAng = Angle(180, 0, 0)
SWEP.WorldPos = Vector(14, -0.5, 4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(0.17, -0.75, 0)
SWEP.lengthSub = 15
SWEP.DistSound = "ak74/ak74_dist.wav"

SWEP.weight = 4