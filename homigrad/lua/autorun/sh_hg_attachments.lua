-- Path scripthooked:lua\\autorun\\sh_hg_attachments.lua"
-- Scripthooked by ???
hg.attachments = {}
hg.attachments.sight = {
	["empty"] = {"sight", "", Angle(0, 0, 0), {}},
	["holo0"] = {
		"sight", --встроенный
		"",
		Angle(0, 0, 0),
		{}
	},
	["holo1"] = {
		"sight",
		"models/weapons/tfa_ins2/upgrades/phy_optic_eotech.mdl",
		Angle(0, 0, -90),
		offset = Vector(-1, 0, -0.02),
		offsetView = Vector(-1.5, 0, 9),
		{
			[1] = "models/weapons/arc9_eft_shared/atts/optic/transparent_glass"
		},
		mountType = "picatinny",
		--holo settings go here
		size = 0.00077, --size of the picture (invisible)
		holo_pos = Vector(-0.75, 2, 0), --pos of the picture (invisible)
		scale = Vector(1, 1.35, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_eotech_xps3-4_marks.png"),
		holo_size = 1.7,
	},
	["holo2"] = {
		"sight",
		"models/weapons/tfa_ins2/upgrades/phy_optic_kobra.mdl",
		Angle(0, 0, -90),
		offset = Vector(-1, 0, -0.02),
		offsetView = Vector(-1.3, -0.03, 9),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.0007, --size of the picture (invisible)
		holo_pos = Vector(-0.7, 1.8, -2), --pos of the picture (invisible)
		scale = Vector(1, 1.1, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_aksion_ekp_8_18_marks_03.png"),
		holo_size = 1.5, --size of the holo
	},
	["holo3"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_sig_romeo_8t.mdl",
		Angle(0, 0, -90),
		offset = Vector(-1, 0, -0.02),
		offsetView = Vector(-1.45, -0.03, 8),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.0007, --size of the picture (invisible)
		holo_pos = Vector(-0.66, 2, 0), --pos of the picture (invisible)
		scale = Vector(1, 1.35, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_sig_romeo_8t_lod0_mark.png"),
		holo_size = 2, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo4"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_walther_mrs.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 0.02, -0.05),
		offsetView = Vector(-1.4, -0.03, 8),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.0006, --size of the picture (invisible)
		holo_pos = Vector(-0.58, 1.8, -1), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_walther_mrs_mark_001.png"),
		holo_size = 1.75, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo5"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_ekb_okp7.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 0, -0.05),
		offsetView = Vector(-1.2, 0.1, 8),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.0007, --size of the picture (invisible)
		holo_pos = Vector(-0.8, 1.7, -3), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_ekb_okp7_true_marks.png"),
		holo_size = 1.75, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo6"] = {
		"sight",
		"models/weapons/arc9_eft_shared/atts/optic/dovetail/okp7.mdl",
		Angle(0, 0, -90),
		offset = Vector(-2, 0.25, 0.2),
		offsetView = Vector(-0.75, 0.2, 6),
		{},
		mountType = "dovetail",
		--holo settings go here
		size = 0.0006, --size of the picture (invisible)
		holo_pos = Vector(-0.8, 1.15, -3.5), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_ekb_okp7_true_marks.png"),
		holo_size = 1.75, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 2),
		PhysAng = Angle(0, 90, 0),
	},
	["holo7"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_belomo_pk_06.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, -0.1, 0),
		offsetView = Vector(-1.1, 0, 9),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.00045, --size of the picture (invisible)
		holo_pos = Vector(-0.43, 1.5, -0.5), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_belomo_pk_06_mark_000.png"),
		holo_size = 2.5, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo8"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_holosun_hs401g5.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, -0.1, 0),
		offsetView = Vector(-1.4, 0, 8),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.00045, --size of the picture (invisible)
		holo_pos = Vector(-0.43, 1.75, 2), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_aimpoint_micro_h1_high_marks.png"),
		holo_size = 2.5, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo9"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_leapers_utg_38_ita_1x30.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, -0.1, 0),
		offsetView = Vector(-1, 0, 8),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.0005, --size of the picture (invisible)
		holo_pos = Vector(-0.45, 1.4, 1), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_leapers_utg_38_ita_1x30_mark2.png"),
		holo_size = 2.5, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo11"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_trijicon_srs_02.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 0.1, 0),
		offsetView = Vector(-1.5, 0, 9),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.00045, --size of the picture (invisible)
		holo_pos = Vector(-0.43, 1.85, 2), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_aimpoint_micro_h1_high_marks.png"),
		holo_size = 2.5, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo12"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_valday_1p87.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, -0.1, 0),
		offsetView = Vector(-2, 0, 9),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.00055, --size of the picture (invisible)
		holo_pos = Vector(-0.55, 2.4, 2), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_valday_1p87_marks.png"),
		holo_size = 2.5, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo13"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_valday_krechet.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, -0.1, 0),
		offsetView = Vector(-2.35, 0, 9),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.00045, --size of the picture (invisible)
		holo_pos = Vector(-0.43, 2.7, 2), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_valday_krechet_mark.png"),
		holo_size = 2.5, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["holo14"] = {
		"sight",
		"models/weapons/arc9_eft_shared/atts/optic/eft_optic_xps3_0.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 0, -0.05),
		offsetView = Vector(-1.45, 0, 9),
		{},
		mountType = "picatinny",
		--holo settings go here
		size = 0.00055, --size of the picture (invisible)
		holo_pos = Vector(-0.55, 2, 2), --pos of the picture (invisible)
		scale = Vector(1, 1.5, 1), --resize the picture (invisible)
		holo = Material("vgui/arc9_eft_shared/reticles/new/scope_all_eotech_xps3-0_marks.png"),
		holo_size = 2, --size of the holo
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(0, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic0"] = {
		"sight", --встроенный
		"",
		Angle(0, 0, 0),
		{},
	},
	["optic1"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_compact_prism.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 0, -0.02),
		offsetView = Vector(-1.3, 0, 9),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("holo/huy-collimator6.png"),
		localScopePos = Vector(2, 1.28, -0.01),
		scope_blackout = 100,
		rot = 0,
		FOVMin = 12,
		FOVMax = 12,
		FOVScoped = 40,
		blackoutsize = 3000,
		sizeperekrestie = 128,
		mount = "models/weapons/arc9_eft_shared/atts/mount/eft_mount_ta51.mdl",
		mountVec = Vector(0, 0, 0),
		mountAng = Angle(0, 0, 0),
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic2"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_fullfield_tac30.mdl",
		Angle(0, 0, -90),
		offset = Vector(2, 1, 0),
		offsetView = Vector(0, 0, 12),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("decals/perekrestie10.png"),
		localScopePos = Vector(2, 0, 0),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 4,
		FOVMax = 12,
		FOVScoped = 40,
		blackoutsize = 3000,
		sizeperekrestie = 2200,
		perekrestieSize = true,
		mount = "models/weapons/arc9/darsu_eft/mods/mount_all_utg_rings.mdl",
		mountVec = Vector(-1.5, 0, -0.8),
		mountAng = Angle(0, 0, 0),
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic3"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_all_valday_ps320.mdl",
		Angle(0, 0, -90),
		offset = Vector(-1, 0, -0.02),
		offsetView = Vector(-1.42, 0, 7),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("decals/perekrestie11.png"),
		localScopePos = Vector(2, 1.4, 0),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 3,
		FOVMax = 12,
		FOVScoped = 40,
		blackoutsize = 3000,
		sizeperekrestie = 2048,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic4"] = {
		"sight",
		"models/weapons/arc9_eft_shared/atts/optic/dovetail/pso1m2.mdl",
		Angle(0, 0, -90),
		{},
		offset = Vector(-2, 0, 0.3),
		offsetView = Vector(-0.6, 0.56, 6.5),
		mountType = "dovetail",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_dovetail_belomo_pso_1m2_1_4x24_marks_1.png"),
		localScopePos = Vector(3, 0.6, -0.56),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 6,
		FOVMax = 6,
		FOVScoped = 40,
		blackoutsize = 3000,
		sizeperekrestie = 1000,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic5"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_razor_hd.mdl",
		Angle(0, 0, -90),
		offset = Vector(1, 1.8, 0),
		offsetView = Vector(0, 0, 12),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_30mm_razor_hd_gen_2_1_6x24_mark.png"),
		localScopePos = Vector(2, -0.02, 0),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 2,
		FOVMax = 20,
		FOVScoped = 40,
		blackoutsize = 3500,
		sizeperekrestie = 4000,
		perekrestieSize = true,
		mount = "models/weapons/arc9/darsu_eft/mods/mount_all_geissele_super_precision.mdl",
		mountVec = Vector(-3, 0, -1.6),
		mountAng = Angle(0, 0, 0),
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic6"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_leupold_mark4.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 1.5, 0),
		offsetView = Vector(0, 0, 12),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_30mm_leupold_mark4_lr_6,5_20x50_marks.png"),
		localScopePos = Vector(0, -0.02, 0),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 1,
		FOVMax = 7,
		FOVScoped = 40,
		blackoutsize = 2000,
		sizeperekrestie = 2300,
		perekrestieSize = true,
		mount = "models/weapons/arc9/darsu_eft/mods/mount_all_lobaev_dvl.mdl",
		mountVec = Vector(-1.8, 0, -1.5),
		mountAng = Angle(0, 0, 0),
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic7"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_sig_bravo4.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 0, 0),
		offsetView = Vector(-1.35, 0, 8),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_all_sig_bravo4_4x30_marks.png"),
		localScopePos = Vector(0, 1.35, 0),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 8,
		FOVMax = 8,
		FOVScoped = 40,
		blackoutsize = 2700,
		sizeperekrestie = 2300,
		perekrestieSize = true,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic8"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_leupold_mark4_hamr.mdl",
		Angle(0, 0, -90),
		offset = Vector(0, 0, 0),
		offsetView = Vector(-1.65, 0, 8),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_all_leupold_mark4_hamr_marks.png"),
		localScopePos = Vector(0, 1.62, 0),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 9,
		FOVMax = 9,
		FOVScoped = 40,
		blackoutsize = 2700,
		sizeperekrestie = 2500,
		perekrestieSize = true,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic9"] = {
		"sight",
		"models/weapons/arc9_eft_shared/atts/scope/eft_scope_ta01.mdl",
		Angle(0, 0, -90),
		offset = Vector(1, 0.3, -0.05),
		offsetView = Vector(-1.25, 0, 8),
		{},
		mountType = "picatinny",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_base_trijicon_acog_ta11_3.5x35_marks.png"),
		localScopePos = Vector(0, 1.25, 0),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 9,
		FOVMax = 9,
		FOVScoped = 40,
		blackoutsize = 2700,
		sizeperekrestie = 4500,
		perekrestieSize = true,

		mount = "models/weapons/arc9/darsu_eft/mods/mount_vulcan_gen3.mdl",
		mountVec = Vector(-0.9, 0, -0.3),
		mountAng = Angle(0, -180, 0),

		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic11"] = {
		"sight",
		"models/weapons/arc9_eft_shared/atts/optic/dovetail/pso1m2.mdl",
		Angle(0, 0, -90),
		{},
		offset = Vector(-2, 0, 0.3),
		offsetView = Vector(-0.6, 0.56, 6.5),
		mountType = "dovetail",
		scopemat = Material("decals/scope2.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/new/scope_dovetail_belomo_pso_1m2_1_4x24_marks_0.png"),
		localScopePos = Vector(3, 0.6, -0.56),
		scope_blackout = 400,
		rot = 0,
		FOVMin = 6,
		FOVMax = 6,
		FOVScoped = 40,
		blackoutsize = 3000,
		sizeperekrestie = 1000,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
	},
	["optic12"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_eotech_vudu.mdl",
		Angle(0, 0, -90),
		{},
		offset = Vector(6, 0.2, 0),
		offsetView = Vector(0, 0, 14),
		mountType = "kar98mount",
		scopemat = Material("decals/scope3.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/adjustable/sb_pm_ii_3-12x50_mark_q.png"),
		localScopePos = Vector(2, 0, 0),
		scope_blackout = 800,
		rot = 0,
		FOVMin = 5,
		FOVMax = 5,
		FOVScoped = 40,
		blackoutsize = 3000,
		sizeperekrestie = 3000,

		mount = "models/weapons/arc9_eft_shared/atts/mounts/mount_dovetail_sag_bit_bracket.mdl",
		mountVec = Vector(-3, 1, -1.5),
		mountAng = Angle(15, 90, 0),

		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0)
	},
	["thermal1"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_flir_rs32.mdl",
		Angle(0, 0, -90),
		{},
		offset = Vector(0, -0.1, 0),
		offsetView = Vector(-1.5, 0, 8),
		mountType = "picatinny",
		colorthermal = {255,255,255},
		scopemat = Material("vgui/arc9_eft_shared/reticles/scope_all_flir_rs32_225_9x_35_60hz_mark_225x.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_all_flir_rs32_225_9x_35_60hz_mark_225x.png"),
		localScopePos = Vector(4, 3.3, 0),
		scope_blackout = 800,
		rot = 0,
		FOVMin = 5,
		pos_perekrestie = {
			x = 260,
			y = 250,
		},
		modifythermal = {
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 1,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = -0.3,
			["$pp_colour_contrast"] = 1,
			["$pp_colour_colour"] = 0,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		},
		FOVMax = 20,
		FOVScoped = 0,
		blackoutsize = 3000,
		sizeperekrestie = 3500,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0)
	},
	["thermal2"] = {
		"sight",
		"models/weapons/arc9/darsu_eft/mods/scope_sig_sauer_echo1.mdl",
		Angle(0, 0, -90),
		{},
		offset = Vector(0, -0.1, 0),
		offsetView = Vector(-1.8, 0, 8),
		mountType = "picatinny",
		colorthermal = {255,255,255},
		scopemat = Material("decals/scope3.png"),
		mat = Material("effects/arc9/rt"),
		perekrestie = Material("vgui/arc9_eft_shared/reticles/scope_all_flir_rs32_225_9x_35_60hz_mark_225x.png"),
		localScopePos = Vector(4, 3.3, 0),
		scope_blackout = 800,
		rot = 0,
		FOVMin = 20,
		pos_perekrestie = {
			x = 260,
			y = 250,
		},
		modifythermal = {
			["$pp_colour_addr"] = 1.5,
			["$pp_colour_addg"] = 1,
			["$pp_colour_addb"] = 7.1,
			["$pp_colour_brightness"] = -2.5,
			["$pp_colour_contrast"] = 0.2,
			["$pp_colour_colour"] = 0.4,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		},
		FOVMax = 20,
		FOVScoped = 0,
		blackoutsize = 3000,
		sizeperekrestie = 3500,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0)
	},
	["ironsight1"] = {
		"sight",
		"models/weapons/arc9_eft_shared/atts/ironsight/eft_rearsight_mbus.mdl",
		Angle(0, 0, -90),
		offset = Vector(-2.5, 0.2, 0),
		offsetView = Vector(-1.4, 0, 12),
		{},
		mountType = "picatinny",
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(0, 90, 0),
		mount = "models/weapons/arc9_eft_shared/atts/ironsight/eft_frontsight_mbus.mdl",
		mountVec = Vector(10, 0, 0),
		mountAng = Angle(0, 180, 0),
	}
}

