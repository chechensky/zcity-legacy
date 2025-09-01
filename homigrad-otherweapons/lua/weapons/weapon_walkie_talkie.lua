-- Path scripthooked:lua\\weapons\\weapon_walkie_talkie.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_base"
SWEP.PrintName = "Walkie-talkie"
SWEP.Instructions = "Use the walkie-talkie to communicate with other people in the 4km radius. Must be on the same frequency."
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
SWEP.WorldModel = "models/sirgibs/ragdoll/css/terror_arctic_radio.mdl"
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_walkietalkie")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_walkietalkie.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 5
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.offsetVec = Vector(4, -8, -42)
SWEP.offsetAng = Angle(0, 180, 0)

SWEP.Frequency = 1
SWEP.Frequencies =  {
    "88.6 MHz",
    "92.3 MHz",
    "97.5 MHz",
    "101.8 MHz",
    "107.8 MHz"
}

function SWEP:BippSound(ent,pitch)
    ent:EmitSound("radio/voip_end_transmit_beep_0" .. math.random(1,8) .. ".wav",35,pitch)
end

if SERVER then

    function SWEP:CanLisen(output,input,isChat)
		if not IsValid(output) or not IsValid(input) then return end
        if not output:Alive() or output.organism.Otrub or not input:Alive() or input.organism.Otrub then return false end
        if not input:HasWeapon("weapon_walkie_talkie") then return end
        if output:GetActiveWeapon() ~= self then return end

        if output:GetWeapon("weapon_walkie_talkie").Frequency == input:GetWeapon("weapon_walkie_talkie").Frequency or output:Team() == 1002 then return true end
    end

    hook.Add("ChatingCanLisen","radio",function(output,input,isChat,teamonly,text)
        local wep = output:GetWeapon("weapon_walkie_talkie")

		if not IsValid(wep) then return end
        if wep:CanLisen(output,input,isChat) then
            if isChat then
				wep:BippSound(output,100)
                if not wep:CanLisen(output,input,isChat) then return end
				if output == input then wep:BippSound(output,100) return end
                    
                wep:BippSound(input,100)
				if input:GetPos():DistToSqr(output:GetPos()) < 600000 and not output.organism.Otrub and not input.organism.Otrub then
					return true
				else
                    input:ChatPrint("Walkie Talkie: " .. text)
					return false
				end
			else
				if wep:CanLisen(output,input,isChat) then
					return true,false 
				end
            end

            --return true,true
        end
    end)

	hook.Add("StartVoice","radio",function(output)
        local wep = output:GetWeapon("weapon_walkie_talkie")
		if not IsValid(wep) then return end

		for i, input in pairs( player.GetAll() ) do
			if wep:CanLisen(output,input,false) then
				if output == input then wep:BippSound(output,100) continue end
				wep:BippSound(input,100)
				--input:EmitSound( "radio/voip_static_loop.wav",35,100,1 )
			end
		end

    end)

	hook.Add("EndVoice","radio",function(output)
        local wep = output:GetWeapon("weapon_walkie_talkie")
		if not IsValid(wep) then return end

		for i, input in pairs( player.GetAll() ) do
			if wep:CanLisen(output,input,false) then
				if output == input then wep:BippSound(output,100) continue end
				wep:BippSound(input,100)
				--input:StopSound("radio/voip_static_loop.wav")
			end
		end
    end)

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
		local boneid = owner:LookupBone("ValveBiped.Bip01_L_Hand")
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

function SWEP:PrimaryAttack()
	if SERVER then
        self.Frequency = ((self.Frequency <= #self.Frequencies-1) and self.Frequency + 1 or 1) 
        self:GetOwner():ChatPrint( self.Frequencies[self.Frequency] )
	end
end

if CLIENT then
	function SWEP:DrawHUD()
		if GetViewEntity() ~= LocalPlayer() then return end
		if LocalPlayer():InVehicle() then return end
	end
end

function SWEP:Initialize()
	self:SetHold(self.HoldType)
end

function SWEP:SecondaryAttack()
	if SERVER then
        self.Frequency = ( (self.Frequency > 1) and self.Frequency - 1 or #self.Frequencies )
        self:GetOwner():ChatPrint( self.Frequencies[self.Frequency] )
	end
end

function SWEP:Reload()
end

if SERVER then
	function SWEP:SetFakeGun(ent)
		self:SetNWEntity("fakeGun", ent)
		self.fakeGun = ent
	end

	function SWEP:RemoveFake()
		if not IsValid(self.fakeGun) then return end
		self.fakeGun:Remove()
		self:SetFakeGun()
	end

	SWEP.RHandPos = Vector(0,0,0)
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
		vec:Set(-self.RHandPos or vector_origin)
		vec:Rotate(ent:GetAngles())
		rh:SetPos(ent:GetPos() + vec)
	end

	function SWEP:RagdollFunc(pos, angles, ragdoll)
		shadowControl = shadowControl or hg.ShadowControl
		local fakeGun = ragdoll.fakeGun
		pos:Add(angles:Forward() * 20)
		angles:RotateAroundAxis(angles:Forward(), 180)
		shadowControl(ragdoll, 7, 0.001, angles, 55500, 30, pos, 1000, 100)
		angles:RotateAroundAxis(angles:Forward(), -180)
		pos:Add(angles:Up() * -43)
		pos:Add(angles:Right() * -9)
		pos:Add(angles:Forward() * 2)

		shadowControl(fakeGun, 0, 0.001, angles, 100, 90, pos, 1000, 900)

	end
end