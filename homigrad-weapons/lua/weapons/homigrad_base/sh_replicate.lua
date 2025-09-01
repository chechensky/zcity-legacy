-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\sh_replicate.lua"
-- Scripthooked by ???
AddCSLuaFile()
if CLIENT then
	net.Receive("hgwep shoot", function()
		local self = net.ReadEntity()
		local shoot = net.ReadBool()
		
		if not IsValid(self) then return end
		if self:GetOwner() == LocalPlayer() then return end
		
		self:Shoot(shoot)
	end)
end

function SWEP:IsClient()
	return CLIENT and self:GetOwner() == LocalPlayer()
end

if SERVER then
	util.AddNetworkString("keyDownply2")
	hook.Add("KeyPress", "huy-hg", function(ply, key)
		net.Start("keyDownply2")
		net.WriteInt(key, 26)
		net.WriteBool(true)
		net.WriteEntity(ply)
		net.Broadcast()
	end)

	hook.Add("KeyRelease", "huy-hg2", function(ply, key)
		net.Start("keyDownply2")
		net.WriteInt(key, 26)
		net.WriteBool(false)
		net.WriteEntity(ply)
		net.Broadcast()
	end)
else
	net.Receive("keyDownply2", function(len)
		local key = net.ReadInt(26)
		local down = net.ReadBool()
		local ply = net.ReadEntity()
		if not IsValid(ply) then return end
		ply.keydown = ply.keydown or {}
		ply.keydown[key] = down
	end)
end

function SWEP:KeyDown(key)
	local owner = self:GetOwner()
	if not IsValid(owner) then return false end
	owner.keydown = owner.keydown or {}
	local localKey
	if CLIENT then
		if self:IsLocal() then
			localKey = owner:KeyDown(key)
		else
			localKey = owner.keydown[key]
		end
	end
	return SERVER and owner:KeyDown(key) or CLIENT and localKey
end