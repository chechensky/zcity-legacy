-- Path scripthooked:lua\\weapons\\weapon_revolver2.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Manurhin MR-96"
SWEP.Author = "Manurhin"
SWEP.Instructions = "Revolver chambered in .357 Magnum\n"
SWEP.Category = "Weapons - Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_pist_jeagle.mdl"

SWEP.WepSelectIcon2 = Material("vgui/wep_jack_hmcd_revolver")
SWEP.IconOverride = "vgui/wep_jack_hmcd_revolver"

SWEP.weight = 1.5

SWEP.weaponInvCategory = 2
SWEP.ShellEject = false
SWEP.ShellEject2 = "EjectBrass_57"
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ".357 Magnum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 35
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 35
SWEP.Primary.Sound = {"homigrad/weapons/pistols/deagle-1.wav", 75, 90, 100}
SWEP.Primary.Wait = 0.2
SWEP.ReloadTime = 2
SWEP.DeploySnd = {"homigrad/weapons/draw_pistol.mp3", 55, 100, 110}
SWEP.HolsterSnd = {"homigrad/weapons/holster_pistol.mp3", 55, 100, 110}
SWEP.HoldType = "revolver"
SWEP.AimHold = "revolver"
SWEP.ZoomPos = Vector(-0.95, -0.0, 25)
SWEP.RHandPos = Vector(0, 0, 1)
SWEP.LHandPos = false
SWEP.SprayRand = {Angle(-0.1, -0.2, 0), Angle(-0.2, 0.2, 0)}
SWEP.AnimShootMul = 4
SWEP.AnimShootHandMul = 4
SWEP.Ergonomics = 0.9
SWEP.OpenBolt = true
SWEP.Penetration = 10
function SWEP:ReloadStartPost()
	self.reloadMiddle = CurTime() + self.ReloadTime / 2
end

SWEP.ShockMultiplier = 3

SWEP.ScrappersSlot = "Secondary"

SWEP.CustomShell = "10mm"

function SWEP:ShiftDrum(val)
	val = math.Round(val % 6)
	
	if val == 0 then return end

	local drumCopy = table.Copy(self.Drum)

	for i = 1,#self.Drum do
		local nextval = i + val
		
		local setval = nextval < 1 and #self.Drum - nextval or nextval > 6 and nextval - 6 or nextval
		
		self.Drum[i] = drumCopy[setval]
	end

	local stringythingy = ""
	for i = 1,#self.Drum do
		stringythingy = stringythingy..tostring(self.Drum[i]).." "
	end
	
	--[[if SERVER then
		net.Start("hg_senddrum")
		net.WriteInt(self:EntIndex(),32)
		net.WriteString(stringythingy)
		net.Broadcast()
	end--]]
	self:SetNWString("drum",stringythingy)
end

local ang = Angle(-90, 0, 0)
ang:RotateAroundAxis(ang:Right(), 180)
function SWEP:Step()
	self:CoreStep()
	local owner = self:GetOwner()
	if not IsValid(owner) or not IsValid(self) then return end
	if CLIENT then
		if self.reloadMiddle and self.reloadMiddle < CurTime() then
			local drum = self:GetDrum()
			for i = 1, #drum do
				if self.CustomShell and drum[i] == -1 then
					self:MakeShell(self.CustomShell, owner:GetBonePosition(owner:LookupBone("ValveBiped.Bip01_L_Hand")), ang, Vector(0,0,0)) 
				end
			end

			self.reloadMiddle = nil
		end
	end
end

function SWEP:InitializePost()
	self.Drum = {
		[1] = 1,
		[2] = 1,
		[3] = 1,
		[4] = 1,
		[5] = 1,
		[6] = 1
	}
end

local function rollDrum()
	RunConsoleCommand("hg_rolldrum")
end

local function loadonebullet(val)
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	local primaryammo = wep:GetPrimaryAmmoType()
	local primaryammocount = ply:GetAmmoCount(primaryammo)
	if wep.Drum[val] != 0 then
		local value = -(-wep.Drum[val])
		wep.Drum[val] = 0
		wep:SetClip1(wep:Clip1() - math.max(value,0))
		ply:SetAmmo(primaryammocount+math.max(value,0),primaryammo)
	else
		if primaryammocount > 0 then
			wep.Drum[val] = 1
			wep:SetClip1(wep:Clip1() + 1)
			ply:SetAmmo(primaryammocount-1,primaryammo)
		end
	end
	
	wep:SetDrum(wep.Drum)

	RunConsoleCommand("hg_insertbullet",val)
end

