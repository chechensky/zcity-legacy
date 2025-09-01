-- Path scripthooked:lua\\weapons\\weapon_hands_sh.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_base"
local function RagdollOwner(ent)
	return hg.RagdollOwner(ent)
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

if SERVER then
	SWEP.Weight = 12
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
else
	SWEP.PrintName = "Hands"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 45
	SWEP.BounceWeaponIcon = false
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_hands")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_hands.png"
	local colWhite = Color(255, 255, 255, 255)
	local colGray = Color(200, 200, 200, 200)
	local lerpthing = 1
	function SWEP:DrawHUD()
		local owner = LocalPlayer()
		if GetViewEntity() ~= owner then return end
		if owner:InVehicle() then return end
		local Tr = eyeTrace(owner)
		local Size = math.max(math.min(1 - Tr.Fraction, 1), 0.1)
		local x, y = Tr.HitPos:ToScreen().x, Tr.HitPos:ToScreen().y
		if Tr.Hit then
			if self:CanPickup(Tr.Entity) then
				lerpthing = Lerp(0.1, lerpthing, 0.1)
				colWhite.a = 255 * Size
				surface.SetDrawColor(colWhite)
				surface.DrawRect(x - 25 * lerpthing, y - 2.5, 50 * lerpthing, 5)
				surface.DrawRect(x - 2.5, y - 25 * lerpthing, 5, 50 * lerpthing)
				local col = Tr.Entity:GetPlayerColor():ToColor()
				local coloutline = (col.r < 50 and col.g < 50 and col.b < 50) and Color(255,255,255) or Color(0,0,0)
				col.a = 255 * Size * 2
				coloutline.a = 255 * Size * 2
				draw.DrawText(Tr.Entity:IsPlayer() and Tr.Entity:GetPlayerName() or Tr.Entity:IsRagdoll() and Tr.Entity:GetPlayerName() or "", "HomigradFontLarge", x + 1, y + 31, coloutline, TEXT_ALIGN_CENTER)
				draw.DrawText(Tr.Entity:IsPlayer() and Tr.Entity:GetPlayerName() or Tr.Entity:IsRagdoll() and Tr.Entity:GetPlayerName() or "", "HomigradFontLarge", x, y + 30, col, TEXT_ALIGN_CENTER)
			else
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
		end
	end
end

local function WhomILookinAt(ply, cone, dist)
	local CreatureTr, ObjTr, OtherTr = nil, nil, nil
	for i = 1, 150 * cone do
		local Tr = eyeTrace(ply)
		if Tr.Hit and not Tr.HitSky and Tr.Entity then
			local Ent, Class = Tr.Entity, Tr.Entity:GetClass()
			if Ent:IsPlayer() or Ent:IsNPC() then
				CreatureTr = Tr
			elseif (Class == "prop_physics") or (Class == "prop_physics_multiplayer") or (Class == "prop_ragdoll") then
				ObjTr = Tr
			else
				OtherTr = Tr
			end
		end
	end

	if CreatureTr then return CreatureTr.Entity, CreatureTr.HitPos, CreatureTr.HitNormal end
	if ObjTr then return ObjTr.Entity, ObjTr.HitPos, ObjTr.HitNormal end
	if OtherTr then return OtherTr.Entity, OtherTr.HitPos, OtherTr.HitNormal end
	return nil, nil, nil
end

SWEP.Category = "ZCity Other"
SWEP.Instructions = "LMB / Reload - raise / lower fists\n\nIn the raised state: LMB - strike, RMB - block\n\nIn the lowered state: RMB - raise the object, R - check the pulse\n\nWhen holding the object: Reload - fix the object in air, E - spin the object in the air."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType = "normal"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_junk/cardboard_box004a.mdl"
SWEP.UseHands = true
SWEP.AttackSlowDown = .5
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.ReachDistance = 100
SWEP.HomicideSWEP = true
SWEP.NoDrop = true
SWEP.ShockMultiplier = 1
SWEP.PainMultiplier = 1
SWEP.Penetration = 1
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextIdle")
	self:NetworkVar("Bool", 2, "Fists")
	self:NetworkVar("Float", 1, "NextDown")
	self:NetworkVar("Bool", 3, "Blocking")
	self:NetworkVar("Bool", 4, "IsCarrying")
