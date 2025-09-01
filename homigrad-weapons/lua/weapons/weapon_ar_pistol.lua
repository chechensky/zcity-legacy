-- "addons\\homigrad-weapons\\lua\\weapons\\weapon_ar_pistol.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "AR-15"
SWEP.Author = "Colt's Manufacturing Company"
SWEP.Instructions = 'AR-15-type "pistol" chambered in 5.56x45 mm\n\nALT+E to change stance (+walk,+use)'
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/ar15/w_colt6149.mdl"

SWEP.WepSelectIcon2 = Material("scrappers/ar15-pistol.png")
SWEP.IconOverride = "scrappers/ar15-pistol.png"

--models/ar15/w_smg_635.mdl
--models/ar15/w_colt6149.mdl
--models/ar15/w_kacmark012.mdl
--models/ar15/w_kacmark011.mdl
--models/ar15/w_ares_shrikemg.mdl
--models/ar15/w_magpulm.mdl
--models/ar15/w_kac_s47.mdl
SWEP.weaponInvCategory = 2
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "5.56x45 mm"
SWEP.CustomShell = "556x45"
SWEP.EjectPos = Vector(0,7,5)
SWEP.EjectAng = Angle(-25,-65,0)

SWEP.ShockMultiplier = 3

SWEP.ScrappersSlot = "Secondary"

SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 44
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 44
SWEP.Primary.Sound = {"m16a4/m16a4_fp.wav", 75, 90, 100}
SWEP.SupressedSound = {"m4a1/m4a1_suppressed_fp.wav", 65, 90, 100}
SWEP.Primary.Wait = 0.063
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "revolver"
SWEP.ZoomPos = Vector(-2.25, -0.035, 42)
SWEP.RHandPos = Vector(2, -1, 1)
SWEP.LHandPos = false
SWEP.AimHands = Vector(-2, 0.45, -5.9)
SWEP.SprayRand = {Angle(-0.03, -0.03, 0), Angle(-0.05, 0.03, 0)}
SWEP.Ergonomics = 1.2
SWEP.Penetration = 7
SWEP.WorldPos = Vector(-0, -0.5, -0.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 1
SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor2", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(-2,0.6,0),
	},
	sight = {
		["empty"] = {
			"empty",
			{
				[1] = "null"
			},
		},
		["mountType"] = "picatinny",
		["mount"] = Vector(-17, 1.3, 0.05),
		["removehuy"] = {
			[1] = "null"
		}
	}
}

SWEP.weight = 2

if CLIENT then
	function SWEP:DrawHUDAdd()
	end
	--self:DoHolo()
end

local recoilAng1 = {Angle(-0.03, -0.03, 0), Angle(-0.05, 0.03, 0)}
local recoilAng2 = {Angle(-0.015, -0.015, 0), Angle(-0.025, 0.015, 0)}
if SERVER then
	util.AddNetworkString("send_huyhuy2")
else
	net.Receive("send_huyhuy2", function(len)
		local self = net.ReadEntity()
		local twohands = net.ReadBool()
		self.HoldType = twohands and "ar2" or "revolver"
		self.SprayRand = twohands and recoilAng1 or recoilAng2
		self.AnimShootHandMul = twohands and 0.25 or 1
		self.ZoomPos = twohands and Vector(-2.25, -0.035, 29) or Vector(-2.25, -0.035, 42)
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
				self.AnimShootHandMul = twohands and 0.25 or 1
				net.Start("send_huyhuy2")
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
SWEP.holsteredPos = Vector(6, 9, 8)
SWEP.holsteredAng = Angle(150, -5, 0)