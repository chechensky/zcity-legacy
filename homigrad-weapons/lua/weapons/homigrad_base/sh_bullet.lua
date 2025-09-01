-- Path scripthooked:lua\\weapons\\homigrad_base\\sh_bullet.lua"
-- Scripthooked by ???
AddCSLuaFile()
--
local surface_hardness = {
	[MAT_METAL] = 0.9,
	[MAT_COMPUTER] = 0.9,
	[MAT_VENT] = 0.9,
	[MAT_GRATE] = 0.9,
	[MAT_FLESH] = 0.5,
	[MAT_ALIENFLESH] = 0.3,
	[MAT_SAND] = 0.1,
	[MAT_DIRT] = 0.9,
	[74] = 0.1,
	[85] = 0.2,
	[MAT_WOOD] = 0.5,
	[MAT_FOLIAGE] = 0.5,
	[MAT_CONCRETE] = 0.9,
	[MAT_TILE] = 0.8,
	[MAT_SLOSH] = 0.05,
	[MAT_PLASTIC] = 0.3,
	[MAT_GLASS] = 0.6,
}

local player_GetAll = player.GetAll
local function BulletEffects(tr, self)
end

if SERVER then
	util.AddNetworkString("bullet_fell")
	util.AddNetworkString("blood particle")
	BulletEffects = function(tr, self)
		net.Start("bullet_fell")
		net.WriteTable(tr)
		net.WriteEntity(self)
		net.Broadcast()
	end
end

local function BloodTr(att, tr, dmgInfo)
	--util.Decal("Impact.Flesh",tr.HitPos + tr.HitNormal,tr.HitPos - tr.HitNormal)
	if SERVER then
		net.Start("blood particle")
		net.WriteVector(tr.StartPos)
		net.WriteVector((tr.HitPos - tr.StartPos):GetNormalized() * dmgInfo:GetDamage() * 2 + VectorRand(-50, 50))
		net.Broadcast()
	end
end
local bulletHit
local function callbackBullet(self, tr, ply)
	if not self.penetrated then return end
	if self.penetrated > 5 then return end
	self.penetrated = self.penetrated + 1
	if tr.Entity.Organism then return end

	local dir, hitNormal, hitPos = tr.Normal, tr.HitNormal, tr.HitPos
	if SERVER then BulletEffects(tr, self) end
	local hardness = surface_hardness[tr.MatType] or 0.5
	local ApproachAngle = -math.deg(math.asin(hitNormal:DotProduct(dir)))
	local MaxRicAngle = 60 * hardness
	-- all the way through

	if ApproachAngle > MaxRicAngle * 1.2 then--or tr.Entity:IsVehicle() then
		local Pen = (self.PenetrationCopy or 5) * 3 or self.Primary.Damage
		local MaxDist, SearchPos, SearchDist, Penetrated = Pen / hardness * 0.15 * 5, hitPos, 5, false
		while not Penetrated and SearchDist < MaxDist do
			SearchPos = hitPos + dir * SearchDist
			local PeneTrace = util.QuickTrace(SearchPos, -dir * SearchDist)
			if not PeneTrace.StartSolid and PeneTrace.Hit then
				Penetrated = true
				self.PenetrationCopy = self.PenetrationCopy - Pen * SearchDist / MaxDist / 3
			else
				SearchDist = SearchDist + 5
			end
		end
		
		if Penetrated then--or tr.Entity:IsVehicle() then
			self:FireBullets({
				Attacker = self:GetOwner(),
				Damage = 1,
				Force = 0,
				Num = 1,
				Tracer = 0,
				TracerName = "nil",
				Dir = -dir,
				Spread = Vector(0, 0, 0),
				Src = SearchPos + dir,
				IgnoreEntity = self:GetOwner(),
				--Callback = bulletHit
			})

			self:FireBullets({
				Attacker = self:GetOwner(),
				Damage = self.Primary.Damage * 0.65,
				Force = self.Primary.Force / 3,
				Num = 1,
				Tracer = 0,
				TracerName = "nil",
				Dir = dir,
				Spread = Vector(0, 0, 0),
				Src = SearchPos + dir,
				Callback = bulletHit,
				IgnoreEntity = self:GetOwner(),
			})
			local tr = util.TraceLine( {
				start = SearchPos + dir,
				endpos = SearchPos + dir + dir * 10000,
				mask = MASK_SHOT
			} )
			timer.Simple(0,function()
				local effectdata1 = EffectData()
				effectdata1:SetOrigin(tr.HitPos)
				effectdata1:SetStart(hitPos + hitNormal)
				effectdata1:SetEntity(self)
				effectdata1:SetMagnitude(2)
				util.Effect("eff_tracer", effectdata1)
			end)
		end
	elseif ApproachAngle < MaxRicAngle * .2 and math.random(10) > 1 then
		-- ping whiiiizzzz
		sound.Play("snd_jack_hmcd_ricochet_" .. math.random(1, 2) .. ".wav", hitPos, 75, math.random(90, 100))
		local NewVec = dir:Angle()
		NewVec:RotateAroundAxis(hitNormal, 180)
		NewVec = NewVec:Forward()
		self:FireBullets({
			Attacker = self:GetOwner(),
			Damage = (self.Primary.Damage or 1) * .85,
			Force = self.Primary.Force / 3,
			Num = 1,
			Tracer = 0,
			TracerName = "nil",
			Dir = -NewVec,
			Spread = Vector(0, 0, 0),
			Src = hitPos + hitNormal,
			Callback = bulletHit,
			IgnoreEntity = self:GetOwner(),
		})
		local tr = util.TraceLine( {
			start = hitPos + hitNormal,
			endpos = hitPos + hitNormal + -NewVec * 10000,
			mask = MASK_SHOT
		} )
		timer.Simple(.1,function()
			local effectdata1 = EffectData()
			effectdata1:SetOrigin(tr.HitPos)
			effectdata1:SetStart(hitPos + hitNormal)
			effectdata1:SetEntity(self)
			effectdata1:SetMagnitude(2)
			util.Effect("eff_tracer", effectdata1)
		end)
	elseif math.random(2) == 1 then
		local effectdata1 = EffectData()
		effectdata1:SetOrigin(hitPos)
		effectdata1:SetNormal(tr.Normal)
		effectdata1:SetStart(tr.HitNormal)
		effectdata1:SetEntity(self)
		effectdata1:SetFlags(2)
		effectdata1:SetMagnitude(4)
		util.Effect("eff_bulletdrop", effectdata1)
	end
