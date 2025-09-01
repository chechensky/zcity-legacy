-- Path scripthooked:lua\\weapons\\weapon_p90.lua"
-- Scripthooked by ???
SWEP.Base = "homigrad_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "FN P90"
SWEP.Author = "FN Herstal"
SWEP.Instructions = "Submachine gun chambered in 5.7x28 mm\n\nRate of fire 1000 rounds per minute"
SWEP.Category = "Weapons - Machine-Pistols"
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.ViewModel = ""
SWEP.WorldModel = "models/pwb2/weapons/w_p90.mdl"

SWEP.WepSelectIcon2 = Material("pwb2/vgui/weapons/p90.png")
SWEP.IconOverride = "entities/weapon_pwb2_p90.png"

SWEP.weight = 2.5

SWEP.ShockMultiplier = 2

SWEP.CustomShell = "556x45"
--SWEP.EjectPos = Vector(0,5,5)
--SWEP.EjectAng = Angle(0,-90,0)
SWEP.ScrappersSlot = "Primary"
SWEP.weaponInvCategory = 1
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "5.7x28 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 32
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 32
SWEP.Primary.Sound = {"homigrad/weapons/pistols/p90-1.wav", 75, 120, 130}
SWEP.Primary.Wait = 0.05
SWEP.ReloadTime = 1.5
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"
SWEP.HoldType = "smg"
SWEP.ZoomPos = Vector(-3.9, 0.38, 22)
SWEP.RHandPos = Vector(0, -1, 0)
SWEP.LHandPos = Vector(7, 0, 0)
SWEP.attPos = Vector(0, 0, 0)
SWEP.attAng = Angle(-0.0, 0.0, 0)
SWEP.ShellEject = "EjectBrass_9mm"
SWEP.Spray = {}
for i = 1, 50 do
	SWEP.Spray[i] = Angle(-0.02 - math.cos(i) * 0.01, math.cos(i * 8) * 0.02, 0) * 2
end

SWEP.Ergonomics = 1.1
SWEP.Penetration = 10
SWEP.AimHands = Vector(-4, 0.65, -3.1)
SWEP.WorldPos = Vector(1, -0.6, 1)
SWEP.WorldAng = Angle(0, 0, 0)
SWEP.UseCustomWorldModel = true
SWEP.size = 0.0006
SWEP.holo_pos = Vector(-0.97, 4.3, 8)
SWEP.scale = Vector(1, 1.1, 1)
SWEP.holo = Material("holo/huy-collimator6.png")
SWEP.holo_size = 0.25
SWEP.scale2 = 1.1
if CLIENT then
	function SWEP:DrawHUDAdd()
		self:DoHolo()
	end
end

SWEP.lengthSub = 30
SWEP.handsAng = Angle(-10, 8, 0)
SWEP.DistSound = "mp5k/mp5k_dist.wav"