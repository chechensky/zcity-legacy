-- "addons\\homigrad-weapons\\lua\\weapons\\homigrad_base\\cl_shells.lua"
-- Scripthooked by ???
local Shells = {}
Shells["9x19"] = {m = "models/shells/fhell_9x19mm.mdl", s = {"arc9_eft_shared/shells/9mm_shell_concrete1.ogg", "arc9_eft_shared/shells/9mm_shell_concrete2.ogg", "arc9_eft_shared/shells/9mm_shell_concrete3.ogg"}}
Shells["9x18"] = {m = "models/shells/fhell_9x18mm.mdl", s = {"arc9_eft_shared/shells/9mm_shell_concrete1.ogg", "arc9_eft_shared/shells/9mm_shell_concrete2.ogg", "arc9_eft_shared/shells/9mm_shell_concrete3.ogg"}}
Shells["45acp"] = {m = "models/shells/fhell_45cal.mdl", s = {"arc9_eft_shared/shells/9mm_shell_concrete1.ogg", "arc9_eft_shared/shells/9mm_shell_concrete2.ogg", "arc9_eft_shared/shells/9mm_shell_concrete3.ogg"}}
Shells["380acp"] = {m = "models/shells/fhell_380acp.mdl", s = {"arc9_eft_shared/shells/9mm_shell_concrete1.ogg", "arc9_eft_shared/shells/9mm_shell_concrete2.ogg", "arc9_eft_shared/shells/9mm_shell_concrete3.ogg"}}
Shells["50ae"] = {m = "models/shells/fhell_50ae.mdl", s = {"arc9_eft_shared/shells/9mm_shell_concrete1.ogg", "arc9_eft_shared/shells/9mm_shell_concrete2.ogg", "arc9_eft_shared/shells/9mm_shell_concrete3.ogg"}}
Shells["50cal"] = {m = "models/shells/fhell_50cal.mdl", s = {"weapons/shells/m249_link_concrete_01.wav","weapons/shells/m249_link_concrete_02.wav","weapons/shells/m249_link_concrete_03.wav","weapons/shells/m249_link_concrete_04.wav","weapons/shells/m249_link_concrete_05.wav","weapons/shells/m249_link_concrete_06.wav","weapons/shells/m249_link_concrete_07.wav","weapons/shells/m249_link_concrete_08.wav"}}
Shells["545x39"] = {m = "models/shells/fhell_545.mdl", s = {"arc9_eft_shared/shells/556mm_shell_concrete1.ogg", "arc9_eft_shared/shells/556mm_shell_concrete2.ogg", "arc9_eft_shared/shells/556mm_shell_concrete3.ogg"}}
Shells["556x45"] = {m = "models/weapons/arc9_eft_shared/shells/eft_shell_556_m855.mdl", s = {"arc9_eft_shared/shells/556mm_shell_concrete1.ogg", "arc9_eft_shared/shells/556mm_shell_concrete2.ogg", "arc9_eft_shared/shells/556mm_shell_concrete3.ogg"}}
Shells["762x39"] = {m = "models/weapons/arc9/darsu_eft/shells/762x39.mdl", s = {"arc9_eft_shared/shells/556mm_shell_concrete1.ogg", "arc9_eft_shared/shells/556mm_shell_concrete2.ogg", "arc9_eft_shared/shells/556mm_shell_concrete3.ogg"}}
Shells["762x51"] = {m = "models/weapons/arc9/darsu_eft/shells/762x51.mdl", s = {"arc9_eft_shared/shells/556mm_shell_concrete1.ogg", "arc9_eft_shared/shells/556mm_shell_concrete2.ogg", "arc9_eft_shared/shells/556mm_shell_concrete3.ogg"}}
Shells["762x54"] = {m = "models/weapons/arc9/darsu_eft/shells/762x54r.mdl", s = {"arc9_eft_shared/shells/556mm_shell_concrete1.ogg", "arc9_eft_shared/shells/556mm_shell_concrete2.ogg", "arc9_eft_shared/shells/556mm_shell_concrete3.ogg"}}
Shells[".338Lapua"] = {m = "models/shells/shell_338mag.mdl", s = {"arc9_eft_shared/shells/556mm_shell_concrete1.ogg", "arc9_eft_shared/shells/556mm_shell_concrete2.ogg", "arc9_eft_shared/shells/556mm_shell_concrete3.ogg"}}
Shells["12x70"] = {m = "models/weapons/arc9/darsu_eft/shells/patron_12x70_shell.mdl", s = {"arc9_eft_shared/shells/12cal_shell_concrete1.ogg", "arc9_eft_shared/shells/12cal_shell_concrete2.ogg", "arc9_eft_shared/shells/12cal_shell_concrete3.ogg"}}
Shells["Pulse"] = {m = "models/pulse_slug.mdl", s = {"arc9_eft_shared/shells/12cal_shell_concrete1.ogg", "arc9_eft_shared/shells/12cal_shell_concrete2.ogg", "arc9_eft_shared/shells/12cal_shell_concrete3.ogg"}}
Shells["10mm"] = {m = "models/shells/fhell_10mm.mdl", s = {"arc9_eft_shared/shells/9mm_shell_concrete1.ogg", "arc9_eft_shared/shells/9mm_shell_concrete2.ogg", "arc9_eft_shared/shells/9mm_shell_concrete3.ogg"}}
Shells["mc51len"] = {m = "models/shells/fhell_mc51.mdl"}
Shells["m249len"] = {m = "models/shells/fhell_m249.mdl"}
Shells["m60len"] = {m = "models/shells/fhell_m60.mdl"}
Shells["12x70beanbag"] = {m = "models/weapons/arc9/darsu_eft/shells/patron_12x70_slug_grizzly_40_shell.mdl", s = {"arc9_eft_shared/shells/12cal_shell_concrete1.ogg", "arc9_eft_shared/shells/12cal_shell_concrete2.ogg", "arc9_eft_shared/shells/12cal_shell_concrete3.ogg"}}
Shells["12x70slug"] = {m = "models/weapons/arc9/darsu_eft/shells/patron_12x70_slug_poleva_3_shell.mdl", s = {"arc9_eft_shared/shells/12cal_shell_concrete1.ogg", "arc9_eft_shared/shells/12cal_shell_concrete2.ogg", "arc9_eft_shared/shells/12cal_shell_concrete3.ogg"}}


