-- Path scripthooked:lua\\weapons\\weapon_traitor_ied.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_base"
SWEP.PrintName = "Improvised Explosive Device"
SWEP.Instructions = "A handmade C4 explosive put in a small cardboard box. The detonator is an old nokia phone. Put the bomb in different objects for shrapnel or fire. LMB to place in an object, RMB to simply place the bomb. LMB to activate it after it's put."
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
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_ied")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_ied"
	SWEP.BounceWeaponIcon = false
end

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.WorkWithFake = false
SWEP.offsetVec = Vector(3, -3, 0)
SWEP.offsetAng = Angle(0, 0, 0)
SWEP.ModelScale = 0.4

SWEP.traceLen = 5

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

local function eyeTrace(self, ply)
	local ent = hg.GetCurrentCharacter(ply)
	local att = ent:LookupAttachment("eyes")
	if att then
		att = ent:GetAttachment(att)
	else
		local tr = {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:GetAimVector() * 32 * self.traceLen ^ 0.25,
			filter = ent
		}
		return util.TraceLine(tr)
	end

	local tr = {}
	tr.start = att.Pos
	tr.endpos = att.Pos + ply:GetAimVector() * 32 * self.traceLen ^ 0.25
	tr.filter = ent
	return util.TraceLine(tr)
end

function SWEP:GetEyeTrace()
	return eyeTrace(self, self:GetOwner())
end

SWEP.BlastDis = 5
SWEP.BlastDamage = 150
SWEP.KABOOM = false

SWEP.SoundFar = "iedins/ied_detonate_dist_01.wav"
SWEP.Sound = "iedins/ied_detonate_far_dist_01.wav"
SWEP.SoundWater = "iedins/water/ied_water_detonate_01.wav"

local FireEnts = {
    ["models/props_c17/oildrum001_explosive.mdl"] = true,
    ["models/props_junk/gascan001a.mdl"] = true,
    ["models/props_junk/propane_tank001a.mdl"] = true,
    ["models/props_c17/canister02a.mdl"] = true,
    ["models/props_c17/canister_propane01a.mdl"] = true,
    ["models/props_c17/canister_propane01a.mdl"] = true,
    ["models/props_junk/PropaneCanister001a.mdl"] = true
}

if CLIENT then
	function SWEP:DrawHUD()
		if GetViewEntity() ~= LocalPlayer() then return end
		if LocalPlayer():InVehicle() then return end
        local tr = self:GetEyeTrace()
        local toScreen = tr.HitPos:ToScreen()

        surface.SetDrawColor(255,255,255,155)
        surface.DrawRect(toScreen.x-2.5, toScreen.y-2.5, 5, 5)

        if IsValid(tr.Entity) then
            --draw.SimpleText( "Plant into Object", "DermaLarge", toScreen.x, toScreen.y+25, color_white, TEXT_ALIGN_CENTER )
        end
	end
end

local function ExplodeTheItem(self,ent)
    if not IsValid(ent) then self:Remove() end
    local EntPos = ent:GetPos() + ent:OBBCenter()
    self.KABOOM = true
    local BlastDamage = self.BlastDamage
    local BlastDis = self.BlastDis
    local owner = self:GetOwner()
    ent:EmitSound("nokia.mp3",75,100,1,CHAN_AUTO)
    timer.Simple(0.4,function()
        if not IsValid(ent) then return end
        timer.Simple(0.1,function()
            net.Start("projectileFarSound")
                net.WriteString(self.Sound)
                net.WriteString(self.SoundFar)
                net.WriteVector(EntPos)
                net.WriteEntity(ent)
                net.WriteBool(ent:WaterLevel() > 0)
                net.WriteString(self.SoundWater)
            net.Broadcast()

            local effectdata = EffectData()
            effectdata:SetOrigin(ent:GetPos())
            effectdata:SetScale(3)
            effectdata:SetNormal(-ent:GetAngles():Forward())
            util.Effect("eff_jack_genericboom", effectdata)
            hg.ExplosionEffect(EntPos, self.BlastDis / 0.2, 80)

            local mat = ent:GetMaterialType()
            if mat == MAT_METAL then
                local Poof=EffectData()
                Poof:SetOrigin(EntPos)
                Poof:SetScale(1)
                util.Effect("eff_jack_hmcd_shrapnel",Poof,true,true)
            end
        end)

        timer.Simple(0.2,function()
            if not IsValid(ent) then self:Remove() return end
            util.BlastDamage(self, Entity(0), EntPos, BlastDis / 0.01905, BlastDamage * 1)
            hgWreckBuildings(ent, EntPos, BlastDamage / 100, BlastDis/8, false)
            hgBlastDoors(ent, EntPos, BlastDamage / 100, BlastDis/8, false)

            local mat = ent:GetMaterialType()
            if mat == MAT_METAL then

                local vecCone = Vector(5, 5, 0)
				local bullet = {}
				bullet.Src = EntPos
				bullet.Spread = vecCone
				bullet.Force = 0.01
				bullet.Damage = BlastDamage
				bullet.AmmoType = "12/70 gauge"
				bullet.Attacker = Entity(0)
				bullet.Distance = 205
				for i = 1, math.Round(ent:GetPhysicsObject():GetMass() * 200) do
					bullet.Dir = vector_up * 1
					bullet.Spread = vecCone
                    ent.PenetrationCopy = 4
					ent:FireBullets(bullet, true)
				end
            end

            if FireEnts[ent:GetModel()] then
                local fire = ents.Create("ent_hg_fire")
                fire:SetPos(EntPos)
                fire:Spawn()
                fire:Activate()
            end

            ent:Remove()
            if IsValid(self) then
                self:Remove()
            end
        end)
    end)