--[[["optic5"] = {--arhandle mount gettfouttahere!!!
        "sight",
        "models/weapons/arc9/darsu_eft/mods/scope_acog_ta11.mdl",
        Angle(0,0,-90),
        {},
        offset = Vector(-1,0.9,-0.02),
        offsetView = Vector(-1.7,-0,9),

        scopemat = Material("decals/scope2.png"),
        mat = Material("effects/arc9/rt"),
        perekrestie = Material("decals/perekrestie8.png"),
        localScopePos = Vector(2,1.4,0),
        scope_blackout = 400,
        rot = 0,
        FOVMin = 4,
        FOVMax = 4,
        FOVScoped = 40,
        blackoutsize = 3000,
        sizeperekrestie = 2048,

        PhysModel = "models/hunter/plates/plate025.mdl",
        PhysPos = Vector(1,0,0),
        PhysAng = Angle(0,90,0)
    },--]]
function hg.attachmentFunc(self, attachmentData)
	self.size = attachmentData.size or self.size
	self.holo_pos = attachmentData.holo_pos or self.holo_pos
	self.scale = attachmentData.scale or self.scale
	self.holo = attachmentData.holo or self.holo
	self.holo_size = attachmentData.holo_size or self.holo_size
	--self.holo_view = curAtt[4] or self.holo_view
	self.pos_perekrestie = attachmentData.pos_perekrestie or self.pos_perekrestie
	self.perekrestieSize = attachmentData.perekrestieSize
	self.mat = attachmentData.mat or self.mat
	self.colorthermal = attachmentData.colorthermal or self.colorthermal
	self.modifythermal = attachmentData.modifythermal or self.modifythermal
	self.scopemat = attachmentData.scopemat or self.scopemat
	self.perekrestie = attachmentData.perekrestie or self.perekrestie
	self.localScopePos = attachmentData.localScopePos or self.localScopePos
	self.scope_blackout = attachmentData.scope_blackout or self.scope_blackout
	self.rot = attachmentData.rot or self.rot
	self.FOVMin = attachmentData.FOVMin or self.FOVMin
	self.FOVMax = attachmentData.FOVMax or self.FOVMax
	self.FOVScoped = attachmentData.FOVScoped or self.FOVScoped
	self.blackoutsize = attachmentData.blackoutsize or self.blackoutsize
	self.sizeperekrestie = attachmentData.sizeperekrestie or self.sizeperekrestie