hg_shelles = hg_shelles or {}
local gamemod = engine.ActiveGamemode()

hg_trails = hg_trails or {}

local hg_potatopc = GetConVar("hg_potatopc") or CreateClientConVar("hg_potatopc", "0", true, false, "enable this if you are noob", 0, 1)

function SWEP:MakeShell(shell, pos, ang, vel)
	if not shell or not pos or not ang then
		return
	end
		
	local t = Shells[shell]
	
	if not t then
		return
	end
	
	vel = vel or Vector(0, 0, -100)
	vel = vel + VectorRand() * 5
	
	local ent = ClientsideModel(t.m, RENDERGROUP_BOTH) 
	ent:SetPos(pos)
	ent:PhysicsInitBox(Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5),"gmod_silent")
	ent:SetAngles(ang)
	ent:SetMoveType(MOVETYPE_VPHYSICS) 
	ent:SetSolid(SOLID_VPHYSICS) 
	ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    hg_shelles[#hg_shelles+1] = ent
	
	local phys = ent:GetPhysicsObject()
	phys:SetMaterial("gmod_silent")
	phys:SetMass(10)
	phys:SetVelocity(vel + (((IsValid(self) and IsValid(self:GetOwner())) and self:GetOwner():GetVelocity()/1.1) or Vector(0,0,0)))
    phys:SetAngleVelocity(VectorRand() * 200)
	
	if not hg_potatopc:GetBool() then
		if math.random(3) == 1 then
			local eff = CreateParticleSystem(ent,"smoke_trail_wild", PATTACH_POINT_FOLLOW, 0)
			eff:StartEmission()
			timer.Simple(1,function()
				if IsValid(eff) then
					eff:StopEmission()
				end
			end)
			timer.Simple(3,function()
				if IsValid(eff) then
					eff:StopEmissionAndDestroyImmediately()
				end
			end)
		end
	end

    ent:AddCallback("PhysicsCollide",function(ent,data)
        if data.Speed > 50 then
            if t.s then
                ent:EmitSound(table.Random(t.s), 60, 100)   
            end
        end
    end)
	gamemod = gamemod or engine.ActiveGamemode()
	if gamemod == "sandbox" then
		SafeRemoveEntityDelayed(ent, 10)
	end
end

hook.Add("PostCleanupMap","cleanupshells",function()
    for k,v in ipairs(hg_shelles) do
        --print("huy")
        v:Remove()
    end
    hg_shelles = {}
end)