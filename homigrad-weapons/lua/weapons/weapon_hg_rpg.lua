-- Path scripthooked:lua\\weapons\\weapon_hg_rpg.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "RPG-7"
SWEP.Author = "Degtyarev plant"
SWEP.Instructions = "The RPG-7 is a portable unguided shoulder-launched anti-tank rocket launcher."
SWEP.Category = "Weapons - Grenade Launchers"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/tfa_ins2/w_rpg.mdl"

SWEP.WepSelectIcon2 = Material("vgui/inventory/weapon_rpg7")
SWEP.IconOverride = "vgui/inventory/weapon_rpg7"


SWEP.weight = 6
SWEP.ScrappersSlot = "Primary"

SWEP.weaponInvCategory = 1
SWEP.ShellEject = ""
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "RPG-7 Projectile"--rpg rounds
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 1
SWEP.Primary.Sound = {"snd_jack_impulse.wav", 75, 90, 100}
SWEP.Primary.Force = 75
SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"weapons/ins2rpg7/handling/rpg7_fetch.wav", 75, 100, 110}
SWEP.HolsterSnd = {"weapons/ins2rpg7/handling/rpg7_endgrab.wav", 75, 100, 110}
SWEP.HoldType = "rpg"
SWEP.ZoomPos = Vector(-7 + 3, 0.9 - 0, 20)
SWEP.RHandPos = Vector(0,0,0)
SWEP.LHandPos = false--Vector(13,0,0)
SWEP.Ergonomics = 0.5
SWEP.WorldPos = Vector(0,-2,-3)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0,-3,13)
SWEP.attAng = Angle(0,0,0)
SWEP.lengthSub = 25
SWEP.DistSound = "weapons/ins2rpg7/rpg7_dist.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_Spine2"
SWEP.holsteredPos = Vector(0,-4,0)
SWEP.holsteredAng = Angle(0, 0, 0)
SWEP.OpenBolt = true
SWEP.SprayRand = {Angle(-0.05, -0.01, 0), Angle(-0.1, 0.01, 0)}
SWEP.SprayRandOnly = true

SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.ReloadHold = "pistol"
SWEP.AnimShootMul = 5
SWEP.AnimShootHandMul = 5
SWEP.addSprayMul = 12

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
		local projectile = ents.Create("rpg_projectile")
		projectile:SetPos(att.Pos + att.Ang:Forward() * 0 + att.Ang:Right() * -6)
		projectile:SetAngles(att.Ang)
		projectile:SetOwner(self:GetOwner())
		projectile:Spawn()

		local phys = projectile:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(self:GetOwner():GetVelocity() + att.Ang:Forward() * 200)
		end
		for i,ent in pairs(ents.FindInCone(att.Pos, -att.Ang:Forward(), 128, 0.8)) do
			if not ent:IsPlayer() then continue end
			if ent == hg.GetCurrentCharacter( self:GetOwner() ) then return end
			local d = DamageInfo()
			d:SetDamage( 400 )
			d:SetAttacker( self:GetOwner() )
			d:SetDamageType( DMG_BURN ) 

			ent:TakeDamageInfo( d )
		end
	end

	self:EmitShoot()
	self:PrimarySpread()
	self:TakePrimaryAmmo(1)
	self:GetWeaponEntity():SetBodygroup(1,1)
end

if CLIENT then
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

	function SWEP:Unload()
		if SERVER then return end
		
		self:GetWeaponEntity():SetBodygroup(1,1)
	end

	function SWEP:InitializePost()
		self:GetWeaponEntity():SetBodygroup(1,self:Clip1() == 1 and 0 or 1)
	end

	function SWEP:OwnerChanged()
		self:GetWeaponEntity():SetBodygroup(1,self:Clip1() == 1 and 0 or 1)
	end
end