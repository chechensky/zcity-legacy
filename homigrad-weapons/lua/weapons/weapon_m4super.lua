-- Path scripthooked:lua\\weapons\\weapon_m4super.lua"
-- Scripthooked by ???

SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Benelli M4 Super 90"
SWEP.Author = "Benelli Armi S.p.A."
SWEP.Instructions = "Semi-automatic shotgun chambered in 12/70"
SWEP.Category = "Weapons - Shotguns"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_m4super90.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/m4super90.png")
SWEP.IconOverride = "entities/weapon_pwb2_m4super90.png"

SWEP.CustomShell = "12x70"
--SWEP.EjectPos = Vector(0,-20,5)
--SWEP.EjectAng = Angle(0,90,0)
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.ShellEject = "ShotgunShellEject"
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "12/70 gauge"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 16
SWEP.Primary.Spread = Vector(0.03, 0.03, 0.03)
SWEP.Primary.Force = 12
SWEP.Primary.Sound = {"toz_shotgun/toz_fp.wav", 80, 70, 75}
SWEP.Primary.Wait = 0.2
SWEP.NumBullet = 8
SWEP.DeploySnd = {"homigrad/weapons/draw_hmg.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/hmg_holster.mp3", 55, 100, 110}
--[type_] = {1 = name,2 = spread,3 = dmg,4 = pen,5 = numbullet,6 = isrubber,7 = shockmul},

SWEP.addSprayMul = 2

SWEP.weight = 4

SWEP.HoldType = "ar2"
SWEP.ReloadHold = "pistol"
SWEP.ZoomPos = Vector(-1.45, 0.36, 33)
SWEP.RHandPos = Vector(-5, -2, 0)
SWEP.LHandPos = Vector(7, -2, -2)
SWEP.SprayRand = {Angle(-0.2, -0.4, 0), Angle(-0.4, 0.4, 0)}
SWEP.Ergonomics = 0.9
SWEP.AnimShootMul = 3
SWEP.AnimShootHandMul = 10
SWEP.AnimStart_Draw = 0
SWEP.AnimStart_Insert = 0
SWEP.AnimInsert = 0.1
SWEP.AnimDraw = 0.1
SWEP.Penetration = 8
SWEP.ReloadTime = 0.75
SWEP.AnimInsert = 0.1
SWEP.AnimDraw = 0.3
SWEP.ReloadDrawTime = 0.5
SWEP.ReloadDrawCooldown = 0.5
SWEP.ReloadInsertTime = 0.1
SWEP.ReloadInsertCooldown = 0.25
SWEP.ReloadInsertCooldownFire = 0.1
SWEP.lengthSub = 20
SWEP.handsAng = Angle(-1, 1, 0)
SWEP.attPos = Vector(0,0,-0.3)

SWEP.ShockMultiplier = 3

function SWEP:GetAnimPos_Insert(time)
	local animpos1 = math.Clamp(self.AnimStart_Insert + self.AnimInsert - time, 0, self.AnimInsert) / self.AnimInsert
	return animpos1
end

function SWEP:GetAnimPos_Draw(time)
	local animpos1 = math.Clamp(self.AnimStart_Draw + self.AnimDraw - time, 0, self.AnimDraw) / self.AnimDraw
	return animpos1
end
function SWEP:AnimHoldPost()
	self:BoneSetAdd(1, "l_finger0", Vector(0.7, -0.3, 0), Angle(0, -20, 0))
	self:BoneSetAdd(1, "l_finger02", Vector(0, 0, 0), Angle(0, 40, 0))
end
function SWEP:ChangeCameraPassive(value)
	if self.reload then return 1 end
	return value
end

function SWEP:InitializePost()
	self.AnimStart_Insert = 0
	self.AnimStart_Draw = 0
end

function SWEP:CanPrimaryAttack()
	return not (self:GetAnimPos_Draw(CurTime()) > 0)
end

SWEP.reloadCoolDown = 0
if SERVER then
	util.AddNetworkString("hgwep draw")
	function SWEP:Reload(time)
		if not self:CanUse() then return end
		if self.reloadCoolDown > CurTime() then return end
		if self.Primary.Next > CurTime() then return end
		if self.drawBullet == false then
			self.AnimStart_Draw = CurTime()
			if SERVER then
				self:Draw(true)
			end
			if CLIENT and LocalPlayer() == self:GetOwner() then ViewPunch(AngleRand(0, -10)) end
			net.Start("hgwep draw")
			net.WriteEntity(self)
			net.WriteBool(self.drawBullet)
			net.WriteFloat(CurTime())
			net.Broadcast()
			self.Primary.Next = CurTime() + 0.5
			self:PlaySnd(self.CockSound or "weapons/shotgun/shotgun_cock.wav",true,CHAN_AUTO)
			self.reloadCoolDown = CurTime() + self.ReloadDrawCooldown
			return
		end

		if self:GetAnimPos_Draw(CurTime()) > 0 then return end
		if not self:CanReload() then return end
		--self:GetOwner():SetPlaybackRate(1)
		self.LastReload = CurTime()
		self:ReloadStart()
		self:ReloadStartPost()
		self.reload = self.LastReload + self.ReloadTime
		self.dwr_reverbDisable = true
		net.Start("hgwep reload")
		net.WriteEntity(self)
		net.WriteFloat(self.LastReload)
		net.Broadcast()
	end
