-- Path scripthooked:lua\\weapons\\weapon_sawedoff.lua"
-- Scripthooked by ???
if true then return end
--ents.Reg(nil,"weapon_m4super")
SWEP.Base = "weapon_m4super"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Ithaca 37"
SWEP.Author = "Ithaca Gun Company"
SWEP.Instructions = "Pump-action shotgun chambered in 12/70"
SWEP.Category = "Weapons - Shotguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_ithaca37stakeout.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/ithaca37stakeout")
SWEP.IconOverride = "entities/weapon_pwb2_ithaca37stakeout.png"
SWEP.weight = 2
SWEP.weaponInvCategory = 1
SWEP.ShellEject = "ShotgunShellEject"
SWEP.AutomaticDraw = false
SWEP.UseCustomWorldModel = false
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "12/70 gauge"
SWEP.Primary.Cone = 0
SWEP.Primary.Spread = Vector(0.07, 0.07, 0.07)
SWEP.Primary.Sound = {"homigrad/weapons/shotguns/xm1014-1.wav", 80, 90, 100}
SWEP.Primary.Wait = 0.25
SWEP.NumBullet = 8
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 500
SWEP.ReloadInsertCooldownFire = 0.25
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-0.45, 0.58, 30)
SWEP.RHandPos = Vector(-2, -1, 1)
SWEP.LHandPos = Vector(7, 0, -2)
SWEP.SprayRand = {Angle(-0.2, -0.4, 0), Angle(-0.4, 0.4, 0)}
SWEP.Ergonomics = 0.9
SWEP.Penetration = 7
SWEP.WorldPos = Vector(3, -1, 1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.attPos = Vector(0,0,-0.5)
SWEP.UseCustomWorldModel = true
SWEP.lengthSub = 22
SWEP.handsAng = Angle(-1, 0, 0)

SWEP.ScrappersSlot = "Primary"