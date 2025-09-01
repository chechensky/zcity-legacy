-- Path scripthooked:lua\\weapons\\weapon_bandage_sh.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_base"
SWEP.PrintName = "Bandage"
SWEP.Instructions = "A gauze bandage used to control light bleedings. RMB to use on someone else."
SWEP.Category = "Medicine"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Wait = 1
SWEP.Primary.Next = 0
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HoldType = "slam"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/bandages.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_bandage")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_bandage.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.ScrappersSlot = "Medicine"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.BleedHeal = 15
SWEP.WorkWithFake = true
SWEP.offsetVec = Vector(3, -4.5, 0)
SWEP.offsetAng = Angle(90, 90, 0)
function SWEP:DrawWorldModel()
	self.model = self.model or ClientsideModel(self.WorldModel)
	local WorldModel = self.model
	local owner = self:GetOwner()
	WorldModel:SetNoDraw(true)
	WorldModel:SetModelScale(self.ModelScale or 1)
	if IsValid(owner) then
		local offsetVec = self.offsetVec
		local offsetAng = self.offsetAng
		local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
		if not boneid then return end
		local matrix = owner:GetBoneMatrix(boneid)
		if not matrix then return end
		local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
		WorldModel:SetPos(newPos)
		WorldModel:SetAngles(newAng)
		WorldModel:SetupBones()
	else
		WorldModel:SetPos(self:GetPos())
		WorldModel:SetAngles(self:GetAngles())
	end

	WorldModel:DrawModel()
end

function SWEP:SetHold(value)
	self:SetWeaponHoldType(value)
	self.holdtype = value
end

if SERVER then
	util.AddNetworkString("wound_check")
	util.AddNetworkString("receive_org")
end

local function eyeTrace(ply)
	local att = ply:LookupAttachment("eyes")
	if att then
		att = ply:GetAttachment(att)
	else
		local tr = {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:GetAimVector() * 60,
			filter = ply
		}
		return util.TraceLine(tr)
	end

	local tr = {}
	tr.start = att.Pos - vector_up * 2 -- - ply:GetAimVector() * 5
	tr.endpos = tr.start + ply:GetAimVector() * 60
	tr.filter = ply
	return util.TraceLine(tr)
end

SWEP.usetime = 2

function SWEP:Think()
	self:SetHold(self.HoldType)

	--[[if self.modeValuesdef[self.mode][2] then
		local time = CurTime()
		local ply = self:GetOwner()
		local entownr = hg.GetCurrentCharacter(ply)

		if not self.attack and ply:KeyPressed(IN_ATTACK) then
			self.startedheal = CurTime()
			self.healsubject = ply
			self.attack = 1
		end

		if self.attack == 1 and ply:KeyReleased(IN_ATTACK) then
			self.endheal = CurTime()
		end

		if not self.attack and ply:KeyPressed(IN_ATTACK2) then
			self.startedheal = CurTime()
			self.healsubject = eyeTrace(self:GetOwner()).Entity
			self.attack = 2
		end

		if self.attack == 2 and ply:KeyReleased(IN_ATTACK2) then
			self.endheal = CurTime()
		end

		if self.startheal and (self.endheal or (self.startheal + self.usetime <= CurTime())) then
			self.endheal = self.endheal or self.startheal + self.usetime
			local usedmuch = (self.endheal - self.startheal) / self.usetime

			self:Heal(self.healsubject, self.mode, usedmuch)
			self.startheal = nil 
			self.endheal = nil 
			self.attack = nil 
			self.healsubject = nil
		end
	end--]]
end

function SWEP:PrimaryAttack()
	if SERVER then--and not self.modeValuesdef[self.mode][2] then
		self.healbuddy = self:GetOwner()
		self:Heal(self.healbuddy, self.mode)
		net.Start("sendvals")
		net.WriteEntity(self)
		net.WriteTable(self.modeValues)
		net.Broadcast()
	end
end

