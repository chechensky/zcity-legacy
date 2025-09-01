-- Path scripthooked:lua\\homigrad\\organism\\tier_1\\modules\\particles\\input\\cl_input.lua"
-- Scripthooked by ???
local mats = {}
for i = 1, 6 do
	mats[i] = Material("decals/blood" .. i)
end
--[[for i = 4, 6 do
	mats[i-3] = Material("homigrad/decals/bld" .. i)
end]]
local countmats = #mats
local bloodparticels1 = bloodparticels1 or {}
local vecZero = Vector(0, 0, 0)
local function addBloodPart(pos, vel, mat, w, h, artery)
	pos = pos + vecZero
	vel = vel + vecZero
	local pos2 = Vector()
	pos2:Set(pos)
	bloodparticels1[#bloodparticels1 + 1] = {pos, pos2, vel, mat, w, h, artery}
end

net.Receive("blood particle", function() addBloodPart(net.ReadVector(), net.ReadVector(), mats[math.random(#mats)], math.random(2, 3), math.random(2, 3), (net.ReadBool() or false)) end)
local min, max = math.min, math.max
net.Receive("blood particle2", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	local wound = net.ReadTable()
	local dir = net.ReadVector()
	local artery = net.ReadBool()
	local bone = wound[4]
	local bonePos, boneAng = ent:GetBonePosition(bone)
	if not wound[2] or not wound[3] or not bonePos or not boneAng then return end
	local pos = LocalToWorld(wound[2], wound[3], bonePos, boneAng)
	local size = math.random(1, 2) * max(min(wound[1], 1), 0.5)
	addBloodPart(pos, dir, mats[math.random(#mats)], size / 2, size / 2, artery)
end)

local Rand = math.Rand
net.Receive("blood particle more", function()
	local pos, vel = net.ReadVector(), net.ReadVector()
	for i = 1, math.random(10, 15) do
		addBloodPart(pos, vel + Vector(Rand(-15, 15), Rand(-15, 15)), mats[math.random(1, #mats)], math.random(10, 15), math.random(10, 15), art)
	end
end)

net.Receive("hg_bloodimpact", function()
	local pos = net.ReadVector()
	local vel = net.ReadVector() * 100

	for i = 1, math.random(2, 4) do
		local size = math.random(2, 4)
		addBloodPart(pos, -vel + Vector(Rand(-60, 60), Rand(-60, 60)), mats[math.random(1, #mats)], size, size)
	end
end)


local function explode(pos)
	local xx, yy = 12, 12
	local w, h = 360 / xx, 360 / yy
	for x = 1, xx do
		for y = 1, yy do
			local dir = Vector(0, 0, -1)
			dir:Rotate(Angle(h * y * Rand(0.9, 1.1), w * x * Rand(0.9, 1.1), 0))
			dir[3] = dir[3] + Rand(0.5, 1.5)
			dir:Mul(250)
			addBloodPart(pos, dir, mats[math.random(1, #mats)], math.random(10, 15), math.random(10, 15))
		end
	end
end

net.Receive("blood particle explode", function() explode(net.ReadVector()) end)
net.Receive("blood particle headshoot", function()
	local pos, vel = net.ReadVector(), net.ReadVector()
	local dir = Vector()
	dir:Set(vel)
	dir:Normalize()
	dir:Mul(25)
	local l1, l2 = pos - dir / 2, pos + dir / 2
	local r = math.random(10, 15)
	for i = 1, r do
		local vel = Vector(vel[1], vel[2], vel[3])
		vel:Rotate(Angle(Rand(-15, 15) * Rand(0.9, 1.1), Rand(-15, 15) * Rand(0.9, 1.1)))
		addBloodPart(Lerp(i / r * Rand(0.9, 1.1), l1, l2), vel, mats[math.random(1, #mats)], math.random(10, 15), math.random(10, 15))
	end
end)

concommand.Add("testpart", function()
	local pos = Vector(0, 0, 0)
	addBloodPart(pos, Vector(25, 0, 0), mats[math.random(1, #mats)], math.random(10, 15), math.random(10, 15))
end)