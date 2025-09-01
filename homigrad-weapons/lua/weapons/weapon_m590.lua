-- Path scripthooked:lua\\weapons\\weapon_m590.lua"
-- Scripthooked by ???
--ents.Reg(nil,"weapon_m4super")
if true then return end
SWEP.Base = "weapon_m4super"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Mossberg 590"
SWEP.Author = "O.F. Mossberg & Sons"
SWEP.Instructions = "Pump-action shotgun chambered in 12/70"
SWEP.Category = "Weapons - Shotguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_mossberg590.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/mossberg590.png")
SWEP.IconOverride = "entities/weapon_pwb2_mossberg590.png"

SWEP.CustomShell = "12x70"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.ShellEject = "ShotgunShellEject"
SWEP.AutomaticDraw = false
SWEP.UseCustomWorldModel = false
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "12/70 gauge"
SWEP.Primary.Cone = 0

SWEP.Primary.Spread = Vector(0.03, 0.03, 0.03)

SWEP.weight = 4

SWEP.Primary.Sound = {"toz_shotgun/toz_fp.wav", 80, 90, 100}
SWEP.Primary.Wait = 0.25
SWEP.NumBullet = 8
SWEP.AnimShootMul = 3
SWEP.AnimShootHandMul = 10
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-1.25, 0.1, 40)
SWEP.RHandPos = Vector(0, 0, 0)
SWEP.LHandPos = Vector(7, 0, -2)
SWEP.SprayRand = {Angle(-0.2, -0.4, 0), Angle(-0.4, 0.4, 0)}
SWEP.Ergonomics = 0.9
SWEP.Penetration = 7
SWEP.WorldPos = Vector(1, -1, 1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.lengthSub = 15
SWEP.handsAng = Angle(-1, 0, 0)