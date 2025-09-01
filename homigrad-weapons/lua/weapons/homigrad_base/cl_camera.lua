-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\cl_camera.lua"
-- Scripthooked by ???
--
local vecZero, angZero = Vector(0, 0, 0), Angle(0, 0, 0)
local vecZero2 = Vector(0, 0, 0)
local eyeAngL = EyeAngles()
local angZoom = Angle(0, 0, 0)
local addBreath = Angle(0, 0, 0)
local scopeIn = Angle(0, 20, 0)
local k, k2, passive = 0, 0, 0
local vec1 = Vector(-1, 0, 0)
SWEP.ZoomAng = Angle(0, 0, 0)
SWEP.ZoomPos = Vector(-3, 1.2, 35)
SWEP.ZoomPosEnd = Vector(-3, 1.2, -1000)
SWEP.UseWepAng = false
SWEP.attAng = Angle(0, 0, 0)
SWEP.attPos = Vector(0, 0, 0)
SWEP.IdlePos = Vector(0, 0, 0)
SWEP.IdleAng = Angle(0, 0, 0)
SWEP.Ergonomics = 1
local Lerp, LerpVector, LerpAngle = Lerp, LerpVector, LerpAngle
local ply
local math_sin, math_cos = math.sin, math.cos
local math_Clamp = math.Clamp
local CurTime = CurTime
local gun
local traceBuilder = {}
local util_TraceLine = util.TraceLine
local dof_zoom = 0

local angRandLerp = Angle(0,0,0)

function SWEP:GetZoomPos(wepAng,wepPos,recoilZoomPos,view,eyePos)
	local up, right, forward = wepAng:Up(), wepAng:Right(), wepAng:Forward()
	local addPos = self.ZoomPos
	local vec = vecZero2
	if self.availableAttachments.sight and self.availableAttachments.sight["mount"] and not (self.attachments.sight[1] == "empty" or table.IsEmpty(self.attachments.sight)) then
		local att = self:GetMuzzleAtt(gun, true, false)
		vec = -self.availableAttachments.sight["mount"]:GetNegated()
		recoilZoomPos:Mul(self.holdtype == "revolver" and 0.25 or 0.5)
		vec:Add(hg.attachments.sight[self.attachments.sight[1]].offset)
		vec:Rotate(att.Ang)
	end
	
	wepPos = (self.attachments.sight[1] and self.attachments.sight[1] ~= "empty") and (vec + wepPos) or wepPos
	local originWep = view.origin - wepPos
	addPos = (self.attachments.sight[1] and self.attachments.sight[1] ~= "empty") and (hg.attachments.sight[self.attachments.sight[1]].offsetView or vecZero) or addPos
	
	local att = self:GetMuzzleAtt(gun, true,false)

	local zoomPos = forward * addPos[3] + up * addPos[1] + right * addPos[2]
	local posZoom = originWep + zoomPos
	if eyePos then
		local _,hitpos,dist = util.DistanceToLine(posZoom,posZoom + att.Ang:Forward(),eyePos)
		
		local zoomPos = zoomPos + att.Ang:Forward() * math.min(dist)
		posZoom = originWep + zoomPos - recoilZoomPos * 0.5
	end
	return posZoom,wepPos
end

