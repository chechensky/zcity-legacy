-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\sh_holster_deploy.lua"
-- Scripthooked by ???
AddCSLuaFile()
--
SWEP.CooldownHolster = 0.25
SWEP.HolsterSnd = {"homigrad/weapons/holster_rifle.mp3", 55, 100, 110}
SWEP.CooldownDeploy = 0.25
SWEP.DeploySnd = {"homigrad/weapons/draw_rifle.mp3", 65, 100, 110}
function SWEP:Step_HolsterDeploy(time)
	local time2 = self.holster
	if time2 and time2 < time then self:Holster_End() end
	time2 = self.deploy
	if time2 and time2 < time then self:Deploy_End() end
end

if SERVER then return end
net.Receive("hg wep deploy", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	if not ent.Deploy then return end
	if ent.IsClient and ent:IsClient() then return end
	ent:Deploy(net.ReadFloat())
end)

net.Receive("hg wep holster", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	if ent.IsClient and ent:IsClient() then return end
	ent:Holster(nil, net.ReadFloat())
end)

net.Receive("Switch Weapon", function() input.SelectWeapon(net.ReadEntity()) end)
function SWEP:Holster(wep, time)
	if self:IsClient() and not IsFirstTimePredicted() then return end
	if not IsValid(wep) then return true end
	
	self:PlaySnd(self.HolsterSnd)

	local time = CurTime()
	self.holster = time + self.CooldownHolster / self.Ergonomics
	self.deploy = nil
end

function SWEP:Holster_End()
	self.holster = nil
end

function SWEP:Deploy(time)
	if self:IsClient() and not IsFirstTimePredicted() then return end
	local time = CurTime()
	
	self:PlaySnd(self.DeploySnd)

	self.holster = nil
	self.deploy = time + self.CooldownDeploy / self.Ergonomics
	self:SetHold(self.HoldType)
	return true
end

function SWEP:Deploy_End()
	self.deploy = nil
end