end

hg.attachments.mount = {
	["empty"] = {"mount", "", Angle(0, 0, 0), {}},
	["mount1"] = {
		"mount",
		"models/wystan/attachments/akrailmount.mdl",
		Angle(90, -0, -90),
		{
			[0] = "pwb/models/weapons/w_akm/akm"
		}
	},
	["mount2"] = {"mount", "models/weapons/arc9/darsu_eft/mods/mount_all_larue_picatinny_raiser_qd_lt101.mdl", Angle(0, -0, -90), {}},
	["mount3"] = {"mount", "models/weapons/arc9_eft_shared/atts/mounts/mount_dovetail_pilad.mdl", Angle(90, 0, -90), {}},
}

hg.attachments.barrel = {
	["empty"] = {"barrel", "", Angle(0, 0, 0), {}},
	["supressor0"] = {
		"barrel", --встроенный
		"",
		Angle(0, 0, 0),
		{}
	},
	["supressor1"] = {"barrel","models/weapons/upgrades/a_suppressor_ak.mdl", Angle(0, 0, 0), {},offset = Vector(0.1, -0.5, -0.2),},
	["supressor2"] = {"barrel", "models/cw2/attachments/556suppressor.mdl", Angle(0, 90, 0), {},offset = Vector(4 - 17 - 4, 0.55 - 1, -3.15),},
	["supressor3"] = {"barrel", "models/weapons/tfa_ins2/upgrades/usp_match/w_suppressor_pistol.mdl", Angle(0, 0, -90), {},offset = Vector(-7+1, -3.4+0.5, 0),},
	["supressor4"] = {"barrel", "models/cw2/attachments/9mmsuppressor.mdl", Angle(0, -90, 0), {},offset = Vector(4, -0.4, -1.25),},
	["supressor5"] = {"barrel", "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl", Angle(0, 0, 0), {},offset = Vector(-31, 2.2, 1.85),},
	["supressor6"] = {"barrel", "models/atts/homemadesuppressor/plastic_bottle_1.mdl", Angle(-90, 0, 0), {}, modelscale = 0.75, offset = Vector(11.5,-0.5,-0.1),},
	["supressor7"] = {"barrel", "models/mass_effect_3/weapons/misc/mods/pistols/barrela.mdl", modelscale = 1, offset = Vector(11.5,-0.5,-0.1)}
}

