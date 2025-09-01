-- Path scripthooked:lua\\entities\\ent_hg_grenade_shg.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Base = "ent_hg_grenade"
ENT.Spawnable = false
ENT.Model = "models/jmod/explosives/grenades/sticknade/stick_grenade_nojacket.mdl"
ENT.timeToBoom = math.random(5, 8)
ENT.Fragmentation = 480 * 2 -- это противотанковая епта граната
ENT.BlastDis = 8 --meters
ENT.Penetration = 10