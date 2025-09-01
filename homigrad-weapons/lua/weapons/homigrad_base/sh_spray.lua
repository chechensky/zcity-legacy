-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\sh_spray.lua"
-- Scripthooked by ???
AddCSLuaFile()
--
function SWEP:Initialize_Spray()
	self.EyeSpray = Angle(0, 0, 0)
	self.SprayI = 0
	self.dmgStack = 0
end

SWEP.SpreadMulZoom = 1.5
SWEP.SpreadMul = 2
SWEP.CrouchMul = 0.75
SWEP.Spray = {}
for i = 1, 150 do
	SWEP.Spray[i] = Angle(-0.02 - math.cos(i) * 0.01, math.cos(i * i) * 0.01, 0)
end

SWEP.SprayRand = {Angle(0, 0, 0), Angle(0, 0, 0)}
SWEP.addSprayMul = 1
local cos, sin, math_max, math_min = math.cos, math.sin, math.max, math.min
function SWEP:GetPrimaryMul()
	local owner = self:GetOwner()
	local mul = ((self:IsZoom() and self.SpreadMulZoom or self.SpreadMul) + math_max(self.Primary.Force / 110 - 1, 0)) * (owner.Crouching and owner:Crouching() and self.CrouchMul or 1) * (self.attachments and self.attachments.barrel and self.attachments.barrel[1] ~= "empty" and 0.75 or 1)
	if self:ApplyForce(mul) then mul = mul end
	mul = mul * (self.Supressor and 0.75 or 1)
	return mul
end

function SWEP:PrimarySpread()
	local owner = self:GetOwner()
	local mul = self:GetPrimaryMul()
	self.SprayI = self.SprayI + 1
	self.dmgStack = self.dmgStack + self.Primary.Damage
	local sprayI = self.SprayI

	if SERVER then
		if self.bipodPlacement then
			local bipod,dir,prop = self:CheckBipod()
		end
	end

	if CLIENT and owner == LocalPlayer() then
		local organism = LocalPlayer().organism or {}

		local force = self.Primary.Force / 100 * (self.Primary.Automatic and math.min(sprayI / 10,1) or 1) * self.addSprayMul
		mul = mul * ((organism.larm or 0) + (organism.rarm or 0) + 2) / 1
		mul = mul * (self.bipodPlacement and 0.25 or 1)

		local angRand = AngleRand(-0.05, 0.05)
		angRand[1] = -math.abs(angRand[1])
		angRand[3] = 0
		local spray

		if sprayI < 3 then
			spray = angRand
		else
			spray = self.Spray[sprayI] or Angle(0.01, 0)
		end
		
		spray = spray + AngleRand(self.SprayRand[1], self.SprayRand[2]) * self.addSprayMul
		
		local angrand2 = AngleRand(-force, force)
		local angrand3 = -(-angrand2)
		angrand3[3] = 0
		if not self.SprayRandOnly then
			angrand2[1] = -math.abs(angrand2[1])
			angrand2[3] = -angrand2[2] * 2 - spray[2] * 1
			ViewPunch(angrand2 * mul / (self.Primary.ClipSize / 2) * 10)-- ^ ((not self.Primary.Automatic and 0.5 or 1)))
			spray = spray + angRand * 2
			spray = spray * (self.attachments.grip and not table.IsEmpty(self.attachments.grip) and hg.attachments.grip[self.attachments.grip[1]].recoilReduction or 1)
		end

		self:GetOwner():SetEyeAngles(self:GetOwner():EyeAngles() + spray * 2 + angrand3 * (self.bipodPlacement and 0.1 or 1))

		self:ApplyEyeSprayVel(spray * mul * math.max(sprayI / self:GetMaxClip1(), 0.5))
		self:AnimApply_RecoilCameraZoom()
	end
end

function SWEP:ApplyForce(mul)
	local fakeGun = self:GetNWEntity("fakeGun")
	mul = mul * self.Primary.Damage / 60 * (self.NumBullet or 1)
	if IsValid(fakeGun) then
		if SERVER then
			local owner = self:GetOwner()
			local ent = hg.GetCurrentCharacter(owner)
			local fakeGunObj = fakeGun:GetPhysicsObject()

			if ent ~= owner then
				ent:GetPhysicsObjectNum(self.LHandPos and 1 or 6):ApplyForceOffset(owner:EyeAngles():Forward() * -50,fakeGunObj:GetPos())
			end

		end
		return true
	end
end

--if CLIENT then
local angZero = Angle(0, 0, 0)
function SWEP:ApplyEyeSprayVel(value)
	self.EyeSprayVel = self.EyeSprayVel + value * 0.2
	self:ApplyEyeSpray(self.EyeSprayVel)
end

function SWEP:Step_SprayVel()
	self.EyeSprayVel = self.EyeSprayVel or Angle(0, 0, 0)
	self.EyeSprayVel = self.EyeSprayVel - self.EyeSprayVel * 0.2--self.EyeSpray * 0.04
	self:ApplyEyeSpray(self.EyeSprayVel)
end

function SWEP:ApplyEyeSpray(value)
	if CLIENT and self:GetOwner() ~= LocalPlayer() then return end
	self.EyeSpray = self.EyeSpray + value * 0.2 * (FrameTime() / engine.TickInterval())
end

function SWEP:Step_Spray(time)
	if self.Primary.Next + 0.1 < time then self.SprayI = 0 end
	if self.Primary.Next + 1 < time then self.dmgStack = 0 end
	
	if SERVER then return end
	local eyeSpray = self.EyeSpray
	self:GetOwner():SetEyeAngles(self:GetOwner():EyeAngles() + eyeSpray)
	eyeSpray:Set(LerpAngleFT(0.05, eyeSpray, angZero))
end

--[[else
	function SWEP:ApplyEyeSpray(value) end
	function SWEP:ApplyEyeSprayVel(value) end
end--]]
SWEP.ZoomFOV = 20
function SWEP:AdjustMouseSensitivity()
	return self:IsZoom() and (math.min(self.ZoomFOV / 10, 0.5) or 0.5) or 1
end