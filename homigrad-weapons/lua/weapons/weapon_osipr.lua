-- Path scripthooked:lua\\weapons\\weapon_osipr.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Overwatch Standard Issue Pulse Rifle"
SWEP.Author = "Combine"
SWEP.Instructions = "O.S.I.P.R. is a Dark Energy/pulse-powered assault rifle.\n\nRate of fire 600 rounds per minute"
SWEP.Category = "Weapons - Assualt Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/arccw/w_irifle.mdl"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pulse"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 50
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 50
SWEP.Primary.Sound = {"weapons/ar2/fire1.wav", 85, 90, 100}
SWEP.ShootEffect = 5
SWEP.ShellEject = true
SWEP.MuzzleEffectType = 3
SWEP.CustomShell = "Pulse"
SWEP.EjectPos = Vector(0,5,5)
SWEP.EjectAng = Angle(15,90,0)
SWEP.ScrappersSlot = "Primary"
SWEP.weight = 3.5

SWEP.WepSelectIcon2 = Material("vgui/wep_jack_hmcd_ar2")
SWEP.IconOverride = "vgui/wep_jack_hmcd_ar2"

SWEP.availableAttachments = {
}

SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-0.03,-3.2,29)
SWEP.RHandPos = Vector(-12, -1, 4)
SWEP.LHandPos = Vector(7, -3, -2)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.06 - math.cos(i) * 0.03, math.cos(i * i) * 0.04, 0) * 2
end

SWEP.DeploySnd = {"weapons/ar2/ar2_deploy.wav", 75, 100, 110}

SWEP.Ergonomics = 0.8
SWEP.HaveModel = "models/weapons/arccw/w_irifle.mdl"
SWEP.Penetration = 17
SWEP.WorldPos = Vector(15, -1, 0)
SWEP.WorldAng = Angle(0, 180, 0)
SWEP.UseCustomWorldModel = true
--https://youtu.be/I7TUHPn_W8c?list=RDEMAfyWQ8p5xUzfAWa3B6zoJg  wizards
SWEP.attPos = Vector(0, 0.7, 0)
SWEP.attAng = Angle(0.5, 0.7, 0)
SWEP.lengthSub = 20
SWEP.handsAng = Angle(-29, -25, -10)
SWEP.DistSound = "weapons/ar2/ar2_dist1.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_Spine2"
SWEP.holsteredPos = Vector(-5, -6.8, -2)
SWEP.holsteredAng = Angle(0, 0, -25)