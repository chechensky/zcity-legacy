-- Path scripthooked:lua\\weapons\\weapon_leadpipe.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Lead Pipe"
SWEP.Instructions = "A lead pipe that can be used as a weapon."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 15
SWEP.Primary.Wait = 1.8
SWEP.Primary.Next = 0
--__settings__--
SWEP.fastHitAllow = false
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_CLUB
SWEP.Penetration = 3
SWEP.traceOffsetAng = Angle(60, -10, 0)
SWEP.traceOffsetVec = Vector(3.5, 1.5, 0)
SWEP.traceLen = 19
SWEP.offsetVec = Vector(6, -1.8, -6)
SWEP.offsetAng = Angle(-30, -10, -180)
SWEP.attacktime = 1.8
SWEP.swing = true
SWEP.swingang = Angle(0, -5, -15)
SWEP.HitSound = "Flesh.ImpactHard"
SWEP.HitWorldSound = "Canister.ImpactHard"
SWEP.animation = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.attackWait = 0.8
SWEP.attacktime = 0.2
SWEP.staminamul = 2
SWEP.BreakBoneMul = 2
SWEP.canchangemodes = false
SWEP.weaponInvCategory = 3

SWEP.DeploySnd = "physics/metal/metal_solid_impact_soft1.wav"
SWEP.HolsterSnd = ""

--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_pipe_lead.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_nmrih_lpipe")
	SWEP.IconOverride = "vgui/hud/tfa_nmrih_lpipe.png"
	SWEP.BounceWeaponIcon = false
end

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
	[1] = {Vector(15, 0, 0), Angle(-90, -45, -10)},
	[0.9] = {Vector(0, 0, 0), Angle(-50, -25, -10)},
	[0.8] = {Vector(0, 0, 0), Angle(-30, -5, 0)},
	[0.7] = {Vector(0, 0, 0), Angle(-20, -5, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(-10, -5, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(00, 0, 0)},
}