-- Path scripthooked:lua\\homigrad\\appearance\\sh_accessories.lua"
-- Scripthooked by ???
hg = hg or {}

hg.Accessories = {
	["none"] = {},

    ["eyeglasses"] = {
        model = "models/captainbigbutt/skeyler/accessories/glasses01.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = { Vector(3,-2.9,0), Angle(0,-70,-90), .9},
        fempos = {Vector(2.1,-2.7,0),Angle(0,-70,-90),.8},
        skin = 0,
        norender = true,
        placement = "face"
    },

    ["bugeye sunglasses"] = {
        model = "models/captainbigbutt/skeyler/accessories/glasses02.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(2.9,-2.2,0),Angle(0,-70,-90),.9},
        fempos = {Vector(2.9,-3.2,0),Angle(0,-70,-90),.8},
        skin = 0,
        norender = true,
        placement = "face"
    },

    ["bugeye sunglasses"] = {
        model = "models/captainbigbutt/skeyler/accessories/glasses04.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(2.2,-3.3,0),Angle(0,-70,-90),.9},
        fempos = {Vector(2.2,-3.3,0),Angle(0,-70,-90),.8},
        skin = 0,
        norender = true,
        placement = "face"
    },

    ["aviators"] = {
        model = "models/gmod_tower/aviators.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.2,-2.5,0),Angle(0,-80,-90),1},
        fempos = {Vector(2.3,-2.2,0),Angle(0,-85,-90),.95},
        skin = 0,
        norender = true,
        placement = "face"
    },

    ["nerd glasses"] = {
        model = "models/gmod_tower/klienerglasses.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.2,-2.6,0),Angle(0,-80,-90),1},
        fempos = {Vector(2.3,-2.2,0),Angle(0,-85,-90),.95},
        skin = 0,
        norender = true,
        placement = "face"
    },

    ["headphones"] = {
        model = "models/gmod_tower/headphones.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.6,-1,0),Angle(0,-80,-90),.85},
        fempos = {Vector(2.4,-1,0),Angle(0,-85,-90),.8},
        skin = 0,
        norender = true
    },

    ["baseball cap"] = {
        model = "models/gmod_tower/jaseballcap.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0,0),Angle(0,-75,-90), 1.12},
        fempos = {Vector(4,-0.1,0),Angle(0,-75,-90), 1.125},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["fedora"] = {
        model = "models/captainbigbutt/skeyler/hats/fedora.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5.5,-0.2,0),Angle(0,-80,-90), 0.7},
        fempos = {Vector(4.5,-0.2,0),Angle(0,-75,-90), 0.7},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["stetson"] = {
        model = "models/captainbigbutt/skeyler/hats/cowboyhat.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(6.2,0.6,0),Angle(0,-60,-90), 0.7},
        fempos = {Vector(5.2,0.5,0),Angle(0,-65,-90), 0.65},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["straw hat"] = {
        model = "models/captainbigbutt/skeyler/hats/strawhat.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5.2,-0.4,0),Angle(0,-70,-90), 0.85},
        fempos = {Vector(4.5,-0.5,0),Angle(0,-75,-90), 0.8},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["sun hat"] = {
        model = "models/captainbigbutt/skeyler/hats/sunhat.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(4.2,2,0),Angle(0,-90,-90), 0.8},
        fempos = {Vector(3.4,2,0),Angle(0,-90,-90), 0.75},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["bling cap"] = {
        model = "models/captainbigbutt/skeyler/hats/zhat.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.9,0.1,0.5),Angle(0,-80,-90), 0.75},
        fempos = {Vector(3.5,0.2,0),Angle(-10,-80,-90), 0.75},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["top hat"] = {
        model = "models/player/items/humans/top_hat.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(0,-1.5,0),Angle(0,-80,-90), 1},
        fempos = {Vector(-0.8,-1.8,0),Angle(0,-80,-90), 1},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["backpack"] = {
        model = "models/makka12/bag/jag.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-3,0,0),Angle(0,90,90),.75},
        fempos = {Vector(-3,-1,0),Angle(0,90,90),.6},
        skin = 0,
        norender = false
    },

    ["purse"] = {
        model = "models/props_c17/BriefCase001a.mdl",
        bone = "ValveBiped.Bip01_Spine1",
        malepos = {Vector(-7,1,7),Angle(0,90,100),.5},
        fempos = {Vector(-7,0,7),Angle(0,90,100),.5},
        skin = 0,
        norender = false
    },
    --CAPS
    ["gray cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["light gray cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 2,
        norender = true,
        placement = "head"
    },

    ["light gray cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 2,
        norender = true,
        placement = "head"
    },

    ["white cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 3,
        norender = true,
        placement = "head"
    },

    ["green cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 4,
        norender = true,
        placement = "head"
    },

    ["dark green cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 5,
        norender = true,
        placement = "head"
    },

    ["brown cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 6,
        norender = true,
        placement = "head"
    },

    ["blue cap"] = {
        model = "models/modified/hat07.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(5,0.4,0),Angle(180,105,90),1},
        fempos = {Vector(3.5,0.2,0),Angle(180,105,90),1},
        skin = 7,
        norender = true,
        placement = "head"
    },
    -- FaceMasks
    ["bandana"] = {
        model = "models/modified/bandana.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(-1,-0.8,0),Angle(180,105,90),1},
        fempos = {Vector(-2,-1.2,0),Angle(180,105,90),.9},
        skin = 0,
        norender = true,
        placement = "face"
    },

    ["arctic_balaclava"] = {
        model = "models/balaklava/arctic_balaclava.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(0.2,-0.95,0),Angle(180,100,90),1.1},
        fempos = {Vector(-1,-0.8,0),Angle(180,105,90),1.05},
        skin = 0,
        norender = true,
        disallowinapperance = true,
        bonemerge = true
    },

    ["phoenix_balaclava"] = {
        model = "models/balaklava/phoenix_balaclava.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(0.6,-0.95,0),Angle(180,100,90),0.95},
        fempos = {Vector(-0.6,-0.6,0),Angle(180,100,90),0.95},
        skin = 0,
        norender = true,
        disallowinapperance = true,
        bonemerge = true
    },
    -- scarfs
    ["white scarf"] = {
        model = "models/sal/acc/fix/scarf01.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-18,8,0),Angle(0,75,90),1},
        fempos = {Vector(-18,5.5,0),Angle(0,80,90),.9},
        skin = 0,
        norender = false,
        placement = "torso"
    },

    ["gray scarf"] = {
        model = "models/sal/acc/fix/scarf01.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-18,8,0),Angle(0,75,90),1},
        fempos = {Vector(-18,5.5,0),Angle(0,80,90),.9},
        skin = 1,
        norender = false,
        placement = "torso"
    },

    ["black scarf"] = {
        model = "models/sal/acc/fix/scarf01.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-18,8,0),Angle(0,75,90),1},
        fempos = {Vector(-18,5.5,0),Angle(0,80,90),.9},
        skin = 2,
        norender = false,
        placement = "torso"
    },

    ["blue scarf"] = {
        model = "models/sal/acc/fix/scarf01.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-18,8,0),Angle(0,75,90),1},
        fempos = {Vector(-18,5.5,0),Angle(0,80,90),.9},
        skin = 3,
        norender = false,
        placement = "torso"
    },

    ["red scarf"] = {
        model = "models/sal/acc/fix/scarf01.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-18,8,0),Angle(0,75,90),1},
        fempos = {Vector(-18,5.5,0),Angle(0,80,90),.9},
        skin = 4,
        norender = false,
        placement = "torso"
    },

    ["green scarf"] = {
        model = "models/sal/acc/fix/scarf01.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-18,8,0),Angle(0,75,90),1},
        fempos = {Vector(-18,5.5,0),Angle(0,80,90),.9},
        skin = 5,
        norender = false,
        placement = "torso"
    },

    ["pink scarf"] = {
        model = "models/sal/acc/fix/scarf01.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-18,8,0),Angle(0,75,90),1},
        fempos = {Vector(-18,5.5,0),Angle(0,80,90),.9},
        skin = 6,
        norender = false,
        placement = "torso"
    },
    -- earmuffs
    ["red earmuffs"] = {
        model = "models/modified/headphones.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(2.8,-1,0),Angle(180,105,90),1},
        fempos = {Vector(1.8,-1,0),Angle(180,105,90),0.95},
        skin = 0,
        norender = true
    },

    ["pink earmuffs"] = {
        model = "models/modified/headphones.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(2.8,-1,0),Angle(180,105,90),1},
        fempos = {Vector(1.8,-1,0),Angle(180,105,90),0.95},
        skin = 1,
        norender = true
    },

    ["green earmuffs"] = {
        model = "models/modified/headphones.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(2.8,-1,0),Angle(180,105,90),1},
        fempos = {Vector(1.8,-1,0),Angle(180,105,90),0.95},
        skin = 2,
        norender = true
    },

    ["yellow earmuffs"] = {
        model = "models/modified/headphones.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(2.8,-1,0),Angle(180,105,90),1},
        fempos = {Vector(1.8,-1,0),Angle(180,105,90),0.95},
        skin = 3,
        norender = true
    },
    -- fedoras

    ["gray fedora"] = {
        model = "models/modified/hat01_fix.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        fempos = {Vector(3,0.2,0),Angle(180,105,90),1},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["black fedora"] = {
        model = "models/modified/hat01_fix.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        fempos = {Vector(3,0.2,0),Angle(180,105,90),1},
        skin = 1,
        norender = true,
        placement = "head"
    },

    ["white fedora"] = {
        model = "models/modified/hat01_fix.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        fempos = {Vector(3,0.2,0),Angle(180,105,90),1},
        skin = 2,
        norender = true,
        placement = "head"
    },

    ["beige fedora"] = {
        model = "models/modified/hat01_fix.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        fempos = {Vector(3,0.2,0),Angle(180,105,90),1},
        skin = 3,
        norender = true,
        placement = "head"
    },

    ["black/red fedora"] = {
        model = "models/modified/hat01_fix.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        fempos = {Vector(3,0.2,0),Angle(180,105,90),1},
        skin = 5,
        norender = true,
        placement = "head"
    },

    ["blue fedora"] = {
        model = "models/modified/hat01_fix.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        fempos = {Vector(3,0.2,0),Angle(180,105,90),1},
        skin = 7,
        norender = true,
        placement = "head"
    },
    -- beanies

    ["striped beanie"] = {
        model = "models/modified/hat03.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(4,0,0),Angle(180,105,90),1},
        fempos = {Vector(3,0.2,0),Angle(180,105,90),1},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["striped beanie"] = {
        model = "models/modified/hat03.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(4,0,0),Angle(180,105,90),1},
        fempos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        skin = 0,
        norender = true,
        placement = "head"
    },

    ["periwinkle beanie"] = {
        model = "models/modified/hat03.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(4,0,0),Angle(180,105,90),1},
        fempos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        skin = 1,
        norender = true,
        placement = "head"
    },

    ["fuschia beanie"] = {
        model = "models/modified/hat03.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(4,0,0),Angle(180,105,90),1},
        fempos = {Vector(3.8,0.2,0),Angle(180,105,90),1},
        skin = 2,
        norender = true,
        placement = "head"
    },

    ["white beanie"] = {
        model = "models/modified/hat03.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(4,0,0),Angle(180,105,90),1},
        fempos = {Vector(3.8,0.2,0),Angle(180,100,90),1},
        skin = 3,
        norender = true,
        placement = "head"
    },

    ["gray beanie"] = {
        model = "models/modified/hat03.mdl",
        bone = "ValveBiped.Bip01_Head1",
        malepos = {Vector(4,0,0),Angle(180,105,90),1},
        fempos = {Vector(3.8,0.2,0),Angle(180,100,90),1},
        skin = 4,
        norender = true,
        placement = "head"
    },
    -- backpacks
    ["large red backpack"] = {
        model = "models/modified/backpack_1.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-7.5,5.2,0),Angle(0,80,90),1},
        fempos = {Vector(-8,4,0),Angle(0,80,90),0.9},
        skin = 0,
        norender = false
    },

    ["large gray backpack"] = {
        model = "models/modified/backpack_1.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-7.5,5.2,0),Angle(0,80,90),1},
        fempos = {Vector(-8,4,0),Angle(0,80,90),0.9},
        skin = 1,
        norender = false
    },

    ["medium backpack"] = {
        model = "models/modified/backpack_3.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-7.5,4,0),Angle(0,80,90),1},
        fempos = {Vector(-8,3,0),Angle(0,80,90),0.9},
        skin = 0,
        norender = false
    },

    ["medium gray backpack"] = {
        model = "models/modified/backpack_3.mdl",
        bone = "ValveBiped.Bip01_Spine4",
        malepos = {Vector(-7.5,4,0),Angle(0,80,90),1},
        fempos = {Vector(-8,3,0),Angle(0,80,90),0.9},
        skin = 1,
        norender = false
    },
}

--[[HMCD_Accessories={
	["none"]={},
	["eyeglasses"]={"models/captainbigbutt/skeyler/accessories/glasses01.mdl","ValveBiped.Bip01_Head1",{Vector(2.1,3,0),Angle(0,-70,-90),.9},{Vector(2.75,2,0),Angle(0,-70,-90),.8},false,0},
	["bugeye sunglasses"]={"models/captainbigbutt/skeyler/accessories/glasses02.mdl","ValveBiped.Bip01_Head1",{Vector(2.9,2.2,0),Angle(0,-70,-90),.9},{Vector(3.5,1.25,0),Angle(0,-70,-90),.8},false,0},
	["large sunglasses"]={"models/captainbigbutt/skeyler/accessories/glasses04.mdl","ValveBiped.Bip01_Head1",{Vector(3.25,2.4,0),Angle(0,-70,-90),.9},{Vector(3.5,1.25,0),Angle(0,-70,-90),.8},false,0},
	["aviators"]={"models/gmod_tower/aviators.mdl","ValveBiped.Bip01_Head1",{Vector(2.2,2.9,0),Angle(0,-75,-90),.9},{Vector(2.8,1.9,0),Angle(0,-75,-90),.85},false,0},
	["nerd glasses"]={"models/gmod_tower/klienerglasses.mdl","ValveBiped.Bip01_Head1",{Vector(2.6,2.9,0),Angle(0,-75,-90),1},{Vector(2.6,2.3,0),Angle(0,-80,-90),.9},false,0},
	["headphones"]={"models/gmod_tower/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(.5,3,0),Angle(0,-90,-90),.9},{Vector(1,2.3,0),Angle(0,-90,-90),.8},false,0},
	["baseball cap"]={"models/gmod_tower/jaseballcap.mdl","ValveBiped.Bip01_Head1",{Vector(.05,5.1,0),Angle(0,-75,-90),1.125},{Vector(0,4.2,0),Angle(0,-75,-90),1.1},true,0},
	["fedora"]={"models/captainbigbutt/skeyler/hats/fedora.mdl","ValveBiped.Bip01_Head1",{Vector(.25,5.5,0),Angle(0,-75,-90),.7},{Vector(0,4.8,0),Angle(0,-75,-90),.65},true,0},
	["stetson"]={"models/captainbigbutt/skeyler/hats/cowboyhat.mdl","ValveBiped.Bip01_Head1",{Vector(.3,6,0),Angle(0,-70,-90),.75},{Vector(.25,5.6,0),Angle(0,-75,-90),.7},true,0},
	["straw hat"]={"models/captainbigbutt/skeyler/hats/strawhat.mdl","ValveBiped.Bip01_Head1",{Vector(.75,5,0),Angle(0,-75,-90),.85},{Vector(.5,4.5,0),Angle(0,-75,-90),.75},true,0},
	["sun hat"]={"models/captainbigbutt/skeyler/hats/sunhat.mdl","ValveBiped.Bip01_Head1",{Vector(-1.5,3.5,0),Angle(0,-75,-90),.8},{Vector(-1.5,3,0),Angle(0,-75,-90),.75},true,0},
	["bling cap"]={"models/captainbigbutt/skeyler/hats/zhat.mdl","ValveBiped.Bip01_Head1",{Vector(.7,3.75,.3),Angle(0,-75,-90),.75},{Vector(.3,3,.25),Angle(0,-75,-90),.75},true,0},
	["top hat"]={"models/player/items/humans/top_hat.mdl","ValveBiped.Bip01_Head1",{Vector(2,-1,0),Angle(0,-80,-90),1.025},{Vector(2,-1,0),Angle(0,-80,-90),.95},true,0},
	["backpack"]={"models/makka12/bag/jag.mdl","ValveBiped.Bip01_Spine4",{Vector(0,-3,0),Angle(0,90,90),.7},{Vector(.5,-3,0),Angle(0,90,90),.6},false,0},
	["purse"]={"models/props_c17/BriefCase001a.mdl","ValveBiped.Bip01_Spine1",{Vector(-3,-10,7),Angle(0,90,90),.6},{Vector(-3,-10,7),Angle(0,90,90),.6},false,0},
	-- gen 2
	["gray cap"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,0},
	["light gray cap"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,2},
	["white cap"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,3},
	["green cap"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,4},
	["dark green cap"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,5},
	["brown cap"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,6},
	["blue cap"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,7},

	["bandana"]={"models/modified/bandana.mdl","ValveBiped.Bip01_Head1",{Vector(1.1,-1.2,0),Angle(0,-75,-90),1},{Vector(1,-1.5,0),Angle(0,-80,-90),.9},false,0},

	["white scarf"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,0},
	["gray scarf"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,1},
	["black scarf"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,2},
	["blue scarf"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,3},
	["red scarf"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,4},
	["green scarf"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,5},
	["pink scarf"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,6},

	["red earmuffs"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,0},
	["pink earmuffs"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,1},
	["green earmuffs"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,2},
	["yellow earmuffs"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,3},

	["gray fedora"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,0},
	["black fedora"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,1},
	["white fedora"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,2},
	["beige fedora"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,3},
	["black/red fedora"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,5},
	["blue fedora"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,7},

	["striped beanie"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,0},
	["periwinkle beanie"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,1},
	["fuschia beanie"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,2},
	["white beanie"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,3},
	["gray beanie"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,4},

	["large red backpack"]={"models/modified/backpack_1.mdl","ValveBiped.Bip01_Spine4",{Vector(-2,-8,0),Angle(0,90,90),1},{Vector(-2,-8,0),Angle(0,90,90),.9},false,0},
	["large gray backpack"]={"models/modified/backpack_1.mdl","ValveBiped.Bip01_Spine4",{Vector(-2,-8,0),Angle(0,90,90),1},{Vector(-2,-8,0),Angle(0,90,90),.9},false,1},

	["medium backpack"]={"models/modified/backpack_3.mdl","ValveBiped.Bip01_Spine4",{Vector(-3,-6,0),Angle(0,90,90),.9},{Vector(-3,-6,0),Angle(0,90,90),.8},false,0},
	["medium gray backpack"]={"models/modified/backpack_3.mdl","ValveBiped.Bip01_Spine4",{Vector(-3,-6,0),Angle(0,90,90),.9},{Vector(-3,-6,0),Angle(0,90,90),.8},false,1}
}]]--