hook.Add("radialOptions","hg_rouletee",function()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon() 
	if not IsValid(wep) or not wep.Drum then return end
	local primaryAmmo = wep:GetPrimaryAmmoType()
	local primaryAmmoCount = ply:GetAmmoCount(primaryAmmo)

	local tbl = {rollDrum, "Roll Drum"}
	hg.radialOptions[#hg.radialOptions + 1] = tbl

	--if wep:Clip1() > 0 then return end
	--if primaryAmmoCount <= 0 then return end

	local drum = wep:GetDrum()
	
	local drum1 = {}
	for i = 1,#drum do
		drum1[i] = "slot №"..tostring(i)
	end

	local tbl = {
		loadonebullet,
		"Load one bullet",
		true,
		drum1
	}
	
	hg.radialOptions[#hg.radialOptions + 1] = tbl
end)

if SERVER then
	concommand.Add("hg_insertbullet",function( ply, cmd, args )
		local val = tonumber(args[1])
		local wep = ply:GetActiveWeapon() 
		if not IsValid(wep) then return end
		local primaryammo = wep:GetPrimaryAmmoType()
		local primaryammocount = ply:GetAmmoCount(primaryammo)

		if not wep.Drum then return end

		if wep.Drum[val] != 0 then
			local value = -(-wep.Drum[val])
			wep.Drum[val] = 0
			wep:SendDrum()
			wep:SetClip1(wep:Clip1() - math.max(value,0))
			ply:SetAmmo(primaryammocount+math.max(value,0),primaryammo)
			ply:EmitSound("weapons/usp_match/usp_match_magout.wav")
			return
		end

		if primaryammocount > 0 then
			wep.Drum[val] = 1
			wep:SendDrum()
			wep:SetClip1(wep:Clip1() + 1)
			ply:SetAmmo(primaryammocount-1,primaryammo)
			ply:EmitSound("weapons/usp_match/usp_match_magin.wav")
		end
	end)

	concommand.Add("hg_rolldrum",function(ply, cmd, args)
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep.Drum then
			wep:ShiftDrum(math.random(6))
			ply:EmitSound("weapons/357/357_spin1.wav")
		end
	end)
end

if SERVER then
	util.AddNetworkString("hg_senddrum")
	
	function SWEP:SendDrum()
		local stringythingy = ""
		for i = 1,#self.Drum do
			stringythingy = stringythingy..tostring(self.Drum[i]).." "
		end
		
		--[[net.Start("hg_senddrum")
		net.WriteInt(self:EntIndex(),32)
		net.WriteString(stringythingy)
		net.Broadcast()--]]

		self:SetNWString("drum",stringythingy)
	end
else
	net.Receive("hg_senddrum",function() 
		local self = Entity(net.ReadInt(32))
		local drumtbl = string.Split(net.ReadString()," ")

		for i = 1,#self.Drum do
			self.Drum[i] = tonumber(drumtbl[i])
		end
		self.DrumLastPredicted = CurTime() + 0.5
	end)
end

function SWEP:Unload()
	if CLIENT then return end
	
	if self.SendDrum then
		for i = 1,#self.Drum do
			self.Drum[i] = 0
		end
		self:SendDrum()
	end
end

function SWEP:GetDrum()
	local drumtbl = string.Split(self:GetNWString("drum","1 1 1 1 1 1")," ")
	
	if (self.DrumLastPredicted or 0) < CurTime() then
		for i = 1,#self.Drum do
			self.Drum[i] = tonumber(drumtbl[i])
		end
	end
	
	return self.Drum
end

function SWEP:SetDrum(drum)
	self.Drum = drum
	self.DrumLastPredicted = CurTime() + 1
end

function SWEP:Shoot(override)
	--self:GetWeaponEntity():ResetSequenceInfo()
	--self:GetWeaponEntity():SetSequence(1)
	if not self:CanPrimaryAttack() then return false end
	if not self:CanUse() then return false end
	if CLIENT and self:GetOwner() != LocalPlayer() and not override then return false end
	local primary = self.Primary

	if primary.Next > CurTime() then return false end
	if (primary.NextFire or 0) > CurTime() then return false end

	self.Drum = SERVER and self.Drum or CLIENT and self:GetDrum()
	
	if self.Drum[1] != 1 then
		self.LastPrimaryDryFire = CurTime()
		self:PrimaryShootEmpty()
		primary.Automatic = false
		self:ShiftDrum(1)
		return false
	end

	self.Drum[1] = -1
	self:ShiftDrum(1)
	
	primary.Next = CurTime() + primary.Wait
	self:SetLastShootTime(CurTime())
	primary.Automatic = weapons.Get(self:GetClass()).Primary.Automatic
	self:PrimaryShoot()
	self:PrimaryShootPost()
end

function SWEP:InsertAmmo(need)
	local owner = self:GetOwner()
	local primaryAmmo = self:GetPrimaryAmmoType()
	local primaryAmmoCount = owner:GetAmmoCount(primaryAmmo)
	need = need or self:GetMaxClip1() - self:Clip1()
	need = math.min(primaryAmmoCount, need)
	need = math.min(need, self:GetMaxClip1())
	self:SetClip1(self:Clip1() + need)

	for i = 1, math.min(self:Clip1() + need,6) do
		self.Drum[i] = 1
	end
	if SERVER then
		self:SendDrum()
	end

	owner:SetAmmo(primaryAmmoCount - need, primaryAmmo)
end

SWEP.WorldPos = Vector(-1, -1, -1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0,0,0)
SWEP.attAng = Angle(0,-0.2,0)
SWEP.lengthSub = 25
SWEP.DistSound = "hndg_sw686/revolver_fire_01.wav"
SWEP.holsteredBone = "ValveBiped.Bip01_Pelvis"
SWEP.holsteredPos = Vector(-2, 5, 9)
SWEP.holsteredAng = Angle(25, -65, -90)
SWEP.shouldntDrawHolstered = true

SWEP.availableAttachments = {
	barrel = {
		[1] = {"supressor4", Vector(0,0,0), {}},
		[2] = {"supressor6", Vector(0,0,0), {}},
		["mount"] = Vector(0.5,0.5,0),
	},
}