function SWEP:Camera(eyePos, eyeAng, view)
	ply = self:GetOwner()
	local wepPos, wepAng
	if self.UseCustomWorldModel then
		self:WorldModel_Transform()
		gun = self.worldModel
	else
		gun = self
	end

	self.Anim_RecoilCameraZoom = LerpVector(0.05, self.Anim_RecoilCameraZoom, self.Anim_RecoilCameraZoomSet)
	local primary = self.Primary
	self.Anim_RecoilLerp = math.max((primary.Next - CurTime()) / primary.Wait / 2, 0)
	self.Anim_RecoilCameraZoomSet = LerpVector(0.3, vector_origin, self.Anim_RecoilCameraZoomSet)
	
	local att = self:GetMuzzleAtt(gun, true,false)
	if not att then return end
	wepPos, wepAng = att.Pos, att.Ang
	wepAng:RotateAroundAxis(wepAng:Forward(), -90)
	local up, right, forward = wepAng:Up(), wepAng:Right(), wepAng:Forward()
	addPos = self.Anim_RecoilCameraZoom * (self.holdtype == "revolver" and 4 or 2) --/ 2
	local recoilZoomPos = up * addPos[1] + right * addPos[2] + forward * addPos[3]
	if not self.attachments then return end
	local att = self:GetMuzzleAtt(gun, self:HasAttachment("sight"),false)
	wepPos, wepAng = att.Pos, att.Ang
	wepAng:RotateAroundAxis(wepAng:Forward(), -90)
	wepAng:Add(self.ZoomAng)
	passive = self:IsEyeAng() and 1 or 0
	passive = self:ChangeCameraPassive(passive) or passive
	local setAng = Lerp(1 - passive, eyeAng, wepAng + self.attAng)
	eyeAngL = eyeAng
	
	local posZoom,wepPos = self:GetZoomPos(wepAng,wepPos,recoilZoomPos,view,eyePos)

	angZoom = eyeAngL
	addPos = self.IdlePos
	local posIdle = eyePos + wepAng:Up() * addPos[1] + wepAng:Right() * addPos[2] + wepAng:Forward() * addPos[3] - recoilZoomPos / 2
	local angIdle = eyeAngL + self.IdleAng
	local zoom = self:IsZoom() and self:CloseAnim() == 0
	if zoom then
		NeedAccarucyRender = true
		k = LerpFT(0.1 * self.Ergonomics ^ 2, k, 1)
		k2 = LerpFT(0.25, k2, 1)
		local organism = LocalPlayer().organism or {}

		local k = ((organism.larm or 0) + (organism.rarm or 0)) / 4 + 0.03
		local angRand = AngleRand(-k * 1, k * 1)
		angRand[3] = 0
		angRandLerp = Lerp(0.01,angRandLerp,angRand)
		ply:SetEyeAngles(ply:EyeAngles() + angRandLerp)
	else
		NeedAccarucyRender = nil
		k = LerpFT(0.1 * self.Ergonomics ^ 2, k, 0)
		k2 = LerpFT(0.25, k2, 0)
	end

	--local shootLerp = self.Anim_RecoilLerp
	--view.fov = Lerp(shootLerp,view.fov,view.fov - 5 * self.Penetration / 15)
	local outputPos, outputAng
	local animpos = -(self.weaponAngLerp or Angle(0, 0, 0))[1] / 20 --:GetAnimShoot2()
	local eyeSpray = -(-self.EyeSpray)
	local animposSpray, spray = self:GetCameraSprayValues(ply, eyeSpray, animpos)
	--angZoom[1] = angZoom[1] + animpos * 20
	posZoom:Add(-animposSpray * (self.holdtype == "revolver" and 200 or 50))
	posIdle:Add(-(diffvec3 * 1))
	--angIdle:Add(offsetView)
	outputPos = LerpVector(k, posIdle, posZoom)
	outputAng = LerpAngle(k, angIdle, angZoom)
	--if self:CanUse() then
	outputPos:Add(animposSpray * (self.holdtype == "revolver" and -100 or -0))
	outputAng:Add(-eyeSpray * 10)
	outputAng:Add(-GetViewPunchAngles() - eyeSpray)
	outputPos:Add(-spray * 150)
	outputPos:Add((diffpos * 20) / (self.Ergonomics or 1))
	view.origin = view.origin - outputPos
	view.angles = outputAng
	return view
end

function SWEP:GetCameraSprayValues(ply, eyeSpray, animpos)
	local animposSpray = -(-eyeSpray)
	animposSpray[1] = animpos
	animposSpray[2] = 0
	animposSpray[3] = 0
	animposSpray = -animposSpray:Forward()
	animposSpray[1] = 0
	animposSpray:Rotate(ply:EyeAngles())
	local spray = eyeSpray:Forward()
	spray[1] = 0
	spray[3] = spray[3] / 4
	spray:Rotate(ply:EyeAngles())
	return animposSpray, spray
end

function SWEP:ChangeCameraPassive(value)
	return value
end

function SWEP:IsEyeAng()
	return self.reload or self.deploy or self.holster or self:IsSprinting() or not self:GetOwner():OnGround() or self.checkingAtts
end

