-- Path scripthooked:lua\\homigrad\\organism\\tier_0\\sh_hitboxorgans_manual.lua"
-- Scripthooked by ???
hg.organism = hg.organism or {}
local male = {}
male["ValveBiped.Bip01_Spine1"] = {
	{"liver", nil, Vector(0, 3, -2.5), Angle(0, 0, 0), Vector(2, 2, 3.5), Color(125, 50, 0)},
	{"stomach", nil, Vector(-1, 2, 2), Angle(0, 0, 0), Vector(2.5, 2, 3), Color(255, 125, 0)}
}
male["ValveBiped.Bip01_Head1"] = {
	{
		"skull", --bone
		0.5,
		Vector(5.5, -1.5, 0),
		Angle(0, 0, 0),
		Vector(2.5, 4.8, 3.2),
		Color(0, 255, 0)
	},
	{
		"skull", --bone niz
		0.5,
		Vector(1, 1.5, 0),
		Angle(0, 0, 0),
		Vector(2, 1.4, 3.2),
		Color(0, 255, 0)
	},
	{
		"jaw", --jaw
		0.05,
		Vector(1, -3, 0),
		Angle(0, 0, 0),
		Vector(2, 3, 3),
		Color(0, 255, 0)
	},
	{
		"brain", --brain
		nil,
		Vector(5.4, -1.5, 0),
		Angle(0, 0, 0),
		Vector(2.5, 4.3, 2.8),
		Color(255, 0, 255)
	},
	{
		"brain", --brain niz
		nil,
		Vector(1.7, 0, 0),
		Angle(0, 0, 0),
		Vector(1.6, 2.1, 1.7),
		Color(255, 0, 255)
	},
	{
		"arteria", --right artery
		nil,
		Vector(-0.5, -2, 1.8),
		Angle(0, 0, 0),
		Vector(2.5, 0.5, 0.5),
		Color(200, 0, 0)
	},
	{
		"arteria", --left artery
		nil,
		Vector(-0.5, -2, -1.8),
		Angle(0, 0, 0),
		Vector(2.5, 0.5, 0.5),
		Color(200, 0, 0)
	},
}

local spine = 0.25
male["ValveBiped.Bip01_Neck1"] = {
	{
		"spine3", --spine3 neck
		spine,
		Vector(1, 1, 0),
		Angle(0, 0, 0),
		Vector(2, 0.5, 0.5),
		Color(0, 125, 0)
	},
	{"trachea", nil, Vector(2, -2, 0), Angle(0, 0, 0), Vector(2, 1, 1), Color(0, 125, 255)}
}

local bone = 0.5
male["ValveBiped.Bip01_Spine2"] = {
	{"spine2", spine, Vector(4, -1, 0), Angle(0, 0, 0), Vector(8, 0.5, 0.5), Color(0, 125, 0)},
	{"spineartery", 0, Vector(2, -1, 1), Angle(0, 0, 0), Vector(6, 0.4, 0.4), Color(255, 0, 0)},
	{
		"chest", --right
		bone,
		Vector(5, 6.5, -3.25),
		Angle(0, 0, 0),
		Vector(5, 0.3, 2.5),
		Color(0, 255, 0)
	},
	{
		"chest", --left
		bone,
		Vector(5, 6.25, 3.25),
		Angle(0, 0, 0),
		Vector(5, 0.3, 2.5),
		Color(0, 255, 0)
	},
	{
		"chest", --mid
		bone,
		Vector(6, 6.25, 0),
		Angle(0, 0, 0),
		Vector(4, 0.3, 0.75),
		Color(0, 255, 0)
	},
	{
		"chest", --left side
		bone,
		Vector(4, 3, 5.5),
		Angle(0, 0, 0),
		Vector(6, 4, 0.3),
		Color(0, 255, 0)
	},
	{
		"chest", --right side
		bone,
		Vector(4, 3, -6.2),
		Angle(0, 0, 0),
		Vector(6, 4, 0.3),
		Color(0, 255, 0)
	},
	{
		"chest", --back
		bone,
		Vector(4, -1, 0),
		Angle(0, 0, 0),
		Vector(6, 0.3, 6),
		Color(0, 255, 0)
	},
	{"lungsR", nil, Vector(4, 3, -3), Angle(0, 0, 0), Vector(5, 3, 2.5), Color(0, 255, 255)},
	{"lungsL", nil, Vector(4, 3, 3), Angle(0, 0, 0), Vector(5, 3, 2.5), Color(0, 255, 255)},
	{"trachea", nil, Vector(6, 3, 0), Angle(0, 0, 0), Vector(6, 1, 1), Color(0, 125, 255)},
	{"heart", nil, Vector(7, 2, 1), Angle(0, 0, 0), Vector(1.5, 1.5, 1.5), Color(200, 0, 0)}
}

