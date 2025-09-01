-- Path scripthooked:lua\\weapons\\weapon_kar98.lua"
-- Scripthooked by ???
SWEP.Base = "weapon_m4super"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Karabiner 98k"
SWEP.Author = "Mauser"
SWEP.Instructions = "Sniper rifle chambered in 7.62x51"
SWEP.Category = "Weapons - Sniper Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/gleb/w_kar98k.mdl"

SWEP.WepSelectIcon2 = Material("vgui/wep_jack_hmcd_rifle")
SWEP.IconOverride = "vgui/wep_jack_hmcd_rifle"

SWEP.CustomShell = "762x51"
SWEP.EjectPos = Vector(0,15,2)
SWEP.EjectAng = Angle(0,-90,0)

SWEP.weight = 3
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.ShellEject = "RifleShellEject"
SWEP.AutomaticDraw = false
SWEP.UseCustomWorldModel = false
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "7.62x51 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Spread = 0
SWEP.Primary.Damage = 65
SWEP.Primary.Force = 65
SWEP.Primary.Sound = {"mosin/mosin_tp.wav", 80, 90, 100}
SWEP.availableAttachments = {
	sight = {
		["empty"] = {
			"empty",
			{
				[1] = "null",
				[2] = "null"
			}
		},
		["mountType"] = "kar98mount",
		["mount"] = Vector(-33.5, 1.6, 0),
	}
}

SWEP.ReloadHold = "pistol"

SWEP.AmmoTypes = false

SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 1

SWEP.ReloadDrawTime = 0.2
SWEP.ReloadDrawCooldown = 0.3
SWEP.ReloadInsertTime = 0.1
SWEP.ReloadInsertCooldown = 0.1
SWEP.ReloadInsertCooldownFire = 0.1

SWEP.AnimStart_Draw = 0
SWEP.AnimStart_Insert = 0
SWEP.AnimInsert = 0.5
SWEP.AnimDraw = 0.4

SWEP.CockSound = "snd_jack_hmcd_boltcycle.wav"

SWEP.ReloadSound = "weapons/mosin/round-insert01.wav"

SWEP.Primary.Wait = 0.25
SWEP.NumBullet = 1
SWEP.addSprayMul = 1
SWEP.ReloadTime = 1
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-0.7, .088, 45)
SWEP.RHandPos = Vector(-12, -2, 4)
SWEP.LHandPos = Vector(15, 1, -2)
SWEP.AimHands = Vector(-3, 1.95, -4.2)
SWEP.SprayRand = {Angle(-0.6, -0.1, 0), Angle(-0.7, 0.2, 0)}
SWEP.Ergonomics = 0.85
SWEP.Penetration = 15
SWEP.ZoomFOV = 20
SWEP.WorldPos = Vector(1, -0.4, -1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.handsAng = Angle(0, 1, 0)
SWEP.scopemat = Material("decals/scope.png")
SWEP.perekrestie = Material("decals/perekrestie6.png")
SWEP.localScopePos = Vector(-27.5, 5.575, -0.09)
SWEP.scope_blackout = 400
SWEP.rot = 191
SWEP.FOVMin = 2
SWEP.FOVMax = 10
SWEP.FOVScoped = 40
SWEP.blackoutsize = 2500
SWEP.sizeperekrestie = 2048
SWEP.ShockMultiplier = 2

SWEP.attPos = Vector(0,0,0)
SWEP.attAng = Angle(-0.1,.4,0)

if CLIENT then
	function SWEP:DrawHUDAdd()
	end
	--self:ChangeFOV()
	--self:DoRT()
end

SWEP.lengthSub = 5
--[[
function SWEP:AnimationPost()
	local animpos1 = self:GetAnimPos_Draw(CurTime())

	if animpos1 > 0 then
		local sin = 1 - animpos1

		if sin >= 0.5 then
			sin = 1 - sin
		else
			sin = sin * 2.5
		end

		self:BoneSetAdd(1,"r_clavicle",Vector(sin * -5,sin * -2.5,sin * -5),Angle(0,0,0))
		self:BoneSetAdd(1,"r_hand",Vector(0,0,0),Angle(0,0,sin * -90))
	end
end
--]]
SWEP.DistSound = "mosin/mosin_dist.wav"
SWEP.bipodAvailable = true