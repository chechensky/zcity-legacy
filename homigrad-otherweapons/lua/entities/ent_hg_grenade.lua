-- Path scripthooked:lua\\entities\\ent_hg_grenade.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "ent_hg_grenade"
ENT.Spawnable = false
ENT.Model = "models/pwb/weapons/w_f1_thrown.mdl"
ENT.timeToBoom = 3
ENT.Fragmentation = 300 * 3 --300 не страшно
ENT.BlastDis = 5 --meters
ENT.Penetration = 8
if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(ONOFF_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetMass(5)
			phys:Wake()
			phys:EnableMotion(true)
		end

		timer.Simple(.1, function()
			if not IsValid(self) then return end
			--self:EmitSound("weapons/m67/m67_spooneject.wav", 90, math.random(95, 105))
		end)
	end

	function ENT:Think()
		if (CurTime() - self.timer) > self.timeToBoom and not self.Exploded then self:Explode() end
	end

	local vecCone = Vector(20, 20, 0)
	function ENT:Explode()
		if math.random(1, 100) == 1 then
			self:EmitSound("weapons/p99/slideback.wav", 75)
			self.Exploded = true
			return
		end

		local selfPos = self:GetPos()
		self.Exploded = true
		local effectdata = EffectData()
		effectdata:SetOrigin(selfPos)
		effectdata:SetScale(1)
		util.Effect("eff_jack_fragsplosion", effectdata)
		self:EmitSound("m67/m67_detonate_01.wav", 75)
		self:EmitSound("m67/m67_detonate_far_dist_02.wav", 140)
		
		util.BlastDamage(self, self.owner, selfPos, self.BlastDis / 0.01905, 250)
		hg.ExplosionEffect(selfPos, self.BlastDis / 0.01905, 250)
		
		local Poof=EffectData()
		Poof:SetOrigin(selfPos)
		Poof:SetScale(1)
		util.Effect("eff_jack_hmcd_shrapnel",Poof,true,true)

		local bullet = {}
		bullet.Src = selfPos
		bullet.Spread = vecCone
		bullet.Force = 0.1	
		bullet.Damage = 40
		bullet.AmmoType = "12/70 gauge"
		bullet.Attacker = self.owner
		bullet.Distance = 75
		timer.Simple(0, function()
			for i = 1, self.Fragmentation do
				bullet.Dir = vector_up
				bullet.Spread = vecCone * i / self.Fragmentation
				self:FireBullets(bullet, true)
			end

			self:Remove()
		end)
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end

function ENT:PhysicsCollide(phys, deltaTime)
	if phys.Speed > 20 then self:EmitSound("physics/metal/metal_grenade_impact_hard" .. math.random(3) .. ".wav", 65, math.random(95, 105)) end
end