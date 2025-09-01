-- Path scripthooked:lua\\weapons\\weapon_tmp.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Steyr TMP-S"
SWEP.Author = "Steyr Mannlicher/Brugger+Thomet"
SWEP.Instructions = "Submachine gun chambered in 9x19 mm\n\nRate of fire 900 rounds per minute"
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb/weapons/w_tmp.mdl"

SWEP.WepSelectIcon2 = Material("pwb/sprites/tmp.png")
SWEP.IconOverride = "entities/weapon_pwb_tmp.png"

SWEP.weight = 1.5
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.CustomShell = "9x19"
SWEP.EjectPos = Vector(-5,0,10)
--SWEP.EjectAng = Angle(-80,-90,0)
SWEP.dwr_customIsSuppressed = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "9x19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 20
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 20
SWEP.Primary.Sound = {"homigrad/weapons/pistols/sil.wav", 75, 120, 130}
SWEP.Primary.Wait = 0.066
SWEP.ReloadTime = 2
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "smg"
SWEP.ZoomPos = Vector(-1.9, 0.18, 30)
SWEP.RHandPos = Vector(-14, -1, 3)
SWEP.LHandPos = Vector(5, -3, -2)
SWEP.Spray = {}
for i = 1, 30 do
	SWEP.Spray[i] = Angle(-0.01 - math.cos(i) * 0.02, math.cos(i * 8) * 0.02, 0) * 2
end

SWEP.availableAttachments = {
	sight = {
		["mount"] = Vector(-15, 1.25, -0),
		--["mountAngle"] = Angle(0,0,0),
		["mountType"] = "picatinny",
	},
}

SWEP.Ergonomics = 1.2
SWEP.Penetration = 7
SWEP.WorldPos = Vector(19, -1, 2.5)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.attPos = Vector(0, -0.5, -0.5)
SWEP.attAng = Angle(0.7, -2, 0)
SWEP.lengthSub = 10
SWEP.SetSupressor = true
SWEP.holsteredBone = "ValveBiped.Bip01_R_Thigh"
SWEP.holsteredPos = Vector(-5, 5, -6)
SWEP.holsteredAng = Angle(2, -5, 90)
SWEP.handsAng = Angle(-10, 5, 0)