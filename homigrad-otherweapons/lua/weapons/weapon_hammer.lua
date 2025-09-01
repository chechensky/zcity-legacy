-- Path scripthooked:lua\\weapons\\weapon_hammer.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "Hammer"
SWEP.Instructions = "A regular household hammer, which has a blunt and a sharp side. Use it to block off paths or restrict someone from moving. E+LMB - Change mode, RMB - Nail"
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Ammo = "Nails"
SWEP.Primary.Damage = 8
SWEP.Primary.Wait = 1.5
SWEP.Primary.Next = 0
--__settings__--
SWEP.fastHitAllow = false
SWEP.HoldType = "knife"
SWEP.DamageType = DMG_CLUB
SWEP.animation = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.Penetration = 2
SWEP.traceOffsetAng = Angle(70, -5, 0)
SWEP.traceOffsetVec = Vector(3, .5, 0)
SWEP.traceLen = 12
SWEP.offsetVec = Vector(0, -1.5, -1.5)
SWEP.offsetAng = Angle(10, 0, 170)
SWEP.attacktime = 0.2
SWEP.swing = true
SWEP.swingang = Angle(0, 0, 5)
SWEP.HitSound = "Flesh.ImpactHard"
SWEP.HitSound2 = "Flesh.ImpactHard"
SWEP.HitWorldSound = "Concrete.ImpactHard"
SWEP.BreakBoneMul = 1

SWEP.weaponInvCategory = 3

SWEP.DeploySnd = "physics/metal/metal_solid_impact_soft1.wav"
SWEP.HolsterSnd = ""

SWEP.r_forearm = Angle(0, 15, 0)
SWEP.r_upperarm = Angle(5, -60, 15)
SWEP.r_hand = Angle(0, 0, 0)
SWEP.l_forearm = Angle(0, 45, 0)
SWEP.l_upperarm = Angle(35, 25, 0)

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_hammer")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_hammer"
	SWEP.BounceWeaponIcon = false
end

--
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_jjife_t.mdl"
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.WorkWithFake = true
SWEP.angHold = Angle(0, 0, 0)
SWEP.UnNailables={MAT_METAL,MAT_SAND,MAT_SLOSH,MAT_GLASS}

game.AddDecal("hmcd_jackanail","decals/mat_jack_hmcd_nailhead")

local function Circle(x, y, radius, seg)
	local cir = {}
	table.insert(cir, {
		x = x,
		y = y,
		u = 0.5,
		v = 0.5
	})

	for i = 0, seg do
		local a = math.rad((i / seg) * -360)
		table.insert(cir, {
			x = x + math.sin(a) * radius,
			y = y + math.cos(a) * radius,
			u = math.sin(a) / 2 + 0.5,
			v = math.cos(a) / 2 + 0.5
		})
	end

	local a = math.rad(0)
	table.insert(cir, {
		x = x + math.sin(a) * radius,
		y = y + math.cos(a) * radius,
		u = math.sin(a) / 2 + 0.5,
		v = math.cos(a) / 2 + 0.5
	})

	surface.DrawPoly(cir)
end