hg.attachments.grip = {
	["grip1"] = {
		"grip",
		"models/weapons/arc9/darsu_eft/mods/fg_rk2.mdl",
		Angle(180, 180, 90),
		{},
		offset = Vector(-16.9, -1.3, -0.15),
		holdtype = "smg",
		mountType = "picatinny",
		recoilReduction = 0.5,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(180, 180, 90),
	}, -- models/weapons/arc9/darsu_eft/mods/fg_ash12.mdl
	["grip2"] = {
		"grip",
		"models/weapons/arc9/darsu_eft/mods/fg_ash12.mdl",
		Angle(180, 180, 90),
		{},
		offset = Vector(-17, -1.4, 0),
		holdtype = "smg",
		mountType = "picatinny",
		recoilReduction = 0.5,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(180, 180, 90),
	},
	["grip3"] = {
		"grip",
		"models/weapons/arc9/darsu_eft/mods/fg_afg.mdl",
		Angle(180, 180, 90),
		{},
		offset = Vector(-17, -1.6, 0),
		holdtype = "ar2",
		mountType = "picatinny",
		recoilReduction = 0.5,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(180, 180, 90),
	}
}

hg.attachments.underbarrel = {
	["laser1"] = {
		"underbarrel",
		"models/weapons/arc9/darsu_eft/mods/tac_ncstar_tbl.mdl",
		Angle(180, 180, 90),
		{},
		offset = Vector(-16.9, -1.3, -0.15),
		offsetPos = Vector(0, -0, 0.73),
		mountType = "picatinny",
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(180, 180, 90),
		color = Color(75, 0, 146, 150),
	},
	["laser2"] = {
		"underbarrel",
		"models/weapons/arc9/darsu_eft/mods/tac_kleh2.mdl",
		Angle(180, 180, 90),
		{},
		offset = Vector(-16.9, -1.3, -0.15),
		offsetPos = Vector(0, -0, 0.73),
		mountType = "picatinny",
		supportFlashlight = true,
		mat = nil,
		farZ = 1600,
		size = 50,
		brightness = 70,
		brightness2 = 0.3,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(180, 180, 90),
		color = Color(255, 0, 0, 150),
	},
	["laser3"] = {
		"underbarrel",
		"models/weapons/arc9/darsu_eft/mods/tac_baldr_pro.mdl",
		Angle(180, 180, 90),
		{},
		offset = Vector(-16.9, -1.3, -0.35),
		offsetPos = Vector(0, -0, 0.73),
		mountType = "picatinny",
		supportFlashlight = true,
		mat = nil,
		farZ = 1600,
		size = 50,
		brightness = 70,
		brightness2 = 0.3,
		PhysModel = "models/hunter/plates/plate025.mdl",
		PhysPos = Vector(1, 0, 0),
		PhysAng = Angle(180, 180, 90),
		color = Color(0, 0, 0, 0),
	},
}
hg.attachments.magwell = {
	["mag1"] = {
		"magwell",
		"models/weapons/arc9/darsu_eft/mods/mag_glock_drum_50.mdl",
		Angle(180, 180, 90),
		{},
		offsetPos = Vector(0, 0, 0),
		capacity = 50,
		ammotype = "9x19 mm Parabellum",
	}
}

