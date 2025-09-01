-- "addons\\homigrad-weapons\\lua\\entities\\projectile_base.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Type = "anim"
ENT.Author = "Sadsalat"
ENT.Category = "ZCity Other"
ENT.PrintName = "Projectile Base"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Model = ""
ENT.Sound = ""
ENT.SoundFar = ""
ENT.SoundWater = ""
ENT.Speed = 1
ENT.TruhstTime = 2
ENT.Oskole = true
ENT.Fragmentation = 1200

ENT.BlastDamage = 80
ENT.BlastDis = 25

game.AddParticles("particles/pcfs_jack_muzzleflashes.pcf")
game.AddParticles("particles/pcfs_jack_explosions_small3.pcf")
game.AddParticles("particles/pcfs_jack_explosions_incendiary2.pcf")

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(true)
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:SetMass(20)
			phys:Wake()
			self:EmitSound("weapons/ins2rpg7/rpg_rocket_loop.wav",75,100,1,CHAN_AUTO)
		end
		local Eff = EffectData()
		Eff:SetOrigin(self:GetPos()+ self:GetAngles():Forward() * -75)
		Eff:SetNormal(-self:GetAngles():Forward())
		Eff:SetScale(1.5)
		util.Effect("eff_jack_rockettrust", Eff, true, true)

		self.Osejka = (100 == math.random(1,100))
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > .2 and data.Speed > 25 then
			if data.Speed > 200 and not self.Exploded then self:Detonate() end
		end
	end

	function AeroDrag(ent, forward, mult, spdReq)
		if constraint.HasConstraints(ent) then return end
		if ent:IsPlayerHolding() then return end
		local Phys = ent:GetPhysicsObject()
		if not IsValid(Phys) then return end
		local Vel = Phys:GetVelocity()
		local Spd = Vel:Length()
	
		if not spdReq then
			spdReq = 300
		end
	
		if Spd < spdReq then return end
		mult = mult or 1
		local Pos, Mass = Phys:LocalToWorld(Phys:GetMassCenter()), Phys:GetMass()
		Phys:ApplyForceOffset(Vel * Mass / 6 * mult, Pos + forward)
		Phys:ApplyForceOffset(-Vel * Mass / 6 * mult, Pos - forward)
		Phys:AddAngleVelocity(-Phys:GetAngleVelocity() * Mass / 1000)
	end


    function ENT:Think()
		AeroDrag(self, self:GetAngles():Forward(), .75)
		if self.Osejka then self:StopSound("weapons/ins2rpg7/rpg_rocket_loop.wav") return end
		self.Truhst = self.Truhst or CurTime() + self.TruhstTime
		local Eff = EffectData()
		Eff:SetOrigin(self:GetPos())
		Eff:SetNormal(-self:GetAngles():Forward())
		Eff:SetScale(0.5)
		util.Effect("eff_jack_rockettrail", Eff, true, true)
		if self.Truhst < CurTime() then return end
        self:GetPhysicsObject():SetVelocity( self:GetVelocity() + self:GetAngles():Forward() * self.Speed )
        self:NextThink(CurTime() + 0.1)
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
	util.AddNetworkString("projectileFarSound")
	function ENT:Detonate()
		if self.Exploded then return end
		self.Exploded = true
		local SelfPos, Owner = self:LocalToWorld(self:OBBCenter()), self

		net.Start("projectileFarSound")
			net.WriteString(self.Sound)
			net.WriteString(self.SoundFar)
			net.WriteVector(SelfPos)
			net.WriteEntity(self)
			net.WriteBool(self:WaterLevel() > 0)
			net.WriteString(self.SoundWater)
		net.Broadcast()

		--[[local boom = DamageInfo()
		boom:SetDamage(self.BlastDamage)
		boom:SetDamageType(DMG_BLAST)
		boom:SetDamageForce(vector_up * 0)
		boom:SetInflictor(self)

		util.BlastDamageInfo( boom, SelfPos, self.BlastDis / 0.01905 )]]--
		util.BlastDamage(self, Owner, SelfPos, self.BlastDis / 0.01905, self.BlastDamage * 1)
		hgWreckBuildings(self, SelfPos, self.BlastDamage / 100, self.BlastDis/6, false)
		hgBlastDoors(self, SelfPos, self.BlastDamage / 100, self.BlastDis/6, false)

        local effectdata = EffectData()
		effectdata:SetOrigin(SelfPos)
		effectdata:SetScale(self.BlastDis/2.5)
        effectdata:SetNormal(-self:GetAngles():Forward())
		util.Effect("eff_jack_genericboom", effectdata)
		hg.ExplosionEffect(SelfPos, self.BlastDis / 0.2, 80)

		timer.Simple(.01, function()
			if not IsValid(self) then return end
			for i = 0, 10 do
				local Tr = util.QuickTrace(SelfPos, -vector_up, {self})
				if Tr.Hit then
					util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
				end
			end
		end)

		timer.Simple(0, function()
			if not IsValid(self) then return end
			if self.Oskole then 
				local vecCone = Vector(5, 5, 0)
				local bullet = {}
				bullet.Src = SelfPos
				bullet.Spread = vecCone
				bullet.Force = 0.01
				bullet.Damage = self.BlastDamage
				bullet.AmmoType = "12/70 gauge"
				bullet.Attacker = Owner
				bullet.Distance = 205
				for i = 1, self.Fragmentation do
					bullet.Dir = self:GetAngles():Forward() * math.random(-1,1)
					bullet.Spread = vecCone * (i / self.Fragmentation)
					self:FireBullets(bullet, true)
				end
			end
            util.ScreenShake(SelfPos,99999,99999,1,3000)
		end)

		timer.Simple(.06, function()
			if not IsValid(self) then return end
			self:StopSound("weapons/ins2rpg7/rpg_rocket_loop.wav")
			self:Remove()
		end)
	end
elseif CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
	
	local function PlaySndDist(snd,snd2,pos,isOnWater,watersnd)
		if SERVER then return end
		local view = render.GetViewSetup(true)
		local time = pos:Distance(view.origin) / 17836
		--print(time)
		timer.Simple(time, function()
			local owner = Entity(0)
			if not isOnWater then
				EmitSound(snd2, pos, 0, CHAN_WEAPON, 1, 90, 0, 100, 0, nil)
				EmitSound(snd, pos, 0, CHAN_AUTO, 1, time > 0.6 and 140 or 110, 0, 100, 0, nil)
			else
				EmitSound(watersnd, pos, 0, CHAN_WEAPON, 1, 100, 0, 85, 0, nil)
			end
		end)
	end

	net.Receive("projectileFarSound",function()
		local snd = net.ReadString() or ""
		local sndfar = net.ReadString() or ""
		local pos = net.ReadVector() or Vector(0,0,0)
		local self = net.ReadEntity()
		local onWater = net.ReadBool()
		local watersnd = net.ReadString() or ""
		--print("huy")
		PlaySndDist(sndfar,snd,pos,onWater,watersnd)
	end)
end