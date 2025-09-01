-- "addons\\homigrad-weapons\\lua\\entities\\projectile_nonexplosive_base.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Type = "anim"
ENT.Author = "Sadsalat"
ENT.Category = "ZCity Other"
ENT.PrintName = "Projectile NoneExplosive Base"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.Model = ""
ENT.HitSound = "weapons/crossbow/hit1.wav"
ENT.FleshHit = "weapons/crossbow/bolt_skewer1.wav"

ENT.Damage = 200
ENT.Force = 0.2

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
			phys:SetMass(1)
			phys:Wake()
		end
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > .2 and data.Speed > 200 then
            local dir = data.HitPos - (data.HitPos + self:GetAngles():Forward() * -5)
            --print(dir:GetNormalized())
            local hitNormal = data.HitNormal
            local ApproachAngle = math.deg(math.asin(hitNormal:DotProduct(dir:GetNormalized())))
	        local MaxRicAngle = 10
            --print(ApproachAngle)

            if ApproachAngle < MaxRicAngle * 1 then 
                    --[[local effectpoint = self:GetPos()
                    timer.Simple(.1,function()
                        local effectdata = EffectData()
                        effectdata:SetOrigin( effectpoint )
                        effectdata:SetScale(1)
                        effectdata:SetMagnitude(2)
                        effectdata:SetRadius(0.1)
                        util.Effect( "Sparks", effectdata )
                    end)
                    local NewVec = dir:Angle()
                    NewVec:RotateAroundAxis(hitNormal, 180)
                    NewVec = NewVec:Forward()
                    self:SetVelocity(self:GetAngles():Forward() * -1000)]]--

                return 
            end

			if not self.Exploded then
                local effectpoint = self:GetPos()
                timer.Simple(.1,function()
                    local effectdata = EffectData()
                    effectdata:SetOrigin( effectpoint )
                    effectdata:SetScale(0.1)
                    effectdata:SetMagnitude(2)
                    effectdata:SetRadius(0.1)
                    util.Effect( "Sparks", effectdata )
                end)
                self:DamagePly(data.HitEntity,data.HitObject:GetMaterial(),data.HitPos) 
                return 
            end
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

    local vecSmoke = Vector(255,255,255)
    function ENT:Think()
		AeroDrag(self, self:GetAngles():Forward(), .6)
        self:NextThink(CurTime() + 0.1)
    end

	function ENT:Use(ply)
	end

	function ENT:OnTakeDamage(dmginfo)
	end
    local fleshmats = {
        ["flesh"] = true,
        ["player"] = true
    }
	function ENT:DamagePly(ent,mat,hitpos)
		if self.Exploded then return end
		self.Exploded = true
		local SelfPos, Owner = self:LocalToWorld(self:OBBCenter()), self
        local DmgInfo = DamageInfo()
        DmgInfo:SetDamage(self.Damage)
        DmgInfo:SetDamageForce(self:GetAngles():Forward() * self.Force)
        DmgInfo:SetDamagePosition(hitpos)
        DmgInfo:SetDamageType(DMG_BULLET)
        DmgInfo:SetInflictor(self)
        DmgInfo:SetAttacker(self)
        ent:TakeDamageInfo(DmgInfo)
        --print(mat)
        self:EmitSound( fleshmats[mat] and self.FleshHit or self.HitSound)
        util.Decal( fleshmats[mat] and "Impact.Flesh" or "Impact.Concrete", SelfPos + self:GetAngles():Forward() * -5, SelfPos + self:GetAngles():Forward() * 500, self )
        self:Remove()
	end

elseif CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end