local attNames = {
	["supressor1"] = "PBS-1",
	["supressor2"] = "Silencerco Saker 556 ASR",
	["supressor3"] = "KAC HK USP-T",
	["supressor4"] = "Gemtech TUNDRA-SV 9mm Supressor",
	["supressor5"] = "Ротор 43 12К",
	["supressor6"] = "Homemade Suppressor",
	["holo1"] = "EOTech 552",
	["holo2"] = "KOBRA ЭКП-8-18",
	["optic1"] = "Aimpoint COMP M2",
	["optic2"] = "Fullfield TAC 30",
	["optic3"] = "Валдай ПС-320 1x/6x",
	["optic4"] = "ПСО-1",
	["optic5"] = "Vortex Razor HD Gen.2 1-6x24",
	["optic11"] = "ПСО-1М2",
	["laser1"] = "TBL Blue Laser",
	["laser2"] = "Klesch Laser + Flashlight",
	["grip1"] = "RK-2",
	["holo3"] = "ROMEO8T",
	["holo4"] = "Walther \"MRS\"",
	["optic6"] = "Leupold Mark 4 LR 6.5-20x50",
	["laser3"] = "Olight \"Baldr Pro\"",
	["optic7"] = "SIG Sauer \"BRAVO4 4X30\"",
	["optic8"] = "Leupold \"Mark 4 HAMR 4x24mm DeltaPoint\"",
	["mag1"] = "Rounded mag Glock18 32 Bullets",
	["grip2"] = "ASh-12 Vertical Grip",
	["grip3"] = "Magpul AFG Tactical Grip",
	["holo5"] = "\"ОКП-7\"",
	["holo6"] = "\"ОКП-7\" Dovetail",
	["holo7"] = "BelOMO PK-06",
	["holo8"] = "Holosun \"HS401G5\"",
	["holo9"] = "Leapers \"UTG\"",
	["holo11"] = "Trijicon\"SRS-02\"",
	["holo12"] = "Valday PK-120",
	["holo13"] = "Valday Krechet",
	["ironsight1"] = "MBUS backiron and foreiron",
	["holo14"] = "EOTech \"XPS3-0\"",
	["optic9"] = "Trijicon \"ACOG TA01NSN 4x32\"",
	["optic12"] = "Sight for kar98k",
	["thermal1"] = "FLIR RS-32",
	["thermal2"] =  "SIG Sauer ECHO1",
}