if CLIENT then
	surface.CreateFont("huyhuy", {
		font = "CloseCaption_Normal", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = ScreenScale(15),
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = false,
		strikeout = false,
		shadow = false,
		outline = false,
	})
	

	local colWhite = Color(255, 255, 255, 255)
	local colGray = Color(200, 200, 200, 200)
	local lerpthing = 1
	local colBrown = Color(40,40,40)
	SWEP.showstats = true
	SWEP.ofsV = Vector(10,-2,1)
	SWEP.ofsA = Angle(-90,-40,270)
	function SWEP:DrawHUD()
		if GetViewEntity() ~= LocalPlayer() then return end
		if LocalPlayer():InVehicle() then return end
		local owner = LocalPlayer()
		local Tr = eyeTrace(LocalPlayer())
		local Size = math.max(math.min(1 - Tr.Fraction, 0.5), 0.1)
		local x, y = Tr.HitPos:ToScreen().x, Tr.HitPos:ToScreen().y
		if Tr.Hit then
			lerpthing = Lerp(0.1, lerpthing, 1)
			colWhite.a = 255 * Size
			surface.SetDrawColor(colGray)
			draw.NoTexture()
			surface.SetDrawColor(colWhite)
			draw.NoTexture()
			surface.DrawRect(x - 25 * lerpthing, y - 2.5, 50 * lerpthing, 5)
			surface.DrawRect(x - 2.5, y - 25 * lerpthing, 5, 50 * lerpthing)
			local col = Tr.Entity:GetPlayerColor():ToColor()
			local coloutline = (col.r < 50 and col.g < 50 and col.b < 50) and Color(255,255,255) or Color(0,0,0)
			coloutline.a = 255 * Size * 2
			draw.DrawText(Tr.Entity:IsPlayer() and Tr.Entity:GetPlayerName() or Tr.Entity:IsRagdoll() and Tr.Entity:GetPlayerName() or "", "HomigradFontLarge", x + 1, y + 31, coloutline, TEXT_ALIGN_CENTER)
			draw.DrawText(Tr.Entity:IsPlayer() and Tr.Entity:GetPlayerName() or Tr.Entity:IsRagdoll() and Tr.Entity:GetPlayerName() or "", "HomigradFontLarge", x, y + 30, col, TEXT_ALIGN_CENTER)
		end
		if not self.model then return end
		local p,a = self.model:GetPos(),self.model:GetAngles()
		local pos,ang = LocalToWorld(self.ofsV,self.ofsA,p,a)
		cam.Start3D()
			cam.Start3D2D(pos,ang,0.01)
				if self.showstats then
					surface.SetFont("huyhuy")
					local size = 0
					for i,name in pairs(self.modeNames) do
						size = math.max(size,surface.GetTextSize(tostring(self.modeNames[i])))
					end
					for i, val in pairs(self.modeValues) do
						if not isnumber(i) or not val or not self.modeValuesdef or not self.modeValuesdef[i][1] then continue end
						local val = math.Round(val / self.modeValuesdef[i][1] * 100)
						local x,y = ScrW() / 40, ScrH() / 1.5 + i * ScrH() / 20
			
						surface.SetDrawColor(0,100,0,255)
						surface.DrawRect(x + size + 10,y,ScrW() / 10 * val / 100,ScrH() / 25)
						surface.SetDrawColor(255,255,255,255)
						surface.DrawOutlinedRect(x + size + 10,y,ScrW() / 10,ScrH() / 25)
						surface.SetTextPos(x,y)
						surface.SetTextColor(255,255,255,255)
						--surface.DrawText(tostring(self.modeNames[i]))
						draw.SimpleTextOutlined(tostring(self.modeNames[i]),"huyhuy",x,y,Color(255,i == self.mode and 0 or 255,i == self.mode and 0 or 255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER,1.5,colBrown)
					end
				end
			cam.End3D2D()
		cam.End3D()
		--[[surface.SetFont("huyhuy")
		local size = 0
		for i,name in pairs(self.modeNames) do
			size = math.max(size,surface.GetTextSize(tostring(self.modeNames[i])))
		end
		for i, val in pairs(self.modeValues) do
			if not isnumber(i) or not val or not self.modeValuesdef or not self.modeValuesdef[i][1] then continue end
			local val = math.Round(val / self.modeValuesdef[i][1] * 100)
			local x,y = ScrW() / 40, ScrH() / 1.5 + i * ScrH() / 20

			surface.SetDrawColor(0,100,0,255)
			surface.DrawRect(x + size + 10,y,ScrW() / 10 * val / 100,ScrH() / 25)
			surface.SetDrawColor(255,255,255,255)
			surface.DrawOutlinedRect(x + size + 10,y,ScrW() / 10,ScrH() / 25)
			surface.SetTextPos(x,y)
			surface.SetTextColor(255,255,255,255)
			--surface.DrawText(tostring(self.modeNames[i]))
			draw.SimpleTextOutlined(tostring(self.modeNames[i]),"huyhuy",x,y,color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER,1.5,Color(40,40,40))
		end--]]
	end
end

SWEP.mode = 1
SWEP.modes = 1
SWEP.modeNames = {
	[1] = "bandaging"
}

function SWEP:InitializeAdd()
end

SWEP.DeploySnd = "physics/body/body_medium_impact_soft5.wav"
SWEP.HolsterSnd = ""
SWEP.FallSnd = "physics/body/body_medium_impact_soft5.wav"

function SWEP:Initialize()
	self:SetHold(self.HoldType)
	self.modeValues = {
		[1] = 50,
	}

	util.PrecacheSound(self.DeploySnd)
	util.PrecacheSound(self.HolsterSnd)
	util.PrecacheSound(self.FallSnd)

	self:AddCallback("PhysicsCollide",function(ent,data)
		if data.Speed > 200 then
			ent:EmitSound(self.FallSnd or self.DeploySnd,65)
		end
	end)

	self:InitializeAdd()
end

SWEP.modeValuesdef = {
	[1] = {50,true},
}

function SWEP:SecondaryAttack()
	if SERVER then
		if IsValid(self:GetNWEntity("fakeGun")) then return end
		local ent = hg.RagdollOwner(eyeTrace(self:GetOwner()).Entity)
		self.healbuddy = ent
		self:Heal(self.healbuddy, self.mode)
		if ent.Organism then
			net.Start("sendvals")
			net.WriteEntity(self)
			net.WriteTable(self.modeValues)
			net.Broadcast()
		end
	end
end

if SERVER then
	util.AddNetworkString("select_mode")
else
	net.Receive("select_mode",function()
		net.ReadEntity().mode = net.ReadInt(4)
	end)
end

function SWEP:Reload()
	if SERVER and self:GetOwner():KeyPressed(IN_RELOAD) and #self.modeValuesdef > 1 then
		self.mode = ((self.mode + 1) > self.modes) and 1 or (self.mode + 1)
		--self:GetOwner():ChatPrint("You have chosen the " .. self.modeNames[self.mode] .. " mode")
		net.Start("select_mode")
		net.WriteEntity(self)
		net.WriteInt(self.mode,4)
		net.Broadcast()
	end
end

if SERVER then
	util.AddNetworkString("sendvals")
else
	net.Receive("sendvals", function() net.ReadEntity().modeValues = net.ReadTable() end)
end

SWEP.ShouldDeleteOnFullUse = true


if SERVER then
	function SWEP:Bandage(ent, bone)
		local org = ent.Organism
		local owner = self:GetOwner()
		if not org then return end
		local bleed = ent:MuchBleeding()
		if self.modeValues[1] == 0 or bleed <= 0 then return end
		self.modeValues[1] = self.modeValues[1] - (math.Clamp(bleed,0,99999))
		ent:HealBleeding(bleed)
		owner:EmitSound("snd_jack_hmcd_bandage.wav", 60, math.random(95, 105))
	end

	function SWEP:Heal(ent, mode, bone)
		local org = ent.Organism
		if not org then return end
		self:Bandage(ent, bone)
		if self.modeValues[1] == 0 and self.ShouldDeleteOnFullUse then
			self:GetOwner():SelectWeapon("weapon_hands_sh")
			self:Remove()
		end
	end

	function SWEP:SetFakeGun(ent)
		self:SetNWEntity("fakeGun", ent)
		self.fakeGun = ent
	end

	function SWEP:RemoveFake()
		if not IsValid(self.fakeGun) then return end
		self.fakeGun:Remove()
		self:SetFakeGun()
	end

	function SWEP:CreateFake(ragdoll)
		if IsValid(self:GetNWEntity("fakeGun")) then return end
		local ent = ents.Create("prop_physics")
		local lh = ragdoll:GetPhysicsObjectNum(5)
		local rh = ragdoll:GetPhysicsObjectNum(7)
		rh:SetPos(rh:GetPos() + self:GetOwner():EyeAngles():Forward() * 20)
		rh:SetAngles(self:GetOwner():EyeAngles() + Angle(0, 0, -90))
		lh:SetPos(rh:GetPos())
		ent:SetModel(self.WorldModel)
		ent:SetPos(rh:GetPos())
		ent:SetAngles(rh:GetAngles() + Angle(0, 0, 180))
		ent:Spawn()
		ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		ent:SetOwner(ragdoll)
		ent:GetPhysicsObject():SetMass(0)
		ent.dontPickup = true
		ent.fakeOwner = self
		ragdoll:DeleteOnRemove(ent)
		ragdoll.fakeGun = ent
		if IsValid(ragdoll.ConsRH) then ragdoll.ConsRH:Remove() end
		self:SetFakeGun(ent)
		ent:CallOnRemove("homigrad-swep", self.RemoveFake, self)
		local vec = Vector(0, 0, 0)
		vec:Set(self.RHandPos or vector_origin)
		vec:Rotate(ent:GetAngles())
		rh:SetPos(ent:GetPos() + vec)
	end

	function SWEP:RagdollFunc(pos, angles, ragdoll)
		shadowControl = shadowControl or hg.ShadowControl
		local fakeGun = ragdoll.fakeGun
		pos:Add(angles:Forward() * 20)
		shadowControl(fakeGun, 0, 0.001, angles, 100, 90, pos, 1000, 900)
		angles:RotateAroundAxis(angles:Forward(), 180)
		shadowControl(ragdoll, 7, 0.001, angles, 55500, 30, pos, 1000, 100)
	end
end


hg.TourniquetGuys = hg.TourniquetGuys or {}

if SERVER then
	util.AddNetworkString("send_tourniquets")
	function SWEP:Tourniquet(ent, bone)
		local org = ent.Organism
		if not org then return end
		if #org.Hit > 0 then
			local ent = org.alive and org.owner or ent
			ent.tourniquets = ent.tourniquets or {}
			
			local whatarteryregen = table.Random(ListArteriesTourniquet)
			local artery_will_healed = false
			for index, artery in ipairs(ListArteriesTourniquet) do
				if table.HasValue(org.Hit, artery) then
					artery_will_healed = true
					whatarteryregen = artery
				end
			end
			if not table.HasValue(org.Hit, whatarteryregen) then return false end
			if artery_will_healed == false then return false end
			table.insert(ent.tourniquets, whatarteryregen)

			if chokehuy then org.o2.regen = 0 end

			table.RemoveByValue(org.Hit,whatarteryregen)

			ent:SetNetVar("Tourniquets",ent.tourniquets)

			if not table.HasValue(hg.TourniquetGuys,ent) then
				table.insert(hg.TourniquetGuys,ent)
			end

			for i,ent in ipairs(hg.TourniquetGuys) do
				if not IsValid(ent) or not ent.tourniquets or table.IsEmpty(ent.tourniquets) then table.remove(hg.TourniquetGuys,i) end
			end

			SetNetVar("TourniquetGuys",hg.TourniquetGuys)

			self:GetOwner():EmitSound("snd_jack_hmcd_bandage.wav", 65, math.random(95, 105))
			return true
		end
	end

	hook.Add("Player Spawn", "remove-tourniquets", function(ply) ply:SetNetVar("Tourniquets",{}) ply.tourniquets = {} end)

	hook.Add("PostPlayerDeath", "homigrad-inventory", function(ply)
		local ragdoll = ply:GetNWEntity("RagdollDeath")

		if IsValid(ragdoll) then
			table.RemoveByValue(hg.TourniquetGuys,ply)
			table.insert(hg.TourniquetGuys,ragdoll)
			
			ragdoll.tourniquets = {}
			ply.tourniquets = ply.tourniquets or {}
			table.CopyFromTo(ply.tourniquets,ragdoll.tourniquets)

			ragdoll:SetNetVar("Tourniquets",ragdoll.tourniquets)

			for i,ent in ipairs(hg.TourniquetGuys) do
				if not IsValid(ent) or not ent.tourniquets or table.IsEmpty(ent.tourniquets) then table.remove(hg.TourniquetGuys,i) end
			end
		end
		ply.tourniquets = {}
		ply:SetNetVar("Tourniquets",{})

		SetNetVar("TourniquetGuys",hg.TourniquetGuys)
	end)
else
	local function removeFunc(self)
		if not self.tourniquetsM then return end
		for i, model in pairs(self.tourniquetsM) do
			if IsValid(model) then
				model:Remove()
				self.tourniquetsM[i] = nil
			end
		end
	end

	hook.Add("RagdollRemove","RemoveFuckingTourniquets",function(ply,ragdoll)
		removeFunc(ply)
	end)

	hook.Add("OnNetVarSet","tourniquets",function(index,key,var)
		if key == "Tourniquets" then
			local ent = Entity(index)
			
			ent.tourniquets = var
			removeFunc(ent)
		end
	end)

	hook.Add("OnGlobalVarSet","TourniquetGuys",function(key,var)
		if key == "TourniquetGuys" then
			local copy = hg.TourniquetGuys or {}
			
			for i,ent in ipairs(copy) do
				if not table.HasValue(var,ent) then
					removeFunc(ent)
				end
			end

			hg.TourniquetGuys = var

			for i,ent in ipairs(hg.TourniquetGuys) do
				if not IsValid(ent) then continue end
				ent:CallOnRemove("removeTourniquets",function()
					if IsValid(ent) and ent.tourniquetsM then
						removeFunc(ent)
					end
				end)
			end
		end
	end)

	local boneScale = {
		["ValveBiped.Bip01_Head1"] = 1,
		["ValveBiped.Bip01_L_UpperArm"] = 0.9,
		["ValveBiped.Bip01_L_Forearm"] = 0.8,
		["ValveBiped.Bip01_R_UpperArm"] = 0.9,
		["ValveBiped.Bip01_R_Forearm"] = 0.8,
		["ValveBiped.Bip01_L_Thigh"] = 1.4,
		["ValveBiped.Bip01_L_Calf"] = 1.2,
		["ValveBiped.Bip01_R_Thigh"] = 1.4,
		["ValveBiped.Bip01_R_Calf"] = 1.2,
	}

	local boneOffset = {
		["ValveBiped.Bip01_Head1"] = {Vector(-2, -1.5, -3), Angle(90, 90, 90)},
		["ValveBiped.Bip01_L_UpperArm"] = {Vector(0, -0, -2), Angle(90, 90, 90)},
		["ValveBiped.Bip01_L_Forearm"] = {Vector(0, -0.1, -2.6), Angle(90, 90, 90)},
		["ValveBiped.Bip01_R_UpperArm"] = {Vector(0, -0, -2), Angle(90, 90, 90)},
		["ValveBiped.Bip01_R_Forearm"] = {Vector(0, -0.1, -2.6), Angle(90, 90, 90)},
		["ValveBiped.Bip01_L_Thigh"] = {Vector(13, -0.4, -4), Angle(90, -90, 90)},
		["ValveBiped.Bip01_L_Calf"] = {Vector(5, -0.5, -3.8), Angle(90, -90, 90)},
		["ValveBiped.Bip01_R_Thigh"] = {Vector(13, -0.4, -4), Angle(90, -90, 90)},
		["ValveBiped.Bip01_R_Calf"] = {Vector(5, -0.5, -3.8), Angle(90, -90, 90)},
	}
	
	local TranslateToBone = {
		["arteria"] = "ValveBiped.Bip01_Head1",
		["larmartery"] = "ValveBiped.Bip01_L_Forearm",
		["rarmartery"] = "ValveBiped.Bip01_R_Forearm",
		["llegartery"] = "ValveBiped.Bip01_L_Thigh",
		["rlegartery"] = "ValveBiped.Bip01_R_Thigh",
	}

	hook.Add("PostDrawOpaqueRenderables", "draw_tourniquets", function()
		for i,ply in ipairs(hg.TourniquetGuys) do
			
			if not IsValid(ply) then
				table.remove(hg.TourniquetGuys,i)
				removeFunc(ply)
				continue
			end

			local ent = ply:IsPlayer() and hg.GetCurrentCharacter(ply) or ply

			for i, wound in pairs(ply.tourniquets) do
				ply.tourniquetsM = ply.tourniquetsM or {}
				ply.tourniquetsM[i] = ply.tourniquetsM[i] or ClientsideModel("models/tourniquet/tourniquet_put.mdl")
				local model = ply.tourniquetsM[i]
				if not IsValid(model) then return end
				local matrix = ent:GetBoneMatrix(ent:LookupBone(TranslateToBone[wound]))
				if not matrix then
					model:SetNoDraw(true)
					return
				end
				
				local bonePos, boneAng = matrix:GetTranslation(), matrix:GetAngles()
				
				local tourniquetOffset = Vector(0,0,0)
				tourniquetOffset[2] = 0
				tourniquetOffset[3] = 0
				tourniquetOffset[1] = 0

				if not boneOffset[TranslateToBone[wound]] then continue end

				local offset = boneOffset[TranslateToBone[wound]][1] + tourniquetOffset
				local offset2 = boneOffset[TranslateToBone[wound]][2]
				local pos, ang = LocalToWorld(offset, offset2, bonePos, boneAng)
				model:SetRenderOrigin(pos)
				model:SetRenderAngles(ang)
				model:SetModelScale(boneScale[TranslateToBone[wound]])
				model:SetupBones()
				model:SetNoDraw(false)
				model:DrawModel()
			end
		end
	end)
end

function SWEP:IsLocal()
	return CLIENT and self:GetOwner() == LocalPlayer()
end

function SWEP:Holster(wep)
	if not IsValid(wep) or wep == self then return true end

	if SERVER or CLIENT and self:IsLocal() then
		self:EmitSound(self.HolsterSnd,50)
	end

	return true
end

function SWEP:Deploy()
	
	if SERVER or CLIENT and self:IsLocal() then
		self:EmitSound(self.DeploySnd,50)
	end
	
	return true
end

--

if SERVER then
	util.AddNetworkString("use_item_hg")

	net.Receive("use_item_hg",function(len,ply)
		local bone = net.ReadString()
		local ent = net.ReadEntity()
		
		if IsValid(ent) and ent.organism and ent:GetPos():Distance(ply:EyePos()) <= 96 then
			local wep = ply:GetActiveWeapon()
			
			if wep.Heal then
				wep:Heal(ent,wep.mode,bone)
				net.Start("sendvals")
				net.WriteEntity(wep)
				net.WriteTable(wep.modeValues)
				net.Broadcast()
			end
		end
	end)
end

if CLIENT then
           
    local mat_femka = Material("homigrad/vgui/health_ui/health_female.png")
    local mat_male = Material("homigrad/vgui/health_ui/health_male.png")

    local limbs_femka = {
        ["head"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_head.png"),
        ["neck"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_neck.png"),
        ["larm"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_left_arm.png"),
        ["lwrist"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_left_wrist.png"),
        ["lfoot"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_left_foot.png"),
        ["lleg"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_left_leg.png"),
        ["rarm"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_right_arm.png"),
        ["rwrist"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_right_wrist.png"),
        ["rfoot"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_right_foot.png"),
        ["rleg"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_right_leg.png"),
        ["pelvis"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_spine.png"),
        --["spine1"] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_spine1.png"),
        ["spine2"] = {[1] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_spine2.png"),[2] = Material("homigrad/vgui/health_ui/bodyparts/female/health_female_spine1.png")},
    }

    local limbs_male = {
        ["head"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_head.png"),
        ["neck"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_neck.png"),
        ["larm"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_left_arm.png"),
        ["lwrist"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_left_wrist.png"),
        ["lfoot"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_left_foot.png"),
        ["lleg"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_left_leg.png"),
        ["rarm"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_right_arm.png"),
        ["rwrist"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_right_wrist.png"),
        ["rfoot"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_right_foot.png"),
        ["rleg"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_right_leg.png"),
        ["pelvis"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_spine.png"),
        --["spine1"] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_spine1.png"),
        ["spine2"] = {[1] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_spine2.png"),[2] = Material("homigrad/vgui/health_ui/bodyparts/male/health_male_spine1.png")},
    }

	local wound4Bones = {
		["ValveBiped.Bip01_Head1"]		=	"head",
		["ValveBiped.Bip01_Neck1"]		=	"neck",

		["ValveBiped.Bip01_L_UpperArm"]	=	"larm",
		["ValveBiped.Bip01_L_Forearm"]	=	"lwrist",
		["ValveBiped.Bip01_L_Hand"]		=	"lwrist",
	
		["ValveBiped.Bip01_R_UpperArm"]	=	"rarm",
		["ValveBiped.Bip01_R_Forearm"]	=	"rwrist",
		["ValveBiped.Bip01_R_Hand"]		=	"rwrist",
	
		["ValveBiped.Bip01_Pelvis"]		=	"pelvis",
		["ValveBiped.Bip01_Spine2"]		=	"spine2",
	
		["ValveBiped.Bip01_L_Thigh"]	=	"lleg",
		["ValveBiped.Bip01_L_Calf"]		=	"lfoot",
		["ValveBiped.Bip01_L_Foot"]		=	"lfoot",
	
		["ValveBiped.Bip01_R_Thigh"]	=	"rleg",
		["ValveBiped.Bip01_R_Calf"]		=	"rfoot",
		["ValveBiped.Bip01_R_Foot"]		=	"rfoot"
	}

	local colGray = Color(122,122,122,255)
	local colBlue = Color(130,10,10)
	local colBlueUp = Color(160,30,30)
	local col = Color(255,255,255,255)
	
	local colSpect1 = Color(75,75,75,255)
	local colSpect2 = Color(85,85,85,255)
	
	local colorBG = Color(55,55,55,255)
	local colorBGBlacky = Color(40,40,40,255)
	
	local blurMat = Material("pp/blurscreen")
	local Dynamic = 0
	
	local function BlurBackground(panel)
		if not (IsValid(panel) and panel:IsVisible()) then return end
		local layers, density, alpha = 1, 1, 155
		local x, y = panel:LocalToScreen(0, 0)
		surface.SetDrawColor(255, 255, 255, alpha)
		surface.SetMaterial(blurMat)
		local FrameRate, Num, Dark = 1 / FrameTime(), 5, 190
		for i = 1, Num do
			blurMat:SetFloat("$blur", (i / layers) * density * Dynamic)
			blurMat:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
		end
	
		surface.SetDrawColor(0, 0, 0, Dark * Dynamic)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		Dynamic = math.Clamp(Dynamic + (1 / FrameRate) * 7, 0, 1)
	end

    local min = math.min

    local white = Color(255,255,255)
    local paint = Color(0,0,0)

    local surface_SetDrawColor = surface.SetDrawColor
    local surface_SetMaterial = surface.SetMaterial
    local surface_DrawRect = surface.DrawRect
    local surface_DrawTexturedRect = surface.DrawTexturedRect
	local surface_DrawOutlinedRect = surface.DrawOutlinedRect

	if IsValid(bandagePanel) then bandagePanel:Remove() bandagePanel = nil end

   	local function WoundCheck(check)
		local lply = LocalPlayer()
		local ent = check == 1 and lply or eyeTrace(lply).Entity

		local org = ent.Organism
		if not ent.Organism then return end

		if IsValid(bandagePanel) then bandagePanel:Remove() bandagePanel = nil end

        local posX,posY = ScrW() / 3,ScrH() / 3
		local sizeX,sizeY = ScrW() / 3,ScrH() / 2

        bandagePanel = vgui.Create("DFrame")
		bandagePanel:SetPos(posX,posY)
		bandagePanel:SetSize(sizeX,sizeY)
		bandagePanel:SetTitle("")
        bandagePanel.gender = ThatPlyIsFemale(ent)

        bandagePanel:MakePopup()
        bandagePanel:SetKeyboardInputEnabled(false)
		bandagePanel:ShowCloseButton(false)

		local selected
		local selectedbut
		local selectedbone

        bandagePanel.Paint = function(self,w,h)
            BlurBackground(self)

			surface.SetDrawColor( 255, 0, 0, 128)
			surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )

			surface_SetDrawColor(white)
            surface_SetMaterial(self.gender and mat_femka or mat_male)
            surface_DrawTexturedRect(-w/3,0,w,h)
			draw.SimpleTextOutlined(ent:GetPlayerName().."'s health","huyhuy",0,0,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,1.5,Color(40,40,40))

			local bonewounds = {}

			for i,wound in pairs(org.wounds) do
				local bld,bone = wound[1],wound[4]
				local bone = ent:GetBoneName(bone)
				if not bone then continue end
				bonewounds[bone] = bonewounds[bone] and bonewounds[bone] + bld or bld
			end
			
			for i,wound in pairs(org.arterialwounds) do
				local bld,bone = wound[1],wound[4]
				local bone = ent:GetBoneName(bone)
				if not bone then continue end
				bonewounds[bone] = bonewounds[bone] and bonewounds[bone] + bld or bld
			end

			for bone,name in pairs(wound4Bones) do
				local selectedhuy = selected and selected == name
				local mat = self.gender and limbs_femka[name] or limbs_male[name]
				if not istable(mat) then
					surface_SetMaterial(self.gender and mat or mat)
					surface_SetDrawColor(255,(255 - (bonewounds[bone] or 0) * 20),(255 - (bonewounds[bone] or 0) * 20),150)
					surface_DrawTexturedRect(-w/3,0,w,h)
					if selectedhuy then
						surface_SetDrawColor(0,0,0,122)
						surface_DrawTexturedRect(-w/3,0,w,h)
					end
				else
					for i,mat in pairs(mat) do
						surface_SetMaterial(self.gender and mat or mat)
						surface_SetDrawColor(255,(255 - (bonewounds[bone] or 0) * 20),(255 - (bonewounds[bone] or 0) * 20),150)
						surface_DrawTexturedRect(-w/3,0,w,h)
						if selectedhuy then
							surface_SetDrawColor(0,0,0,122)
							surface_DrawTexturedRect(-w/3,0,w,h)
						end
					end
				end
			end
        end

		local closebutton = vgui.Create("DButton", bandagePanel)
		local w,h = bandagePanel:GetWide(), bandagePanel:GetTall()
		local sizeX,sizeY = ScrW() / 20, ScrH() / 30
		closebutton:SetPos(w - sizeX - 5, 5)
		closebutton:SetSize(sizeX, sizeY)
		closebutton:SetText("")
		
		closebutton.DoClick = function()
			if IsValid(bandagePanel) then
				bandagePanel:Remove()
				bandagePanel = nil
			end
		end
	
		closebutton.Paint = function(self,w,h)
			surface.SetDrawColor(0, 0, 0, 122)
			surface.DrawRect(0, 0, w, h, 2.5)
			surface.SetDrawColor(122, 122, 122, 255)
			surface.DrawOutlinedRect(0, 0, w, h, 2.5)
			surface.SetFont("ZB_InterfaceMedium")
			surface.SetTextColor(col.r, col.g, col.b, col.a)
			local lengthX, lengthY = surface.GetTextSize("Close")
			surface.SetTextPos(lengthX / 4, lengthY / 8)
			surface.DrawText("Close")
		end

		local DScrollPanel = vgui.Create("DScrollPanel", bandagePanel)
		local sx,sy = w / 2,h
		DScrollPanel:SetPos(w - sx, h / 10)
		DScrollPanel:SetSize(sx,sy - h / 5)
		function DScrollPanel:Paint( w, h )
			BlurBackground(self)

			surface.SetDrawColor( 255, 0, 0, 128)
			surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
		end
		--DScrollPanel:Center()
		local bonewounds = {}

		for i,wound in pairs(org.wounds) do
			local bld,bone = wound[1],wound[4]
			local bone = ent:GetBoneName(bone)
			if not bone then continue end
			bonewounds[bone] = bonewounds[bone] and bonewounds[bone] + bld or bld
		end

		local bonearteries = {}

		for i,wound in pairs(org.arterialwounds) do
			local bld,bone = wound[1],wound[4]
			local bone = ent:GetBoneName(bone)
			if not bone then continue end
			bonearteries[bone] = bonearteries[bone] and bonearteries[bone] + bld or bld
		end

		for bone,name in SortedPairs(wound4Bones) do
			--if not (bonewounds[bone] or bonearteries[bone]) then continue end
			local but = vgui.Create("DButton",DScrollPanel)
			but:SetSize(100,50)
			but:Dock(TOP)
			but:DockMargin( 8, 6, 8, -1 )
			but:SetText("")

			but.DoClick = function(self)
				selected = name
				selectedbone = bone
				selectedbut = self
			end

			but.Paint = function(self,w,h)
				surface.SetDrawColor(0, 0, 0, 122)
				surface.DrawRect(0, 0, w, h, 2.5)
				surface.SetDrawColor(selectedbut == self and 255 or 122, 122, 122, 255)
				surface.DrawOutlinedRect(0, 0, w, h, 2.5)
				surface.SetFont("ZB_InterfaceMedium")
				surface.SetTextColor(col.r, col.g, col.b, col.a)
				local lengthX, lengthY = surface.GetTextSize(name)
				surface.SetTextPos(0,0)
				surface.DrawText(name..tostring(bonearteries[bone] and " - artery punctured" or ""..tostring(bonewounds[bone] and " - bleeding" or "")))
			end
		end

		local useitem = vgui.Create("DButton", bandagePanel)
		local w,h = bandagePanel:GetWide(), bandagePanel:GetTall()
		local sizeX,sizeY = ScrW() / 10, ScrH() / 30
		useitem:SetPos(w - sizeX - 5, h - sizeY - 5)
		useitem:SetSize(sizeX, sizeY)
		useitem:SetText("")
		
		useitem.DoClick = function()
			if selectedbone then
				net.Start("use_item_hg")
				net.WriteString(selectedbone)
				net.WriteEntity(ent)
				net.SendToServer()
			end
			WoundCheck(check)
		end
	
		useitem.Paint = function(self,w,h)
			surface.SetDrawColor(0, 0, 0, 122)
			surface.DrawRect(0, 0, w, h, 2.5)
			surface.SetDrawColor(122, 122, 122, 255)
			surface.DrawOutlinedRect(0, 0, w, h, 2.5)
			surface.SetFont("ZB_InterfaceMedium")
			surface.SetTextColor(col.r, col.g, col.b, col.a)
			local lengthX, lengthY = surface.GetTextSize("Use current item")
			surface.SetTextPos(0,0)
			surface.DrawText("Use current item")
		end
    end

	hook.Add("radialOptions", "hg-medicine-manipulations", function()
		local organism = LocalPlayer().Organism or {}
		if not organism.Otrub then

			local tbl = {
				WoundCheck,
				"Check Player Status",
				true,
				{
					[1] = "Self",
					[2] = "Other player"
				}
			}

			--hg.radialOptions[#hg.radialOptions + 1] = tbl
		end
	end)
end
