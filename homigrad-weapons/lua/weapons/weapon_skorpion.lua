-- Path scripthooked:lua\\weapons\\weapon_skorpion.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Šcorpion vz. 61"
SWEP.Author = "Česká zbrojovka"
SWEP.Instructions = "Pistol chambered in 7.65x17 mm\n\nRate of fire 900 rounds per minute"
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_vz61.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/vz61.png")
SWEP.IconOverride = "entities/weapon_pwb_vz61.png"
SWEP.weight = 1
SWEP.weaponInvCategory = 2
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 17
SWEP.Primary.Sound = {"hndg_beretta92fs/beretta92_fire1.wav", 75, 90, 100}
SWEP.Primary.Force = 17
SWEP.Primary.Wait = 0.066
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(0.38, 0.05, 25)
SWEP.RHandPos = Vector(-13.5, -1, 3)
SWEP.LHandPos = false
SWEP.Spray = {}
for i = 1, 20 do
	SWEP.Spray[i] = Angle(-0.02 - math.cos(i) * 0.01, math.cos(i * i) * 0.01, 0) * 2
end

SWEP.CustomShell = "9x19"
--SWEP.EjectPos = Vector(0,5,5)
--SWEP.EjectAng = Angle(-5,180,0)

SWEP.Ergonomics = 1.2
SWEP.Penetration = 1
SWEP.WorldPos = Vector(13, -1, 2.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.lengthSub = 20
SWEP.DistSound = "m9/m9_dist.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_R_Thigh"
SWEP.holsteredPos = Vector(0, 0, -3)
SWEP.holsteredAng = Angle(-5, -5, 90)
SWEP.attPos = Vector(-3,-1,0)
SWEP.attAng = Angle(0,0,0)