end

function SWEP:PreDrawViewModel(vm, wep, ply)
end

function SWEP:Initialize()
	self:SetNextIdle(CurTime() + 5)
	self:SetNextDown(CurTime() + 5)
	self:SetHoldType(self.HoldType)
	self:SetFists(false)
	self:SetBlocking(false)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then
		self:DoBFSAnimation("fists_draw")
		self:GetOwner():GetViewModel():SetPlaybackRate(.1)
		return
	end

	self:SetNextPrimaryFire(CurTime() + .5)
	self:SetFists(false)
	self:SetNextDown(CurTime())
	self:DoBFSAnimation("fists_draw")
	return true
end

function SWEP:Holster()
	self:OnRemove()
	return true
end

function SWEP:CanPrimaryAttack()
	return true
end

local pickupWhiteList = {
	["prop_ragdoll"] = true,
	["prop_physics"] = true,
	["prop_physics_multiplayer"] = true
}

function SWEP:CanPickup(ent)
	if ent:IsNPC() then return false end
	if ent:IsPlayer() then return false end
	if ent:IsWorld() then return false end
	local class = ent:GetClass()
	if pickupWhiteList[class] then return true end
	if CLIENT then return true end
	if IsValid(ent:GetPhysicsObject()) then return true end
	return false
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	if self:GetFists() then return end
	if SERVER then
		self:SetCarrying()
		local ply = self:GetOwner()
		local tr = util.QuickTrace(ply:GetAttachment(ply:LookupAttachment("eyes")).Pos - vector_up * 2, self:GetOwner():GetAimVector() * self.ReachDistance, {self:GetOwner()})
		if IsValid(tr.Entity) and self:CanPickup(tr.Entity) and not tr.Entity:IsPlayer() then
			local Dist = (self:GetOwner():GetShootPos() - tr.HitPos):Length()
			if Dist < self.ReachDistance then
				sound.Play("Flesh.ImpactSoft", self:GetOwner():GetShootPos(), 65, math.random(90, 110))
				self:SetCarrying(tr.Entity, tr.PhysicsBone, tr.HitPos, Dist)
				tr.Entity.Touched = true
				self:ApplyForce()
			end
		elseif IsValid(tr.Entity) and tr.Entity:IsPlayer() then
			local Dist = (self:GetOwner():GetShootPos() - tr.HitPos):Length()
			if Dist < self.ReachDistance then
				sound.Play("Flesh.ImpactSoft", self:GetOwner():GetShootPos(), 65, math.random(90, 110))
				self:GetOwner():SetVelocity(self:GetOwner():GetAimVector() * 20)
				tr.Entity:SetVelocity(-self:GetOwner():GetAimVector() * 50)
				self:SetNextSecondaryFire(CurTime() + .25)
			end
		end
	end
end

function SWEP:FreezeMovement()
	if self:GetOwner():KeyDown(IN_USE) and self:GetOwner():KeyDown(IN_ATTACK2) and self:GetNWBool("Pickup") then return true end
	return false
end

