-- Path scripthooked:lua\\weapons\\weapon_hatchet.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Hatchet"
SWEP.Instructions = "A single-handed striking tool with a sharp blade on one side used to cut and split wood, and a hammerhead on the other side."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 25
SWEP.Primary.Wait = 1.8
SWEP.Primary.Next = 0
SWEP.weaponInvCategory = 6
SWEP.dropAfterHolster = true
--__settings__--
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_SLASH
SWEP.Penetration = 3
SWEP.traceOffsetAng = Angle(-2, -10, 0)
SWEP.traceOffsetVec = Vector(2.5, 2, 0)
SWEP.traceLen = 19
SWEP.offsetVec = Vector(3, -1, -1)
SWEP.offsetAng = Angle(-15, -25, 80)
SWEP.attacktime = 0.2
SWEP.swing = true
SWEP.swingang = Angle(0, -5, -15)
SWEP.HitSound = "snd_jack_hmcd_axehit.wav"
SWEP.HitWorldSound = "Canister.ImpactHard"
SWEP.fastHitAllow = false
SWEP.animation = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.attackWait = 1
SWEP.staminamul = 2
SWEP.BreakBoneMul = 1
SWEP.canchangemodes = false
SWEP.DeploySnd = "physics/metal/metal_solid_impact_soft1.wav"
SWEP.HolsterSnd = ""
--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/eu_homicide/w_hatchet.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_hatchet")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_hatchet.png"
	SWEP.BounceWeaponIcon = false
end
SWEP.destroyDoors = 0.25
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.angHold = Angle(0, 0, -18)
SWEP.animationAttackClavicle = {
	[1] = {Vector(0, 0, 0), Angle(0, 50, 50)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 40, 20)},
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
	[1] = {Vector(0, 0, 0), Angle(0, 0, 5)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 0, 30)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 0, 10)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackForearm = {
	[1] = {Vector(0, 0, 0), Angle(-20, 50, 50)},
	[0.9] = {Vector(0, 0, 0), Angle(-10, 50, 90)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 40, 90)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 30, 90)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackHand = {
	[1] = {Vector(15, 0, 0), Angle(-140, 45, -10)},
	[0.9] = {Vector(0, 0, 0), Angle(-50, 25, -10)},
	[0.8] = {Vector(0, 0, 0), Angle(30, -5, 0)},
	[0.7] = {Vector(0, 0, 0), Angle(20, -5, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(10, -5, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(00, 0, 0)},
}