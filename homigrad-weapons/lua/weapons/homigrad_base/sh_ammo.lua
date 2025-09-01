-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\sh_ammo.lua"
-- Scripthooked by ???
AddCSLuaFile()
hg.ammotypes = hg.ammotypes or {}
--[type_] = {1 = name,2 = dmg,3 = pen,4 = numbullet,5 = RubberBullets,6 = ShockMultiplier,7 = Force},
function SWEP:ApplyAmmoChanges(type_)
	local ammo = self.AmmoTypes[type_]
	self.Primary.Ammo = ammo[1]
	self.Primary.Damage = ammo[2]
	self.Penetration = ammo[3]
	self.NumBullet = ammo[4]
	self.RubberBullets = ammo[5]
	self.ShockMultiplier = ammo[6]
	self.Primary.Force = ammo[7]
	if SERVER then
		net.Start("syncAmmoChanges")
		net.WriteEntity(self)
		net.WriteInt(type_, 4)
		net.Broadcast()
	end
end

if SERVER then
	util.AddNetworkString("syncAmmoChanges")
else
	net.Receive("syncAmmoChanges", function()
		local self = net.ReadEntity()
		local type_ = net.ReadInt(4)
		if self.ApplyAmmoChanges then
			self:ApplyAmmoChanges(type_)
		end
	end)
end

if CLIENT then
	local lply = LocalPlayer()
	hg.weapons = hg.weapons or {}
	concommand.Add("hg_unload_ammo", function(ply, cmd, args)
		local wep = ply:GetActiveWeapon()
		if wep and hg.weapons[wep] and wep:Clip1() > 0 and wep:CanUse() then
			net.Start("unload_ammo")
			net.WriteEntity(wep)
			net.SendToServer()
			wep:SetClip1(0)
			wep.drawBullet = nil
		end
	end)

	concommand.Add("hg_change_ammotype", function(ply, cmd, args)
		local wep = ply:GetActiveWeapon()
		local type_ = math.Round(args[1])
		if wep and hg.weapons[wep] and wep:Clip1() == 0 and wep:CanUse() and wep.AmmoTypes and wep.AmmoTypes[type_] then
			--wep:ApplyAmmoChanges(type_)
			ply:ChatPrint("Changed ammotype to: " .. wep.AmmoTypes[type_][1])
			net.Start("changeAmmoType")
			net.WriteEntity(wep)
			net.WriteInt(type_, 4)
			net.SendToServer()
		end
	end)

	local function unloadAmmo()
		RunConsoleCommand("hg_unload_ammo")
	end

	local function changeAmmoType(chosen)
		RunConsoleCommand("hg_change_ammotype", chosen)
	end

	hook.Add("radialOptions", "hg-ammo-manipulations", function()
		local wep = LocalPlayer():GetActiveWeapon()
		local organism = LocalPlayer().organism or {}

		if organism.Otrub then return end

		if IsValid(wep) and hg.weapons[wep] then
			if wep:Clip1() == 0 and wep.AmmoTypes then
				local ammotypes = {}
				for k,ammotype in ipairs(wep.AmmoTypes) do
					print(k)
					ammotypes[k] = ammotype[1]
				end 
				local tbl = {
					changeAmmoType,
					"Change Ammo Type",
					true,
					ammotypes
				}

				hg.radialOptions[#hg.radialOptions + 1] = tbl
			elseif wep:Clip1() > 0 then
				local tbl = {unloadAmmo, "Unload Ammo"}
				hg.radialOptions[#hg.radialOptions + 1] = tbl
			end
		end
	end)

	net.Receive("unload_ammo",function()
		local wep = net.ReadEntity()
		if wep.Unload then
			wep:Unload()
		end
	end)
else
	util.AddNetworkString("unload_ammo")
	util.AddNetworkString("changeAmmoType")
	net.Receive("unload_ammo", function(len, ply)
		local wep = net.ReadEntity()
		wep.drawBullet = nil
		if wep and hg.weapons[wep] and wep:Clip1() > 0 and wep:CanUse() then
			ply:GiveAmmo(wep:Clip1(), wep:GetPrimaryAmmoType(), true)
			wep:SetClip1(0)
			if wep.Unload then
				wep:Unload()
			end
			net.Start("unload_ammo")
			net.WriteEntity(wep)
			net.Broadcast()
			hg.GetCurrentCharacter(ply):EmitSound("snd_jack_hmcd_ammotake.wav")
		end
	end)

	net.Receive("changeAmmoType", function(len, ply)
		local wep = net.ReadEntity()
		local type_ = net.ReadInt(4)
		if wep and hg.weapons[wep] and wep:Clip1() == 0 and wep:CanUse() and wep.AmmoTypes and wep.AmmoTypes[type_] then wep:ApplyAmmoChanges(type_) end
	end)
	--bruh probably need to broadcast this bullshit after
end