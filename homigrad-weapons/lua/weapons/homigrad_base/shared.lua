-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\shared.lua"
-- Scripthooked by ???
SWEP.Base = "weapon_base"
SWEP.PrintName = "base_hg"
SWEP.Category = "Other"
SWEP.Spawnable = false
SWEP.AdminOnly = true
SWEP.ReloadTime = 1
SWEP.ReloadSound = "weapons/smg1/smg1_reload.wav"
SWEP.Primary.SoundEmpty = {"weapons/ClipEmpty_Rifle.wav", 75, 100, 105, CHAN_WEAPON, 2}
SWEP.Primary.Wait = 0.1
SWEP.Primary.Next = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.shouldntDrawHolstered = false
hg.weapons = hg.weapons or {}

SWEP.ishgwep = true

SWEP.EyeSprayVel = Angle(0,0,0)

SWEP.ScrappersSlot = "Primary"
--[type_] = {1 = name,2 = dmg,3 = pen,4 = numbullet,5 = RubberBullets,6 = ShockMultiplier,7 = Force},
SWEP.AmmoTypes2 = {
	["12/70 gauge"] = {
		[1] = {"12/70 gauge", 16, 5, 8, false, 2, 16},
		[2] = {"12/70 beanbag", 12, 5, 1, true, 2, 12},
		[3] = {"12/70 Slug", 12, 5, 1, true, 2, 12}
	},
	["9x19 mm Parabellum"] = {
		[1] = {"9x19 mm Parabellum", 25, 7, 1, false, 1, 25},
		[2] = {"9x19 mm Green Tracer", 25, 7, 1, false, 1, 25},
	},
	["5.56x45 mm"] = {
		[1] = {"5.56x45 mm", 44, 7, 1, false, 1, 25},
		[2] = {"5.56x45 mm Red Tracer", 44, 7, 1, false, 1, 25},
		[3] = {"5.56x45 mm AP", 44, 7, 1, false, 1, 25}
	},
}
--function SWEP:PVS_Connect() end
function SWEP:Initialize()
	self:SetLastShootTime(0)
	self.LastPrimaryDryFire = 0
	self:Initialize_Spray()
	self:Initialize_Anim()
	self:Initialize_Reload()
	self:SetClip1(self.Primary.DefaultClip)
	self:Draw()

	self:ClearAttachments()

	self.AmmoTypes = self.AmmoTypes2[self.Primary.Ammo]

	util.PrecacheSound(self.HolsterSnd[1])
	util.PrecacheSound(self.DeploySnd[1])
	util.PrecacheSound(self.Primary.Sound[1])

	--game.AddParticles("particles/tfa_ins2_muzzlesmoke.pcf")
	--PrecacheParticleSystem("tfa_ins2_weapon_muzzle_smoke")
	game.AddParticles("particles/tfa_smoke.pcf")
	PrecacheParticleSystem("smoke_trail_tfa")
	PrecacheParticleSystem("smoke_trail_wild")
	
	hg.weapons[self] = true

	if SERVER then
		self:SetNetVar("attachments",self.attachments)
	end
	--SetNetVar("weapons",hg.weapons)

	if CLIENT then
		self:CallOnRemove("asdasd", function()
			if self.flashlight and self.flashlight:IsValid() then
				self.flashlight:Remove()
				self.flashlight = nil
			end
		end)
	end

	self.init = false
	
	timer.Simple(0.1,function()
		if self.AmmoTypes and SERVER then
			self:ApplyAmmoChanges(1)
		end
	end)

	if SERVER then hg.SyncWeapons() end
	self:InitializePost()
end

SWEP.WepSelectIcon2 = Material("null")
SWEP.IconOverride = ""

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )


	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( self.WepSelectIcon2 )

	surface.DrawTexturedRect( x, y + 10,  256 * ScrW()/1920 , 128 * ScrH()/1080 )

	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )

end

if CLIENT then
	hook.Add("OnGlobalVarSet","hg-weapons",function(key,var)
		if key == "weapons" then
			hg.weapons = var
		end
	end)

	hook.Add("OnNetVarSet","weapons-net-var",function(index,key,var)
		if key == "attachments" then
			local ent = Entity(index)

			ent.attachments = nil
			if ent.modelAtt then
				for atta, model in pairs(ent.modelAtt) do
					if not atta then continue end
					if IsValid(model) then model:Remove() end
					ent.modelAtt[atta] = nil
				end
			end

			ent.attachments = var
		end
	end)