local attachmentsIcons = {
	["supressor1"] = "vgui/icons/silencer_akm",
	["supressor2"] = "vgui/icons/silencer_assaultrifle",
	["supressor3"] = "vgui/icons/silencer_usp",
	["supressor4"] = "entities/eft_attachments/muzzles/srd9.png",
	["supressor5"] = "entities/eft_attachments/muzzles/rotor.png",
	["supressor6"] = "scrappers/homemadesuppressor.png",
	["holo1"] = "vgui/icons/sights_eotech",
	["holo2"] = "vgui/icons/sights_kobra",
	["optic1"] = "entities/eft_attachments/scopes/compm4.png",
	["optic2"] = "entities/eft_attachments/scopes/30mmtac30.png",
	["optic3"] = "entities/eft_attachments/scopes/ps320.png",
	["optic4"] = "entities/eft_attachments/scopes/s_pso1m2.png",
	["optic5"] = "entities/eft_attachments/scopes/30mmrazor.png",
	["laser1"] = "entities/eft_attachments/tactical/tbl.png",
	["laser2"] = "entities/eft_attachments/tactical/k2iks.png",
	["grip1"] = "entities/eft_attachments/foregrips/rk2.png",
	["holo3"] = "entities/eft_attachments/scopes/romeo8t.png",
	["holo4"] = "entities/eft_attachments/scopes/mrs.png",
	["optic6"] = "entities/eft_attachments/scopes/30mmmark4.png",
	["laser3"] = "entities/eft_attachments/tactical/baldr.png",
	["optic7"] = "entities/eft_attachments/scopes/bravo4.png",
	["optic8"] = "entities/eft_attachments/scopes/hamr.png",
	["grip2"] = "entities/eft_attachments/foregrips/ash12.png",
	["grip3"] = "entities/eft_attachments/foregrips/afg.png",
	["holo5"] = "entities/eft_attachments/scopes/okp7.png",
	["holo6"] = "entities/eft_attachments/scopes/s_okp.png",
	["holo7"] = "entities/eft_attachments/scopes/pk06.png",
	["holo8"] = "entities/eft_attachments/scopes/hs401g5.png",
	["holo9"] = "entities/eft_attachments/scopes/utg.png",
	["holo11"] = "entities/eft_attachments/scopes/srs02.png",
	["holo12"] = "entities/eft_attachments/scopes/pk120.png",
	["holo13"] = "entities/eft_attachments/scopes/krechet.png",
	["ironsight1"] = "entities/eft_attachments/ironsights/mbus.png",
	["mag1"] = "entities/eft_attachments/mags/eft_mag_drum545.png",
	["holo14"] = "entities/eft_attachments/scopes/xps3.png",
	["optic9"] = "entities/eft_attachments/scopes/ta01nsn.png",
	["optic11"] = "entities/eft_attachments/scopes/s_pso1m2.png",
	["optic12"] = "entities/eft_attachments/scopes/30mmvudu.png",
	["thermal1"] = "entities/eft_attachments/scopes/flir.png",
	["thermal2"] = "entities/eft_attachments/scopes/echo.png",
}

