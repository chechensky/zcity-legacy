-- Path scripthooked:lua\\weapons\\weapon_draco.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Draco"
SWEP.Author = "ROMARM via Regia Autonomă pentru producţia de Tehnică Militară (RATMIL), Cugir"
SWEP.Instructions = "DRACO-Pistol chambered in 7.62x39 mm\n\nALT+E to change stance (+walk,+use)"
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/draco/w_draco.mdl"

SWEP.WepSelectIcon2 = Material("scrappers/darco.png")
SWEP.IconOverride = "scrappers/darco.png"

SWEP.CustomShell = "762x39"
--SWEP.EjectPos = Vector(0,10,5)
--SWEP.EjectAng = Angle(-55,80,0)

SWEP.weight = 2

SWEP.ScrappersSlot = "Secondary"

SWEP.ShockMultiplier = 2

SWEP.weaponInvCategory = 2
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "7.62x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 50
SWEP.Primary.Sound = {"homigrad/weapons/rifle/fal.wav", 85, 90, 100}
SWEP.Primary.Force = 50
SWEP.Primary.Wait = 0.1
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(-1.36, -0.02, 40)
SWEP.RHandPos = Vector(-5, -1, -1)
SWEP.LHandPos = false
SWEP.SprayRand = {Angle(-0.1, -0.2, 0), Angle(-0.2, 0.2, 0)}
SWEP.Ergonomics = 0.9
SWEP.Penetration = 15
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 1
SWEP.WorldPos = Vector(5, -1, -1.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attAng = Angle(-0.05, 0.8, 0)
function SWEP:InitializePost()
	if SERVER then
		if math.random(100) <= 5 then
			net.Start("gdraco")
			net.WriteEntity(self)
			net.Broadcast()
			self.WorldModel = "models/draco/w_gdraco.mdl"
			self.ViewModel = "models/draco/w_gdraco.mdl"
		end
	end

	self:SetBodyGroups("01")
end

if SERVER then
	util.AddNetworkString("gdraco")
else
	net.Receive("gdraco", function(len)
		local self = net.ReadEntity()
		self.WorldModel = "models/draco/w_gdraco.mdl"
		self.ViewModel = "models/draco/w_gdraco.mdl"
	end)
end

local recoilAng1 = {Angle(-0.05, -0.1, 0), Angle(-0.1, 0.1, 0)}
local recoilAng2 = {Angle(-0.1, -0.2, 0), Angle(-0.2, 0.2, 0)}
if SERVER then
	util.AddNetworkString("send_huyhuy3")
else
	net.Receive("send_huyhuy3", function(len)
		local self = net.ReadEntity()
		local twohands = net.ReadBool()
		self.HoldType = twohands and "ar2" or "revolver"
		self.SprayRand = twohands and recoilAng1 or recoilAng2
		self.AnimShootMul = twohands and 0.25 or 2
		self.ZoomPos = twohands and Vector(-1.46, -0.02, 29) or Vector(-1.36, -0.02, 40)
	end)
end

function SWEP:Step()
	self:CoreStep()
	local owner = self:GetOwner()
	if not IsValid(owner) then return end
	if owner:KeyDown(IN_WALK) and owner:KeyDown(IN_USE) then
		if not self.huybut then
			if SERVER then
				local twohands = self.HoldType == "revolver"
				self.HoldType = twohands and "ar2" or "revolver"
				self.SprayRand = twohands and recoilAng1 or recoilAng2
				self.AnimShootMul = twohands and 0.25 or 2
				net.Start("send_huyhuy3")
				net.WriteEntity(self)
				net.WriteBool(twohands)
				net.Broadcast()
			end

			self.huybut = true
		end
	else
		self.huybut = false
	end
end

SWEP.lengthSub = 10
SWEP.DistSound = "ak74/ak74_dist.wav"
SWEP.holsteredPos = Vector(1, 9, 5)
SWEP.holsteredAng = Angle(150, -10, 0)