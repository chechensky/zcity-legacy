-- Path scripthooked:lua\\weapons\\weapon_bat.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Wooden bat"
SWEP.Instructions = "A wooden bat. The design features of the bat allow it to deliver powerful and heavy blows."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 15
SWEP.Primary.Wait = 1.8
SWEP.Primary.Next = 0
SWEP.weaponInvCategory = 6
SWEP.dropAfterHolster = true

--__settings__--
SWEP.HoldType = "melee2"
SWEP.DamageType = DMG_CLUB
SWEP.Penetration = 2
SWEP.traceOffsetAng = Angle(75, 8, 0)
SWEP.traceOffsetVec = Vector(3.5, 1.5, 0)
SWEP.traceLen = 24
SWEP.offsetVec = Vector(3, -1.2, -2.5)
SWEP.offsetAng = Angle(-10, 20, -180)
SWEP.swing = true
SWEP.swingang = Angle(0, 5, 15)
SWEP.HitSound = "Flesh.ImpactHard"
SWEP.HitWorldSound = "physics/wood/wood_plank_impact_hard1.wav"
SWEP.fastHitAllow = false
SWEP.r_forearm = Angle(0, 25, -5)
SWEP.r_upperarm = Angle(-10, -40, -5)
SWEP.r_hand = Angle(0, 0, 0)
SWEP.l_forearm = Angle(0, 0, 0)
SWEP.l_upperarm = Angle(0, 0, 0)
SWEP.animation = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
SWEP.attackWait = 1.5
SWEP.attacktime = 0.2
SWEP.staminamul = 4
SWEP.BreakBoneMul = 1
SWEP.PainMul = 2
SWEP.canchangemodes = false
SWEP.DeploySnd = "physics/wood/wood_plank_impact_soft2.wav"
SWEP.HolsterSnd = ""
--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_bat_wood.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_baseballbat")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_baseballbat.png"
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