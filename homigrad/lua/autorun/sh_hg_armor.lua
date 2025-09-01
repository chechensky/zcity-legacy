-- Path scripthooked:lua\\autorun\\sh_hg_armor.lua"
-- Scripthooked by ???
hg.armor = {}
hg.armor.torso = {
	["vest1"] = {
		"torso",
		"models/combataegis/body/ballisticvest_d.mdl",
		Vector(19, 3, 0),
		Angle(0, 90, 90),
		protection = 14.5,
		bone = "ValveBiped.Bip01_Spine2",
		model = "models/combataegis/body/ballisticvest.mdl",
		femPos = Vector(-4, 0, 1),
		femscale = 0.92,
		effect = "Impact",
		surfaceprop = 67,
		mass = 10,
		ScrappersSlot = "Armor",
	},
	["vest2"] = {
		"torso",
		"models/eu_homicide/armor_prop.mdl",
		Vector(-1, 2, 0),
		Angle(0, 90, 90),
		protection = 6.7,
		bone = "ValveBiped.Bip01_Spine2",
		model = "models/eu_homicide/armor_on.mdl",
		femPos = Vector(-2.4, 0, 1.1),
		femscale = 0.94,
		effect = "Impact",
		surfaceprop = 77,
		mass = 3,
		ScrappersSlot = "Armor",
	},
	["vest3"] = {
		"torso",
		"models/jworld_equipment/kevlar.mdl",
		Vector(-42, 3.2, 0),
		Angle(0, 90, 90),
		protection = 9.8,
		bone = "ValveBiped.Bip01_Spine2",
		model = "models/sal/acc/armor01.mdl",
		material = "sal/acc/armor01",
		femPos = Vector(2.5, 0, 1),
		scale = 0.88,
		femscale = 0.8,
		effect = "Impact",
		surfaceprop = 77,
		mass = 5,
		ScrappersSlot = "Armor",
	},
	["vest4"] = {
		"torso",
		"models/jworld_equipment/kevlar.mdl",
		Vector(-42, 3.2, 0),
		Angle(0, 90, 90),
		protection = 13.5,
		bone = "ValveBiped.Bip01_Spine2",
		model = "models/sal/acc/armor01.mdl",
		material = "sal/acc/armor01_2",
		femPos = Vector(2.5, 0, 1),
		scale = 0.88,
		femscale = 0.8,
		effect = "Impact",
		surfaceprop = 67,
		mass = 8,
		ScrappersSlot = "Armor",
	},
}

