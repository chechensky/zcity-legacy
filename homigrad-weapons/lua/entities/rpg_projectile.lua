-- "addons\\homigrad-weapons\\lua\\entities\\rpg_projectile.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Base = "projectile_base"
ENT.Author = "Sadsalat"
ENT.Category = "ZCity Other"
ENT.PrintName = "Projectile Base"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Model = "models/weapons/tfa_ins2/w_rpg7_projectile.mdl"
ENT.Sound = "rpg/at4rpg_detonate_01.wav"
ENT.SoundFar = "rpg/at4rpg_detonate_far_dist_01.wav"
ENT.SoundWater = "iedins/water/ied_water_detonate_01.wav"
ENT.Speed = 3000
ENT.TruhstTime = 0.4

ENT.BlastDamage = 200
ENT.BlastDis = 7