local white = Color(255, 255, 255)
local white2 = Color(150, 150, 150)
local red = Color(250, 100, 100)
local hg_show_hitposmuzzle = ConVarExists("hg_show_hitposmuzzle") and GetConVar("hg_show_hitposmuzzle") or CreateClientConVar("hg_show_hitposmuzzle", "0", false, false, "shows weapons crosshair, work only witch admin rank or sv_cheats 1")
local sv_cheats = GetConVar("sv_cheats")
local pos, wep, lply
hook.Add("HUDPaint", "homigrad-test-att", function()
	lply = LocalPlayer()
	if not hg_show_hitposmuzzle:GetBool() or (hg_show_hitposmuzzle:GetBool() and not (sv_cheats:GetBool() or lply:IsAdmin() or lply:IsSuperAdmin())) then return end
	wep = lply:GetActiveWeapon()
	if not IsValid(wep) or not wep.GetHitPos then return end
	pos = wep:GetMuzzleAtt(nil,true).Pos:ToScreen()
	draw.RoundedBox(0, pos.x - 2, pos.y - 2, 4, 4, red)
	pos = wep:GetHitPos():ToScreen()
	draw.RoundedBox(0, pos.x - 2, pos.y - 2, 4, 4, white)
	if not IsValid(lply.FakeRagdoll) then draw.RoundedBox(0, ScrW() / 2 - 2, ScrH() / 2 - 2, 4, 4, white2) end
end)

local pp_dof_initlength = CreateClientConVar("pp_dof_initlength", "256", true, false)
local pp_dof_spacing = CreateClientConVar("pp_dof_spacing", "512", true, false)
local pp_dof = CreateClientConVar("pp_dof", "0", false, false)
local potatopc = GetConVar("hg_potatopc")
hook.Add("Think", "DOFThink", function()
	--if not GAMEMODE:PostProcessPermitted("dof") or not pp_dof:GetBool() or potatopc:GetInt() or 0 >= 1 then return end
	--DOF_SPACING = pp_dof_spacing:GetFloat()
	--DOF_OFFSET = pp_dof_initlength:GetFloat()
end)

--[[local angleHuy = Angle(0,-90,0)
local someVec = Vector(0,0,36)
hook.Add("PreDrawTranslucentRenderables","huy",function()
	local lply = LocalPlayer()
	local firstPerson = true--lply == GetViewEntity()
	if firstPerson then
		lply:ManipulateBoneAngles(lply:LookupBone("ValveBiped.Bip01_Spine1"),angleHuy)
		playerModel = playerModel or ClientsideModel(lply:GetModel())

		--local pos,ang = lply:GetBonePosition(0)

		playerModel:SetPos(lply:GetPos())

		--ang:RotateAroundAxis(ang:Right(),90)
		--ang:RotateAroundAxis(ang:Forward(),-90)
		local ang = lply:EyeAngles()
		ang[1] = 0
		playerModel:SetAngles(ang)
		local ang = lply:EyeAngles()

		playerModel:ManipulateBoneAngles(playerModel:LookupBone("ValveBiped.Bip01_Head1"),Angle(ang[3],-ang[1],0))

		playerModel:ManipulateBonePosition(0,playerModel:WorldToLocal(lply:GetBonePosition(0)) - someVec,false)
		playerModel:ManipulateBoneAngles(playerModel:LookupBone("ValveBiped.Bip01_L_Thigh"),-angleHuy)
		playerModel:ManipulateBoneAngles(playerModel:LookupBone("ValveBiped.Bip01_R_Thigh"),-angleHuy)
	end
end)]]
local ot = Angle(0, 0, 0)
hook.Add("InputMouseApply", "huyasd2", function(cmd, x, y, angle)
	if IsValid(follow) then return end
	local wep = LocalPlayer():GetActiveWeapon()
	if not wep.bipodDir then return end
	local attang = wep.bipodDir:Angle()
	ot = angle - attang
	ot:Normalize()
	ot[2] = math.Clamp(ot[2], -45, 45)
	ot[1] = math.Clamp(ot[1], -15, 15)
	angle = attang + ot
	angle.pitch = math.Clamp(angle.pitch + y / 50, -89, 89)
	angle.yaw = angle.yaw - x / 50
	cmd:SetViewAngles(angle)
	return true
end)