function SWEP:ApplyForce()
	local target = self:GetOwner():GetAimVector() * self.CarryDist + self:GetOwner():GetShootPos()
	local phys = self.CarryEnt:GetPhysicsObjectNum(self.CarryBone)
	if IsValid(phys) then
		local TargetPos = phys:GetPos()
		if self.CarryPos then TargetPos = self.CarryEnt:LocalToWorld(self.CarryPos) end
		local vec = target - TargetPos
		local len, mul = vec:Length(), self.CarryEnt:GetPhysicsObject():GetMass()
		if len > self.ReachDistance then
			self:SetCarrying()
			return
		end

		if self.CarryEnt:GetClass() == "prop_ragdoll" then
			mul = mul * 3
			local ply = hg.RagdollOwner(self.CarryEnt) or self.CarryEnt
			local bone = self.CarryEnt:GetBoneName(self.CarryEnt:TranslatePhysBoneToBone(self.CarryBone))
			if self:GetOwner():KeyPressed(IN_RELOAD) and ((bone == "ValveBiped.Bip01_L_Hand") or (bone == "ValveBiped.Bip01_R_Hand") or (bone == "ValveBiped.Bip01_Head1")) then
				local org = ply.Organism
				if not org then
					self:GetOwner():ChatPrint("Нет пульса.")
				else
					if org.heartstop then
						self:GetOwner():ChatPrint("Нет пульса.")
					else
						if org.pulse > 35 then
							self:GetOwner():ChatPrint("Пульс есть.")
						else	
							self:GetOwner():ChatPrint("Нет пульса.")
						end
					end
					if (org.o2[1] < 10 or not org.alive) and (bone == "ValveBiped.Bip01_Head1") then
						self:GetOwner():ChatPrint("Не дышит.")
					elseif (bone == "ValveBiped.Bip01_Head1") then
						self:GetOwner():ChatPrint("Дышит.")
					end
					if (bone == "ValveBiped.Bip01_Head1") then
						self:GetOwner():ChatPrint(org.Otrub and "Реакции нет." or "Реакция присутствует.")
						if ply:Alive() and not org.Otrub then
							ply:ChatPrint("Вас проверили на реакцию.")
						end
					end
				end
			end
		end

		vec:Normalize()
		if SERVER then
			local ply = hg.RagdollOwner(self.CarryEnt) or self.CarryEnt
			local org = ply.Organism
			if self:GetOwner():KeyDown(IN_ATTACK) then
				local bone = self.CarryEnt:GetBoneName(self.CarryEnt:TranslatePhysBoneToBone(self.CarryBone))

				if org and bone == "ValveBiped.Bip01_Spine2" then
					if self.firstTimePrint then self:GetOwner():ChatPrint("Вы начинаете проводить СЛР... (держите ЛКМ зажатым до появления пульса)") end
					self.firstTimePrint = false
					if (self.CPRThink or 0) < CurTime() then
						self.CPRThink = CurTime() + 1
						if ply:Alive() then
							org.o2[1] = org.o2[1] + 3
							org.o2[2] = org.o2[2] + 3
							org.pulse = org.pulse + 15
							if org.pulse > 15 then org.heartstop = false end
						end

						self.CarryEnt:EmitSound("physics/body/body_medium_impact_soft" .. tostring(math.random(7)) .. ".wav")
					end
				end
			else
				self.firstTimePrint = true
			end
		end

		local avec, velo = vec * len, phys:GetVelocity() - self:GetOwner():GetVelocity()
		local Force = (avec - velo / 2) * (self.CarryBone > 3 and mul / 10 or mul)
		local ForceMagnitude = Force:Length()
		if ForceMagnitude > 6000 * 1 then
			self:SetCarrying()
			return
		end

		if self.CarryPos then
			phys:ApplyForceOffset(Force, self.CarryEnt:LocalToWorld(self.CarryPos))
		else
			phys:ApplyForceCenter(Force)
		end

		if self:GetOwner():KeyDown(IN_USE) then
			SetAng = SetAng or self:GetOwner():EyeAngles()
			local commands = self:GetOwner():GetCurrentCommand()
			local x, y = commands:GetMouseX(), commands:GetMouseY()
			if self.CarryEnt:IsRagdoll() then
				rotate = Vector(x, y, 0) / 6
			else
				rotate = Vector(x, y, 0) / 4
			end

			phys:AddAngleVelocity(rotate)
		end

		phys:ApplyForceCenter(Vector(0, 0, mul))
		phys:AddAngleVelocity(-phys:GetAngleVelocity() / 10)
	end
