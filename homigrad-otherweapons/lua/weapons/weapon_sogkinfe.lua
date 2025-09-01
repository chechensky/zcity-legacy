-- Path scripthooked:lua\\weapons\\weapon_sogkinfe.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "SOG SEAL 2000"
SWEP.Instructions = "A serious big knife used by seals (special forces of the US Navy). A good choice for a melee weapon."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 15
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Wait = 2
SWEP.Primary.Next = 0
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.ScrappersSlot = "Melee"

--__settings__--
SWEP.fastHitAllow = true
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_SLASH
SWEP.Penetration = 2
SWEP.traceOffsetAng = Angle(60, 0, 0)
SWEP.traceOffsetVec = Vector(2.5, 1, 0)
SWEP.traceLen = 12

SWEP.ModelScale = 1.3

SWEP.offsetAng = Angle(-170, 90, 30)
SWEP.offsetVec = Vector(3.5, -1.5, -1)
SWEP.r_forearm = Angle(5, -15, 0)
SWEP.r_upperarm = Angle(25, -25, -10)
SWEP.r_hand = Angle(-00, 0, 10)

SWEP.attacktime = 0.1
SWEP.HitSound = "snd_jack_hmcd_knifestab.wav"
SWEP.HitSound2 = "snd_jack_hmcd_slash.wav"
SWEP.HitWorldSound = "snd_jack_hmcd_knifehit.wav"
SWEP.staminamul = 1
--
SWEP.weaponInvCategory = 5
SWEP.ViewModel = ""
SWEP.WorldModel = "models/zcity/weapons/w_sog_knife.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_knife")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_knife.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 1
SWEP.SlotPos = 1
local hullVec = Vector(5,5,5)

function SWEP:ChangedMode(mode)
	if mode then
		self.offsetAng = Angle(-170, 90, 30)
		self.offsetVec = Vector(3.5, -1.5, -1)
        self.r_forearm = Angle(15, -15, 0)
        self.r_upperarm = Angle(15, -25, 0)
        self.r_hand = Angle(-20, 0, 0)
	else
		self.offsetAng = Angle(-170, 90, 20)
		self.offsetVec = Vector(3.5, -1.5, -2)
        self.r_forearm = Angle(-15, -10, -21)
        self.r_upperarm = Angle(15, -40, 25)
        self.r_hand = Angle(0, 0, 0)
	end
end