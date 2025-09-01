-- Path scripthooked:lua\\autorun\\sh_hg_ammo.lua"
-- Scripthooked by ???
--
hg.ammotypes = {
	["5.56x45mm"] = {
		name = "5.56x45 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 120,
		minsplash = 5,
		maxsplash = 5,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 2,
			TracerLength = 155,
			TracerWidth = 2,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 44,
			Force = 44,
			Penetration = 13,
			Shell = "556x45"
		}
	},
	["5.56x45mmredtracer"] = {
		name = "5.56x45 mm Red Tracer",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 120,
		minsplash = 5,
		maxsplash = 5,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 90,
			TracerLength = 255,
			TracerWidth = 5,
			TracerColor = Color(255, 0, 0),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 44,
			Force = 44,
			Penetration = 13,
			Shell = "556x45"
		}
	},
	["5.56x45mmap"] = {
		name = "5.56x45 mm AP",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 120,
		minsplash = 5,
		maxsplash = 5,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 2,
			TracerLength = 155,
			TracerWidth = 2,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 44,
			Force = 44,
			Penetration = 15,
			Shell = "556x45"
		}
	},
	["7.62x39mm"] = {
		name = "7.62x39 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 160,
		maxcarry = 120,
		minsplash = 8,
		maxsplash = 8,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 2,
			TracerLength = 175,
			TracerWidth = 2,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 50,
			Force = 50,
			Penetration = 15,
			Shell = "762x39"
		}
	},
	["5.45x39mm"] = {
		name = "5.45x39 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 120,
		minsplash = 5,
		maxsplash = 5,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 2,
			TracerLength = 155,
			TracerWidth = 2,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 35,
			Force = 35,
			Penetration = 11,
			Shell = "545x39"
		}
	},
	["12/70gauge"] = {
		name = "12/70 gauge",
		dmgtype = DMG_BUCKSHOT,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 350,
		maxcarry = 46,
		minsplash = 15,
		maxsplash = 15,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 1,
			TracerLength = 15,
			TracerWidth = 1,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 10000,
			NoSpin = true,
		},
		BulletSetings = {
			Damage = 16,
			Force = 12,
			Penetration = 8,
			NumBullet = 8,
			Shell = "12x70"
		}
	},
	["12/70beanbag"] = {
		name = "12/70 beanbag",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 46,
		minsplash = 0,
		maxsplash = 0,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 1.5,
			TracerLength = 155,
			TracerWidth = 5,
			TracerColor = Color(70, 78, 36),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 3000,
			NoSpin = true,
		},
		BulletSetings = {
			Damage = 6,
			Force = 4,
			Penetration = 2,
			Shell = "12x70beanbag",
			Spread = Vector(0, 0, 0),
		}
	},
	["12/70slug"] = {
		name = "12/70 Slug",
		dmgtype = DMG_BUCKSHOT,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 250,
		maxcarry = 46,
		minsplash = 15,
		maxsplash = 15,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 1.5,
			TracerLength = 25,
			TracerWidth = 3,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 10000,
			NoSpin = true,
		},
		BulletSetings = {
			Damage = 70,
			Force = 70,
			Penetration = 15,
			Shell = "12x70slug",
			Spread = Vector(0, 0, 0),
		}
	},
	["9x18mm"] = {
		name = "9x18 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 90,
		maxcarry = 80,
		minsplash = 1,
		maxsplash = 1,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 1,
			TracerLength = 45,
			TracerWidth = 1,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 15000
		},
		BulletSetings = {
			Damage = 24,
			Force = 24,
			Penetration = 6,
			Shell = "9x18"
		}
	},
	["9x19mmparabellum"] = {
		name = "9x19 mm Parabellum",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 80,
		minsplash = 1,
		maxsplash = 1,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 1,
			TracerLength = 45,
			TracerWidth = 1,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 15000
		},
		BulletSetings = {
			Damage = 25,
			Force = 25,
			Penetration = 7,
			Shell = "9x19"
		}
	},
	["9x19mmgreentracer"] = {
		name = "9x19 mm Green Tracer",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 80,
		minsplash = 1,
		maxsplash = 1,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 55,
			TracerLength = 85,
			TracerWidth = 5,
			TracerColor = Color(0, 255, 0),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 15000
		},
		BulletSetings = {
			Damage = 25,
			Force = 25,
			Penetration = 7,
			Shell = "9x19"
		}
	},
	[".45rubber"] = {
		name = ".45 Rubber",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 80,
		minsplash = 0,
		maxsplash = 0,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 1,
			TracerLength = 5,
			TracerWidth = 1,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 6000,
			NoSpin = true,
		},
		BulletSetings = {
			Damage = 8,
			Force = 5,
			Penetration = 4,
			Shell = "9x18"
		}
	},
	["4.6x30mm"] = {
		name = "4.6x30 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 120,
		minsplash = 4,
		maxsplash = 4,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 2,
			TracerLength = 45,
			TracerWidth = 2.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 32,
			Force = 32,
			Penetration = 9,
			Shell = "556x45"
		}
	},
	["5.7x28mm"] = {
		name = "5.7x28 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 150,
		minsplash = 4,
		maxsplash = 4,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 45,
			TracerWidth = 2.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 32,
			Force = 32,
			Penetration = 10,
			Shell = "556x45"
		}
	},
	[".44remingtonmagnum"] = {
		name = ".44 Remington Magnum",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 100,
		maxcarry = 150,
		minsplash = 3,
		maxsplash = 3,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 35,
			TracerWidth = 2.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 20000
		},
		BulletSetings = {
			Damage = 40,
			Force = 40,
			Penetration = 10,
			Shell = "10mm"
		}
	},
	[".357magnum"] = {
		name = ".357 Magnum",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 130,
		maxcarry = 150,
		minsplash = 2.5,
		maxsplash = 2.5,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 35,
			TracerWidth = 2.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 20000
		},
		BulletSetings = {
			Damage = 35,
			Force = 35,
			Penetration = 10,
			Shell = "10mm"
		}
	},
	["9x39mm"] = {
		name = "9x39 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 150,
		maxcarry = 150,
		minsplash = 5,
		maxsplash = 5,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 75,
			TracerWidth = 2.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 0.5,
			TracerSpeed = 15000
		},
		BulletSetings = {
			Damage = 42,
			Force = 42,
			Penetration = 15,
			Shell = "762x39"
		}
	},
	[".50actionexpress"] = {
		name = ".50 Action Express",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 150,
		maxcarry = 150,
		minsplash = 6,
		maxsplash = 6,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 35,
			TracerWidth = 1.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 40,
			Force = 40,
			Penetration = 11,
			Shell = "50ae"
		}
	},
	["7.62x51mm"] = {
		name = "7.62x51 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 250,
		maxcarry = 120,
		minsplash = 10,
		maxsplash = 10,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 75,
			TracerWidth = 1.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 65,
			Force = 65,
			Penetration = 15,
			Shell = "762x51"
		}
	},
	["7.62x54mm"] = {
		name = "7.62x54 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 250,
		maxcarry = 120,
		minsplash = 11,
		maxsplash = 11,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 75,
			TracerWidth = 2,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 70,
			Force = 70,
			Penetration = 20,
			Shell = "762x54"
		}
	},
	[".338lapuamagnum"] = {
		name = ".338 Lapua Magnum",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 400,
		maxcarry = 120,
		minsplash = 15,
		maxsplash = 15,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 105,
			TracerWidth = 5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 180,
			Force = 60,
			Penetration = 35,
			Shell = ".338Lapua"
		}
	},
	[".22longrifle"] = {
		name = ".22 Long Rifle",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 70,
		maxcarry = 120,
		minsplash = 1,
		maxsplash = 1,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = .5,
			TracerLength = 55,
			TracerWidth = .5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 10000
		},
		BulletSetings = {
			Damage = 17,
			Force = 20,
			Penetration = 6.5,
			Shell = "9x19"
		}
	},
	["rpg-7projectile"] = {
		name = "RPG-7 Projectile",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 5000,
		maxcarry = 120,
		minsplash = 10,
		maxsplash = 5
	},
	["12.7x108mm"] = {
		name = "12.7x108 mm",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 550,
		maxcarry = 120,
		minsplash = 20,
		maxsplash = 20,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 5,
			TracerLength = 150,
			TracerWidth = 8.5,
			TracerColor = Color(255, 237, 155),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 45000
		},
		BulletSetings = {
			Damage = 150,
			Force = 40,
			Penetration = 60,
			Shell = "50cal"
		}
	},
	["nails"] = {
		name = "Nails",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 50,
		maxcarry = 120,
		minsplash = 10,
		maxsplash = 5
	},
	["armature"] = {
		name = "Armature",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 150,
		maxcarry = 120,
		minsplash = 10,
		maxsplash = 5
	},
	["pulse"] = {
		name = "Pulse",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 120,
		maxcarry = 120,
		minsplash = 16,
		maxsplash = 16,
		TracerSetings = {
			TracerBody = Material("particle/fire"),
			TracerTail = Material("effects/laser_tracer"),
			TracerHeadSize = 25,
			TracerLength = 150,
			TracerWidth = 1.5,
			TracerColor = Color(155, 232, 255),
			TracerTPoint1 = 0.25,
			TracerTPoint2 = 1,
			TracerSpeed = 25000
		},
		BulletSetings = {
			Damage = 50,
			Force = 50,
			Penetration = 17,
			Shell = "Pulse"
		}
	}
}