end

function SWEP:CallbackBullet(self, tr, ply)
	return callbackBullet(self, tr, ply)
end

--не нахуй
bulletHit = function(ply, tr, dmgInfo)
	--if tr.HitSky then return end
	local inflictor = ply:IsPlayer() and ply:GetActiveWeapon() or dmgInfo:GetInflictor()

	if CLIENT then
		local effectdata1 = EffectData()
		effectdata1:SetOrigin(tr.HitPos)
		effectdata1:SetStart(tr.StartPos)
		effectdata1:SetEntity(inflictor)
		effectdata1:SetMagnitude(1)
		util.Effect("eff_tracer", effectdata1)
		return
	end

	if tr.Entity:IsRagdoll() or tr.Entity:IsPlayer() then
		tr.Entity:RegRegisterXRayHit(dmgInfo)
	end

	if tr.MatType == MAT_FLESH then
		util.Decal("Impact.Flesh", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	end
		
	timer.Simple(0,function()
		callbackBullet(inflictor, tr, ply)
	end)
end

local bullet = {}
local empty = {}
local vecCone = Vector(0, 0, 0)
local cone, att, att2, owner, primary, ang
local math_Rand, math_random = math.Rand, math.random
local gun
function SWEP:GetWeaponEntity()
	--gun = self:GetNWEntity("fakeGun")
	return IsValid(self.worldModel) and self.worldModel or self
end

SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(0, 0, 0)
local gun
local vecZero = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
local attTbl = {
	Pos = vecZero,
	Ang = angZero
}

function SWEP:GetMuzzleAtt(ent, trueAtt, supressorAdd)
	gun = ent or self:GetWeaponEntity()
	if not IsValid(gun) then return attTbl end
	local att = gun:GetAttachment(gun:LookupAttachment("muzzle"))
	local att = att ~= nil and att or gun:GetAttachment(gun:LookupAttachment("muzzle_flash"))
	--local att = gun:GetAttachment(gun:LookupAttachment("muzzle"))
	--local att = att!=nil and att or gun:GetAttachment(gun:LookupAttachment("muzzle_flash"))
	local attPos = self.attPos
	local attAng = self.attAng
	
	if not att then
		local angHuy = gun:GetAngles()
		
		angHuy:RotateAroundAxis(angHuy:Forward(), 90)
		angHuy:Add(attAng)
		
		local posHuy = gun:GetPos()
		posHuy:Add(angHuy:Up() * attPos[1] + angHuy:Right() * attPos[2] + angHuy:Forward() * attPos[3])
		if supressorAdd and self:HasAttachment("barrel", "supressor") then posHuy:Add(angHuy:Forward() * 10) end
		attTbl.Pos = posHuy
		attTbl.Ang = angHuy
		return attTbl
	end

	if trueAtt then
		local pos, ang = att.Pos, att.Ang
		
		local pos, ang = LocalToWorld(attPos, attAng, pos, ang)
		
		att.Pos = pos
		att.Ang = ang
		--ang:Add(attAng)
		if supressorAdd and self:HasAttachment("barrel", "supressor") then pos:Add(ang:Forward() * 10) end
		--pos:Add(ang:Up() * attPos[1] + ang:Right() * attPos[2] + ang:Forward() * attPos[3])
	end
	
	return att
end

local tr = {}
local att
local util_TraceLine = util.TraceLine
function SWEP:GetHitPos()
	att = self:GetMuzzleAtt(nil, true)
	if not att then return end
	--local quicktr = util.QuickTrace(att.Pos,-att.Ang:Forward() * 60,self:GetOwner())
	--tr.start = quicktr.HitPos
	tr.start = att.Pos - att.Ang:Forward() * 60
	tr.endpos = att.Pos + att.Ang:Forward() * 8000
	tr.filter = {self:GetOwner(), self, self:GetNWEntity("fakeGun"), self:GetOwner().FakeRagdoll}
	return util_TraceLine(tr).HitPos
end

function SWEP:GetTrace()
	att = self:GetMuzzleAtt(nil, true)
	if not att then return end
	local owner = self:GetOwner()
	tr.start = att.Pos - att.Ang:Forward() * 60
	tr.endpos = att.Pos + att.Ang:Forward() * 8000
	tr.filter = {gun, not owner.suiciding and owner or nil}
	return util_TraceLine(tr)
end

SWEP.ShellEject = "EjectBrass_556"
SWEP.MuzzleEffectType = 1
local images_muzzle = {
	[2] = {"effects/muzzleflash1", "effects/muzzleflash2", "effects/muzzleflash3", "effects/muzzleflash4"},
	[3] = {"effects/gunshipmuzzle","effects/combinemuzzle2"}
}
local vecZero = Vector(0, 0, 0)
local image_distort = "sprites/heatwave"

function SWEP:FireBullet()
	local gun = self:GetWeaponEntity()
	local att = self:GetMuzzleAtt(gun, true)
	if not att then return end
	local pos, ang = att.Pos, att.Ang
	local owner = self:GetOwner()
	if not owner:IsPlayer() then return end
	local fakeGun = self:GetNWEntity("fakeGun")
	local dist,point = util.DistanceToLine(pos,pos-ang:Forward() * (IsValid(owner.FakeRagdoll) and 0 or (owner.suiciding and 0 or 50)),owner:EyePos())

	pos = point
	local primary = self.Primary
	owner:LagCompensation(true)
	local ammotype = hg.ammotypes[string.lower( string.Replace( self.Primary and self.Primary.Ammo or "nil"," ", "") )].BulletSetings

	local numbullet = ammotype.NumBullet or 1
	bullet.Num = 1--self.NumBullet
	bullet.Src = pos
	bullet.Dir = ang:Forward()
	bullet.Force = ammotype.Force or primary.Force
	bullet.Damage = ammotype.Damage or primary.Damage or 25
	bullet.Spread = ammotype.Spread or self.Primary.Spread or 0
	bullet.AmmoType = primary.Ammo
	bullet.Attacker = owner
	bullet.Callback = bulletHit
	bullet.Damage = bullet.Damage * (self.Supressor and 0.9 or 1)
	bullet.TracerName = self.Tracer or "nil"
	bullet.IgnoreEntity = IsValid(self:GetNWEntity("fakeGun")) and self:GetNWEntity("fakeGun") or not owner.suiciding and owner or nil


	--if IsValid(fakeGun) then fakeGun:SetOwner() end
	
	for i = 1,numbullet do
		self.penetrated = 0
		self.PenetrationCopy = ammotype.Penetration or (-(-self.Penetration))
		self.bullet = bullet
		gun:FireBullets(bullet)
	end
	
	--if IsValid(fakeGun) then fakeGun:SetOwner(owner.FakeRagdoll) end
	
	owner:LagCompensation(false)
	if CLIENT then
		local mul = self.MuzzleMul or 1
		mul = mul * (self.Supressor and 0.25 or 1)
		if mul > 0 then
			local pos = self:GetMuzzleAtt(nil,true).Pos
			local emitter = ParticleEmitter(pos)
			local particle = emitter:Add(image_distort, pos)
			if particle then
				particle:SetVelocity((ang:Forward() * 25) + 1.05 * owner:GetVelocity())
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(0.1, 0.2))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(math.Rand(7, 10))
				particle:SetEndSize(0)
				particle:SetRoll(math.Rand(0, 360))
				particle:SetRollDelta(math.Rand(-2, 2))
				particle:SetAirResistance(5)
				particle:SetGravity(Vector(0, 0, 40))
				particle:SetColor(255, 255, 255)
			end

			if not self.Supressor then 
				if self.MuzzleEffectType > 1 then
					local particle = emitter:Add(images_muzzle[self.MuzzleEffectType][math.random(#images_muzzle[self.MuzzleEffectType])], pos)

					if particle then
						particle:SetVelocity( 1.05 * owner:GetVelocity())
						particle:SetLifeTime(0)
						particle:SetDieTime(math.Rand(0.05 ,0.1))
						particle:SetStartAlpha(math.Rand(155, 255))
						particle:SetEndAlpha(0)
						particle:SetStartSize(math.Rand(5, 10))
						particle:SetEndSize(math.Rand(15, 20))
						particle:SetLighting(false)
						particle:SetColor(255, 255, 255)
					end
				else
					local effectdata = EffectData()
					effectdata:SetOrigin(att.Pos + (self.Supressor and (att.Ang:Forward() * 15) or vecZero))
					effectdata:SetAngles(ang)
					effectdata:SetScale(mul / 2) 
					effectdata:SetEntity(self)
					effectdata:SetFlags( self.ShootEffect or 1 )
			
					util.Effect(self.ShootEffect and "MuzzleFlash" or "MuzzleEffect", effectdata)
				end
			end

			local dlight = DynamicLight(gun:EntIndex())
			dlight.pos = att.Pos
			dlight.r = math_random(245, 255)
			dlight.g = math_random(245, 255)
			dlight.b = math_random(150, 200)
			dlight.brightness = math_Rand(7, 8)
			dlight.Decay = 1000
			dlight.Size = math_Rand(60, 75) * mul
			dlight.DieTime = CurTime() + 1 / 60
		end
	end
end

if CLIENT then
	net.Receive("reject shell",function()
		net.ReadEntity():RejectShell(net.ReadString())
	end)

	function SWEP:RejectShell(shell)
		if not shell then return end
		local gun = self:GetWeaponEntity()
		if not IsValid(gun) then return end
		local attmuzle = self:GetMuzzleAtt(gun, true)
		local att = gun:GetAttachment(gun:LookupAttachment("ejectbrass")) or gun:GetAttachment(gun:LookupAttachment("shell"))
		local pos, ang
		if not att then
			pos, ang = gun:GetPos(), gun:GetAngles()
		else
			pos, ang = att.Pos, att.Ang
		end

		if gun == self:GetNWEntity("fakeGun") then shell = shell ~= "ShotgunShellEject" and "ShellEject" or "ShotgunShellEject" end
		if self.EjectPos then pos = gun:GetPos() + ang:Right() * self.EjectPos.x + ang:Up() * self.EjectPos.z + ang:Forward() * self.EjectPos.y end
		if self.EjectAng then ang:Add(self.EjectAng) end

		local ammotype = hg.ammotypes[string.lower( string.Replace( self.Primary and self.Primary.Ammo or "nil"," ", "") )].BulletSetings

		if self.CustomSecShell then self:MakeShell(self.CustomSecShell, pos, attmuzle.Ang, ang:Forward() * 75) end
		if ammotype.Shell or self.CustomShell then self:MakeShell(ammotype.Shell or self.CustomShell, pos, attmuzle.Ang, ang:Forward() * 105) return end
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetFlags(25)
		util.Effect(shell, effectdata)
	end
else
	util.AddNetworkString("reject shell")
	function SWEP:RejectShell(shell)
		net.Start("reject shell")
		net.WriteEntity(self)
		net.WriteString(shell)
		net.Broadcast()
	end
end