local bone = 0.5
male["ValveBiped.Bip01_Pelvis"] = {
	{"spine1", spine, Vector(0, 2, -5), Angle(0, 0, 0), Vector(0.5, 5, 0.5), Color(0, 125, 0)},
	{"spineartery", 0, Vector(1, 2, -5), Angle(0, 0, 0), Vector(0.4, 5, 0.4), Color(255, 0, 0)},
	{
		"pelvis", --back
		bone,
		Vector(-4, 1, -4),
		Angle(0, 0, 0),
		Vector(3, 4, 0.5),
		Color(0, 255, 0)
	},
	{
		"pelvis", --back
		bone,
		Vector(4, 1, -4),
		Angle(0, 0, 0),
		Vector(3, 4, 0.5),
		Color(0, 255, 0)
	},
	{
		"pelvis", --left
		bone,
		Vector(6.5, 1, -0.5),
		Angle(0, 0, 0),
		Vector(0.5, 3, 3.5),
		Color(0, 255, 0)
	},
	{
		"pelvis", --right
		bone,
		Vector(-6.5, 1, -0.5),
		Angle(0, 0, 0),
		Vector(0.5, 3, 3.5),
		Color(0, 255, 0)
	},
	{"intestines", nil, Vector(0, 2, 0), Angle(0, 0, 0), Vector(5, 3.5, 3), Color(250, 120, 120)}
}