else
	function hg.SyncWeapons()
		SetNetVar("weapons",hg.weapons)
	end
end

function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:OwnerChanged()
	self.init = true
	self.reload = nil
	--self.drawBullet = self:Clip1() > 0

	if SERVER then
		self:SetNetVar("attachments",self.attachments)
	end
end

function SWEP:InitializePost()
end

hg.weaponsDead = hg.weaponsDead or {}
function SWEP:OnRemove()
	if SERVER then
		hg.weapons[self] = nil

		SetNetVar("weapons",hg.weapons)
	end
end

local owner
local CurTime = CurTime
function SWEP:IsZoom()
	local owner = self:GetOwner()
	return IsValid(self:GetNWEntity("fakeGun")) or self:CanUse() and (self:GetOwner():IsPlayer() and self:KeyDown(IN_ATTACK2)) and owner:IsOnGround() and owner.posture ~= 1 and owner.posture ~= 3 and not owner.suiciding
end

function SWEP:CanUse()
	return not (self.reload or self.deploy or self.holster or (IsValid(self:GetOwner()) and (not self:GetOwner():OnGround() and false) and not IsValid(self:GetOwner().FakeRagdoll)) or (self:GetOwner():IsPlayer() and ((self:IsSprinting() and not self:GetOwner().FakeRagdoll) or (true and false))) or self.checkingAtts)
end

function SWEP:IsSprinting()
	local ply = self:GetOwner()
	return ply:IsSprinting() or ply.posture == 4 or ((self.holster or self.deploy) and true)
end

function SWEP:IsLocal()
	return CLIENT and self:GetOwner() == LocalPlayer()
end

local math_random = math.random
function SWEP:PlaySnd(snd, server, chan)
	if SERVER and not server then return end
	local owner = IsValid(self:GetOwner().FakeRagdoll) and self:GetOwner().FakeRagdoll or IsValid(self:GetOwner()) and self:GetOwner() or self
	if CLIENT then
		local view = render.GetViewSetup(true)
		local time = owner:GetPos():Distance(view.origin) / 17836
		if not IsValid(self:GetOwner()) then return end
		if not IsValid(self) then return end
		timer.Simple(time, function()
			if not self then return end
			if not self:GetOwner() then return end
			if not IsValid(self:GetOwner()) then return end
			if not IsValid(self) then return end
			if not ( IsValid(self) or IsValid(self:GetOwner()) ) then return end
			local owner = IsValid(self) and (IsValid(self:GetOwner()) and (IsValid(self:GetOwner().FakeRagdoll) and self:GetOwner().FakeRagdoll or self:GetOwner()) or self)
			owner = IsValid(owner) and owner
			if not owner then return end
			if type(snd) == "table" then
				EmitSound(snd[1], owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, snd[5] or 1, snd[2] or (self.Supressor and 75 or 75), 0, math_random(snd[3] or 100, snd[4] or 100), 0, nil)
			else
				EmitSound(snd, owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, 1, self.Supressor and 75 or 75, 0, 100, 0, nil)
			end
		end)
	else
		if type(snd) == "table" then
			EmitSound(snd[1], owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, snd[5] or 1, snd[2] or (self.Supressor and 75 or 75), 0, math_random(snd[3] or 100, snd[4] or 100), 0, nil)
		else
			EmitSound(snd, owner:GetPos(), owner:EntIndex(), chan or CHAN_WEAPON, 1, self.Supressor and 75 or 75, 0, 100, 0, nil)
		end
	end
end

function SWEP:PlaySndDist(snd)
	if SERVER then return end
	local owner = IsValid(self:GetOwner().FakeRagdoll) and self:GetOwner().FakeRagdoll or self:GetOwner()
	owner = IsValid(owner) and owner or self
	local view = render.GetViewSetup(true)
	local time = owner:GetPos():Distance(view.origin) / 17836
	timer.Simple(time, function()
		local owner = IsValid(self) and (IsValid(self:GetOwner()) and (IsValid(self:GetOwner().FakeRagdoll) and self:GetOwner().FakeRagdoll or self:GetOwner()) or self)
		owner = IsValid(owner) and owner
		if not owner then return end
		EmitSound(snd, owner:GetPos(), owner:EntIndex(), CHAN_AUTO, 1, self.Supressor and 1 or 120, 0, 100, 0, nil)
	end)
end

