-- Path scripthooked:lua\\weapons\\weapon_protecta.lua"
-- Scripthooked by ???
if true then return end
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Protecta"
SWEP.Author = "Hilton Walker"
SWEP.Instructions = "Semi-automatic shotgun chambered in 12/70"
SWEP.Category = "Weapons - Shotguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_protecta.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/protecta.png")
SWEP.IconOverride = "entities/weapon_pwb_protecta.png"

SWEP.weight = 3
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "12/70 gauge"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 8
SWEP.Primary.Spread = Vector(0.06, 0.06, 0.06)
SWEP.Primary.Force = 4
SWEP.Primary.Sound = {"toz_shotgun/toz_fp.wav", 80, 70, 75}
SWEP.Primary.Wait = 0.2
SWEP.NumBullet = 8
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 500
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(0.05, 0.4, 27)
SWEP.RHandPos = Vector(-14, 0, 4)
SWEP.LHandPos = Vector(7, 0, -2)
SWEP.ShellEject = "ShotgunShellEject"
SWEP.SprayRand = {Angle(-0.4, -0.7, 0), Angle(-0.6, 0.7, 0)}
SWEP.Ergonomics = 0.75
SWEP.OpenBolt = true
SWEP.Penetration = 5
SWEP.WorldPos = Vector(13, -0.5, 4)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, -2, 0)
SWEP.attAng = Angle(-0.45, -0.8, 0)
SWEP.AimHands = Vector(0, 4, -2)
SWEP.lengthSub = 23
SWEP.DistSound = "toz_shotgun/toz_dist.wav"