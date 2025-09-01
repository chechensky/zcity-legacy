-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\sh_anim.lua"
-- Scripthooked by ???
AddCSLuaFile()
--
function SWEP:Initialize_Anim()
	self.Anim_RecoilCameraZoom = Vector(0, 0, 0)
	self.Anim_RecoilCameraZoomSet = Vector(0, 0, 0)
	self.Anim_RecoilLerp = 0
end

function SWEP:SetHold(value)
	self.holdtype = value
	self:SetWeaponHoldType(value)
end

local translatehuys = {
	[1] = 1,
	[2] = 1,
	[3] = 2,
	[4] = 2
}

hook.Add("Bones", "homigrad-weapons-bone", function(ply)
	local wep = ply:GetActiveWeapon()
	local func = wep.Animation
	if func then func(wep, ply) end
end)

local vecZero = Vector(0, 0, 0)
local vecZero2 = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
local CurTime = CurTime
function SWEP:Animation()
	local owner = self:GetOwner()

	if owner:InVehicle() then
		--self:AnimHold()
		self:SetHoldType(self.HoldType == "revolver" and "pistol" or "smg")
		--return
	end

	if (not IsValid(owner)) or (owner:GetActiveWeapon() ~= self) then return end
	if owner.suiciding then
		self:SuicideAnim()
		return
	end

	self:DeployAnim()
	self:HolsterAnim()
	if self.holster or self.deploy then self:AnimSprint() end
	--owner:SetFlexWeight(7,self:IsZoom() and 1 or 0)
	--self:SetHold(self.HoldType)
	if not false then --owner:IsSprinting() then
		self:AnimApply_ShootRecoil(self:LastShootTime())
		self:AnimApply_ShootRecoil(self.LastPrimaryDryFire, 50)
		if not owner:InVehicle() then self:CloseAnim() end
		if owner:EyeAngles()[1] < -53 then self:AnimLookUp() end
		if owner:EyeAngles()[1] > 46 then self:AnimLookDown() end
		self:AnimHold()
		if self:IsZoom() then self:AnimZoom() end
	end

	if self:IsSprinting() and not self.reload then self:AnimSprint() end
	self:AnimationPost()
end

function SWEP:AnimationPost()
end

--local hg.bone = hg.bone
local bone, name
function SWEP:BoneSetAdd(layerID, lookup_name, vec, ang)
	hg.bone.SetAdd(self:GetOwner(), translatehuys[layerID], lookup_name, vec, ang)
end

function SWEP:BoneAdd(layerID, lookup_name, vec, ang)
	hg.bone.Add(self:GetOwner(), translatehuys[layerID], lookup_name, vec, ang)
end

function SWEP:BoneApply(layerID, lookup_name, lerp)
	hg.bone.Apply(self:GetOwner(), translatehuys[layerID], lookup_name, lerp)
end

function SWEP:BoneGet(lookup_name)
	return hg.bone.Get(self:GetOwner(), lookup_name)
end

--но это бред
local math_cos, math_sin = math.cos, math.sin
function SWEP:AnimHoldPost()
end