local colWhite = Color(255, 255, 255, 255)
local colGray = Color(200, 200, 200, 200)
local OffsetPos = {290,220}
if CLIENT then
    local Mat = surface.GetTextureID("vgui/hud/hmcd_nail")
    function SWEP:DrawHUD() 

        surface.SetDrawColor(255,255,255,255)
        surface.SetTexture(Mat)
        surface.DrawTexturedRect(ScrW()-300,ScrH()-250,200,150)

        local Owner = self:GetOwner()
        local Text = "+ "..Owner:GetAmmoCount(self.Primary.Ammo)
        surface.SetFont( "DermaLarge" )
	    surface.SetTextColor( 0, 0, 0)
	    surface.SetTextPos( ScrW() - OffsetPos[1]+2, ScrH() - OffsetPos[2]+2 ) 
	    surface.DrawText( Text )

	    surface.SetTextColor( 255, 255, 255 )
	    surface.SetTextPos( ScrW() - OffsetPos[1], ScrH() - OffsetPos[2] ) 
	    surface.DrawText( Text )

        if GetViewEntity() ~= LocalPlayer() then return end
        if LocalPlayer():InVehicle() then return end
        local Tr = self:GetWeaponTrace()
        --[[cam.Start3D()
            render.DrawLine(Tr.StartPos,Tr.HitPos,color_white)
        cam.End3D()--]]
        local Size = math.max(math.min(1 - Tr.Fraction, 0.5), 0.1)
        local x, y = Tr.HitPos:ToScreen().x, Tr.HitPos:ToScreen().y
        if Tr.Hit then
            surface.SetDrawColor(colGray)
            draw.NoTexture()
            Circle(x, y, 55 * Size, 32)
            surface.SetDrawColor(colWhite)
            draw.NoTexture()
            Circle(x, y, 40 * Size, 32)
            local col = Tr.Entity:IsPlayer() and Tr.Entity:GetPlayerColor():ToColor() or colWhite
            col.a = 255 * Size * 2
            draw.DrawText(Tr.Entity:IsPlayer() and Tr.Entity:Name() or Tr.Entity:GetNWString("Nickname") or "", "HomigradFontLarge", x, y + 30, col, TEXT_ALIGN_CENTER)
        end

        local Owner = self:GetOwner()
		local toScreen = self:GetEyeTrace().HitPos:ToScreen()
		for i=1,10 do
			surface.DrawCircle(toScreen.x, toScreen.y, 15-i, 155-i*15,155-i*15,155-i*15,205)
		end
    end
end

local function BindObjects(ent1,pos1,ent2,pos2,power,bone1,bone2)
	ent1.Nails = ent1.Nails or {}
	ent2.Nails = ent2.Nails or {}
	
	if not ent1.Nails[bone1] then
		local weld = constraint.Weld(ent1,ent2,bone1 or 0,bone2 or 0,5000,false,false)
		if weld then
    		ent1.Nails[bone1] = {weld,1}
			weld:CallOnRemove("removefromtbl",function() ent1.Nails[bone1] = nil end)
		end
	else
		ent1.Nails[bone1][2] = ent1.Nails[bone1][2] + 1
	end

	if not ent2.Nails[bone2] then
		local weld = constraint.Weld(ent1,ent2,bone1 or 0,bone2 or 0,5000,false,false)
		if weld then
    		ent2.Nails[bone2] = {weld,1}
			weld:CallOnRemove("removefromtbl",function() ent2.Nails[bone2] = nil end)
		end
	else
		ent2.Nails[bone2][2] = ent2.Nails[bone2][2] + 1
	end

	return ent1:IsWorld() and ent2.Nails[bone2][2] or ent1.Nails[bone1][2]
end

function hgCheckBindObjects(ent1)
	if not ent1.Nails then return end

    return ( ent1.Nails and ent1.Nails[0] and #ent1.Nails[0]) or 0
end

SWEP.modeNames = {[true] = "blunt",[false] = "sharp"}

function SWEP:PrimaryAttack()
	if CLIENT and not IsFirstTimePredicted() then return end
	if self:LastShootTime() + self.attackWait > CurTime() then return end
	if self:KeyDown(IN_USE) and not IsValid(self:GetOwner().FakeRagdoll) then return end

	self:SetLastAttack(CurTime())
	self:SetLastShootTime(CurTime())
	self.shouldHit = true
	self.shouldHit2 = true
	self.power = self.mode and 1 or 0.5
	self.attacksound = self.HitSound
	self.DamageType = self.mode and DMG_CLUB or DMG_SLASH
	if SERVER then self:EmitSound("weapons/slam/throw.wav", 50, 100, 0.1) end
	self:GetOwner():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.animation, true)
	if SERVER then
		net.Start("hg_attack")
		net.WriteEntity(self)
		net.WriteInt(self.animation,32)
		net.Broadcast()
	end
	if SERVER and IsValid(self:GetOwner().FakeRagdoll) then
		local ragdoll = self:GetOwner().FakeRagdoll
		local rh = ragdoll:GetPhysicsObjectNum(hg.realPhysNum(ragdoll, 7))

		rh:ApplyForceCenter(self:GetOwner():EyeAngles():Forward() * 5000)
	end
end