local math_Rand = math.Rand
local matrix, matrixSet
local math_random = math.random
local primary
local weapons_Get = weapons.Get
if SERVER then util.AddNetworkString("hgwep shoot") end
function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:Shoot(override)
	--self:GetWeaponEntity():ResetSequenceInfo()
	--self:GetWeaponEntity():SetSequence(1)
	if not self:CanPrimaryAttack() then return false end
	if not self:CanUse() then return false end
	if CLIENT and self:GetOwner() != LocalPlayer() and not override then return false end
	local primary = self.Primary
	if override then self.drawBullet = override end
	
	if not self.drawBullet or (self:Clip1() == 0 and not override) then
		self.LastPrimaryDryFire = CurTime()
		self:PrimaryShootEmpty()
		primary.Automatic = false
		return false
	end
	
	if primary.Next > CurTime() then return false end
	if (primary.NextFire or 0) > CurTime() then return false end
	primary.Next = CurTime() + primary.Wait
	self:SetLastShootTime(CurTime())
	primary.Automatic = weapons_Get(self:GetClass()).Primary.Automatic
	self:PrimaryShoot()
	self:PrimaryShootPost()
end

function SWEP:PrimaryAttack()
	if CLIENT and not IsFirstTimePredicted() then return end
	if CLIENT and not self:IsClient() then return end
	
	local huy = self:Shoot() ~= false
	if SERVER then
		net.Start("hgwep shoot")
		net.WriteEntity(self)
		net.WriteBool(huy)
		net.Broadcast()
	end
end

function SWEP:PrimaryShootPost()
end

function SWEP:Draw(server)
	if self.drawBullet == false then
		if SERVER and server then self:RejectShell(self.ShellEject) end
		if CLIENT and not server then self:RejectShell(self.ShellEject) end
		self.drawBullet = nil
	end

	if self:Clip1() > 0 then self.drawBullet = true end
end

SWEP.AutomaticDraw = true
function SWEP:PrimaryShoot()
	self:EmitShoot()
	--if SERVER or self:IsClient() then
		self:FireBullet()
	--end
	self.dwr_reverbDisable = nil
	self:TakePrimaryAmmo(1)
	self.drawBullet = false
	if self.AutomaticDraw then self:Draw() end
	self:PrimarySpread()
end

function SWEP:PrimaryShootEmpty()
	if CLIENT then return end
	self:PlaySnd(self.Primary.SoundEmpty, true, CHAN_AUTO)
end

SWEP.DistSound = "m4a1/m4a1_dist.wav"
function SWEP:EmitShoot()
	if SERVER then return end
	self:PlaySnd(self.Supressor and (self.SupressedSound or "m4a1/m4a1_suppressed_fp.wav") or self.Primary.Sound)
	self:PlaySndDist(self.DistSound)
end

function SWEP:CanSecondaryAttack()
end

function SWEP:SecondaryAttack()
end

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

if CLIENT then
	local hook_Run = hook.Run
	hook.Add("Think", "homigrad-weapons", function()
		for wep in pairs(hg.weapons) do
			--local wep = ply:GetActiveWeapon()
			if not IsValid(wep) or not wep.Step or (not IsValid(wep:GetOwner()) and wep:GetVelocity():Length() < 1) then continue end
			hook_Run("SWEPStep", wep)
			wep:Step()
		end
	end)
end

local colBlack = Color(0, 0, 0, 125)
local colWhite = Color(255, 255, 255, 255)
local yellow = Color(255, 255, 0)
local vecZero = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
local lerpAmmoCheck = 0
local function LerpColor(lerp, source, set)
	return Lerp(lerp, source.r, set.r), Lerp(lerp, source.g, set.g), Lerp(lerp, source.b, set.b)
end

local col = Color(0, 0, 0)
local col2 = Color(0, 0, 0)
local dynamicmags

if CLIENT then
	surface.CreateFont("AmmoFont",{
		font = "Bahnschrift",
		size = ScreenScale(16),
		extended = true,
		weight = 500,
		antialias = true
	})

	dynamicmags = CreateClientConVar("hg_dynamic_mags", "0", true, false)

end

function SWEP:DrawHUDAdd()
end