end

function SWEP:OnRemove()

end

function SWEP:GetCarrying()
	return self.CarryEnt
end

function SWEP:SetCarrying(ent, bone, pos, dist)
	if IsValid(ent) then
		self:SetNWBool("Pickup", true)
		self.CarryEnt = ent
		self.CarryBone = bone
		self.CarryDist = dist

		if not self.CarryEnt.collisionChanged then
			self.CarryEnt:SetCustomCollisionCheck(true)
			self.CarryEnt:CollisionRulesChanged()
			self.CarryEnt.collisionChanged = true
			self.CarryEnt:SetNWEntity("ply",self:GetOwner())
			self:GetOwner():SetNWEntity("carryent",self.CarryEnt)
			self:GetOwner():SetNWFloat("carrymass",self.CarryEnt:GetPhysicsObject():GetMass())
		end

		if ent:GetClass() ~= "prop_ragdoll" then
			self.CarryPos = ent:WorldToLocal(pos)
		else
			self.CarryPos = nil
		end
	else
		if IsValid(self.CarryEnt) and self.CarryEnt.collisionChanged then
			self.CarryEnt:SetCustomCollisionCheck(false)
			self.CarryEnt:CollisionRulesChanged()
			self.CarryEnt.collisionChanged = false
			self.CarryEnt:SetNWEntity("ply",NULL)
			self:GetOwner():SetNWEntity("carryent",NULL)
			self:GetOwner():SetNWFloat("carrymass",0)
		end
		self:SetNWBool("Pickup", false)
		self.CarryEnt = nil
		self.CarryBone = nil
		self.CarryPos = nil
		self.CarryDist = nil
	end
end

function SWEP:Think()
	if IsValid(self:GetOwner()) and self:GetOwner():KeyDown(IN_ATTACK2) and not self:GetFists() then
		if IsValid(self.CarryEnt) then self:ApplyForce() end
	elseif self.CarryEnt then
		self:SetCarrying()
	end

	if self:GetFists() and self:GetOwner():KeyDown(IN_ATTACK2) then
		self:SetNextPrimaryFire(CurTime() + .5)
		self:SetBlocking(true)
	else
		self:SetBlocking(false)
	end

	local HoldType = "normal"
	if self:GetFists() then
		HoldType = "fist"
		local Time = CurTime()
		if self:GetNextIdle() < Time then
			self:DoBFSAnimation("fists_idle_0" .. math.random(1, 2))
			self:UpdateNextIdle()
		end

		if self:GetBlocking() then
			self:SetNextDown(Time + 1)
			HoldType = "camera"
		end

		if (self:GetNextDown() < Time) or self:GetOwner():KeyDown(IN_SPEED) then
			self:SetNextDown(Time + 1)
			self:SetFists(false)
			self:SetBlocking(false)
		end
	else
		HoldType = "normal"
		self:DoBFSAnimation("fists_draw")
	end

	if IsValid(self.CarryEnt) or self.CarryEnt then HoldType = "magic" end
	if self:GetOwner():KeyDown(IN_SPEED) then HoldType = "normal" end
	if SERVER then self:SetHoldType(HoldType) end
end

function SWEP:PrimaryAttack()
	local side = "fists_left"
	if math.random(1, 2) == 1 then side = "fists_right" end
	if self:GetOwner():KeyDown(IN_ATTACK2) then return end
	self:SetNextDown(CurTime() + 555)
	if not self:GetFists() then
		self:SetFists(true)
		self:DoBFSAnimation("fists_draw")
		self:SetNextPrimaryFire(CurTime() + .35)
		return
	end

	if self:GetBlocking() then return end
	if self:GetOwner():KeyDown(IN_SPEED) then return end
	if not IsFirstTimePredicted() then
		self:DoBFSAnimation(side)
		return
	end

	self:GetOwner():ViewPunch(Angle(0, 0, math.random(-2, 2)))
	self:DoBFSAnimation(side)

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)

	self:UpdateNextIdle()
	if SERVER then
		sound.Play("weapons/slam/throw.wav", self:GetPos(), 65, math.random(90, 110))
		self:GetOwner():ViewPunch(Angle(0, 0, math.random(-2, 2)))
		timer.Simple(.075, function() if IsValid(self) then self:AttackFront() end end)
		--self:AttackFront()
	end

	self:SetNextPrimaryFire(CurTime() + .35)
	self:SetNextSecondaryFire(CurTime() + .35)
	self:SetLastShootTime(CurTime())
