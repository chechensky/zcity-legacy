-- Path scripthooked:lua\\weapons\\weapon_deagle.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Desert Eagle"
SWEP.Author = "Magnum Research/Israel Weapon Industries"
SWEP.Instructions = "Pistol chambered in .50 Magnum"
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_deserteagle.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/deserteagle.png")
SWEP.IconOverride = "entities/weapon_pwb2_deserteagle.png"

SWEP.CustomShell = "50ae"
--SWEP.EjectPos = Vector(0,10,5)
--SWEP.EjectAng = Angle(-55,80,0)

SWEP.weight = 1.5

SWEP.ScrappersSlot = "Secondary"

SWEP.weaponInvCategory = 2
SWEP.ShellEject = "EjectBrass_57"
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ".50 Action Express"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 40
SWEP.Primary.Sound = {"homigrad/weapons/pistols/deagle-1.wav", 75, 60, 70}
SWEP.Primary.Force = 40
SWEP.Primary.Wait = 0.2
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(0.3, 0.78, 30)
SWEP.RHandPos = Vector(0, -0.5, -1)
SWEP.LHandPos = false
SWEP.Ergonomics = 0.9
SWEP.Penetration = 11
SWEP.SprayRand = {Angle(-0.1, -0.2, 0), Angle(-0.2, 0.2, 0)}
SWEP.AnimShootMul = 4
SWEP.AnimShootHandMul = 4
SWEP.WorldPos = Vector(-1, -1, -1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0.3, -1, -0.74)
SWEP.attAng = Angle(-0, -0, 0)
SWEP.lengthSub = 20
SWEP.availableAttachments = {
	sight = {
		["mountType"] = "picatinny",
		["mount"] = Vector(-5, -0.7+1, 0),
	},
	mount = {
		[1] = {"mount2", Vector(-5, -0.5, 0), {}},
	}
}

SWEP.ShockMultiplier = 2

SWEP.DistSound = "hndg_sw686/revolver_fire_01.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_Pelvis"
SWEP.holsteredPos = Vector(-2, 5, 9)
SWEP.holsteredAng = Angle(25, -65, -90)
SWEP.shouldntDrawHolstered = true