local bone = 0.5
male["ValveBiped.Bip01_L_UpperArm"] = {{"larmup", bone, Vector(6, 0, 0), Angle(0, 0, 0), Vector(6, 0.8, 0.8), Color(0, 255, 0)}, {"larmartery", 0, Vector(6, 0, -1), Angle(0, 0, 0), Vector(6, 0.1, 0.1), Color(255, 0, 0)},}
male["ValveBiped.Bip01_R_UpperArm"] = {{"rarmup", bone, Vector(6, 0, 0), Angle(0, 0, 0), Vector(6, 0.8, 0.8), Color(0, 255, 0)}, {"rarmartery", 0, Vector(6, 0, 1), Angle(0, 0, 0), Vector(6, 0.1, 0.1), Color(255, 0, 0)},}
male["ValveBiped.Bip01_L_Forearm"] = {{"larmdown", bone, Vector(6, -1, 0), Angle(0, 5, 0), Vector(6, 0.5, 0.5), Color(0, 255, 0)}, {"larmdown", bone, Vector(6, 1, 0), Angle(0, -5, 0), Vector(6, 0.5, 0.5), Color(0, 255, 0)}, {"larmartery", 0, Vector(6, -0.8, 0), Angle(0, 0, 0), Vector(6, 0.1, 0.1), Color(255, 0, 0)}, {"larmartery", 0, Vector(6, 0.8, 0), Angle(0, 0, 0), Vector(6, 0.1, 0.1), Color(255, 0, 0)},}
male["ValveBiped.Bip01_R_Forearm"] = {{"rarmdown", bone, Vector(6, -1, 0), Angle(0, 5, 0), Vector(6, 0.5, 0.5), Color(0, 255, 0)}, {"rarmdown", bone, Vector(6, 1, 0), Angle(0, -5, 0), Vector(6, 0.5, 0.5), Color(0, 255, 0)}, {"rarmartery", 0, Vector(6, -0.8, 0), Angle(0, 0, 0), Vector(6, 0.1, 0.1), Color(255, 0, 0)}, {"rarmartery", 0, Vector(6, 0.8, 0), Angle(0, 0, 0), Vector(6, 0.1, 0.1), Color(255, 0, 0)},}
male["ValveBiped.Bip01_L_Thigh"] = {{"llegup", bone, Vector(9, 0, 0), Angle(0, 0, 0), Vector(9, 1.5, 1.5), Color(0, 255, 0)}, {"llegartery", 0, Vector(9, 2, -1), Angle(0, 0, 0), Vector(9, 0.2, 0.2), Color(255, 0, 0)},}
male["ValveBiped.Bip01_R_Thigh"] = {{"rlegup", bone, Vector(9, 0, 0), Angle(0, 0, 0), Vector(9, 1.5, 1.5), Color(0, 255, 0)}, {"rlegartery", 0, Vector(9, 2, 1), Angle(0, 0, 0), Vector(9, 0.2, 0.2), Color(255, 0, 0)},}
male["ValveBiped.Bip01_L_Calf"] = {{"llegdown", bone, Vector(8, 0, 0), Angle(0, 0, 0), Vector(8, 1.5, 1.5), Color(0, 255, 0)}, {"llegartery", 0, Vector(6, 2, -1), Angle(0, 0, 0), Vector(6, 0.2, 0.2), Color(255, 0, 0)},}
male["ValveBiped.Bip01_R_Calf"] = {{"rlegdown", bone, Vector(8, 0, 0), Angle(0, 0, 0), Vector(8, 1.5, 1.5), Color(0, 255, 0)}, {"rlegartery", 0, Vector(6, 2, 1), Angle(0, 0, 0), Vector(6, 0.2, 0.2), Color(255, 0, 0)},}
local models_female = {
	["models/player/group01/female_01.mdl"] = true,
	["models/player/group01/female_02.mdl"] = true,
	["models/player/group01/female_03.mdl"] = true,
	["models/player/group01/female_04.mdl"] = true,
	["models/player/group01/female_05.mdl"] = true,
	["models/player/group01/female_06.mdl"] = true,
	["models/player/group03/female_01.mdl"] = true,
	["models/player/group03/female_02.mdl"] = true,
	["models/player/group03/female_03.mdl"] = true,
	["models/player/group03/female_04.mdl"] = true,
	["models/player/group03/female_05.mdl"] = true,
	["models/player/group03/police_fem.mdl"] = true
}

table.insert(male["ValveBiped.Bip01_Spine2"],1,{"vest1", 1, Vector(3, 8, 0), Angle(0, 0, 0), Vector(7, 1, 6), Color(250, 255, 0), true, hg.armor.torso["vest1"].protection})
table.insert(male["ValveBiped.Bip01_Spine2"],1,{"vest1", 1, Vector(3, -2.5, 0), Angle(0, 0, 0), Vector(7, 1, 6), Color(250, 255, 0), true, hg.armor.torso["vest1"].protection})

table.insert(male["ValveBiped.Bip01_Spine1"],1,{"vest2", 1, Vector(-4, 2, 0), Angle(0, 0, 0), Vector(5, 7, 7), Color(140, 0, 255), true, hg.armor.torso["vest2"].protection})
table.insert(male["ValveBiped.Bip01_Spine2"],1,{"vest2", 1, Vector(2, 3, 0), Angle(0, 0, 0), Vector(8, 7, 6), Color(183, 0, 255), true, hg.armor.torso["vest2"].protection})

table.insert(male["ValveBiped.Bip01_Spine2"],1,{"vest3", 1, Vector(3, 8, 0), Angle(0, 0, 0), Vector(7, 2, 6), Color(47, 0, 255), true, hg.armor.torso["vest3"].protection})
table.insert(male["ValveBiped.Bip01_Spine2"],1,{"vest3", 1, Vector(3, -2.5, 0), Angle(0, 0, 0), Vector(7, 2, 6), Color(0, 17, 255), true, hg.armor.torso["vest3"].protection})

