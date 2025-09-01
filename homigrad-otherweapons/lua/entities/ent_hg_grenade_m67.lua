-- Path scripthooked:lua\\entities\\ent_hg_grenade_m67.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Base = "ent_hg_grenade"
ENT.Spawnable = false
ENT.Model = "models/weapons/tfa_ins2/w_m67.mdl"
ENT.timeToBoom = 5
ENT.Fragmentation = 350 * 2 -- 450 уже страшно
ENT.BlastDis = 5 --meters
ENT.Penetration = 7