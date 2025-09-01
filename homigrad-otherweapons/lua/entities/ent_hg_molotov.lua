-- Path scripthooked:lua\\entities\\ent_hg_molotov.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Type = "anim"
ENT.Author = "Mannytko"
ENT.Category = "ZCity Other"
ENT.PrintName = "Molotov Cocktail"
ENT.Spawnable = true
ENT.AdminOnly = true
if SERVER then
	function ENT:Initialize()
		self:SetModel("models/w_models/weapons/w_eq_molotov.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(true)
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:SetMass(35)
			phys:Wake()
		end
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > .2 and data.Speed > 25 then
			self:EmitSound("GlassBottle.ImpactHard")
			if data.Speed > 300 and not self.Exploded then self:Detonate() end
		end
	end

	function ENT:Use(ply)
		ply:PickupObject(self)
	end

	function ENT:OnTakeDamage(dmginfo)
		if self.Exploded then return end
		self:TakePhysicsDamage(dmginfo)
		local Dmg = dmginfo:GetDamage()
		if Dmg >= 1 and dmginfo:IsDamageType(DMG_BURN) then
			timer.Simple(2, function()
				if not IsValid(self) then return end
				self:Detonate()
			end)
		end
	end

	function ENT:Detonate()
		if self.Exploded then return end
		self.Exploded = true
		local SelfPos, Owner = self:LocalToWorld(self:OBBCenter()), self.EZowner or self
		local Boom = ents.Create("env_explosion")
		Boom:SetPos(SelfPos)
		Boom:SetKeyValue("imagnitude", "50")
		Boom:SetOwner(Owner)
		Boom:Spawn()
		Boom:Fire("explode", 0)
		timer.Simple(.01, function()
			if not IsValid(self) then return end
			for i = 0, 10 do
				local Tr = util.QuickTrace(SelfPos, VectorRand() * math.random(10, 150), {self})
				if Tr.Hit then
					util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
					util.Decal("BeerSplash", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
				end
			end
		end)

		local effectdata = EffectData()
		effectdata:SetOrigin(SelfPos)
		effectdata:SetScale(0.5)
		util.Effect("eff_jack_fragsplosion", effectdata)

		timer.Simple(.02, function()
			if not IsValid(self) then return end
			sound.Play("snd_jack_firebomb.wav", SelfPos, 80, 100)
			local Eff = EffectData()
			Eff:SetOrigin(self:GetPos())
			Eff:SetEntity(self)
			Eff:SetMagnitude(.5)
			Eff:SetScale(60)
			Eff:SetColor(120, 60, 0)
			Eff:SetNormal(VectorRand())
			util.Effect("GlassImpact", Eff, true, true)
			for i = 1, 10 do
				sound.Play("GlassBottle.Break", SelfPos, 80 + i, 100)
			end
		end)

		--for i = 1, 2 do
		local FireVec = (self:GetVelocity() / 500 + VectorRand() * .6 + Vector(0, 0, .6)):GetNormalized()
		FireVec.z = FireVec.z / 2
		local Flame = ents.Create("ent_hg_firesmall")
		Flame:SetPos(SelfPos + Vector(0, 0, 10))
		Flame:SetAngles(FireVec:Angle())
		Flame:SetOwner(IsValid(self.Initiator) and self.Initiator or self or game.GetWorld())
		Flame:Spawn()
		Flame:Activate()
		--end
		timer.Simple(.06, function()
			if not IsValid(self) then return end
			self:Remove()
		end)
	end
elseif CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end