hg.armor.head = {
	["helmet1"] = {
		"head",
		"models/barney_helmet.mdl",
		Vector(1, -2, 0),
		Angle(180, 110, 90),
		protection = 12,
		bone = "ValveBiped.Bip01_Head1",
		model = "models/barney_helmet.mdl",
		femPos = Vector(-1, 0, 0),
		material = "sal/hanker",
		norender = true,
		viewmaterial = Material("sprites/mat_jack_hmcd_helmover"),
		femscale = 0.92,
		effect = "Impact",
		surfaceprop = 67,
		mass = 2,
		ScrappersSlot = "Armor",
	},
	["helmet2"] = {
		"head",
		"models/dean/gtaiv/helmet.mdl",
		Vector(2.6, 0, 0),
		Angle(180, 110, 90),
		protection = 5,
		bone = "ValveBiped.Bip01_Head1",
		model = "models/dean/gtaiv/helmet.mdl",
		femPos = Vector(-1, 0, 0),
		norender = true,
		viewmaterial = Material("sprites/mothelm_over"),
		effect = "Impact",
		surfaceprop = 67,
		mass = 1,
		ScrappersSlot = "Armor",
	},
	["helmet3"] = {
		"head",
		"models/eu_homicide/helmet.mdl",
		Vector(2, 0.2, 0),
		Angle(180, 110, 90),
		protection = 4,
		bone = "ValveBiped.Bip01_Head1",
		model = "models/eu_homicide/helmet.mdl",
		femPos = Vector(-1.2, 0, 0.5),
		norender = true,
		viewmaterial = Material("sprites/mat_jack_helmoverlay_r"),
		effect = "Impact",
		surfaceprop = 67,
		mass = 1,
		ScrappersSlot = "Armor",
	}
}
hg.armor.face = {
	["mask1"] = {
		"face", -- "face"
		"models/jmod/ballistic_mask.mdl",
		Vector(4.55, -0.8, 0),
		Angle(180, 90, 90),
		protection = 8,
		bone = "ValveBiped.Bip01_Head1",
		model = "models/jmod/ballistic_mask.mdl",
		femPos = Vector(-1.2, 0, 0.15),
		material = "sal/hanker",
		norender = true,
		scale = 1,
		femscale = 0.97,
		viewmaterial = Material("sprites/mat_jack_hmcd_narrow"),
		effect = "MetalSpark",
		surfaceprop = 77,
		mass = 1.5,
		ScrappersSlot = "Armor",
	},
	["mask2"] = {
		"face", -- "face"
		"models/gasmasks/m40.mdl",
		Vector(3,-2,-0.5),
		Angle(-90, 90, 0),
		protection = 2,
		bone = "ValveBiped.Bip01_Head1",
		model = "models/gasmasks/m40.mdl",
		femPos = Vector(-1,0,0),
		norender = true,
		scale = 1,
		femscale = 0.9,
		viewmaterial = Material("overlays/ba_gasmask"),
		effect = "Impact",
		surfaceprop = 67,
		loopsound = "breath_normal.wav",
		mass = 0.5,
		ScrappersSlot = "Armor",
	}
}
if SERVER then
	local ArmorEffect
	local function protec(org, bone, dmg, dmgInfo, placement, armor, scale, scaleprot, punch, boneindex, dir, hit, ricochet)
		
		if org.owner.armors[placement] ~= armor then return 0 end
		
		local prot = hg.armor[placement][armor].protection - (dmgInfo:GetInflictor().PenetrationCopy or 1)
		
		ArmorEffect(placement, armor, dmgInfo, org)

		if punch then
			if org.owner:IsPlayer() and org.alive then
				org.owner:ViewPunch(AngleRand(-30, 30))
				if not IsValid(org.owner.FakeRagdoll) then
					--org.owner:EmitSound("homigrad/player/headshot_helmet.wav")
				end
			end
		end
		
		if prot < 0 and not ricochet then dmgInfo:ScaleDamage(scale) return 1 - (scale/1.1) end
		dmgInfo:SetDamageType(DMG_CLUB)
		dmgInfo:ScaleDamage(scaleprot)
		
		return 1
	end

	ArmorEffect = function(placement,armor,dmgInfo,org)
		local armdata = hg.armor[placement][armor]
		local eff = armdata.effect
		local dir = -dmgInfo:GetDamageForce()
		dir:Normalize()
		local effdata = EffectData()
		
		effdata:SetOrigin( dmgInfo:GetDamagePosition() - dir )
		effdata:SetNormal( dir )
		effdata:SetMagnitude(0.25)
		effdata:SetRadius(4)
		effdata:SetNormal(dir)
		effdata:SetStart(dmgInfo:GetDamagePosition() + dir)
		effdata:SetEntity(org.owner)
		effdata:SetSurfaceProp(armdata.surfaceprop)
		effdata:SetDamageType(dmgInfo:GetDamageType())

		EmitSound("physics/metal/metal_solid_impact_bullet"..math.random(4)..".wav",dmgInfo:GetDamagePosition(),0,CHAN_AUTO,1,55,nil,100)
		util.Effect(eff,effdata)
	end

	hg.organism = hg.organism or {}
	hg.organism.input_list = hg.organism.input_list or {}
	hg.organism.input_list.vest1 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "torso", "vest1", 0.6, 0.025, false, ...)
		return protect
	end

	hg.organism.input_list.helmet1 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "head", "helmet1", 1, 0.15, true, ...)
		return protect
	end

	hg.organism.input_list.helmet2 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "head", "helmet2", 1, 0.6, true, ...)
		return protect
	end

	hg.organism.input_list.helmet3 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "head", "helmet3", 1, 0.5, true, ...)
		return protect
	end

	hg.organism.input_list.vest2 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "torso", "vest2", 1, 0.4, false, ...)
		return protect
	end

	hg.organism.input_list.vest3 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "torso", "vest3", 0.8, 0.1, false, ...)
		return protect
	end

	hg.organism.input_list.vest4 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "torso", "vest4", 0.8, 0.05, false, ...)
		return protect
	end

	hg.organism.input_list.mask1 = function(org, bone, dmg, dmgInfo, ...)
		local protect = protec(org, bone, dmg, dmgInfo, "face", "mask1", 1, 0.3, true, ...)
		return protect
	end