local attCategoryNames = {
	["sight"] = "Sights",
	["barrel"] = "Muzzles",
	["underbarrel"] = "Underbarrel",
	["magwell"] = "Magwells",
	["mount"] = "Mounts",
	["grip"] = "Grips"
}
hg.attachmentslaunguage = attNames
hg.attachmentsIcons = attachmentsIcons
local function initAttachments()
	for possibleAtt, attachments in pairs(hg.attachments) do
		for attachment, attData in pairs(attachments) do
			if CLIENT then language.Add(attachment, attNames[attachment] or attachment) end
			local att = {}
			att.Base = "attachment_base"
			att.PrintName = CLIENT and language.GetPhrase(attachment) or attachment
			att.name = attachment
			att.Category = "HG Attachments " .. (attCategoryNames[possibleAtt] or "")
			att.Spawnable = not (string.find(attachment, "0") or string.find(attachment, "empty") or string.find(attachment, "mount"))
			att.Model = attData[2]
			att.WorldModel = attData[2]
			att.SubMats = attData[4]
			att.attachment = attData
			att.PhysModel = attData.PhysModel or nil
			att.PhysPos = attData.PhysPos or nil
			att.PhysAng = attData.PhysAng or nil
			att.IconOverride = attachmentsIcons[attachment]
			scripted_ents.Register(att, "ent_att_" .. attachment)
		end
	end
end

function hg.GetAttachmentTab(att)
	local found

	for ia,attPos in pairs(hg.attachments) do
		for i,fatt in pairs(attPos) do
			if i == att then found = ia end
		end
	end

	return found
end

function hg.GiveAttachment(ply,att)
	local att = string.Replace(att,"ent_att_","")
	local inv = ply:GetNetVar("Inventory",{})

	inv["Attachments"] = inv["Attachments"] or {}

	--if not table.HasValue(inv["Attachments"],att) then
	inv["Attachments"][#inv["Attachments"] + 1] = att

	ply:SetNetVar("Inventory",inv)
	--end
end

function hg.NotValidAtt(att)
	local att = isstring(att) and att or istable(att) and isstring(att[1]) and att[1]
	
	if att then
		local att = string.Replace(att,"ent_att_","")

		return (not att) or string.find(att,"0") or string.find(att,"empty") or string.find(att,"mount")
	end

	return true
end

function hg.IsValidAtt(att)
	return not hg.NotValidAtt(att)
end

initAttachments()
hook.Add("Initialize", "init-atts", initAttachments)