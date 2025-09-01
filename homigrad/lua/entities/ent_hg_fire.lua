-- Path scripthooked:lua\\entities\\ent_hg_fire.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Fire"
ENT.Category = "ZCity Other"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Radius = 150
if CLIENT then return end
local boundVector1, boundVector2 = Vector(-20, -20, -10), Vector(20, 20, 10)
function ENT:Initialize()
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(false)
	self:SetNoDraw(true)
	self:SetCollisionBounds(boundVector1, boundVector2)
	self:PhysicsInitBox(boundVector1, boundVector2)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:EnableCollisions(false) end
	self:SetNotSolid(true)
	self.NextSound = 0
	if not self.Initiator then self.Initiator = self:GetOwner() end
	SafeRemoveEntityDelayed(self, 30)
end

function ENT:Think()
	local SelfPos = self:GetPos() + Vector(0, 0, math.random(0, 100)) + VectorRand() * math.random(0, 100)
	if self.Radius > 50 then
		local Foof = EffectData()
		Foof:SetOrigin(SelfPos)
		Foof:SetRadius(self.Radius)
		util.Effect("eff_hg_fire", Foof, true, true)
	end

	for key, obj in ipairs(ents.FindInSphere(SelfPos, self.Radius)) do
		if (obj ~= self) and obj.GetPhysicsObject and IsValid(obj:GetPhysicsObject()) then
			local Dist = (obj:GetPos() - self:GetPos()):Length()
			local Frac = 1 - (Dist / self.Radius)
			if self:Visible(obj) then
				local Dmg = DamageInfo()
				-- если создается огонь то ему нужно будет назначить ent.Initiator (это чето типо овнера)
				Dmg:SetAttacker(IsValid(self.Initiator) and self.Initiator or self or game.GetWorld())
				Dmg:SetInflictor(self)
				Dmg:SetDamageType(DMG_BURN)
				Dmg:SetDamagePosition(SelfPos)
				Dmg:SetDamageForce(vector_origin)
				local 🔥 = obj:WaterLevel() < 1 and Frac * 2 or Frac * .6
				if obj:IsRagdoll() then 🔥 = Frac * .8 end
				Dmg:SetDamage(🔥)
				--obj:TakeDamageInfo(Dmg)
				Frac = math.max(Frac,0)
				if IsValid(obj) and obj:IsPlayer() and obj:Alive() then
					local org = obj.organism
					
					if org then
						org.o2[1] = math.min(org.o2[1] + 0.03 * math.min(Frac,0.4),1)
						org.o2[2] = math.min(org.o2[2] + 0.03 * math.min(Frac,0.4),1)
					end
				end
				if IsValid(obj) and ((obj:IsPlayer() and obj:Alive()) or (not obj:IsPlayer() and not obj:IsOnFire() or obj:WaterLevel() < 1)) and obj:GetMoveType() != MOVETYPE_NOCLIP then obj:Ignite(30) end
			end
		end
	end

	for i, ent in ipairs(ents.FindInSphere(SelfPos, self.Radius * 2)) do
		if self:Visible(ent) then
			local Dist = (ent:GetPos() - self:GetPos()):Length()
			local Frac = 1 - (Dist / (self.Radius * 2))
			Frac = math.max(Frac,0)
			if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
				local org = ent.organism
				
				if org then
					org.o2[1] = org.o2[1] - 1 * math.min(Frac,0.4)
				end
			end
		end
	end

	if self.NextSound < CurTime() then
		self.NextSound = CurTime() + 7
		sound.Play("snd_jack_firebomb.wav", SelfPos, 80, 100)
	end

	if self:WaterLevel() > 0 then
		self.Radius = self.Radius - 6
	else
		self.Radius = self.Radius + (self.Small and 2 or 4)
	end

	if self.Radius < 1 then SafeRemoveEntity(self) end
	self:NextThink(CurTime() + .2)
	return true
end