-- Path scripthooked:lua\\weapons\\weapon_revolver.lua"
-- Scripthooked by ???
if true then return end
SWEP.Base = "weapon_revolver2"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Mateba 6 Unica Home Protection"
SWEP.Author = "Mateba"
SWEP.Instructions = "Revolver chambered in .44 Remington Magnum"
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_matebahomeprotection.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/matebahomeprotection.png")
SWEP.IconOverride = "entities/weapon_pwb2_matebahomeprotection.png"

SWEP.weight = 1.5

SWEP.ScrappersSlot = "Secondary"

SWEP.weaponInvCategory = 2
SWEP.ShellEject = false
SWEP.ShellEject2 = "EjectBrass_57"
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ".44 Remington Magnum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 40
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 40
SWEP.Primary.Sound = {"homigrad/weapons/pistols/deagle-1.wav", 75, 90, 100}
SWEP.Primary.Wait = 0.2
SWEP.ReloadTime = 2
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.HoldType = "revolver"
SWEP.AimHold = "revolver"
SWEP.ZoomPos = Vector(0.65, 0.58, 30)
SWEP.RHandPos = Vector(0, 0, 1)
SWEP.LHandPos = false
SWEP.SprayRand = {Angle(-0.1, -0.2, 0), Angle(-0.2, 0.2, 0)}
SWEP.AnimShootMul = 4
SWEP.AnimShootHandMul = 4
SWEP.Ergonomics = 0.9
SWEP.OpenBolt = true
SWEP.Penetration = 10

SWEP.CustomShell = "10mm"

SWEP.WorldPos = Vector(-1, -1, -1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0.8, -1.5, -0.6)
SWEP.attAng = Angle(0, -0.3, 0)
SWEP.lengthSub = 25
SWEP.DistSound = "hndg_sw686/revolver_fire_01.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_Pelvis"
SWEP.holsteredPos = Vector(-2, 5, 9)
SWEP.holsteredAng = Angle(25, -65, -90)
SWEP.shouldntDrawHolstered = true