end

local armorNames = {
	["vest1"] = "Plate Body Armor IV",
	["helmet1"] = "ACH Helmet III",
	["helmet2"] = "Biker Helmet",
	["helmet3"] = "Riot Helmet",
	["vest2"] = "Police Riot Vest",
	["vest3"] = "Kevlar IIIA Vest",
	["vest4"] = "Kevlar III Vest",
	["mask1"] = "Balistic Mask",
	["mask2"] = "M40 Gas Mask"
}

local armorIcons = {
	["vest1"] = "scrappers/armor1.png",
	["helmet1"] = "vgui/icons/helmet.png",
	["helmet2"] = "vgui/icons/mothelmet.png",
	["helmet3"] = "vgui/icons/riothelm.png",
	["vest2"] = "vgui/icons/policevest.png",
	["vest3"] = "vgui/icons/armor01.png",
	["vest4"] = "vgui/icons/armor02.png",
	["mask1"] = "vgui/icons/ballisticmask",
	["mask2"] = "vgui/icons/gasmask"
}
hg.armorIcons = armorIcons

local entityMeta = FindMetaTable("Entity")
function entityMeta:SyncArmor()
	if self.armors then
		self:SetNetVar("Armor", self.armors)
	end
end

--["mask1"] = "Баллистическая Маска",
local function initArmor()
	for possibleArmor, armors in pairs(hg.armor) do
		for armorkey, armorData in pairs(armors) do
			if CLIENT then language.Add(armorkey, armorNames[armorkey] or armorkey) end
			local armor = {}
			armor.Base = "armor_base"
			armor.PrintName = CLIENT and language.GetPhrase(armorkey) or armorkey
			armor.name = armorkey
			armor.Category = "HG Armor"
			armor.Spawnable = true
			armor.Model = armorData[2]
			armor.WorldModel = armorData[2]
			armor.SubMats = armorData[4]
			armor.armor = armorData
			armor.placement = armorData[1]
			armor.IconOverride = armorIcons[armorkey]
			armor.PhysModel = armorData.PhysModel or nil
			armor.PhysPos = armorData.PhysPos or nil
			armor.PhysAng = armorData.PhysAng or nil
			armor.material = armorData.material or nil
			scripted_ents.Register(armor, "ent_armor_" .. armorkey)
		end
	end
end

function hg.GetArmorPlacement(armor)
	if istable(armor) then return end
	armor = string.Replace(armor,"ent_armor_","")
	
	local found
	for i,armplc in pairs(hg.armor) do
		for i2,armor2 in pairs(armplc) do
			if i2 == armor then found = i end
		end
	end
	return found
end

local stringToNum = {
	["torso"] = 1,
	["head"] = 2,
	["face"] = 3,
}

function hg.GetArmorPlacementNum(armor)
	return stringToNum[hg.GetArmorPlacement(armor)]
end

initArmor()
hook.Add("Initialize", "init-atts", initArmor)