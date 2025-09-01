-- Path scripthooked:lua\\weapons\\weapon_tomahawk.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Tomahawk"
SWEP.Instructions = "A single-handed striking tool designed to be used as a melee weapon by military personnel or as a hunting tool."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 25
SWEP.Primary.Wait = 1
SWEP.Primary.Next = 0
SWEP.weaponInvCategory = 6
SWEP.dropAfterHolster = true
--__settings__--
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_SLASH
SWEP.Penetration = 5
SWEP.traceOffsetAng = Angle(-30, -21, 0)
SWEP.traceOffsetVec = Vector(5, 2, -8)
SWEP.traceLen = 12
SWEP.offsetVec = Vector(2, -1, 0)
SWEP.offsetAng = Angle(-40, -20, -90)
SWEP.swing = true
SWEP.swingang = Angle(0, 0, -15)
SWEP.fastHitAllow = false
SWEP.HitSound = "snd_jack_hmcd_axehit.wav"
SWEP.HitWorldSound = "Canister.ImpactHard"
SWEP.animation = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.attackWait = 1
SWEP.attacktime = 0.2
SWEP.staminamul = 2
SWEP.BreakBoneMul = 3
SWEP.DeploySnd = "physics/metal/metal_solid_impact_soft1.wav"
SWEP.HolsterSnd = ""
SWEP.canchangemodes = false
--
SWEP.destroyDoors = 0.25
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_tomahawk_thrown.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("pwb/sprites/tomahawk")
	SWEP.IconOverride = "pwb/sprites/tomahawk.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
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
	[1] = {Vector(0, 0, 0), Angle(20, 60, 90)},
	[0.9] = {Vector(0, 0, 0), Angle(-20, 60, 90)},
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