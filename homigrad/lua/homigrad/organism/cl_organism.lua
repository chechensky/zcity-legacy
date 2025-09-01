-- Path scripthooked:lua\\homigrad\\organism\\tier_1\\cl_main.lua"
-- Scripthooked by ???
net.Receive("organism_send", function()
	local org = net.ReadTable()
	local ply = org.owner
	if not org.alive then return end
	if ply == LocalPlayer() and not ply:Alive() then
		org.owner.Organism = {}
	end
	org.owner.Organism = org

	if ply:Alive() then
		org.health = ply:Health()
	end
	
	if org.owner.FakeRagdoll then
		org.owner.FakeRagdoll.Organism = org
	end
end)

concommand.Add("getotrotrt", function(ply)
end)
hook.Add("ScalePlayerDamage", "remove-effects", function(ent, hitgroup, dmgInfo) if dmgInfo:IsDamageType(DMG_BUCKSHOT + DMG_BULLET + DMG_SLASH) then return true end end)
local lply = LocalPlayer()
local min = math.min
local breathe = 0

local FemPlayerModels = {
}
for i = 1, 6 do
	table.insert(FemPlayerModels,"models/player/group01/female_0" .. i .. ".mdl")
end

net.Receive("pulse", function()
	local organism = LocalPlayer().organism or {}

	local pulse = organism.pulse or 0
	breathe = breathe + 1
	lply:EmitSound("snd_jack_hmcd_heartpound.wav", min(pulse / 2, 45), 100, pulse / 600)
	--sound.Play("snd_jack_hmcd_heartpound.wav",lply:GetPos(),min(pulse,45),100,pulse / 200)
	if breathe % 3 == 0 and organism.o2.curregen > organism.timeValue then
		lply:EmitSound("snds_jack_hmcd_breathing/" .. (ThatPlyIsFemale(lply) and "f" or "m") .. math.random(4) .. ".wav", min(pulse / 2, 45), 100, pulse / 1200)
		--sound.Play("snds_jack_hmcd_breathing/m2.wav",lply:GetPos(),min(pulse,45),100,pulse / 200)
	end
end)

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
}

local tabblood = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
}

local tab2 = {
	["$pp_colour_addr"] = 0.00,
	["$pp_colour_addg"] = 0.00,
	["$pp_colour_addb"] = 0.04,
	["$pp_colour_brightness"] = -0.02,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 0.7,
	["$pp_colour_mulr"] = 0.1,
	["$pp_colour_mulg"] = 0.1,
	["$pp_colour_mulb"] = 0.25,
}

local k1, k2, k3

local lply
hook.Add("HUDShouldDraw", "RemoveRedScreen", function(name)
    if name == "CHudDamageIndicator" then
        return false
    end
end)
hook.Add("RenderScreenspaceEffects", "organism-effects", function()
	lply = lply or LocalPlayer()

	DrawColorModify(tab2)

	local spect = IsValid(lply:GetNWEntity("spect")) and lply:GetNWEntity("spect")
	local organism = lply:Alive() and lply.Organism or (viewmode == 1 and spect and spect.Organism) or {}
	
	if not organism then return end
	local alive = lply:Alive() or (spect and spect:Alive())
	
	local health = (lply:Alive() and lply:Health()) or 100
	if not alive or follow then end
	local org = organism
	local adrenaline = org.adrenaline or 0
	local pulse = org.pulse or 70
	local pain = org.pain or 0
	local hurt = org.hurt or 0
	local blood = org.Blood or 5000
	local bleed = org.bleed or 0
	local o2 = org.o2 and org.o2[1] or 30
	local brain = org.brain or 0
	local Otrub = org.Otrub or false
	local anesthetics = org.anesthetics or 0
	local health = health
	local disorientation = org.disorientation or 0
	local immobilization = org.immobilization or 0
	if Otrub then 
		lply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255), 0.3, 0.5 )
		lply:SetDSP(15)
	else
		lply:SetDSP(0)
	end

	k1 = LerpFT(0.1, k1 or 0, math.min(adrenaline, 2) + math.min(bleed / 60,0.7))
	k2 = brain * 2 + (30 - o2) / 30
	k3 = (5000 / math.max(blood, 1000)) - 1

	DrawSharpen(k1 * 2, k1)
	local lowpulse = math.max((70 - pulse) / 70, 0)
	local amount = 1 - math.Clamp(lowpulse + disorientation / 5 + k2 * 2,0,1)
	
	if disorientation > 0 or k2 > 0 or lowpulse > 0 then
		DrawMotionBlur(0.25 + amount, k2 + lowpulse + disorientation / 5, 0.01)
	end

	if k1 > 0 or k2 > 0 then
		DrawToyTown(2, (k3 * 3 + k2 * 2) * ScrH() / 2)
	end
	
	if pain > 0 or hurt > 0 or immobilization > 0 then
		local k = ((pain / 15 + hurt + immobilization / 15) / 2)
		DrawToyTown(1, k * ScrH())
	end
	
	--DrawMaterialOverlay( "overlays/vignette01", 0)
	local view = render.GetViewSetup()
	--RenderSuperDoF(view.origin,view.angles,0)
	if anesthetics > 0.5 then
		DrawMaterialOverlay( "particle/warp4_warp_noz", -(anesthetics - 0.5) / 150 )
	end
	tabblood["$pp_colour_colour"] = LerpFT(0.2, tabblood["$pp_colour_colour"], math.min(health / 100, 1) - (anesthetics > 0.5 and (anesthetics - 0.5) * 2 + (anesthetics - 0.5) * math.cos((CurTime()%360) * 1) + (anesthetics - 0.5) * math.sin((CurTime()%180) * 0.5) * 8 or 0))
	tabblood["$pp_colour_contrast"] = LerpFT(0.2, tabblood["$pp_colour_contrast"], health < 80 and math.max(1.5 * ( 1 - math.min(health / 80, 1) ), 1 ) or 1)
	tabblood["$pp_colour_brightness"] = LerpFT(0.2, tabblood["$pp_colour_brightness"],health < 80 and -0.3 * ( 1 - math.min(health / 80, 1) ) or 0 )
	--tab["$pp_colour_addb"] = k1 > 1 and (k1 - 1) / 60 or 0
	tab["$pp_colour_brightness"] = k1 > 1 and -(k1 - 1) / 20 or 0
	tab["$pp_colour_contrast"] = k1 > 1 and -(k1 - 1) / 10 + 1 or 1
	DrawColorModify(tab)
	DrawColorModify(tabblood)

	local ent = hg.GetCurrentCharacter(lply)

	if IsValid(ent) and ent.Blinking then
		surface.SetDrawColor(0,0,0,255)
		--surface.DrawRect(-1,-1,ScrW()+1,ent.Blinking * ScrH())
		--surface.DrawRect(-1,ScrH() + 1,ScrW()+1,-ent.Blinking * ScrH())
	end
end)