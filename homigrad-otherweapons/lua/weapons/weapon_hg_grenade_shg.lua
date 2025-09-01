-- Path scripthooked:lua\\weapons\\weapon_hg_grenade_shg.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_hg_grenade"
SWEP.PrintName = "Stielhandgranate"
SWEP.Instructions = "A working replica of a WWII nazi-germany offensive grenade. It has a pyrotechnic delay of 5-8 seconds"
SWEP.Category = "Weapons - Explosive"
SWEP.Spawnable = true
SWEP.HoldType = "grenade"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/jmod/explosives/grenades/sticknade/stick_grenade.mdl"

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.ENT = "ent_hg_grenade_shg"

SWEP.offsetVec = Vector(3, -2, -1)
SWEP.offsetAng = Angle(145, 0, 0)

SWEP.spoon = "models/jmod/explosives/grenades/sticknade/stick_grenade_cap.mdl"
