-- Path scripthooked:lua\\weapons\\weapon_zombclaws.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Zombie Claws"
SWEP.Instructions = "LMB - Normal hit\nRMB - Extra hit"
SWEP.Category = "ZCity Other"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Damage = math.random(20, 25)
SWEP.Primary.Wait = .5
SWEP.Primary.Next = 0
--__settings__--
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_SLASH
SWEP.Penetration = 2
SWEP.BreakBoneMul = 2
SWEP.traceOffsetAng = Angle(30, 0, 0)
SWEP.traceOffsetVec = Vector(-3, 0, 0)
SWEP.traceLen = 25
SWEP.offsetVec = Vector(0, 0, 0)
SWEP.offsetAng = Angle(0, 0, 0)
SWEP.attacktime = .15
SWEP.swing = true
SWEP.swingang = Angle(10, 10, 5)
SWEP.staminamul = -.1
SWEP.HitSound = "npc/fast_zombie/claw_strike1.wav"
SWEP.HitWorldSound = "npc/fast_zombie/claw_strike3.wav"

SWEP.DeploySnd = ""
SWEP.HolsterSnd = ""

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_zombhands")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_zombhands.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.r_forearm = Angle(0, 30, -60)
SWEP.r_upperarm = Angle(10, -70, 0)
SWEP.r_hand = Angle(0, 0, 0)
SWEP.l_forearm = Angle(-10, 35, 35)
SWEP.l_upperarm = Angle(-10, -45, -25)
--
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.WorkWithFake = false
if SERVER then
	function SWEP:Initialize()
		self:SetHold(self.HoldType)
		self.nextAttack = 0
		timer.Simple(.2, function()
			local owner = self:GetOwner()
			if not (self:IsValid() or owner:IsValid()) then return end
			local org = owner.organism
			if not org then return end
			owner:StripWeapon("weapon_hands_sh")
			owner:SetModel("models/player/zombie_fast.mdl")
			owner:SetHealth(130)
			owner:SetMaxHealth(130)
			owner:SetWalkSpeed(600)
			owner:SetRunSpeed(600)
			owner:SetNWString("PlayerName", "Zombie")
			owner:SetSubMaterial()
			org.adrenaline = 1
			org.painkiller = 1
			org.disorientation = 0
			org.bleed = 0
			org.pain = 0
			org.painadd = 0
			org.shock = 0
			org.hurt = 0
			org.stamina.regen = 10
			org.stamina.fatigue = 10
			org.internalBleedHeal = 10
			org.stamina.range = 300
			self.SoundLoop = CreateSound(owner, "npc/fast_zombie/breathe_loop1.wav")
			self.SoundLoop:SetSoundLevel(70)
			self.SoundLoop:PlayEx(.3, math.random(95, 105))
		end)
	end

	local nextThink = 0
	function SWEP:Think()
		if nextThink > CurTime() then return end
		local owner = self:GetOwner()
		if self.SoundLoop and not IsValid(owner) then self.SoundLoop:Stop() end
		if not (self:IsValid() or owner:IsValid()) then return end
		local org = owner.organism
		if not org then return end
		org.adrenaline = 1
		org.painkiller = 1
		org.disorientation = 0
		org.bleed = 0
		org.pain = 0
		org.painadd = 0
		org.shock = 0
		org.hurt = 0
		org.pulse = 100
		org.stamina.regen = 100
		org.stamina.max = 600
		org.stamina.sub = 0
		org.internalBleedHeal = 10
		org.Otrub = false
		nextThink = CurTime() + .5
	end

	function SWEP:OnRemove()
		local owner = self:GetOwner()
		if not (self:IsValid() or owner:IsValid()) then return end
		if self.SoundLoop then self.SoundLoop:Stop() end
	end

	function SWEP:OnDrop()
		self:Remove()
	end

	function SWEP:Holster()
		return false
	end
end

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
	[0.7] = {Vector(0, 0, 0), Angle(0, 30, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}

SWEP.animationAttackHand = {
	[1] = {Vector(5, 0, 0), Angle(0, 0, 0)},
	[0.9] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.8] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.7] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.6] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.5] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.4] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.3] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.2] = {Vector(0, 0, 0), Angle(0, 0, 0)},
	[0.1] = {Vector(0, 0, 0), Angle(0, 0, 0)},
}