if SERVER then
	hook.Add("Should Fake Up","DuctTaped",function(ply)
		if ply and IsValid(ply.FakeRagdoll) then
			local Nails = ply.FakeRagdoll.Nails

			if Nails then
				for i,tbl in pairs(Nails) do
					if tbl[2] > 0 then
						tbl[2] = tbl[2] - 0.05
						--ply.FakeRagdoll:EmitSound("tape_friction"..math.random(3)..".mp3",65)
						if tbl[2] <= 0 then
							if IsValid(Nails[i][1]) then
								Nails[i][1]:Remove()
								Nails[i][1] = nil
							end
							Nails[i] = nil
						end
					end
				end

				if table.Count(Nails) > 0 then
					return false
				end
			end
		end
	end)
end

function SWEP:SprayDecals()
    local Owner = self:GetOwner()
	local Tr=util.QuickTrace(Owner:GetShootPos(),Owner:GetAimVector()*70,{Owner})
	util.Decal("hmcd_jackanail",Tr.HitPos+Tr.HitNormal,Tr.HitPos-Tr.HitNormal)

	local Tr2=util.QuickTrace(Owner:GetShootPos(),(Owner:GetAimVector()+Vector(0,0,.15))*70,{Owner})
	util.Decal("hmcd_jackanail",Tr2.HitPos+Tr2.HitNormal,Tr2.HitPos-Tr2.HitNormal)

	local Tr3=util.QuickTrace(Owner:GetShootPos(),(Owner:GetAimVector()+Vector(0,0,-.15))*70,{Owner})
	util.Decal("hmcd_jackanail",Tr3.HitPos+Tr3.HitNormal,Tr3.HitPos-Tr3.HitNormal)

	local Tr4=util.QuickTrace(Owner:GetShootPos(),(Owner:GetAimVector()+Vector(0,.15,0))*70,{Owner})
	util.Decal("hmcd_jackanail",Tr4.HitPos+Tr4.HitNormal,Tr4.HitPos-Tr4.HitNormal)

	local Tr5=util.QuickTrace(Owner:GetShootPos(),(Owner:GetAimVector()+Vector(0,-.15,0))*70,{Owner})
	util.Decal("hmcd_jackanail",Tr5.HitPos+Tr5.HitNormal,Tr5.HitPos-Tr5.HitNormal)

	local Tr6=util.QuickTrace(Owner:GetShootPos(),(Owner:GetAimVector()+Vector(.15,0,0))*70,{Owner})
	util.Decal("hmcd_jackanail",Tr6.HitPos+Tr6.HitNormal,Tr6.HitPos-Tr6.HitNormal)

	local Tr7=util.QuickTrace(Owner:GetShootPos(),(Owner:GetAimVector()+Vector(-.15,0,0))*70,{Owner})
	util.Decal("hmcd_jackanail",Tr7.HitPos+Tr7.HitNormal,Tr7.HitPos-Tr7.HitNormal)
end

function SWEP:ChangedMode(mode)
	if mode then
		self.offsetAng = Angle(10, 0, 170)
		self.offsetVec = Vector(0, -1.5, -1.5)
	else
		self.offsetAng = Angle(50, 180, 190)
		self.offsetVec = Vector(7, -1.5, 1)
	end
end

function SWEP:CanNail(Tr)
    local Owner = self:GetOwner()
	return (Owner:GetAmmoCount(self.Primary.Ammo)>0) and (Tr.Hit) and (Tr.Entity) and ((IsValid(Tr.Entity)) or (Tr.Entity:IsWorld())) and not ((Tr.Entity:IsPlayer())or(Tr.Entity:IsNPC())) and not (table.HasValue(self.UnNailables,Tr.MatType))
end

