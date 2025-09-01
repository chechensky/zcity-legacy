-- Path scripthooked:lua\\weapons\\weapon_pocketknife.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Pocket Knife"
SWEP.Instructions = "A small knife which can be easily hidden in your pockets. RMB to interact with environment."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 7
SWEP.Primary.Wait = 1
SWEP.Primary.Next = 0
--__settings__--
SWEP.fastHitAllow = true
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_SLASH
SWEP.Penetration = 3
SWEP.traceOffsetAng = Angle(-30, -21, 0)
SWEP.traceOffsetVec = Vector(12, 0, -8)
SWEP.traceLen = 3
SWEP.offsetVec = Vector(3, -1, 0)
SWEP.offsetAng = Angle(-170, 90, 15)
SWEP.attacktime = 0.1
SWEP.swing = true
SWEP.swingang = Angle(0, -2, 5)
SWEP.attackWait = 0.7
SWEP.ImmobilizationMul = 0.2

SWEP.weaponInvCategory = 3
SWEP.DeploySnd = "snd_jack_hmcd_tinyswish.wav"
SWEP.HolsterSnd = ""
--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_knife_swch.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_pocketknife")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_pocketknife.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.animationAttackClavicle = {
	[1] = {Vector(0, 0, 0), Angle(0, 50, 50)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 50, 30)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 20, 10)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackTorso = {
	[1] = {Vector(0, 0, 0), Angle(0, 0, 15)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 0, 15)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 0, 2)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, -2)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackForearm = {
	[1] = {Vector(0, 0, 0), Angle(-20, 60, 0)},
	[0.9] = {Vector(0, 0, 0), Angle(-10, 50, 0)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 40, 0)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackHand = {
	[1] = {Vector(0, 0, 0), Angle(-70, 0, 0)},
	[0.9] = {Vector(0, 0, 0), Angle(-60, 0, 0)},
	[0.8] = {Vector(0, 0, 0), Angle(-40, 0, 0)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}