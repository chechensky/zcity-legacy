-- Path scripthooked:lua\\homigrad\\organism\\tier_1\\modules\\particles\\cl_blood.lua"
-- Scripthooked by ???

local sounds = {}
for i = 1, 4 do
	sounds[i] = "ambient/water/drip" .. i .. ".wav"
	hg.PrecahceSound(sounds[i])
end

local mat = {Material("homigrad/decals/blood1"), Material("homigrad/decals/blood1"), Material("homigrad/decals/blood1")}
mat[#mat] = nil
local paint = Color(0, 0, 0)
net.Receive("blood decal", function()
	local pos, normal, ent, artery = net.ReadVector(), net.ReadVector(), net.ReadEntity(), net.ReadBool()
	sound.Play("homigrad/blooddrip" .. math.random(1, 4) .. ".wav", pos, math.random(40, 60), math.random(80, 120))
	local r = not artery and math.random(25, 35) or math.random(65, 95)
	paint.r = r
	paint.g = 0
	paint.b = 0
	paint.a = math.random(220, 250)
	local w = math.Rand(1, 1.5) / 16 / (artery and 4 or 1)
	local h = w --+ math.Rand(-0.25,0.25) / 4
	util.DecalEx(mat[math.random(1, #mat)], game.GetWorld(), pos + normal, -normal * 20, paint, w, h)
end)

bloodparticels1 = bloodparticels1 or {}
local bloodparticels1 = bloodparticels1
bloodparticels_hook = bloodparticels_hook or {}
local mats = {}
for i = 1, 3 do
	mats[i] = Material("homigrad/decals/blood" .. i)
end

local mats_huy = {}
--[[for i = 4, 6 do
	mats_huy[i - 3] = Material("homigrad/decals/bld" .. i)
end--]]

for i = 1, 6 do
	mats_huy[i] = Material("decals/blood" .. i)
end

local tr = {
	filter = function(ent) return not ent:IsPlayer() and not ent:IsRagdoll() end
}

local vecDown = Vector(0, 0, -40)
local vecZero = Vector(0, 0, 0)
local LerpVector = LerpVector
local math_random = math.random
local table_remove = table.remove
local util_Decal = util.Decal
local util_TraceLine = util.TraceLine
local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
bloodparticels_hook[1] = function(anim_pos)
	for i = 1, #bloodparticels1 do
		local part = bloodparticels1[i]
		
		render_SetMaterial(part[4])
		render_DrawSprite(LerpVector(anim_pos, part[2], part[1]), part[5], part[6])
	end
end

local paint = Color(255, 255, 255, 255)
local function decalBlood(pos, normal, hitTexture, artery)
	local r = artery and math.random(100, 150) or math.random(25, 45)
	paint.r = r
	paint.g = 0
	paint.b = 0
	paint.a = math.random(250, 255)
	local w = math.Rand(1, 1.5) / math.random(48, 64) * (artery and 0.5 or 1) -- / 6
	local h = w
	game.GetWorld():SetSaveValue("m_bCanDecal", true)
	if hitTexture == "**displacement**" then
		util.DecalEx(mats_huy[math.random(#mats_huy)], game.GetWorld(), pos + normal, -normal * 20, paint, w * 32, h * 32)
	else
		util.DecalEx(mats[math.random(#mats)], game.GetWorld(), pos + normal, -normal * 20, paint, w * 2, h * 2)
	end
end

bloodparticels_hook[2] = function(mul)
	for i = 1, #bloodparticels1 do
		local part = bloodparticels1[i]
		if not part then break end
		local pos = part[1]
		local posSet = part[2]
		tr.start = posSet
		tr.endpos = tr.start + part[3] * mul
		--tr.filter = nil
		result = util_TraceLine(tr)
		local hitPos = result.HitPos
		if result.Hit then
			--if IsValid(result.Entity) and result.Entity:IsPlayer() or result.Entity:IsRagdoll() then
			--	part[3] = -part[3]
			--end

			table_remove(bloodparticels1, i)
			local dir = result.HitNormal
			decalBlood(result.HitPos, dir, result.HitTexture, part[7])
			sound.Play("homigrad/blooddrip" .. math_random(1, 4) .. ".wav", hitPos, 100, 100)
			continue
		else
			pos:Set(posSet)
			posSet:Set(hitPos)
		end

		part[3] = LerpVector(0.25 * mul, part[3], vecZero)
		part[3]:Add(vecDown)
	end
end

local hitBoxes = {}
local holes = {}

net.Receive("AddHole", function()
	local iHole = net.ReadTable()
	local oHole = net.ReadTable()
end)

net.Receive("PlusHitrays", function()
	local pos = net.ReadVector()
	local ang = net.ReadAngle()
	local min = net.ReadVector()
	local max = net.ReadVector()
	local color = net.ReadColor()
	table.insert(hitBoxes, {
		pos = pos,
		ang = ang,
		min = min,
		max = max,
		spawn = CurTime() + 5,
		color = color,
	})
end)

hook.Add("PostDrawOpaqueRenderables", "DrawHitBoxes", function()
	for _, box in ipairs(hitBoxes) do
		if box.spawn < CurTime() then
			table.RemoveByValue(hitBoxes, box)
		end
		render.DrawWireframeBox(box.pos, box.ang, box.min, box.max, box.color)
	end
end)