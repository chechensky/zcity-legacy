-- Path scripthooked:lua\\weapons\\weapon_sr25.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "SR25"
SWEP.Author = "Knight's Armament Company"
SWEP.Instructions = "Semi-automatic Marksman rifle chambered in 7.62x51 NATO"
SWEP.Category = "Weapons - Sniper Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/w_sr25/w_sr25.mdl"
SWEP.ScrappersSlot = "Primary"
SWEP.WepSelectIcon2 = Material("vgui/hud/tfa_ins2_sr25_eft.png")
SWEP.IconOverride = "vgui/hud/tfa_ins2_sr25_eft.png"
SWEP.weight = 3.5
SWEP.weaponInvCategory = 1
SWEP.CustomShell = "762x51"
--SWEP.EjectPos = Vector(0,5,5)
--SWEP.EjectAng = Angle(-5,180,0)
SWEP.AutomaticDraw = true
SWEP.UseCustomWorldModel = false
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Spread = 0
SWEP.Primary.Damage = 65
SWEP.Primary.Force = 65
SWEP.Primary.Sound = {"homigrad/weapons/rifle/m4a1-1.wav", 65, 90, 100}
SWEP.SupressedSound = {"homigrad/weapons/rifle/m4a1-1.wav", 65, 90, 100}
SWEP.availableAttachments = {
	sight = {
		["removehuy"] = {
			[1] = "null",
			[2] = "null"
		},
		["mountType"] = "picatinny",
		["mount"] = Vector(-29, 2.5, -0.2),
		["empty"] = {
			"empty",
			{
				[1] = "null",
				[2] = "null"
			},
		},
	},
	barrel = {
		[1] = {"supressor0", Vector(0, 0, 0), {}},
	},
	underbarrel = {
		["mount"] = Vector(0, 0.2 + 2.25, -1.2 + 0.15),
		["mountAngle"] = Angle(0, 0, -90),
		["mountType"] = "picatinny"
	}
}

function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_forearm", Vector(0, 0, 0), Angle(1, 10, 0))
end

SWEP.ShockMultiplier = 2

SWEP.handsAng = Angle(0, 0, 0)
SWEP.handsAng2 = Angle(0, 0, 0)

SWEP.Primary.Wait = 0.15
SWEP.NumBullet = 1
SWEP.AnimShootMul = 1.5
SWEP.AnimShootHandMul = 1.5
SWEP.ReloadTime = 1.7
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-3.95, .2, 40)
SWEP.RHandPos = Vector(-8, -2, 6)
SWEP.LHandPos = Vector(6, -3, 1)
SWEP.AimHands = Vector(-10, 1.8, -6.1)
SWEP.SprayRand = {Angle(0.05, -0.05, 0), Angle(-0.05, 0.05, 0)}
SWEP.Ergonomics = 0.75
SWEP.Penetration = 15
SWEP.ZoomFOV = 20
SWEP.WorldPos = Vector(14, -1, 3.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.handsAng = Angle(5, -2, 0)
SWEP.scopemat = Material("decals/scope.png")
SWEP.perekrestie = Material("decals/perekrestie8.png", "smooth")
SWEP.localScopePos = Vector(-21, 3.95, -0.2)
SWEP.scope_blackout = 400
SWEP.maxzoom = 3.5
SWEP.rot = 37
SWEP.FOVMin = 3.5
SWEP.FOVMax = 10
SWEP.huyRotate = 25
SWEP.FOVScoped = 40
if CLIENT then
	function SWEP:DrawHUDAdd()
	end
	--self:ChangeFOV()
	--self:DoRT()
end

SWEP.lengthSub = 15
SWEP.Supressor = true
SWEP.SetSupressor = true

function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "l_finger0", Vector(0.7, -0.3, 0), Angle(0, -20, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 40, 0))
end