local ammotypes = hg.ammotypes
--[[
name = "5.56x45 mm",

name = "7.62x39 mm",

name = "5.45x39 mm",

name = "12/70 gauge",

name = "12/70 beanbag",

name = "9x19 mm Parabellum",

name = ".45 Rubber",

name = "4.6×30 mm",

name = "5.7×28 mm",

name = ".44 Remington Magnum",

name = "9x39 mm",

name = ".50 Action Express",

name = "7.62x51 mm",

name = "7.62x54 mm",

name = ".338 Lapua Magnum"
]]
local ammoents = {
	["5.56x45mm"] = {
		Material = "models/hmcd_ammobox_556",
		Scale = 1
	},
	["5.56x45mmap"] = {
		Model = "models/zcity/ammo/ammo_556x45_ap.mdl",
		Scale = 1,
	},
	["5.56x45mmredtracer"] = {
		Material = "models/hmcd_ammobox_556",
		Scale = 1,
		Color = Color(255,0,0)
	},
	["7.62x39mm"] = {
		Model = "models/items/ammo_76239.mdl",
		Scale = 1
	},
	["7.62x51mm"] = {
		Model = "models/items/ammo_76251.mdl",
		Scale = 1,
		Count = 25,
	},
	["7.62x54mm"] = {
		Model = "models/zcity/ammo/ammo_762x54_7h1.mdl",
		Scale = 1,
		Count = 25,
	},
	["5.45x39mm"] = {
		Model = "models/zcity/ammo/ammo_545x39_fmj.mdl",
		Scale = 1,
	},
	["12/70gauge"] = {
		Material = "models/hmcd_ammobox_12",
		Scale = 1.1,
		Count = 12,
	},
	["12/70beanbag"] = {
		Model = "models/ammo/beanbag12_ammo.mdl",
		Scale = 1,
		Count = 12,
	},
	["12/70slug"] = {
		Model = "models/zcity/ammo/ammo_12x76_zhekan.mdl",
		Scale = 1.1,
		Count = 12,
		Color = Color(125, 155, 95)
	},
	["9x18mm"] = {
		Model = "models/zcity/ammo/ammo_9x18_pmm.mdl",
		Scale = 1
	},
	["9x19mmparabellum"] = {
		Material = "models/hmcd_ammobox_9",
		Scale = 0.8,
	},
	["9x19mmgreentracer"] = {
		Material = "models/hmcd_ammobox_9",
		Color = Color(0, 255, 0),
		Scale = 0.8
	},
	[".45rubber"] = {
		Model = "models/ammo/beanbag9_ammo.mdl",
		Scale = 1
	},
	["4.6x30mm"] = {
		Model = "models/4630_ammobox.mdl",
		Scale = 1,
	},
	[".44remingtonmagnum"] = {
		Material = "models/hmcd_ammobox_22",
		Color = Color(125, 155, 95),
		Scale = 0.8,
		Count = 20,
	},
	[".357magnum"] = {
		Material = "models/hmcd_ammobox_38",
		Color = Color(255, 255, 255),
		Scale = 0.8,
		Count = 20,
	},
	["9x39mm"] = {
		Model = "models/zcity/ammo/ammo_9x39_sp5.mdl",
		Scale = 1,
		Count = 20,
	},
	["5.7x28mm"] = {
		Material = "models/hmcd_ammobox_22",
		Scale = 1.2,
		Color = Color(125, 155, 95)
	},
	[".50actionexpress"] = {
		Material = "models/hmcd_ammobox_22",
		Scale = 1,
		Color = Color(255, 255, 125),
		Count = 20,
	},
	[".338lapuamagnum"] = {
		Material = "models/hmcd_ammobox_792",
		Scale = 1,
		Color = Color(125, 255, 125),
		Count = 20,
	},
	["12.7x108mm"] = {
		Material = "models/hmcd_ammobox_792",
		Scale = 1.6,
		Color = Color(225, 122, 125),
		Count = 20,
	},
	[".22longrifle"] = {
		Material = "models/hmcd_ammobox_22",
		Scale = 1
	},
	["rpg-7projectile"] = {
		Model = "models/weapons/tfa_ins2/w_rpg7_projectile.mdl",
		Count = 1
	},
	["nails"] = {
		Material = "models/hmcd_nails",
		Scale = 1,
		Count = 3,
	},
	["armature"] = {
		Model = "models/Items/CrossbowRounds.mdl",
		Count = 5
	},
	["pulse"] = {
		Model = "models/Items/combine_rifle_cartridge01.mdl",
		Count = 30
	}
}

