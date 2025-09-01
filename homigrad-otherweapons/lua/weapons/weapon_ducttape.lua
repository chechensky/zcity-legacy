-- Path scripthooked:lua\\weapons\\weapon_ducttape.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Duct Tape"
SWEP.Instructions = "A household duct tape. Use it to block off paths or restrict someone from moving."
SWEP.Category = "ZCity Other"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Damage = 8
SWEP.Primary.Wait = 1.5
SWEP.Primary.Next = 0
--__settings__--
SWEP.fastHitAllow = false
SWEP.HoldType = "slam"
SWEP.DamageType = DMG_CLUB
SWEP.Penetration = 2
SWEP.traceOffsetAng = Angle(70, -5, 0)
SWEP.traceOffsetVec = Vector(3, .5, 0)
SWEP.traceLen = 12
SWEP.offsetVec = Vector(4, -3.5, -1.5)
SWEP.offsetAng = Angle(90, 180, 0)
SWEP.attacktime = 1.3
SWEP.swing = true
SWEP.swingang = Angle(0, 0, 5)
SWEP.HitSound = "Flesh.ImpactHard"
SWEP.HitSound2 = "Flesh.ImpactHard"
SWEP.HitWorldSound = "Concrete.ImpactHard"
SWEP.BreakBoneMul = 0.5

SWEP.r_forearm = Angle(0, 15, 0)
SWEP.r_upperarm = Angle(5, -60, 15)
SWEP.r_hand = Angle(0, 0, 0)
SWEP.l_forearm = Angle(0, 0, 0)
SWEP.l_upperarm = Angle(0, 0, 0)

SWEP.weaponInvCategory = false

SWEP.DeploySnd = "physics/body/body_medium_impact_soft5.wav"
SWEP.HolsterSnd = ""

SWEP.modeNames = {[true] = "huy",[false] = "chlen"}

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_ducttape")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_ducttape"
	SWEP.BounceWeaponIcon = false
end

--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_phx/wheels/drugster_front.mdl"
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.WorkWithFake = false
SWEP.angHold = Angle(0, 0, 0)
SWEP.UnTapeables = { MAT_SAND,MAT_SLOSH,MAT_SNOW}
SWEP.TapeAmount = 100

game.AddDecal("hmcd_jackatape","decals/mat_jack_hmcd_ducttape")

function SWEP:DrawWorldModel()
	self.model = self.model or ClientsideModel(self.WorldModel)
	local WorldModel = self.model
	local owner = self:GetOwner()
	WorldModel:SetNoDraw(true)
	WorldModel:SetModelScale(0.15)
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

	WorldModel:SetColor(Color(0,0,0))
	WorldModel:SetMaterial("models/shiny")
	
	WorldModel:DrawModel()
end

local colWhite = Color(255, 255, 255, 255)
local colGray = Color(200, 200, 200, 200)
local OffsetPos = {290,220}
if CLIENT then
    local Mat = surface.GetTextureID("vgui/wep_jack_hmcd_ducttape")
    function SWEP:DrawHUD() 

        surface.SetDrawColor(255,255,255,255)
        surface.SetTexture(Mat)
        surface.DrawTexturedRect(ScrW()-350,ScrH()-250,300,150)

        local Owner = self:GetOwner()
		local toScreen = self:GetEyeTrace().HitPos:ToScreen()
		for i=1,10 do
			surface.DrawCircle(toScreen.x, toScreen.y, 55-i, 155-i*15,155-i*15,155-i*15,205)
		end
    end
end

