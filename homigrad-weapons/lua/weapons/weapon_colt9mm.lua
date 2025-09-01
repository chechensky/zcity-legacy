-- "addons\\homigrad-weapons\\lua\\weapons\\weapon_colt9mm.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Colt 9mm SMG"
SWEP.Author = "Colt's Manufacturing Company"
SWEP.Instructions = "AR15 pistol chambered in 9x19 mm\n\nALT+E to change stance (+walk,+use)"
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/ar15/w_smg_635.mdl"

SWEP.CustomShell = "9x19"
SWEP.EjectPos = Vector(0,10,5)
SWEP.EjectAng = Angle(-55,80,0)

SWEP.ScrappersSlot = "Secondary"

SWEP.WepSelectIcon2 = Material("scrappers/colt9.png")
SWEP.IconOverride = "scrappers/colt9.png"
--models/ar15/w_smg_635.mdl
--models/ar15/w_colt6149.mdl
--models/ar15/w_kacmark012.mdl
--models/ar15/w_kacmark011.mdl
--models/ar15/w_ares_shrikemg.mdl
--models/ar15/w_magpulm.mdl
--models/ar15/w_kac_s47.mdl
SWEP.weaponInvCategory = 2
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.Primary.ClipSize = 32
SWEP.Primary.DefaultClip = 32
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 25
SWEP.Primary.Sound = {"m16a4/m16a4_fp.wav", 75, 120, 130}
SWEP.Primary.Force = 25
SWEP.Primary.Wait = 0.063
SWEP.ReloadTime = 2.3
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(-2.65, -0.15, 40)
SWEP.RHandPos = Vector(2, -1, 1)
SWEP.LHandPos = false
SWEP.SprayRand = {Angle(-0.00, -0.02, 0), Angle(-0.01, 0.02, 0)}
SWEP.Ergonomics = 0.9
SWEP.Penetration = 7
SWEP.WorldPos = Vector(-2.5, -1, 1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 2
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(0.38, -0.1, 0)
function SWEP:InitializePost()
	self:SetBodyGroups("01")
end

SWEP.weight = 1.5

local recoilAng1 = {Angle(-0.03, -0.03, 0), Angle(-0.05, 0.03, 0)}
local recoilAng2 = {Angle(-0.015, -0.015, 0), Angle(-0.025, 0.015, 0)}
if SERVER then
	util.AddNetworkString("send_huyhuy")
else
	net.Receive("send_huyhuy", function(len)
		local self = net.ReadEntity()
		local twohands = net.ReadBool()
		self.HoldType = twohands and "ar2" or "revolver"
		self.SprayRand = twohands and recoilAng2 or recoilAng1
		self.AnimShootHandMul = twohands and 0.5 or 2
		self.ZoomPos = twohands and Vector(-2.65, -0.05, 25) or Vector(-2.65, -0.15, 40)
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
				self.SprayRand = twohands and recoilAng2 or recoilAng1
				self.AnimShootHandMul = twohands and 0.5 or 2
				net.Start("send_huyhuy")
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

SWEP.lengthSub = 5
SWEP.DistSound = "m9/m9_dist.wav"
SWEP.holsteredPos = Vector(11, 9, 8)
SWEP.holsteredAng = Angle(150, -10, 0)