-- Path scripthooked:lua\\weapons\\weapon_makarov.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Makarov Pistol"
SWEP.Author = "Ижевский механический завод"
SWEP.Instructions = "Pistol chambered in 9x18mm"
SWEP.Category = "Weapons - Pistols"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/tfa_ins2/w_pm.mdl"

SWEP.WepSelectIcon2 = Material("vgui/hud/tfa_ins2_pm.png")
SWEP.IconOverride = "entities/weapon_insurgencymakarov.png"

SWEP.CustomShell = "9x18"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)

SWEP.weight = 1

SWEP.ScrappersSlot = "Secondary"

SWEP.weaponInvCategory = 2
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "9x18 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 8
SWEP.Primary.Sound = {"hndg_beretta92fs/beretta92_fire1.wav", 75, 90, 100}
SWEP.Primary.Force = 5
SWEP.ReloadTime = 2.3
SWEP.Primary.Wait = 0.12
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(0, -0.7, 26)
SWEP.RHandPos = Vector(-5, -1.5, 2)
SWEP.LHandPos = false
SWEP.SprayRand = {Angle(-0, -0.01, 0), Angle(-0.01, 0.01, 0)}
SWEP.Ergonomics = 1
SWEP.AnimShootMul = 2.5
SWEP.AnimShootHandMul = 0.2
SWEP.addSprayMul = 0.5
SWEP.Penetration = 4
SWEP.ShockMultiplier = 1
SWEP.WorldPos = Vector(4, -1.5, -2.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(0.4, 0, 0)
SWEP.lengthSub = 25
SWEP.DistSound = "m9/m9_dist.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_R_Thigh"
SWEP.holsteredPos = Vector(0, 0, 0)
SWEP.holsteredAng = Angle(-5, -5, 90)
SWEP.shouldntDrawHolstered = true