local function addAmmoTypes()
	for name, tbl in pairs(ammotypes) do
		game.AddAmmoType(tbl)
		if CLIENT then language.Add(tbl.name .. "_ammo", tbl.name) end
		local ammoent = {}
		ammoent.Base = "ammo_base"
		ammoent.PrintName = tbl.name
		ammoent.Category = "HG Ammo"
		ammoent.Spawnable = true
		ammoent.AmmoCount = ammoents[name].Count or 30
		ammoent.AmmoType = tbl.name
		ammoent.Model = ammoents[name].Model or "models/props_lab/box01a.mdl"
		ammoent.ModelMaterial = ammoents[name].Material or ""
		ammoent.ModelScale = ammoents[name].Scale or 1
		ammoent.Color = ammoents[name].Color or Color(255, 255, 255)
		scripted_ents.Register(ammoent, "ent_ammo_" .. name)
	end

	game.BuildAmmoTypes()
	--PrintTable(game.GetAmmoTypes())
end

addAmmoTypes()
hook.Add("Initialize", "init-ammo", addAmmoTypes)

if CLIENT then
    local blurMat = Material("pp/blurscreen")
    local Dynamic = 0
	local red = Color(75,25,25)
	local redselected = Color(150,0,0)

    local function BlurBackground(panel)
        if not((IsValid(panel))and(panel:IsVisible()))then return end
        local layers,density,alpha=1,1,255
        local x,y=panel:LocalToScreen(0,0)
        surface.SetDrawColor(255,255,255,alpha)
        surface.SetMaterial(blurMat)
        local FrameRate,Num,Dark=1/FrameTime(),5,150
        for i=1,Num do
            blurMat:SetFloat("$blur",(i/layers)*density*Dynamic)
            blurMat:Recompute()
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(-x,-y,ScrW(),ScrH())
        end
        surface.SetDrawColor(0,0,0,Dark*Dynamic)
        surface.DrawRect(0,0,panel:GetWide(),panel:GetTall())
        Dynamic=math.Clamp(Dynamic+(1/FrameRate)*7,0,1)
    end

    function AmmoMenu(ply)
        local ammodrop = 0
        if !ply:Alive() then return end
        local Frame = vgui.Create( "DFrame" )
        Frame:SetTitle( "Ammunition" )
        Frame:SetSize( 200,300 )
        Frame:Center()			
        Frame:MakePopup()
        Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
            draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 0, 0, 0, 140) )
            BlurBackground(Frame)
			surface.SetDrawColor( 255, 0, 0, 128)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
        end
        local DPanel = vgui.Create( "DScrollPanel", Frame )
        DPanel:SetPos( 5, 30 ) -- Set the position of the panel
        DPanel:SetSize( 190, 215 ) -- Set the size of the panel
        DPanel.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 140) )
        end

        local DermaNumSlider = vgui.Create( "DNumSlider", Frame )
        DermaNumSlider:SetPos( 10, 245 )				
        DermaNumSlider:SetSize( 210, 25 )			
        DermaNumSlider:SetText( "Count " )	
        DermaNumSlider:SetMin( 0 )				 	
        DermaNumSlider:SetMax( 60 )				
        DermaNumSlider:SetDecimals( 0 )				

        -- If not using convars, you can use this hook + Panel.SetValue()
        DermaNumSlider.OnValueChanged = function( self, value )
            ammodrop = math.Round(value)
        end

        local ammos = LocalPlayer():GetAmmo()

        for k,v in pairs(ammos) do
            local DermaButton = vgui.Create( "DButton", DPanel ) 
            DermaButton:SetText( game.GetAmmoName( k )..": "..v )	
            DermaButton:SetTextColor( Color(255,255,255) )	
            DermaButton:SetPos( 0, 0 )	
            DermaButton:Dock( TOP )
            DermaButton:DockMargin( 2, 2.5, 2, 0 )	
            DermaButton:SetSize( 120, 25 )

            DermaButton.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
                DermaButton.a = Lerp(0.1,DermaButton.a or 100,DermaButton:IsHovered() and 255 or 150)
				draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,DermaButton.a))
                --BlurBackground(DermaButton)
            end				
            DermaButton.DoClick = function()
                --print( math.min(ammodrop,v),game.GetAmmoName( k ))				
                net.Start( "drop_ammo" )
                    net.WriteFloat( k )
                    net.WriteFloat( math.min(ammodrop,v) )
                net.SendToServer()
                Frame:Close()
            end

            DermaButton.DoRightClick = function()
                net.Start( "drop_ammo" )
                    net.WriteFloat( k )
                    net.WriteFloat( math.min(v,v) )
                net.SendToServer()
                Frame:Close()
            end
        end
        local DLabel = vgui.Create( "DLabel", Frame )
        DLabel:SetPos( 10, 268 )
		DLabel:SetTextColor(Color(255,255,255))
        DLabel:SetText( "LMB - Drop count\nRMB - Drop all" )
        DLabel:SizeToContents()

    end

    concommand.Add( "hg_ammomenu", function( ply, cmd, args )
        AmmoMenu(ply)
    end )

	hook.Add("radialOptions", "hg-ammomenu", function()
		local organism = LocalPlayer().Organism or {}
		if not organism.Otrub and table.Count(LocalPlayer():GetAmmo()) > 0 then
			hg.radialOptions[#hg.radialOptions + 1] = {function() RunConsoleCommand("hg_ammomenu") end, "Drop Ammo"}
		end
	end)
end

if SERVER then
    util.AddNetworkString( "drop_ammo" )

    net.Receive( "drop_ammo", function( len, ply )
        if !ply:Alive() or ply.Organism.Otrub then return end
        local ammotype = net.ReadFloat()
        local count = net.ReadFloat()
        local pos = ply:EyePos()+ply:EyeAngles():Forward()*15
        if ply:GetAmmoCount(ammotype)-count < 0 then ply:ChatPrint(((math.random(1,100) == 100 or 1) and "I need mor booolets!!!" ) or "You don't have enogh ammo") return end
        if count < 1 then ply:ChatPrint("You can't drop zero ammo") return end
			--if not ammolistent[ammotype] then ply:ChatPrint("Invalid entitytype...") return end
			--print(game.GetAmmoName(ammotype))
        local AmmoEnt = ents.Create( "ent_ammo_"..string.lower( string.Replace(game.GetAmmoName(ammotype)," ", "") ) )
		if not IsValid(AmmoEnt) then return ply:ChatPrint("Invalid entitytype...") end
        AmmoEnt:SetPos( pos )
        AmmoEnt:Spawn()
        AmmoEnt.AmmoCount = count
        ply:SetAmmo(ply:GetAmmoCount(ammotype)-count,ammotype)
        ply:EmitSound("snd_jack_hmcd_ammobox.wav", 75, math.random(80,90), 1, CHAN_ITEM )
		ply.inventory.Ammo = ply:GetAmmo()
		ply:SetNetVar("Inventory",ply.inventory)
    end)
end