table.insert(male["ValveBiped.Bip01_Spine2"],1,{"vest4", 1, Vector(3, 8, 0), Angle(0, 0, 0), Vector(7, 1, 6), Color(55, 0, 255), true, hg.armor.torso["vest4"].protection})
table.insert(male["ValveBiped.Bip01_Spine2"],1,{"vest4", 1, Vector(3, -2.5, 0), Angle(0, 0, 0), Vector(7, 1, 6), Color(68, 0, 255), true, hg.armor.torso["vest4"].protection})

table.insert(male["ValveBiped.Bip01_Head1"],1,{"helmet1", 1, Vector(6.5, -0.9, 0), Angle(0, 12, 0), Vector(2.7, 7, 4.5), Color(250, 255, 0), true, hg.armor.head["helmet1"].protection})
table.insert(male["ValveBiped.Bip01_Head1"],1,{"helmet2", 1, Vector(3.5, -0.9, 0), Angle(0, 0, 0), Vector(5, 6, 5.5), Color(255, 255, 0), true, hg.armor.head["helmet2"].protection})
table.insert(male["ValveBiped.Bip01_Head1"],1,{"helmet3", 1, Vector(3.5, -0.9, 0), Angle(0, 0, 0), Vector(5, 6, 5.5), Color(255, 255, 0), true, hg.armor.head["helmet3"].protection})

table.insert(male["ValveBiped.Bip01_Head1"],1,{"mask1", 1, Vector(3.5, -4, 0), Angle(0, 0, 0), Vector(5, 3, 4.5), Color(255, 0, 221), true, hg.armor.face["mask1"].protection})

local female = {}
table.CopyFromTo(male, female)

female["ValveBiped.Bip01_Head1"] = {
	{
		"skull", --bone
		0.5,
		Vector(4.5, 0, 0),
		Angle(0, 0, 0),
		Vector(2.5, 4.8, 3.2),
		Color(0, 255, 0)
	},
	{
		"skull", --bone niz
		0.5,
		Vector(0, 3, 0),
		Angle(0, 0, 0),
		Vector(2, 1.4, 3.2),
		Color(0, 255, 0)
	},
	{
		"jaw", --jaw
		0.05,
		Vector(0, -1.5, 0),
		Angle(0, 0, 0),
		Vector(2, 3, 3),
		Color(0, 255, 0)
	},
	{
		"brain", --brain
		nil,
		Vector(4.4, -0, 0),
		Angle(0, 0, 0),
		Vector(2.5, 4.3, 2.8),
		Color(255, 0, 255)
	},
	{
		"brain", --brain niz
		nil,
		Vector(0.5, 2, 0),
		Angle(0, 0, 0),
		Vector(1.6, 2.1, 1.7),
		Color(255, 0, 255)
	},
	{
		"arteria", --right artery
		nil,
		Vector(-0.5, -2, 1.8),
		Angle(0, 0, 0),
		Vector(2.5, 0.5, 0.5),
		Color(200, 0, 0)
	},
	{
		"arteria", --left artery
		nil,
		Vector(-0.5, -2, -1.8),
		Angle(0, 0, 0),
		Vector(2.5, 0.5, 0.5),
		Color(200, 0, 0)
	},
}

table.insert(female["ValveBiped.Bip01_Head1"],1,{"helmet1", 1, Vector(6.5, -0.9, 0), Angle(0, 12, 0), Vector(2.7, 7, 4.5), Color(250, 255, 0), true, hg.armor.head["helmet1"].protection})
table.insert(female["ValveBiped.Bip01_Head1"],1,{"helmet2", 1, Vector(3.5, -0.9, 0), Angle(0, 0, 0), Vector(5, 6, 5.5), Color(255, 255, 0), true, hg.armor.head["helmet2"].protection})
table.insert(female["ValveBiped.Bip01_Head1"],1,{"helmet3", 1, Vector(3.5, -0.9, 0), Angle(0, 0, 0), Vector(5, 6, 5.5), Color(255, 255, 0), true, hg.armor.head["helmet3"].protection})

table.insert(female["ValveBiped.Bip01_Head1"],1,{"mask1", 1, Vector(3.5, -4, 0), Angle(0, 0, 0), Vector(5, 3, 4.5), Color(255, 0, 221), true, hg.armor.face["mask1"].protection})
function hg.organism.GetHitBoxOrgans(model, ent)
	return (models_female[model] and female) or male
end