function SWEP:SecondaryAttack()
	if CLIENT then return end

	if self:LastShootTime() + 2 > CurTime() then return end
	local Tr = self:GetEyeTrace()

	if not self.mode then
		if Tr.Entity.Nails and Tr.Entity.Nails[Tr.PhysicsBone] then
			self:GetOwner():EmitSound("nail_pull.mp3",65,100,1,CHAN_AUTO)
			timer.Simple(2,function()
				local tbl = Tr.Entity.Nails[Tr.PhysicsBone]
				if tbl then
					if IsValid(tbl[1]) then
						tbl[1]:Remove()
						tbl[1] = nil
					end

					Tr.Entity.Nails[Tr.PhysicsBone] = nil

					self:GetOwner():SetAmmo(self:GetOwner():GetAmmoCount(self.Primary.Ammo)+1,self.Primary.Ammo)
				end
			end)
			self:SetLastShootTime(CurTime())
		end
	else
		local Owner = self:GetOwner()
		if Owner:KeyDown(IN_SPEED) then return end

		if not (Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
			return
		end

		local AimVec = Owner:GetAimVector()
		local Tr = self:GetEyeTrace()

		if(self:CanNail(Tr))then
			
			local NewTr,NewEnt=util.QuickTrace(Tr.HitPos,AimVec*20,{Owner,Tr.Entity}),nil

			if(self:CanNail(NewTr))then
				
				if not NewTr.HitSky then NewEnt = NewTr.Entity end
				if ( NewEnt ) and ((IsValid(NewEnt)) or (NewEnt:IsWorld())) and not ((NewEnt:IsPlayer()) or (NewEnt:IsNPC()) or (NewEnt==Tr.Entity)) then
					if hgIsDoor(Tr.Entity) then
						if Owner:GetAmmoCount(self.Primary.AmmoType) > 2 then
							Tr.Entity:Fire("lock","",0)
							self:TakePrimaryAmmo(3)

							sound.Play("snd_jack_hmcd_hammerhit.wav",Tr.HitPos,65,math.random(90,110))
							self:SprayDecals()

							Owner:PrintMessage(HUD_PRINTCENTER,"Door Sealed")
							Owner:ViewPunch(Angle(3,0,0))
							Owner:SetAnimation(PLAYER_ATTACK1)
						else
							Owner:PrintMessage(HUD_PRINTCENTER,"Need at least 3 nails to seal door.")
						end

					else
						if Tr.Entity:IsRagdoll() then
							local DmgInfo = DamageInfo()
							DmgInfo:SetDamage(5)
							DmgInfo:SetDamageType(DMG_SLASH)
							DmgInfo:SetDamageForce(AimVec * 5)
							DmgInfo:SetDamagePosition(Tr.HitPos)
							DmgInfo:SetInflictor(self)
							DmgInfo:SetAttacker(self:GetOwner())
							Tr.Entity:TakeDamageInfo(DmgInfo)
						end

						if NewEnt:IsRagdoll() then
							local DmgInfo = DamageInfo()
							DmgInfo:SetDamage(5)
							DmgInfo:SetDamageType(DMG_SLASH)
							DmgInfo:SetDamageForce(AimVec * 5)
							DmgInfo:SetDamagePosition(NewTr.HitPos)
							DmgInfo:SetInflictor(self)
							DmgInfo:SetAttacker(self:GetOwner())
							NewEnt:TakeDamageInfo(DmgInfo)
						end

						local Strength, Weld = BindObjects( Tr.Entity, Tr.HitPos, NewEnt, NewTr.HitPos, 3.5, Tr.PhysicsBone or 0, NewTr.PhysicsBone or 0)
						--print(Tr.Entity,Weld)
						if Weld or Weld == nil then
							self:TakePrimaryAmmo(1)
						end

						sound.Play("snd_jack_hmcd_hammerhit.wav",Tr.HitPos,65,math.random(90,110))
						util.Decal("hmcd_jackanail",Tr.HitPos+Tr.HitNormal,Tr.HitPos-Tr.HitNormal)

						Owner:PrintMessage(HUD_PRINTCENTER,"Bond strength: "..tostring(Strength))
						Owner:ViewPunch(Angle(3,0,0))
						Owner:SetAnimation(PLAYER_ATTACK1)

					end
				end
			end
		end
		
		self:SetNextSecondaryFire(CurTime()+2.5)
		self:SetNextPrimaryFire(CurTime()+2.5)
	end
end

function SWEP:Initialize()
	self.ammogive = 3
end

function SWEP:OwnerChanged()
	if SERVER and IsValid(self:GetOwner()) then
		self:GetOwner():SetAmmo(self:GetOwner():GetAmmoCount(self.Primary.Ammo)+self.ammogive,self.Primary.Ammo)
		self.ammogive = 0
	end
end