if CLIENT then
	local function changePosture()
		RunConsoleCommand("hg_change_posture", -1)
	end

	local function resetPosture()
		RunConsoleCommand("hg_change_posture", 0)
	end

	hook.Add("radialOptions", "hg-change-posture", function()
		local wep = LocalPlayer():GetActiveWeapon()
		local organism = LocalPlayer().organism or {}

		if wep and hg.weapons[wep] and not organism.Otrub then
			local tbl = {changePosture, "Change Posture"}
			hg.radialOptions[#hg.radialOptions + 1] = tbl
			local tbl = {resetPosture, "Reset Posture"}
			hg.radialOptions[#hg.radialOptions + 1] = tbl
		end
	end)

	local printed
	concommand.Add("hg_change_posture", function(ply, cmd, args)
		if not args[1] and not printed then print([[Change your gun posture:
0 - regular hold
1 - hipfire
2 - left clavicle pose
3 - high ready
4 - low ready
5 - point shooting
6 - shooting from cover
]]) printed = true end
		local pos = math.Round(args[1] or -1)
		net.Start("change_posture")
		net.WriteEntity(ply)
		net.WriteInt(pos, 8)
		net.SendToServer()
	end)

	net.Receive("change_posture", function()
		local ply = net.ReadEntity()
		local pos = net.ReadInt(8)
		ply.posture = ply.posture or 0
		ply.posture = (ply.posture + 1) >= 7 and 0 or ply.posture + 1
		if pos ~= -1 then ply.posture = pos end
	end)
else
	util.AddNetworkString("change_posture")
	net.Receive("change_posture", function()
		local ply = net.ReadEntity()
		local pos = net.ReadInt(8)
		ply.posture = ply.posture or 0
		ply.posture = (ply.posture + 1) >= 7 and 0 or ply.posture + 1
		if pos ~= -1 then ply.posture = pos end
		net.Start("change_posture")
		net.WriteEntity(ply)
		net.WriteInt(pos, 8)
		net.Broadcast()
	end)
end

local angHold1 = Angle(-10, -5, 0)
local angHold2 = Angle(-10, 5, 0)
SWEP.handsAng = Angle(0, 0, 0)
local plyAng, handAng, handPos, addAng, _ = Angle(0, 0, 0), Angle(0, 0, 0), vecZero, Angle(0, 0, 0), vecZero
--function SWEP:DrawHUDAdd()
--cam.Start3D()
--render.DrawLine(handPos,handPos + (handAng - addAng):Forward() * 10,color_white)
--cam.End3D()
--end
function SWEP:SuicideAnim()
	if self.HoldType == "ar2" or self.HoldType == "smg" then
		self:SetHold("normal")
		local crouching = self:KeyDown(IN_DUCK)
		self:BoneSetAdd(1, "r_forearm", vecZero, (crouching and Angle(-25, 90, 25)) or Angle(-5, -35, -15))
		self:BoneSetAdd(1, "r_upperarm", vecZero, (crouching and Angle(0, -20, 0)) or Angle(0, -15, 0))
		self:BoneSetAdd(1, "r_hand", vecZero, (crouching and Angle(-30, -50, -80)) or Angle(0, -20, -12))
		self:BoneSetAdd(1, "l_forearm", vecZero, (crouching and Angle(45, 15, -25)) or Angle(0, -100, 15))
		self:BoneSetAdd(1, "l_upperarm", vecZero, (crouching and Angle(-10, -60, 0)) or Angle(-15, -5, -10))
		self:BoneSetAdd(1, "l_hand", Vector(1, 1, 0), (crouching and Angle(0, -50, 0)) or Angle(-15, -15, -15))
	else
		self:SetHold("normal")
		local crouching = self:KeyDown(IN_DUCK)
		self:BoneSetAdd(1, "r_forearm", vecZero, Angle(0, crouching and -25 or -120, 0))
		self:BoneSetAdd(1, "r_upperarm", vecZero, Angle(10, 0, 0))
		self:BoneSetAdd(1, "r_hand", vecZero, Angle(crouching and 40 or 40, crouching and 0 or -30, crouching and 15 or 30))
	end
end

--[[
if CLIENT then
	local function callbackBones(ent,bones)
		for i = 1,bones do
			if string.find(ent:GetBoneName(i),"ValveBiped.Bip01_L") then
				local bon = ent:LookupBone("ValveBiped.Bip01_L_Hand")
				local m = ent:GetBoneMatrix(bon)
				m:SetTranslation(m:GetTranslation() + m:GetAngles():Forward())
				ent:SetBoneMatrix(bon,m)
			end
		end
	end
	local ent = Entity(1)
	ent:AddCallback( "BuildBonePositions", callbackBones)
	--потом...
end
--]]

local ang1 = Angle(-20, 20, 0)
local ang2 = Angle(5, 5,0)

local ang3 = Angle(-10, -20, 0)
local ang4 = Angle(-20, 20, 0)

local ang5 = Angle(-0, 20, 30)
local ang6 = Angle(-20, 10, 0)

local vec1 = Vector(0,1,1)
local ang7 = Angle(35, -25,-45)
local ang8 = Angle(45, 5, 0)
local ang9 = Angle(25, 15, 0)
local ang10 = Angle(-5, 10, 0)
local ang11 = Angle(85, -15,0)
local ang12 = Angle(15, -15, 15)
local ang13 = Angle(0, 0, -40)
local ang14 = Angle(25, 15, 0)
local ang15 = Angle(0, -15, 5)

--mmm optimization

local funcNil = function() end

hg.postureFunctions = {
	[1] = function(self,ply)
		if self.holdtype == "revolver" then ply.posture = ply.posture + 1 end
		self:BoneSetAdd(1, "r_upperarm", vecZero, ang1)
		self:BoneSetAdd(1, "r_forearm", vecZero, ang2)
	end,
	[2] = function(self,ply)
		if self.holdtype == "revolver" then ply.posture = ply.posture + 1 end
		self:BoneSetAdd(1, "r_upperarm", vecZero, ang3)
		self:BoneSetAdd(1, "r_forearm", vecZero, ang4)
	end,
	[3] = function(self,ply)
		self:BoneSetAdd(1, "r_upperarm", vecZero,ang5)
		self:BoneSetAdd(1, "r_forearm", vecZero, ang6)
		if self.holdtype == "revolver" then self:BoneSetAdd(1, "r_forearm", vecZero, Angle(-10, -40, 0)) end
	end,
	[6] = function(self,ply)
		if self.holdtype == "revolver" then 
			self:BoneSetAdd(1, "r_upperarm", vecZero, ang7)
			self:BoneSetAdd(1, "r_forearm", vecZero, ang8) 
			self:BoneSetAdd(1, "head", vecZero, ang9)
			self:BoneSetAdd(1, "spine1", vecZero, ang10)
		else
			self:BoneSetAdd(1, "r_upperarm", vec1, ang11)
			self:BoneSetAdd(1, "r_forearm", vecZero, ang12)
			self:BoneSetAdd(1, "l_forearm", vecZero, ang13)
			self:BoneSetAdd(2, "head", vecZero, ang14)
			self:BoneSetAdd(2, "spine1", vecZero, ang15)
		end
	end,
}

function SWEP:AnimHold()
	local _
	local ply = self:GetOwner()
	if not self.attachments then return end
	self:SetHold(self.attachments.grip and not table.IsEmpty(self.attachments.grip) and hg.attachments.grip[self.attachments.grip[1]].holdtype or self.HoldType)
	if self.HoldType == "ar2" then
		self:BoneSetAdd(1, "r_upperarm", vecZero, angHold1, 0.1)
		self:BoneSetAdd(1, "r_hand", vecZero, angHold2, 0.1)
	end

	local bon = ply:LookupBone("ValveBiped.Bip01_R_Hand")
	if not bon then return end
	local hand = ply:GetBoneMatrix(bon)
	if not hand then return end
	handAng = hand:GetAngles()
	handPos = hand:GetTranslation()
	local gun = self:GetWeaponEntity()
	if not IsValid(gun) then return end
	plyAng = self:IsLocal() and gun:GetAngles() or gun:GetAngles() --(ply:GetEyeTrace().HitPos - ply:EyePos()):Angle()
	local _,plyAng = LocalToWorld(vecZero,(self.handsAng2 or angZero),vecZero,plyAng)
	plyAng:Normalize()
	plyAng[3] = plyAng[3] + 180
	local c = ply:GetManipulateBoneAngles(bon)
	c:Normalize()
	plyAng:RotateAroundAxis(plyAng:Up(), self.WorldAng[2])
	_, addAng = WorldToLocal(vecZero, plyAng, vecZero, handAng)
	addAng:Add(c)
	addAng[2] = addAng[2] - 6
	addAng[1] = addAng[1]
	addAng:Add(self.handsAng)
	addAng:Normalize()

	self:BoneSetAdd(4, "r_hand", vecZero, addAng)
	
	ply.posture = ply.posture or 0
	if not ply:InVehicle() then
		local height = (1 - (ply:EyePos() - ply:GetPos())[3] / 64) * 2
		local crouchingPistol = (self:KeyDown(IN_DUCK) or height < 1) and self.holdtype == "revolver"
		local ispistol = self.holdtype == "revolver"
		self:BoneSetAdd(3, "r_forearm", vecZero, Angle(0, 30, 0) * height * (ispistol and 1 or 0.25))
		self:BoneSetAdd(3, "r_upperarm", vecZero, Angle(20, -20, 0) * height * (ispistol and 1 or 0.25))
		local walking = (ply:GetVelocity():Length() > 20) and ply:OnGround()
		local walkingMul = (ply:GetVelocity():Length() - 20) / 200
		self:BoneSetAdd(1, "r_forearm", vecZero, walking and Angle(0, 10, 0) * walkingMul / (crouchingPistol and 4 or 1) * (ThatPlyIsFemale(ply) and 1 or (ispistol and 6 or 1)) or Angle(0, 0, 0))
		self:BoneSetAdd(1, "r_upperarm", vecZero, walking and Angle(10, -10, 0) * walkingMul / (crouchingPistol and 4 or 1) * (ThatPlyIsFemale(ply) and 1 or (ispistol and 6 or 1)) or Angle(0, 0, 0))
	end
	
	local func = hg.postureFunctions[ply.posture] or funcNil
	func(self,ply)

	if self.bipodPlacement then
		self:SetHold("slam")
		--local bon = ply:LookupBone("ValveBiped.Bip01_R_UpperArm")
		--local matrix = ply:GetBoneMatrix(bon)
		--local ang = (matrix:GetTranslation() - self.bipodPlacement):Angle()
		--self:BoneSetAdd(1,"r_upperarm",vecZero,-ang)--Angle(45,-90,0))
	end

	if (self.holdtype == "smg" or self.holdtype == "ar2") and not ThatPlyIsFemale(ply) then
		self:BoneSetAdd(1, "r_upperarm", vecZero, Angle(-0, -5, 10))
	end

	if self.attachments.grip and not table.IsEmpty(self.attachments.grip) and hg.attachments.grip[self.attachments.grip[1]].holdtype and hg.attachments.grip[self.attachments.grip[1]].holdtype == "smg" then
		self:BoneSetAdd(1, "r_hand", vecZero, Angle(-4, 4, 0))
	end

	--[[if CLIENT then
		ply:SetIK(false)
		ply:SetModel(ply:GetModel())

		local bon = ply:LookupBone("ValveBiped.Bip01_L_Hand")
		if not bon then return end
		--local m = ply:GetBoneMatrix(bon)
		--m:SetTranslation(handPos)
		--ply:SetBoneMatrix(bon,m)

		ply:SetupBones()
	end--]]

	self:AnimHoldPost()
	--[[
	
	local bone = ply:GetBoneMatrix(ply:LookupBone("ValveBiped.Bip01_L_ForeArm"))
	local bone2 = ply:GetBoneMatrix(ply:LookupBone("ValveBiped.Bip01_R_Hand"))

	if CLIENT then
		ply:SetIK(false)
	end

	local pos,ang = WorldToLocal(bone:GetTranslation() + bone:GetAngles():Forward() * 3 + bone:GetAngles():Up() * 3,Angle(0,0,0),bone:GetTranslation(),bone:GetAngles())
	self:BoneSetAdd(1,"l_hand",pos,Angle(0,0,0))

	--homemade ik maybe???
	--https://en.m.wikipedia.org/wiki/Inverse_kinematics
	--useful

	]]
end

local vecZoom1 = Vector(1, -1, 0)
local angZoom1 = Angle(0, 0, 0)
function SWEP:AnimZoom()
	local owner = self:GetOwner()
	--self:SetHold(self.ZoomHold or self.HoldType)
	local att = owner:LookupAttachment("eyes")
	if not att then return end
	att = owner:GetAttachment(att)
	self:BoneSetAdd(1, "r_clavicle", vecZoom1, angZero)
	angZoom1[1] = (self:GetWeaponEntity():GetPos() - att.Pos):GetNormalized():Dot(owner:EyeAngles():Right())
	angZoom1[1] = -angZoom1[1] * 100
	angZoom1[1] = math.Clamp(angZoom1[1],-20,20)
	self:BoneSetAdd(1, "head", vecZero, angZoom1)
end

local angSprint1 = Angle(-30, 20, 0)
local angSprint2 = Angle(-10, -10, -30)
function SWEP:AnimSprint()
	if self.HoldType == "revolver" then self:BoneSetAdd(1, "r_upperarm", vecZero, angSprint1) end
	--self:BoneSetAdd(1,"r_hand",vecZero,angSprint2,0.1)
end

local angLookUp1 = Angle(0, 0, 0)
function SWEP:AnimLookUp()
	local owner = self:GetOwner()
	local eyeAng = owner:EyeAngles()
	if self:IsLocal() then
		angLookUp1[1] = -eyeAng[1] - 53
		--self:BoneSetAdd(4,"r_hand",vecZero,angLookUp1)
	end
end

function SWEP:AnimLookDown()
	local owner = self:GetOwner()
	local eyeAng = owner:EyeAngles()
	if self:IsLocal() then
		if self.HoldType == "ar2" or self.HoldType == "smg" then
			--self:BoneSetAdd(1,"r_hand",vecZero,Angle(-eyeAng[1]+46,0,0))
		end
	end
end

local math_max, math_Clamp = math.max, math.Clamp
SWEP.AnimShootMul = 1
SWEP.AnimShootHandMul = 1
function SWEP:GetAnimPos_Shoot(time, timeSpan)
	local timeSpan = timeSpan or 0.2
	return timeSpan - math_Clamp(CurTime() - time, 0, timeSpan)
end

function SWEP:AnimApply_ShootRecoil(time, div)
	local owner = self:GetOwner()
	local animpos = self:GetAnimPos_Shoot(time)
	if animpos > 0 then
		animpos = animpos * ((self:IsZoom() and self.SpreadMulZoom or self.SpreadMul) + math_max(self.Primary.Force / 110 - 1, 0)) * (owner:Crouching() and self.CrouchMul or 1) * 0.75
		animpos = animpos * self.AnimShootMul
		animpos = animpos / (div or 1)

		if self.holdtype != "revolver" then
			self:BoneSetAdd(4, "r_upperarm", Vector(4 * animpos, -7 * animpos, 7 * animpos) / 4, angZero)
			self:BoneSetAdd(4, "spine", vecZero, Angle(0, 0, -5 * animpos))
		else
			self:BoneSetAdd(4, "r_upperarm", Vector(-2 * animpos, 0, 7 * animpos) / 4, angZero)
		end
	end
end

local hullVec = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
local vecAsd2 = Vector(-45, 4, 1)
SWEP.lengthSub = 0
function SWEP:CloseAnim(dontapply)
	local owner = self:GetOwner()
	local att = self:GetMuzzleAtt(nil, true)
	if not att then return end
	local pos = att.Pos
	local ang = owner:EyeAngles() --att.Ang
	if not self.attachments then return end
	local lengthAdd = self.attachments.barrel[1] and string.find(self.attachments.barrel[1], "supressor") and 10 or 0
	local dis, point = util.DistanceToLine(att.Pos - ang:Forward() * 30, ang:Forward() * 30, owner:EyePos())
	local tr = util.TraceHull({
		start = att.Pos + ang:Forward() * -30,
		endpos = att.Pos + ang:Forward() * (10 + lengthAdd),
		filter = {self, self:GetOwner()},
		mins = -hullVec,
		maxs = hullVec,
		mask = MASK_SHOT
	})
	--[[if CLIENT then
		cam.Start3D()
			render.DrawLine(point,tr.HitPos)
		cam.End3D()
	end--]]
	--local ang2 = tr.Normal:Angle()
	--ang2:RotateAroundAxis(tr.HitNormal,180)
	local frac = tr.Fraction
	local dist = math.min((1 - frac) * 5, 1)
	if not dontapply then
		if self.holdtype != "revolver" then
			self:BoneSetAdd(1, "r_upperarm", vecZero, Angle(0, dist * 90, 0))
			self:BoneSetAdd(1, "r_forearm", vecZero, Angle(-00 * dist, dist * -40, 0))
			--self:BoneSetAdd(1,"r_hand",vecZero,Angle(dist * 50,dist * -20,dist * -0))
		else
			self:BoneSetAdd(1, "r_upperarm", vecZero, Angle(0, 30 * dist, dist > 0.5 and (dist - 0.5) * -60 or 0))
			self:BoneSetAdd(1, "r_forearm", vecZero, Angle(0, -80 * dist, -10 * dist))
		end
	end
	return dist
end

function SWEP:AnimApply_RecoilCameraZoom()
	local vecrand = VectorRand(-0.1, 0.1)
	vecrand[3] = 0
	--vecrand[1] = vecrand[1] - 0.3
	self.Anim_RecoilCameraZoomSet = Vector(0, 0, 3) + vecrand
	self.Anim_RecoilCameraZoom = LerpVector(0.2, self.Anim_RecoilCameraZoom, self.Anim_RecoilCameraZoomSet)
end

function SWEP:DeployAnim()
	local animpos = self.deploy
	if true then return end
	if animpos then
		animpos = math.min((self.deploy - CurTime()) / (self.CooldownDeploy / self.Ergonomics), 1)
		--self:SetHold("pistol")
		if self.HoldType == "ar2" then
			self:BoneSetAdd(3, "r_upperarm", vecZero, Angle(30 * animpos, -60 * animpos, 30 * animpos))
			self:BoneSetAdd(3, "r_forearm", vecZero, Angle(0, -90 * animpos, -10 * animpos))
			self:BoneSetAdd(3, "r_hand", vecZero, Angle(70 * animpos, 0, 30 * animpos))
		else
			self:BoneSetAdd(3, "r_upperarm", vecZero, Angle(-10 * animpos, 40 * animpos, 0))
			self:BoneSetAdd(3, "r_forearm", vecZero, Angle(-100 * animpos, 0, -60 * animpos))
			self:BoneSetAdd(3, "r_hand", vecZero, Angle(-30 * animpos, -50 * animpos, 0))
		end
	end
end

function SWEP:HolsterAnim()
	local animpos = self.holster
	if true then return end
	if animpos then
		animpos = 1 - (self.holster - CurTime()) / (self.CooldownHolster / self.Ergonomics)
		--self:SetHold("pistol")
		if self.HoldType == "ar2" then
			self:BoneSetAdd(3, "r_upperarm", vecZero, Angle(30 * animpos, -60 * animpos, 30 * animpos))
			self:BoneSetAdd(3, "r_forearm", vecZero, Angle(0, -90 * animpos, -10 * animpos))
			self:BoneSetAdd(3, "r_hand", vecZero, Angle(70 * animpos, 0, 30 * animpos))
		else
			self:BoneSetAdd(3, "r_upperarm", vecZero, Angle(-10 * animpos, 40 * animpos, 0))
			self:BoneSetAdd(3, "r_forearm", vecZero, Angle(-100 * animpos, 0, -60 * animpos))
			self:BoneSetAdd(3, "r_hand", vecZero, Angle(-30 * animpos, -50 * animpos, 0))
		end
	end
end

local function isMoving(ply)
	return ply:GetVelocity():Length() > 30 and ply:OnGround()
end

local function isCrouching(ply)
	return (ply:KeyDown(IN_DUCK) or ply:Crouching()) and ply:OnGround()
end

local function keyDown(owner, key)
	owner.keydown = owner.keydown or {}
	local localKey
	if CLIENT then
		if owner == LocalPlayer() then
			localKey = owner:KeyDown(key)
		else
			localKey = owner.keydown[key]
		end
	end
	return SERVER and owner:KeyDown(key) or CLIENT and localKey
end

hook.Add("Bones", "homigrad-lean-bone", function(ply)
	if IsValid(ply.FakeRagdoll) then
		ply.lean = 0
		return
	end

	if not keyDown(ply, IN_ALT1) and not keyDown(ply, IN_ALT2) or (keyDown(ply, IN_ALT1) and keyDown(ply, IN_ALT2)) then ply.lean = math.Round(LerpFT(0.4, ply.lean or 0, 0), 3) end
	if keyDown(ply, IN_ALT1) and not keyDown(ply, IN_ALT2) then
		ply.lean = math.Round(LerpFT(0.4, ply.lean or 0, -1), 3)
		local self = ply:GetActiveWeapon()
		if self.holdtype == "ar2" or self.holdtype == "smg" then
			hg.bone.SetAdd(ply, 1, "r_upperarm", vecZero, Angle(0, -10, -20))
			hg.bone.SetAdd(ply, 1, "spine1", vecZero, Angle(isCrouching(ply) and -45 or -33, -30, isCrouching(ply) and 0 or -10))
			--elseif self.HoldType == "smg" then
			--hg.bone.SetAdd(ply,1,"spine1",vecZero,Angle(isCrouching(ply) and -50 or -32,-30,isCrouching(ply) and -3 or -10))
		else
			hg.bone.SetAdd(ply, 1, "spine1", vecZero, Angle(isCrouching(ply) and -35 or -30, 10, isCrouching(ply) and -2 or -5))
		end
	end

	if keyDown(ply, IN_ALT2) and not keyDown(ply, IN_ALT1) then
		ply.lean = math.Round(LerpFT(0.4, ply.lean or 0, 1), 3)
		local self = ply:GetActiveWeapon()
		if self.holdtype == "ar2" or self.holdtype == "smg" then
			hg.bone.SetAdd(ply, 1, "r_upperarm", vecZero, Angle(10, 0, 10))
			hg.bone.SetAdd(ply, 1, "spine1", vecZero, Angle(isCrouching(ply) and 35 or 20, 25, isCrouching(ply) and 18 or 18))
			hg.bone.SetAdd(ply, 1, "r_forearm", vecZero, Angle(-10, -10, -10))
			hg.bone.SetAdd(ply, 1, "head", vecZero, Angle(30, 0, 0))
			--elseif self.HoldType == "smg" then
			--hg.bone.SetAdd(ply,1,"spine1",vecZero,Angle(isCrouching(ply) and 32 or 20,30,22))
			--hg.bone.SetAdd(ply,1,"head",vecZero,Angle(30,0,0))
		else
			hg.bone.SetAdd(ply, 1, "spine1", vecZero, Angle(35, -10, isCrouching(ply) and -5 or 0))
		end
	end
end)

function SWEP:InFreemove()
	--
end

function SWEP:ResetFreemove()
	--
end
--[[
	"head",
	"spine",
	"spine1",
	"spine2",
	"spine4",
	"pelvis",

	"r_clavicle",
	"r_upperarm",
	"r_forearm",
	"r_hand",

	"l_clavicle",
	"l_upperarm",
	"l_forearm",
	"l_hand",

	"r_thigh",
	"r_calf",
	"r_foot",
	"r_toe0",

	"l_thigh",
	"l_calf",
	"l_foot",
	"l_toe0"
]]