end

function SWEP:AttackFront()
	if CLIENT then return end
	self.PenetrationCopy = -(-self.Penetration)
	self:GetOwner():LagCompensation(true)
	local Ent, HitPos = WhomILookinAt(self:GetOwner(), .3, 55)
	local AimVec = self:GetOwner():GetAimVector()
	if IsValid(Ent) or (Ent and Ent.IsWorld and Ent:IsWorld()) then
		local SelfForce, Mul = -150, 1
		if self:IsEntSoft(Ent) then
			SelfForce = 25
			if Ent:IsPlayer() and IsValid(Ent:GetActiveWeapon()) and Ent:GetActiveWeapon().GetBlocking and Ent:GetActiveWeapon():GetBlocking() and not RagdollOwner(Ent) then
				sound.Play("Flesh.ImpactSoft", HitPos, 65, math.random(90, 110))
			else
				sound.Play("Flesh.ImpactHard", HitPos, 65, math.random(90, 110))
			end
		else
			sound.Play("Flesh.ImpactSoft", HitPos, 65, math.random(90, 110))
		end

		local DamageAmt = math.random(2, 3)
		local Dam = DamageInfo()
		Dam:SetAttacker(self:GetOwner())
		Dam:SetInflictor(self.Weapon)
		Dam:SetDamage(DamageAmt * Mul)
		Dam:SetDamageForce(AimVec * Mul ^ 2)
		Dam:SetDamageType(DMG_CLUB)
		Dam:SetDamagePosition(HitPos)
		Ent:TakeDamageInfo(Dam)
		local Phys = Ent:GetPhysicsObject()
		if IsValid(Phys) then
			if Ent:IsPlayer() then Ent:SetVelocity(AimVec * SelfForce * 1.5) end
			Phys:ApplyForceOffset(AimVec * 5000 * Mul, HitPos)
			self:GetOwner():SetVelocity(-AimVec * SelfForce * .8)
		end

		--add bleeding when punching glass
	end

	self:GetOwner():LagCompensation(false)
end

--self.CarryDist
--self.CarryPos
--self.CarryBone
function SWEP:Reload()
	if not IsFirstTimePredicted() then return end
	self:SetFists(false)
	self:SetBlocking(false)
	local ent = self:GetCarrying()
	if SERVER then
		local target = self:GetOwner():GetAimVector() * (self.CarryDist or 50) + self:GetOwner():GetShootPos()
		heldents = heldents or {}
		for i, tbl in pairs(heldents) do
			if tbl[2] == self:GetOwner() then heldents[i] = nil end
		end
		if IsValid(ent) then
			--if heldents[ent:EntIndex()] then heldents[ent:EntIndex()] = nil end
			local bone = self.CarryEnt:GetBoneName(self.CarryEnt:TranslatePhysBoneToBone(self.CarryBone))
			if ((bone ~= "ValveBiped.Bip01_L_Hand") or (bone ~= "ValveBiped.Bip01_R_Hand") or (bone ~= "ValveBiped.Bip01_Head1")) then
				heldents[ent:EntIndex()] = {self.CarryEnt, self:GetOwner(), self.CarryDist, target, self.CarryBone, self.CarryPos}
			end
		end
	end
	--self:SetCarrying()
end

