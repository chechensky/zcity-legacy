-- Path scripthooked:lua\\homigrad\\liquid_drum\\particles\\input\\input_cl.lua"
-- Scripthooked by ???
local mats = {}
for i = 1, 3 do
	mats[i] = Material("homigrad/decals/bld" .. i + 3)
end

gasparticles = gasparticles or {}
local vecZero = Vector(0, 0, 0)
function addGasPart(pos, vel, mat, w, h, ent)
	local mat = mats[math.random(#mats)]
	pos = pos + vecZero
	vel = vel + vecZero
	local pos2 = Vector()
	pos2:Set(pos)
	gasparticles[#gasparticles + 1] = {pos, pos2, vel, mat, w, h, ent}
end

net.Receive("gas particle", function() addGasPart(net.ReadVector(), net.ReadVector(), mats[math.random(#mats)], math.random(5, 8), math.random(5, 8), net.ReadEntity()) end)