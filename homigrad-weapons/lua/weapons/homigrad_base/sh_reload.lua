-- Path scripthooked:lua\\weapons\\homigrad_base\\sh_reload.lua"
-- Scripthooked by ???
AddCSLuaFile()
--
function SWEP:Initialize_Reload()
	self.LastReload = 0
end

SWEP.dwr_customVolume = 1
SWEP.OpenBolt = false
function SWEP:CanReload()
	if self:LastShootTime() + 0.1 > CurTime() then return end
	if self.ReloadNext or not self:CanUse() or self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) == 0 or self:Clip1() >= self:GetMaxClip1() + (self.drawBullet and not self.OpenBolt and 1 or 0) then --shit
		return
	end
	return true
end

function SWEP:InsertAmmo(need)
	local owner = self:GetOwner()
	local primaryAmmo = self:GetPrimaryAmmoType()
	local primaryAmmoCount = owner:GetAmmoCount(primaryAmmo)
	need = need or self:GetMaxClip1() - self:Clip1()
	need = math.min(primaryAmmoCount, need)
	need = math.min(need, self:GetMaxClip1())
	self:SetClip1(self:Clip1() + need)
	owner:SetAmmo(primaryAmmoCount - need, primaryAmmo)
end

SWEP.ReloadCooldown = 0.1
local math_min = math.min
function SWEP:ReloadEnd()
	self:InsertAmmo(self:GetMaxClip1() - self:Clip1() + (self.drawBullet ~= nil and not self.OpenBolt and 1 or 0))
	self.ReloadNext = CurTime() + self.ReloadCooldown --я хуй знает чо это
	self:Draw()
end

function SWEP:Step_Reload(time)
	if self:KeyDown(IN_WALK) and self:KeyDown(IN_RELOAD) then
		self.checkingammo = true
	else
		self.checkingammo = false
	end

	local time2 = self.reload
	if time2 and time2 < time then
		self.reload = nil
		self:ReloadEnd()
	end

	time2 = self.ReloadNext
	if time2 and time2 < time then
		self.ReloadNext = nil
		self.dwr_reverbDisable = nil
	end
end

function SWEP:ReloadStartPost()
end

if SERVER then
	util.AddNetworkString("hgwep reload")
	function SWEP:ReloadStart()
		if not IsValid(self:GetOwner()) then return end
		self:SetHold(self.ReloadHold or self.HoldType)
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
	end
	function SWEP:Reload(time)
		if not self:CanUse() then return end
		if self.ReloadCooldown > CurTime() then return end
		if self.Primary.Next > CurTime() then return end

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
end

if SERVER then return end
net.Receive("hgwep reload", function()
	local self = net.ReadEntity()
	local time = net.ReadFloat()
	if self.Reload then self:Reload(time) end
end)

function SWEP:Reload(time)
	if not time then return end
	self.LastReload = time
	self:ReloadStart()
	self:ReloadStartPost()
	self.reload = time + self.ReloadTime
	self.dwr_reverbDisable = true
end

function SWEP:ReloadStart()
	if not IsValid(self:GetOwner()) then return end
	self:SetHold(self.ReloadHold or self.HoldType)
	self:GetOwner():SetAnimation(PLAYER_RELOAD)
end