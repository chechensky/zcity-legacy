-- Path scripthooked:lua\\weapons\\weapon_hg_axe.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Woodcutting axe"
SWEP.Instructions = "An axe is an implement that has been used for millennia to shape, split, and cut wood. Can break down doors."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 35
SWEP.Primary.Wait = 1.5
SWEP.Primary.Next = 0
SWEP.weaponInvCategory = 6
SWEP.dropAfterHolster = true
--__settings__--
SWEP.HoldType = "melee2"
SWEP.DamageType = bit.bor(DMG_SLASH, DMG_CLUB)
SWEP.Penetration = 4
SWEP.traceOffsetAng = Angle(-5, 0, 0)
SWEP.traceOffsetVec = Vector(1, 1, -18)
SWEP.traceLen = 10
SWEP.offsetVec = Vector(3.5, -1.5, -4)
SWEP.offsetAng = Angle(-5, 5, 90)
SWEP.attacktime = 0.2
SWEP.swing = true
SWEP.swingang = Angle(0, 5, 15)
SWEP.HitSound = "snd_jack_hmcd_axehit.wav"
SWEP.HitWorldSound = "Canister.ImpactHard"
SWEP.fastHitAllow = false
SWEP.r_forearm = Angle(5, 45, -5)
SWEP.r_upperarm = Angle(-10, -40, -15)
SWEP.r_hand = Angle(0, 0, 0)
SWEP.l_forearm = Angle(0, 0, 0)
SWEP.l_upperarm = Angle(0, 0, 0)
SWEP.animation = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
SWEP.attackWait = 1.5
SWEP.staminamul = 5
SWEP.BreakBoneMul = 4
SWEP.ShockMultiplier = 2
SWEP.DeploySnd = "physics/wood/wood_plank_impact_soft2.wav"
SWEP.HolsterSnd = ""
SWEP.canchangemodes = false
--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props/cs_militia/axe.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_axe")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_axe.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.angHold = Angle(0, 0, -18)
SWEP.animationAttackClavicle = {
	[1] = {Vector(0, 0, 0), Angle(0, 20, -150)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 40, -20)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 20, -10)},
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
	[1] = {Vector(0, 0, 0), Angle(40, -50, -50)},
	[0.9] = {Vector(0, 0, 0), Angle(10, -20, -90)},
	[0.8] = {Vector(0, 0, 0), Angle(0, -40, -90)},
	[0.7] = {Vector(0, 0, 0), Angle(0, -10, -90)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackHand = {
	[1] = {Vector(15, 0, 0), Angle(0, -135, 90)},
	[0.9] = {Vector(0, 0, 0), Angle(0, -135, 90)},
	[0.8] = {Vector(0, 0, 0), Angle(0, -135, 40)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 40)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 40)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.destroyDoors = 0.5