-- Path scripthooked:lua\\weapons\\weapon_brick.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Brick"
SWEP.Instructions = "A heavy construction brick, that can be used as a deadly weapon."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = 6
SWEP.Primary.Wait = 1.5
SWEP.Primary.Next = 0
--__settings__--
SWEP.fastHitAllow = false
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_CLUB
SWEP.Penetration = 4
SWEP.traceOffsetAng = Angle(70, -5, 0)
SWEP.traceOffsetVec = Vector(3, .5, 0)
SWEP.traceLen = 12
SWEP.offsetVec = Vector(2.8, -1.5, -1.5)
SWEP.offsetAng = Angle(-70, 180, -90)
SWEP.attacktime = 0.1
SWEP.swing = true
SWEP.swingang = Angle(0, 0, 5)
SWEP.HitSound = "Flesh.ImpactHard"
SWEP.HitSound2 = "Flesh.ImpactHard"
SWEP.HitWorldSound = "Concrete.ImpactHard"
SWEP.BreakBoneMul = 2
SWEP.canchangemodes = false
SWEP.weaponInvCategory = 3

SWEP.DeploySnd = "physics/concrete/rock_impact_hard3.wav"
SWEP.HolsterSnd = ""

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_brick")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_brick"
	SWEP.BounceWeaponIcon = false
end

--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_brick.mdl"
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.angHold = Angle(2, 0, -10)
SWEP.animationAttackClavicle = {
	[1] = {Vector(0, 0, 0), Angle(0, 80, 40)},
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
	[1] = {Vector(0, 0, 0), Angle(0, 0, 50)},
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
	[1] = {Vector(5, 0, 0), Angle(-45, 0, 20)},
	[0.9] = {Vector(0, 0, 0), Angle(-45, 0, 20)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 0, 20)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}