end

function SWEP:SecondaryAttack()
	if SERVER then
        if not self.Planted then
            local Owner = self:GetOwner()
            local Tr = self:GetEyeTrace()

            local bomb = ents.Create("prop_physics")
            bomb:SetModel("models/props_junk/cardboard_jox004a.mdl")
            bomb:SetPos(Tr.HitPos)
            bomb:SetModelScale(0.4)
            bomb:Spawn()
            bomb:Activate()

            if IsValid(bomb:GetPhysicsObject()) then
                bomb:GetPhysicsObject():SetMass(20)
            end

            self.Planted = true
            self.HaveTheBomb = bomb

            self.WorldModel = "models/saraphines/insurgency explosives/ied/insurgency_ied_phone.mdl"

            net.Start("ied_have_the_bomb")
            net.WriteEntity(self)
            net.Broadcast()
            
            Owner:EmitSound("snd_jack_hmcd_bombrig.wav",40,100,1,CHAN_AUTO)
            self.nextattackhuy = CurTime() + 2
        end
	end
end

function SWEP:Initialize()
	self:SetHold(self.HoldType)
    self.Planted = false
    self.HaveTheBomb = false
    self.WorldModel = "models/props_junk/cardboard_jox004a.mdl"
end

function SWEP:PrimaryAttack()
    if CLIENT and LocalPlayer() == self:GetOwner() then
        net.Start("ied_primary_attack")
        net.WriteEntity(self)
        net.SendToServer()
    end
end

if CLIENT then
    net.Receive("ied_have_the_bomb",function(len)
        local self = net.ReadEntity()

        self.WorldModel = "models/saraphines/insurgency explosives/ied/insurgency_ied_phone.mdl"
        if IsValid(self.model) then
            self.model:Remove()
            self.model = nil
        end
        self.model = ClientsideModel(self.WorldModel)
        self.model:SetSkin(1)
        self.offsetVec = Vector(5, 0.5, -15)
        self.offsetAng = Angle(0, 70, 180)
        self.ModelScale = 1
    end)
end

if SERVER then
    util.AddNetworkString("ied_primary_attack")
    util.AddNetworkString("ied_have_the_bomb")
    SWEP.nextattackhuy = 0

    net.Receive("ied_primary_attack",function()
        net.ReadEntity():AttackHuy()
    end)

    function SWEP:AttackHuy()
        if not (self.Planted or self.HaveTheBomb) then
            local Owner = self:GetOwner()
            local Tr = self:GetEyeTrace()
            
            if IsValid(Tr.Entity) and IsValid(Tr.Entity:GetPhysicsObject()) and Tr.Entity:GetPhysicsObject():GetMass() < 80 then
                bomb = Tr.Entity

                self.Planted = true
                self.HaveTheBomb = bomb

                self.WorldModel = "models/saraphines/insurgency explosives/ied/insurgency_ied_phone.mdl"

                net.Start("ied_have_the_bomb")
                net.WriteEntity(self)
                net.Broadcast()

                Owner:EmitSound("snd_jack_hmcd_bombrig.wav",40,100,1,CHAN_AUTO)
                self:SetNextPrimaryFire(CurTime()+2)
                self.nextattackhuy = CurTime() + 2
                return
            end
        end

        if (self.nextattackhuy or 0) <= CurTime() and self.Planted and self.HaveTheBomb and not self.KABOOM then
            ExplodeTheItem(self,self.HaveTheBomb)
            self:EmitSound("keypad"..math.random(1,3)..".mp3")
            self.HaveTheBomb = nil
        end
    end
end

function SWEP:Reload()
end
