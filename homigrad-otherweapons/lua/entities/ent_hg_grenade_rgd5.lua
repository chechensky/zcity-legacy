-- Path scripthooked:lua\\entities\\ent_hg_grenade_rgd5.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Base = "ent_hg_grenade"
ENT.Spawnable = false
ENT.Model = "models/pwb/weapons/w_rgd5_thrown.mdl"
ENT.timeToBoom = 4
ENT.Fragmentation = 320 * 2
ENT.BlastDis = 5 --meters
ENT.Penetration = 7.5