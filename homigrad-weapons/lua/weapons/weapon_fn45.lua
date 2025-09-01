-- Path scripthooked:lua\\weapons\\weapon_fn45.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "FNX-45"
SWEP.Author = "FNH-USA"
SWEP.Instructions = "Pistol chambered in .45 ACP"--bruh too lazy to make .45 acp
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_fnp45.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/fnp45.png")
SWEP.IconOverride = "entities/weapon_pwb_fnp45.png"

SWEP.CustomShell = "45acp"
SWEP.EjectPos = Vector(-5,2,10)
--SWEP.EjectAng = Angle(-55,80,0)

SWEP.weight = 1

SWEP.ScrappersSlot = "Secondary"

SWEP.weaponInvCategory = 2
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.Primary.ClipSize = 15
SWEP.Primary.DefaultClip = 15
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 25
SWEP.Primary.Sound = {"hndg_beretta92fs/beretta92_fire1.wav", 75, 90, 100}
SWEP.Primary.Force = 25
SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.UseCustomWorldModel = true
SWEP.WorldPos = Vector(13, -0.5, 2.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(.88, 0.51, 30)
SWEP.RHandPos = Vector(-13.5, 0, 3)
SWEP.LHandPos = false
SWEP.attPos = Vector(0, -2, -0.5)
SWEP.attAng = Angle(0, 0, 0)
SWEP.SprayRand = {Angle(-0.03, -0.03, 0), Angle(-0.05, 0.03, 0)}
SWEP.Ergonomics = 1.2
SWEP.Penetration = 7
SWEP.lengthSub = 25
SWEP.DistSound = "m9/m9_dist.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_R_Thigh"
SWEP.holsteredPos = Vector(0, 0, -3)
SWEP.holsteredAng = Angle(-5, -5, 90)
SWEP.shouldntDrawHolstered = true