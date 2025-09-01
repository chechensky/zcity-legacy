-- Path scripthooked:lua\\weapons\\weapon_hg_crossbow.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Homemade Crossbow"
SWEP.Author = "Unknown"
SWEP.Instructions = "A rather weighty homemade crossbow that shoots red-hot armature.\nHas very high damage"
SWEP.Category = "Weapons - Other"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/zcity/weapons/w_crossbow.mdl"

SWEP.WepSelectIcon2 = Material("vgui/wep_jack_hmcd_crossbow")
SWEP.IconOverride = "vgui/wep_jack_hmcd_crossbow"
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.ShellEject = ""
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Armature"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 1
SWEP.Primary.Sound = {"weapons/crossbow/fire1.wav", 75, 90, 100}
SWEP.Primary.Force = 25
SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"weapons/crossbow/crossbow_deploy.wav", 55, 100, 110}
SWEP.HolsterSnd = {"snds_jack_gmod/ez_weapons/amsr/in.wav", 45, 100, 110}
SWEP.HoldType = "ar2"
SWEP.ZoomPos = Vector(-2.3, 26, 0)
SWEP.RHandPos = Vector(0,0,0)
SWEP.LHandPos = Vector(13,0,0)
SWEP.Ergonomics = 0.8
SWEP.WorldPos = Vector(0,1.1,-1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0,0,2)
SWEP.attAng = Angle(-90,0,0)
SWEP.lengthSub = 25
SWEP.DistSound = ""
SWEP.holsteredBone = "ValveBiped.Bip01_Spine2"
SWEP.holsteredPos = Vector(15,-5,6)
SWEP.holsteredAng = Angle(170, -5, 90)
SWEP.OpenBolt = true
SWEP.SprayRand = {Angle(-0.05, -0.01, 0), Angle(-0.1, 0.01, 0)}
SWEP.SprayRandOnly = true

SWEP.mat = Material("models/weapons/v_crossbow_new/v_crossbow_lens")
SWEP.scopemat = Material("decals/scope.png")
SWEP.perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_dovetail_npz_nspum_3,5x_marks.png")
SWEP.sizeperekrestie = 3096

SWEP.handsAng = Angle(-5, -1, 0)

SWEP.localScopePos = Vector(-15,2.28,0)
SWEP.scope_blackout = 400
SWEP.rot = 0
SWEP.FOVMin = 3
SWEP.FOVMax = 12
SWEP.perekrestieSize = true
SWEP.blackoutsize = 3000

SWEP.ReloadSound = "weapons/crossbow/reload1.wav"
SWEP.ReloadHold = "smg"
SWEP.AnimShootMul = 2
SWEP.AnimShootHandMul = 5
SWEP.addSprayMul = 2



SWEP.weight = 3


function SWEP:Shoot(override)
	if not self:CanPrimaryAttack() then return false end
	if not self:CanUse() then return false end
	if self:Clip1() == 0 then return end
	local primary = self.Primary
	if not self.drawBullet then
		self.LastPrimaryDryFire = CurTime()
		self:PrimaryShootEmpty()
		primary.Automatic = false
		return false
	end

	if primary.Next > CurTime() then return false end
	if (primary.NextFire or 0) > CurTime() then return false end
	primary.Next = CurTime() + primary.Wait
	self:SetLastShootTime(CurTime())
	primary.Automatic = weapons.Get(self:GetClass()).Primary.Automatic
	
    local gun = self:GetWeaponEntity()
	local att = self:GetMuzzleAtt(gun, true)
	--self:GetOwner():Kick("lol")

	if SERVER then
		local projectile = ents.Create("crossbow_projectile")
		projectile:SetPos(att.Pos + att.Ang:Forward() * -1)
		projectile:SetAngles(att.Ang)
		projectile:Spawn()

		local phys = projectile:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(self:GetOwner():GetVelocity() + att.Ang:Forward() * 9000)
		end
	end

	self:EmitShoot()
	self:PrimarySpread()
	self:TakePrimaryAmmo(1)
	self:GetWeaponEntity():SetBodygroup(1,1)
end

if CLIENT then
	function SWEP:DrawHUDAdd()
		self:DoRT()
	end

	function SWEP:ReloadStart()
		self:SetHold(self.ReloadHold or self.HoldType)
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
	end

	function SWEP:ReloadEnd()
		self:GetWeaponEntity():SetBodygroup(1,0)
		
		self:InsertAmmo(1)
		self.ReloadNext = CurTime() + self.ReloadCooldown
		self:Draw()
	end

	function SWEP:InitializePost()
		self:GetWeaponEntity():SetBodygroup(1,self:Clip1() == 1 and 0 or 1)
	end

	function SWEP:OwnerChanged()
		self:GetWeaponEntity():SetBodygroup(1,self:Clip1() == 1 and 0 or 1)
	end
end