if SERVER then
	local angZero = Angle(0, 0, 0)
	hook.Add("Think", "held-entities", function()
		heldents = heldents or {}
		for i, tbl in pairs(heldents) do
			if not tbl or not IsValid(tbl[1]) then
				heldents[i] = nil
				continue
			end

			local ent, ply, dist, target, bone, pos = tbl[1], tbl[2], tbl[3], tbl[4], tbl[5], tbl[6]
			local phys = ent:GetPhysicsObjectNum(bone)
			if not phys then
				heldents[i] = nil
				return
			end

			local TargetPos = phys:GetPos()
			if pos then TargetPos = ent:LocalToWorld(pos) end
			local vec = target - TargetPos
			local len, mul = vec:Length(), ent:GetPhysicsObject():GetMass()
			vec:Normalize()
			local avec, velo = vec * len, phys:GetVelocity() - ply:GetVelocity()
			local Force = (avec - velo / 10) * (bone > 3 and mul / 10 or mul)
			--слушай а это вообще прикольнее даже чем у кета
			if math.abs((tbl[2]:GetPos() - tbl[1]:GetPos()):Length()) < 80 and tbl[2]:GetGroundEntity() ~= tbl[1] then
				if tbl[6] then
					phys:ApplyForceOffset(Force, ent:LocalToWorld(pos))
				else
					phys:ApplyForceCenter(Force)
				end

				phys:ApplyForceCenter(Vector(0, 0, mul))
				phys:AddAngleVelocity(-phys:GetAngleVelocity() / 10)
			else
				heldents[i] = nil
			end
		end
	end)
end

function SWEP:DrawWorldModel()
end

-- no, do nothing
function SWEP:DoBFSAnimation(anim)
end

--local vm = self:GetOwner():GetViewModel()
--vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
function SWEP:UpdateNextIdle()
end

function SWEP:IsEntSoft(ent)
	return ent:IsNPC() or ent:IsPlayer() or RagdollOwner(ent) or ent:IsRagdoll()
end

if CLIENT then
	local BlockAmt = 0
	function SWEP:GetViewModelPosition(pos, ang)

	end
end

hook.Add("ShouldCollide","CustomCollisions",function(ent1,ent2)
    if IsValid(ent1:GetNWEntity("ply")) then
        local ply = ent1:GetNWEntity("ply")

        if IsValid(ply) and ply==ent2 and ent1:IsRagdoll() then return false end
    end
end)

local bone, name
function SWEP:BoneSetAdd(layerID, lookup_name, vec, ang)
	hg.bone.SetAdd(self:GetOwner(), layerID, lookup_name, vec, ang)
end

function SWEP:BoneAdd(layerID, lookup_name, vec, ang)
	hg.bone.Add(self:GetOwner(), layerID, lookup_name, vec, ang)
end

function SWEP:BoneApply(layerID, lookup_name, lerp)
	hg.bone.Apply(self:GetOwner(), layerID, lookup_name, lerp)
end

function SWEP:BoneGet(lookup_name)
	return hg.bone.Get(self:GetOwner(), lookup_name)
end

function SWEP:Animation()
	local owner = self:GetOwner()

	if IsValid(owner.FakeRagdoll) then return end

	local angles = (owner:GetEyeTrace().HitPos - owner:EyePos()):Angle() --:EyeAngles()
	angles:Normalize()

	--self:BoneSetAdd(1,"spine2", Vector(0,0,0), Angle(-10,0,50))
	if CLIENT and LocalPlayer() != self:GetOwner() then return end
	if SERVER then return end
	if CLIENT and GetViewEntity() != LocalPlayer() then return end

	if self:GetFists() and not self:GetBlocking() and (self:LastShootTime() - CurTime() + 0.35 > 0) then
		self:BoneSetAdd(1,"r_clavicle", Vector(0,0,0), Angle(0,10,40))
		self:BoneSetAdd(1,"l_clavicle", Vector(0,0,0), Angle(-30,30,-70))
		self:BoneSetAdd(1,"l_upperarm", Vector(0,0,0), Angle(0,-10,10))
	end
	
end