function SWEP:DrawHUD()
	local clipsize = (self:GetMaxClip1() + (self.OpenBolt and 0 or 1))
	local owner = self:GetOwner()
	local attpos = self:GetMuzzleAtt(nil, true, true).Pos
	local posX,posY = dynamicmags:GetBool() and attpos:ToScreen().x + 50 or ScrW() - ScrW() / 4, dynamicmags:GetBool() and attpos:ToScreen().y + 90 or ScrH() - ScrH() / 6
	local sizeX,sizeY =  clipsize == 1 and ScrH() / 15 or ScrW() / 40, clipsize == 1 and ScrH() / 80 or ScrH() / 10

	lerpAmmoCheck = Lerp(owner:KeyDown(IN_RELOAD) and 1 or 0.01, lerpAmmoCheck, owner:KeyDown(IN_RELOAD) and 1 or (dynamicmags:GetBool() and 0 or 0.05))
	colBlack.a = 125 * lerpAmmoCheck
	colWhite.a = 255 * lerpAmmoCheck
	local ammoLeft = math.ceil(self:Clip1() / clipsize * sizeY)
	
	col:SetUnpacked(LerpColor(ammoLeft / sizeY, yellow, color_white))
	col.a = 255 * lerpAmmoCheck
	local color = col
	surface.SetDrawColor(color)
	surface.DrawRect(posX,posY - ammoLeft + sizeY, sizeX, ammoLeft, 1)
	surface.DrawOutlinedRect(posX - 5, posY - 5, sizeX + 10, sizeY + 10, 1)
	
	local ammo = owner:GetAmmoCount(self:GetPrimaryAmmoType())
	local magCount = math.ceil(ammo / clipsize)

	local posX,posY = posX + (clipsize == 1 and ScrW() / 40 or ScrW() / 50), posY + (clipsize == 1 and ScrH()/70	 or ScrH() / 20)
	local sizeX,sizeY = sizeX / 2,sizeY / 2

	for i = 1,magCount do
		if i > 3 then continue end
		local ammoasd = math.min(clipsize,ammo)
		ammo = ammo - ammoasd
		
		local ammoLeft = math.ceil(ammoasd / clipsize * sizeY)
		
		col2:SetUnpacked(LerpColor(ammoLeft / sizeY, yellow, color_white))
		col2.a = 255 * lerpAmmoCheck
		surface.SetDrawColor(col2)
		surface.DrawRect(posX + (sizeX + 15) * i,posY - ammoLeft + sizeY, sizeX, ammoLeft, 1)
		surface.DrawOutlinedRect(posX - 5 + (sizeX + 15) * i,posY - 5, sizeX + 10, sizeY + 10, 1)
	end

	if magCount > 3 then
		draw.SimpleText("+"..magCount-3,"AmmoFont",posX + (sizeX + 15) * 4 + 1, posY + sizeX/2 + 1,Color(0,0,0,255*lerpAmmoCheck),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		draw.SimpleText("+"..magCount-3,"AmmoFont",posX + (sizeX + 15) * 4 , posY + sizeX/2,Color(255,255,255,255*lerpAmmoCheck),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	end

	if self.attachments then
		if not table.IsEmpty(self.attachments.sight) and string.find(self.attachments.sight[1], "holo") then self:DoHolo() end
		if not table.IsEmpty(self.attachments.sight) and string.find(self.attachments.sight[1], "optic") then self:DoRT() end
		if not table.IsEmpty(self.attachments.sight) and string.find(self.attachments.sight[1], "thermal") then self:DoThermal() end
	end
	self:ChangeFOV()
	self:CheckBipod()
	self:DrawHUDAdd()
end

if SERVER then
	function SWEP:Think()
		self:Step()
	end
end

function SWEP:Step()
	self:CoreStep()
end

local CurTime = CurTime
if CLIENT then
	SWEP.particleEffect = nil

	local vecSmoke = Vector(255, 255, 255)
	function SWEP:MuzzleEffect(time_)
		local att = self:GetMuzzleAtt(nil, true, true)
		local owner = self:GetOwner()

		local lastdmg = self.dmgStack
		local lastdmgMul = lastdmg / 100
		
		if time_ < 0.5 and self.SprayI == 0 then
			if not IsValid(self.particleEffect) then
				self.particleEffect = CreateParticleSystemNoEntity("smoke_trail_tfa", att.Pos, att.Ang)
				self.particleEffectCreateTime = CurTime()
			end
		end
		
		if IsValid(self.particleEffect) then
			self.particleEffect:SetControlPoint(0, att.Pos)
			
			if self.particleEffectCreateTime + 2 < CurTime() then
				self.particleEffect:StopEmission()
			end

			if self.particleEffectCreateTime + 4 < CurTime() then
				self.particleEffect:StopEmissionAndDestroyImmediately()
				self.particleEffect = nil
			end

			if IsValid(owner) and owner:IsPlayer() and IsValid(owner:GetActiveWeapon()) and owner:GetActiveWeapon() ~= self and self.shouldntDrawHolstered then
				if self.particleEffect then
					self.particleEffect:StopEmission()
				end
			end
		end
	end
else
	function SWEP:MuzzleEffect(time)
	end
end

if SERVER then
	util.AddNetworkString("place_bipod")
	function SWEP:PlaceBipod(bipod, dir)
		net.Start("place_bipod")
		net.WriteEntity(self)
		net.WriteVector(bipod)
		net.WriteVector(dir)
		net.Broadcast()
		self.removebipodtime = CurTime() + 1
		self.bipodPlacement = bipod
		self.bipodDir = dir
	end

	function SWEP:RemoveBipod()
		net.Start("place_bipod")
		net.WriteEntity(self)
		net.Broadcast()
		self.bipodPlacement = nil
		self.bipodDir = nil
	end
else
	net.Receive("place_bipod", function()
		local self = net.ReadEntity()
		local pos, dir = net.ReadVector(), net.ReadVector()
		if pos:IsZero() or dir:IsZero() then
			self.bipodPlacement = nil
			self.bipodDir = nil
			return
		end

		self.bipodPlacement = pos
		self.bipodDir = dir
	end)
end

function SWEP:GunOverHead(height)
	local attheight = self:GetMuzzleAtt().Pos[3]
	local owner = self:GetOwner()
	return owner:GetAttachment(owner:LookupAttachment("eyes")).Pos[3] < (height or attheight)
end

function SWEP:CoreStep()
	local owner = self:GetOwner()
	
	if SERVER and not true and IsValid(owner:GetActiveWeapon()) and self == owner:GetActiveWeapon() then
		self:RemoveFake()
		owner:DropWeapon()
		return
	end

	local time = CurTime() - self:LastShootTime()
	self:MuzzleEffect(time)
	if not IsValid(owner) then return end
	if SERVER and self.UseCustomWorldModel then 
		self:WorldModel_Transform() 
	end
	local time = CurTime()
	self:Step_HolsterDeploy(time)
	self:Step_Reload(time)
	self:Animation(time)
	if self:IsClient() or SERVER then self:Step_Spray(time) end
	if self:IsClient() or SERVER then self:Step_SprayVel() end
	self:AttachmentsSetup()
	self:ThinkAtt()
	
	if SERVER then
		local bipod, dir = self:CheckBipod()
		if bipod and not owner.FakeRagdoll and not self.bipodPlacement then self:PlaceBipod(bipod, dir) end
		local bipod, dir = self:CheckBipod(true)
		if ((self.removebipodtime or 0) < CurTime()) and self.bipodPlacement and (not self:CanUse() or owner:GetVelocity():Length() > 10 or self:GunOverHead(self.bipodPlacement[3]) or not bipod) then self:RemoveBipod() end
	else
		if self.bipodPlacement and self.bipodPlacement:IsZero() then
			self.bipodPlacement = nil
			self.bipodDir = nil
		end
	end

	if SERVER then self:DrawAttachments() end
end

if SERVER then hook.Add("UpdateAnimation", "fuckgmodok", function(ply) ply:RemoveGesture(ACT_GMOD_NOCLIP_LAYER) end) end
if CLIENT then
	local nilTbl = {}
	function SWEP:CustomAmmoDisplay()
		return nilTbl
	end
end


local vecZero = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
local hullVec = Vector(2, 2, 2)

function SWEP:CheckBipod(nouse)
	local owner = self:GetOwner()
	if not IsValid(owner) then return end

	if SERVER and ((not self:KeyDown(IN_USE) and not nouse) or not self.bipodAvailable) then return end
	local att = self:GetMuzzleAtt()
	
	--local worldpos = -(-self.WorldPos)
	--worldpos:Rotate(att.Ang)
	
	local tr = {}
	tr.start = att.Pos - att.Ang:Forward() * 30
	tr.endpos = tr.start - vector_up * 20
	tr.filter = {self,self:GetWeaponEntity(),owner}
	tr.mins = -hullVec
	tr.maxs = hullVec
	tr = util.TraceLine(tr)
	
	--if CLIENT then
	--	cam.Start3D()
	--		render.DrawLine(tr.StartPos,tr.HitPos,color_white)
	--	cam.End3D()
	--end

	if CLIENT then return end

	local selfpos = self:GetWeaponEntity():GetPos()
	selfpos[3] = tr.HitPos[3]
	if selfpos[3] < (owner:EyePos()[3] - 32) then return end
	if tr.Hit then
		return selfpos + vector_up * 5, att.Ang:Forward()
	end
end