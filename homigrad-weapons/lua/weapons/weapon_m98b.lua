-- Path scripthooked:lua\\weapons\\weapon_m98b.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Barrett M98B"
SWEP.Author = "Barrett Firearms"
SWEP.Instructions = "Sniper rifle chambered in .338 Lapua Magnum"
SWEP.Category = "Weapons - Sniper Rifles"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/w_m98b/w_m98b.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/m98b.png")
SWEP.IconOverride = "entities/weapon_pwb_m98b.png"

SWEP.CustomShell = ".338Lapua"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)
function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "r_upperarm", Vector(0, 0, 0), Angle(0, 10, -10))
	self:BoneSetAdd(1, "l_finger0", Vector(0.7, -0.3, 0), Angle(0, -20, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 40, 0))
end
SWEP.weight = 5
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.ShellEject = "RifleShellEject"
SWEP.AutomaticDraw = true
SWEP.UseCustomWorldModel = false
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ".338 Lapua Magnum"
SWEP.Primary.Cone = 0
SWEP.Primary.Spread = 0
SWEP.Primary.Damage = 180
SWEP.Primary.Force = 60
SWEP.Primary.Sound = {"homigrad/weapons/rifle/loud_awp.wav", 80, 90, 100}
SWEP.availableAttachments = {
	sight = {
		["empty"] = {
			"empty",
			{
				[1] = "null",
				[2] = "null"
			}
		},
		["mountType"] = "picatinny",
		["mount"] = Vector(-40, 2.3, -0.09),
		["removehuy"] = {
			[1] = "null",
			[2] = "null"
		}
	}
}

SWEP.Primary.Wait = 0.25
SWEP.NumBullet = 1
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 3
SWEP.addSprayMul = 3
SWEP.ReloadTime = 1.7
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-5.565, .088, 47)
SWEP.RHandPos = Vector(-12, -2, 4)
SWEP.LHandPos = Vector(6, 1, -2)
SWEP.AimHands = Vector(-3, 1.95, -4.2)
SWEP.SprayRand = {Angle(-0.6, -0.1, 0), Angle(-0.7, 0.2, 0)}
SWEP.Ergonomics = 0.75
SWEP.Penetration = 35
SWEP.ZoomFOV = 20
SWEP.WorldPos = Vector(14, -1, 3.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.handsAng = Angle(4, 0, 0)
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
SWEP.ShockMultiplier = 1

SWEP.attPos = Vector(0,2,0)
SWEP.attAng = Angle(0,0,0)

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