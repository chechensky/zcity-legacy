-- Path scripthooked:lua\\weapons\\weapon_traitor_poison1.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_base"
SWEP.PrintName = "Tetrodotoxin syringe"
SWEP.Instructions = "Tetrodotoxin is a strong poison that was found by a japanese scientist in 1906. Death occurs from paralysis of the respiratory muscles. Can only be injected in the spinal nerves."
SWEP.Category = "ZCity Other"
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
SWEP.HoldType = "normal"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_models/w_jyringe_proj.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_poisonneedle")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_poisonneedle"
	SWEP.BounceWeaponIcon = false
end

SWEP.Weight = 3
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 3
SWEP.SlotPos = 4
SWEP.WorkWithFake = false
SWEP.offsetVec = Vector(5, -1.5, -0.6)
SWEP.offsetAng = Angle(0, 0, 0)
SWEP.ModelScale = 0.5

if SERVER then
    function SWEP:OnRemove() end
end

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

function SWEP:Think()
	self:SetHold(self.HoldType)
end

SWEP.traceLen = 5

local function eyeTrace(self, ply)
	local ent = hg.GetCurrentCharacter(ply)
	local att = ent:LookupAttachment("eyes")
	if att then
		att = ent:GetAttachment(att)
	else
		local tr = {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:GetAimVector() * 24 * self.traceLen ^ 0.25,
			filter = ent
		}
		return util.TraceLine(tr)
	end

	local tr = {}
	tr.start = att.Pos
	tr.endpos = att.Pos + ply:GetAimVector() * 24 * self.traceLen ^ 0.25
	tr.filter = ent
	return util.TraceLine(tr)
end

function SWEP:GetEyeTrace()
	return eyeTrace(self, self:GetOwner())
end

local caninjectbone = {
    ["ValveBiped.Bip01_Spine"] = true,
    ["ValveBiped.Bip01_Spine1"] = true,
    ["ValveBiped.Bip01_Spine2"] = true
}

function SWEP:CanInject(ent,bone) 

    local matrix = ent:GetBoneMatrix(ent:TranslatePhysBoneToBone(bone))
    local pos = matrix:GetTranslation()
    local ang = matrix:GetAngles()

    local TrueVec = ( self.Owner:GetPos() - ent:GetPos() ):GetNormalized()
	local LookVec = ent:GetAngles():Forward() * 1
	local DotProduct = LookVec:DotProduct( TrueVec )
	local ApproachAngle=( -math.deg( math.asin(DotProduct) )+90 )

    return ApproachAngle>=120
end

if CLIENT then
	function SWEP:DrawHUD()
		if GetViewEntity() ~= LocalPlayer() then return end
		if LocalPlayer():InVehicle() then return end
        local tr = self:GetEyeTrace()
        local toScreen = tr.HitPos:ToScreen()

        if IsValid(tr.Entity) and (tr.Entity:IsPlayer() or tr.Entity:IsRagdoll())and caninjectbone[tr.Entity:GetBoneName(tr.PhysicsBone)] and self:CanInject(tr.Entity,tr.PhysicsBone) then
            draw.SimpleText( "inject", "DermaLarge", toScreen.x, toScreen.y+25, Color(255,0,0,255), TEXT_ALIGN_CENTER )
            surface.SetDrawColor(195,0,0,155)
            surface.DrawRect(toScreen.x-2.5, toScreen.y-2.5, 5, 5)
        else
            surface.SetDrawColor(255,255,255,155)
            surface.DrawRect(toScreen.x-2.5, toScreen.y-2.5, 5, 5)
        end
	end
end

function SWEP:DoPoison(ply)
    local org = ply.organism
    local Owner = self:GetOwner()
    local wep = self
    org.poison1 = true

    Owner:EmitSound("snd_jack_hmcd_needleprick.wav",30)

    timer.Create( "orgPoison1first"..org.owner:EntIndex(), math.random(20,40), 1, function()
        if IsValid(org.owner) and org.owner:IsPlayer() and org.owner:Alive() then
            local updatedOrg = org.owner.organism
            if updatedOrg and updatedOrg.poison1 then
                updatedOrg.owner:EmitSound( ( ThatPlyIsFemale(org.owner) and "vo/npc/female01/moan0"..math.random(5)..".wav" ) or "vo/npc/male01/moan0"..math.random(5)..".wav")
            end
        end
    end)

    timer.Create( "orgPoison1second"..org.owner:EntIndex(), math.random(50,60), 1, function()
        if IsValid(org.owner) and org.owner:IsPlayer() and org.owner:Alive() then
            local updatedOrg = org.owner.organism
            if updatedOrg and updatedOrg.poison1 then
                updatedOrg.owner:TakeDamage(1,Owner,Owner)

                updatedOrg.owner:Kill()
            end
        end
    end)

    self:Remove()
end
if SERVER then
    hook.Add("Org Clear", "RemovePoison1", function(org)
        org.poison1 = false
    end)
end

function SWEP:SecondaryAttack()
end

function SWEP:Initialize()
	self:SetHold(self.HoldType)
end

function SWEP:PrimaryAttack()
	if SERVER then
        local tr = self:GetEyeTrace()

        if IsValid(tr.Entity) and (tr.Entity:IsPlayer() or tr.Entity:IsRagdoll())and caninjectbone[tr.Entity:GetBoneName(tr.PhysicsBone)] and self:CanInject(tr.Entity,tr.PhysicsBone) then
            local ply = tr.Entity
            if IsValid(ply) then
                self:DoPoison(ply)
            end
        end
	end
end

function SWEP:Reload()
end