else
	function SWEP:Reload(time)
		if not time then return end
		self.LastReload = time
		self:ReloadStart()
		self:ReloadStartPost()
		self.reload = time + self.ReloadTime
		self.dwr_reverbDisable = true
	end

	function SWEP:ReloadStart()
		if not self or not self:GetOwner() then return end
		self:SetHold(self.ReloadHold or self.HoldType)
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
	end

	net.Receive("hgwep draw", function()
		local self = net.ReadEntity()
		local drawBullet = net.ReadBool()
		local time = net.ReadFloat()
		self.Primary = self.Primary or {}
		self.AnimStart_Draw = time
		self.drawBullet = drawBullet
		--if self.Draw then self:Draw() end
		self.Primary.Next = time + 0.5
	end)
end

function SWEP:ReloadEnd()
	local owner = self:GetOwner()
	--owner:SetPlaybackRate(-1)
	self:InsertAmmo(1)
	self.ReloadNext = CurTime() + self.ReloadCooldown
	if SERVER then
		if not self.drawBullet then
			self.AnimStart_Draw = CurTime()
			self:Draw(true)
			net.Start("hgwep draw")
			net.WriteEntity(self)
			net.WriteBool(self.drawBullet)
			net.WriteFloat(CurTime())
			net.Broadcast()
			self.Primary.Next = CurTime() + 0.5
			self:GetOwner():EmitSound(self.CockSound or "weapons/shotgun/shotgun_cock.wav")
		end
	end
end

--[[
function SWEP:ReloadDrawEnd()
	self.reloadDrawing = nil
	self.ReloadNext = CurTime() + self.ReloadDrawCooldown
	self:Draw()
end

function SWEP:ReloadAmmoEnd()
	self.ReloadNext = CurTime()  + self.ReloadInsertCooldown
	self:InsertAmmo(1)
	self.Primary.NextFire = CurTime() + self.ReloadInsertCooldownFire
end
--]]
function SWEP:PrimaryShootPost()
	self.ReloadNext = CurTime() + 0.5
end

function SWEP:AnimationPost()
	local animpos1 = self:GetAnimPos_Draw(CurTime())
	if animpos1 > 0 then
		local sin = 1 - animpos1
		if sin >= 0.5 then
			sin = 1 - sin
		else
			sin = sin * 2.5
		end

		--self:BoneSetAdd(1,"r_forearm",Vector(0,0,0),Angle(0,-sin * 20,-sin * 40))
		--self:BoneSetAdd(1,"r_upperarm",Vector(0,0,0),Angle(0,sin * 30,0))
		--self:BoneSetAdd(1,"r_hand",Vector(0,0,0),Angle(sin * 30,sin * 40,0))
		self:BoneSetAdd(4,"r_hand",Vector(0,0,0),Angle(sin * -5,sin * -5,0))
		self:BoneSetAdd(1,"r_clavicle",Vector(0,0,0),Angle(sin * -30,sin * -30,0))
		self:BoneSetAdd(1, "l_clavicle", Vector(0,0,0), Angle(0, sin * -30, 0))
	end
	--[[

	self:BoneSetAdd(1, "l_upperarm", Vector(0, 0, 0), Angle(0,0,0))
	self:BoneSetAdd(1, "l_forearm", Vector(0, 0, 0), Angle(-10,0,0))

	if animpos1 > 0 then
		local sin = 1 - animpos1
		if sin >= 0.5 then
			sin = 1 - sin
		else
			sin = sin * 5
		end

		self:BoneSetAdd(1, "l_upperarm", Vector(0, 0, 0), Angle(sin * 10, sin * 10, sin * 10))
		self:BoneSetAdd(1, "l_forearm", Vector(0, 0, 0), Angle(sin * -05, sin * -20, sin * 10))
	end
	if CLIENT then
		if oldIk != (animpos1 == 0) then
			local owner = self:GetOwner()
			owner:SetIK(animpos1 == 0)
			owner:SetModel(owner:GetModel())
			oldIk = animpos1 == 0
		end
	end

	--]]
	local animpos1 = self:GetAnimPos_Insert(CurTime())
	if animpos1 > 0 then
		local animpos2 = animpos1
		self:BoneSetAdd(2, "r_hand", Vector(0, 0, 0), Angle(-animpos1 * 15, 0, animpos2 * 45))
	end
end

SWEP.UseCustomWorldModel = true
SWEP.WorldPos = Vector(5, -1, 0)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.DistSound = "toz_shotgun/toz_dist.wav"