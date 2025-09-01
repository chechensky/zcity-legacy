-- Path scripthooked:lua\\weapons\\weapon_glock17.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Glock 17"
SWEP.Author = "Glock GmbH"
SWEP.Instructions = "Pistol chambered in 9x19 mm"
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
--SWEP.WorldModel				= "models/pwb/weapons/w_glock17.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_glock_p80.mdl"

SWEP.WepSelectIcon2 = Material("vgui/hud/tfa_ins2_glock_p80.png")
SWEP.IconOverride = "entities/weapon_pwb_glock17.png"

SWEP.CustomShell = "9x19"
SWEP.EjectPos = Vector(0,2,2)
SWEP.EjectAng = Angle(-45,-80,0)

SWEP.weight = 1

SWEP.ScrappersSlot = "Secondary"

SWEP.weaponInvCategory = 2
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.Primary.ClipSize = 17
SWEP.Primary.DefaultClip = 17
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 25
SWEP.Primary.Sound = {"hndg_beretta92fs/beretta92_fire1.wav", 75, 90, 100}
SWEP.Primary.Force = 25
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 8
SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(-0.55, 0, 25)
--SWEP.RHandPos = Vector(-13.5,0,4)
SWEP.RHandPos = Vector(-4, 0, -3)
SWEP.LHandPos = false
SWEP.SprayRand = {Angle(-0.03, -0.03, 0), Angle(-0.05, 0.03, 0)}
SWEP.Ergonomics = 1.2
SWEP.Penetration = 7
--SWEP.WorldPos = Vector(13,0,3.5)
--SWEP.WorldAng = Angle(0,0,0)
SWEP.WorldPos = Vector(2.9, -2, -3.1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, -1.2, 6.5)
SWEP.attAng = Angle(0, 0, 0)
SWEP.lengthSub = 25
SWEP.DistSound = "m9/m9_dist.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_L_Thigh"
SWEP.holsteredPos = Vector(0, 0, 6)
SWEP.holsteredAng = Angle(5, -5, 100)
SWEP.shouldntDrawHolstered = true
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor4", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-0.5,0.3,0),
	},
}

function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_finger0", Vector(0, 0, 0), Angle(10, -5, 0))
	self:BoneSetAdd(1, "l_finger0", Vector(0, -0.5, 0), Angle(-30, 0, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 0, 0))
end