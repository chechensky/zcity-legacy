-- "addons\\homigrad-weapons\\lua\\entities\\crossbow_projectile.lua"
-- Scripthooked by ???
if SERVER then AddCSLuaFile() end
ENT.Base = "projectile_nonexplosive_base"
ENT.Author = "Sadsalat"
ENT.Category = "ZCity Other"
ENT.PrintName = "Crossbow Projectile"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Model = "models/crossbow_bolt.mdl"
ENT.HitSound = "weapons/crossbow/hit1.wav"

ENT.Damage = 350
ENT.Force = 10