local function BindObjects(ent1,pos1,ent2,pos2,power,bone1,bone2)
	ent1.DuctTape = ent1.DuctTape or {}
	ent2.DuctTape = ent2.DuctTape or {}

	local weld = constraint.Weld(ent1,ent2,bone1,bone2,5000,false,false)
	
	if not ent1.DuctTape[bone1] then
    	ent1.DuctTape[bone1] = {weld,1}
		weld:CallOnRemove("removefromtbl",function() ent1.DuctTape[bone1] = nil end)
	else
		ent1.DuctTape[bone1][2] = ent1.DuctTape[bone1][2] + 1
	end

	if not ent2.DuctTape[bone2] then
    	ent2.DuctTape[bone2] = {weld,1}
		weld:CallOnRemove("removefromtbl",function() ent2.DuctTape[bone2] = nil end)
	else
		ent2.DuctTape[bone2][2] = ent2.DuctTape[bone2][2] + 1
	end

	return ent1:IsWorld() and ent2.DuctTape[bone2][2] or ent1.DuctTape[bone1][2]
end

function hgCheckDuctTapeObjects(ent1)
	if not ent1.DuctTape then return end

    return (ent1.DuctTape and ent1.DuctTape[0] and #ent1.DuctTape[0]) or 0 
end

if SERVER then
	hook.Add("Should Fake Up","DuctTaped",function(ply)
		if ply and IsValid(ply.FakeRagdoll) then
			local dtape = ply.FakeRagdoll.DuctTape

			if dtape then
				for i,tbl in pairs(dtape) do
					if tbl[2] > 0 then
						tbl[2] = tbl[2] - 1
						ply.FakeRagdoll:EmitSound("tape_friction"..math.random(3)..".mp3",65)
						if tbl[2] <= 0 then
							if IsValid(tbl[1]) then
								tbl[1]:Remove()
								tbl[1] = nil
							end
							dtape[i] = nil
						end
						break
					end
				end
				
				if table.Count(dtape) > 0 then
					ply.fakecd = CurTime() + 1
					return false
				end
			end
		end
	end)
end
function SWEP:FindObjects()
	local Owner = self:GetOwner()
	local Pos, Vec, GotOne, Tries, TrOne, TrTwo = self:GetEyeTrace().StartPos, Owner:GetAimVector(), false, 0, nil, nil
	while(not(GotOne)and(Tries<100))do
		local Tr=util.QuickTrace(Pos - Vec * 10,Vec*60+VectorRand()*2,{Owner})
		local FindBone = util.QuickTrace(Pos,Vec*60,{Owner})
		if((Tr.Hit)and not(Tr.HitSky)and not(table.HasValue(self.UnTapeables,Tr.MatType)))then
			GotOne=true
			TrOne=Tr
			TrOne.PhysicsBone = FindBone.PhysicsBone
		end
		Tries=Tries+1
	end
	if(GotOne)then
		GotOne=false
		Tries=0
		while(not(GotOne)and(Tries<100))do
			local Tr=util.QuickTrace(Pos - Vec * 10,Vec*60+VectorRand()*2,{Owner})
			local FindBone = util.QuickTrace(Pos,Vec*60,{Owner})
			if((Tr.Hit)and not(Tr.HitSky)and not(table.HasValue(self.UnTapeables,Tr.MatType))and (Tr.Entity ~= TrOne.Entity))then
				GotOne=true
				TrTwo=Tr
				TrTwo.PhysicsBone = FindBone.PhysicsBone
			end
			Tries=Tries+1
		end
	end
	if((TrOne)and(TrTwo))then return true,TrOne,TrTwo else return false,nil,nil end
end

function SWEP:PrimaryAttack()
	local Owner = self:GetOwner()
	if(Owner:KeyDown(IN_SPEED))then return end
	if(SERVER)then
		local Go,TrOne,TrTwo=self:FindObjects()
		if(Go)then
			local DoorSealed=false
			if(hgIsDoor(TrOne.Entity))then DoorSealed=true;TrOne.Entity:Fire("lock","",0) end
			if(hgIsDoor(TrTwo.Entity))then DoorSealed=true;TrTwo.Entity:Fire("lock","",0) end
			if(DoorSealed)then
				if not(self.TapeAmount)then self.TapeAmount=100 end
				self.TapeAmount=self.TapeAmount-100
				sound.Play("snd_jack_hmcd_ducttape.wav",TrOne.HitPos,65,math.random(80,120))
				Owner:SetAnimation(PLAYER_ATTACK1)
				Owner:ViewPunch(Angle(3,0,0))
				self:SprayDecals()
				Owner:PrintMessage(HUD_PRINTCENTER,"Door Sealed")
				timer.Simple(.1,function() if(self.TapeAmount<=0)then self:Remove() end end)
			else
				local Strength = BindObjects(TrOne.Entity,TrOne.HitPos,TrTwo.Entity,TrTwo.HitPos,2,TrOne.PhysicsBone,TrTwo.PhysicsBone)
				if not(self.TapeAmount)then self.TapeAmount=100 end
				self.TapeAmount=self.TapeAmount-10
				sound.Play("snd_jack_hmcd_ducttape.wav",TrOne.HitPos,65,math.random(80,120))
				Owner:SetAnimation(PLAYER_ATTACK1)
				Owner:ViewPunch(Angle(3,0,0))
				util.Decal("hmcd_jackatape",TrOne.HitPos+TrOne.HitNormal,TrOne.HitPos-TrOne.HitNormal)
				util.Decal("hmcd_jackatape",TrTwo.HitPos+TrTwo.HitNormal,TrTwo.HitPos-TrTwo.HitNormal)
				Owner:PrintMessage(HUD_PRINTCENTER,"Bond strength: "..tostring(Strength))
				timer.Simple(.1,function() if(self.TapeAmount<=0)then self:Remove() end end)
			end
		end
	end

	self:SetNextPrimaryFire(CurTime()+2.5)
end

function SWEP:SprayDecals()
	local Owner = self:GetOwner()
	local Tr=util.QuickTrace(self:GetEyeTrace().StartPos,Owner:GetAimVector()*70,{Owner})
	util.Decal("hmcd_jackatape",Tr.HitPos+Tr.HitNormal,Tr.HitPos-Tr.HitNormal)

	local Tr2=util.QuickTrace(self:GetEyeTrace().StartPos,(Owner:GetAimVector()+Vector(0,0,.15))*70,{Owner})
	util.Decal("hmcd_jackatape",Tr2.HitPos+Tr2.HitNormal,Tr2.HitPos-Tr2.HitNormal)

	local Tr3=util.QuickTrace(self:GetEyeTrace().StartPos,(Owner:GetAimVector()+Vector(0,0,-.15))*70,{Owner})
	util.Decal("hmcd_jackatape",Tr3.HitPos+Tr3.HitNormal,Tr3.HitPos-Tr3.HitNormal)

	local Tr4=util.QuickTrace(self:GetEyeTrace().StartPos,(Owner:GetAimVector()+Vector(0,.15,0))*70,{Owner})
	util.Decal("hmcd_jackatape",Tr4.HitPos+Tr4.HitNormal,Tr4.HitPos-Tr4.HitNormal)

	local Tr5=util.QuickTrace(self:GetEyeTrace().StartPos,(Owner:GetAimVector()+Vector(0,-.15,0))*70,{Owner})
	util.Decal("hmcd_jackatape",Tr5.HitPos+Tr5.HitNormal,Tr5.HitPos-Tr5.HitNormal)

	local Tr6=util.QuickTrace(self:GetEyeTrace().StartPos,(Owner:GetAimVector()+Vector(.15,0,0))*70,{Owner})
	util.Decal("hmcd_jackatape",Tr6.HitPos+Tr6.HitNormal,Tr6.HitPos-Tr6.HitNormal)

	local Tr7=util.QuickTrace(self:GetEyeTrace().StartPos,(Owner:GetAimVector()+Vector(-.15,0,0))*70,{Owner})
	util.Decal("hmcd_jackatape",Tr7.HitPos+Tr7.HitNormal,Tr7.HitPos-Tr7.HitNormal)
end