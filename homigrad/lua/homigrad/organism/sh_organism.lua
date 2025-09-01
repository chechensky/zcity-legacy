-- Path scripthooked:lua\\homigrad\\organism\\tier_0\\sh_hitboxorgans.lua"
-- Scripthooked by ???
hg.organism = hg.organism or {}
local empty = {}
local Vector = Vector --ыыы
local vecZero, angZero = Vector(0, 0, 0), Angle(0, 0, 0)
local box, _mins = Vector(0, 0, 0), Vector(0, 0, 0)
local center
local function getTransform(pos, ang, mins, maxs, obbCenter)
	box:Set(mins)
	box:Sub(maxs)
	box:Div(2) --holyshit...
	box:Rotate(ang)
	_mins:Set(mins)
	_mins:Rotate(ang)
	_mins:Sub(box)
	center = pos + _mins
	return center, (obbCenter - center):Length() + box:Length() / 2
end

local LocalToWorld = LocalToWorld
function hg.organism.ShootMatrix(ent, organs)
	local boxs = {}
	local mins, maxs, matrix, box
	local pos, ang, center
	local sphereChunk = 0
	local obbCenter = ent:GetPos() --да какая же хуйня это))0
	obbCenter:Add(ent:OBBCenter())
	for i = 0, ent:GetHitBoxCount(0) - 1 do
		matrix = ent:GetBoneMatrix(ent:GetHitBoxBone(i, 0))
		if not matrix then continue end
		mins, maxs = ent:GetHitBoxBounds(i, 0)
		pos = matrix:GetTranslation()
		ang = matrix:GetAngles()
		local center, disOfCenter = getTransform(pos, ang, mins, maxs, obbCenter)
		if disOfCenter > sphereChunk then sphereChunk = disOfCenter end
		boxs[#boxs + 1] = {pos, ang, mins, maxs, center}
	end
	
	for nameBone, organs in pairs(organs) do
		matrix = ent:GetBoneMatrix(ent:LookupBone(nameBone))
		if not matrix then continue end
		pos = matrix:GetTranslation()
		ang = matrix:GetAngles()
		for key, organ in pairs(organs) do
			--print(key,organ[1])
			local additional = organ[7]
			if additional then
				local ent = IsValid(ent.csmodelowner) and ent.csmodelowner or ent
				local ent = ent:IsPlayer() and ent or ent:IsRagdoll() and IsValid(hg.RagdollOwner(ent)) and hg.RagdollOwner(ent) or ent
				if ent and ent.armors and not table.HasValue(ent.armors,organ[1]) then
					continue
				end
			end
			mins = -organ[5]
			maxs = -mins
			local center, disOfCenter, boxLen = getTransform(pos, ang, mins, maxs, obbCenter)
			if disOfCenter > sphereChunk then sphereChunk = disOfCenter end
			local pos, ang = LocalToWorld(organ[3], organ[4], pos, ang)
			boxs[#boxs + 1] = {pos, ang, mins, maxs, center, nameBone, key}
		end
	end
	return boxs, obbCenter, sphereChunk
end

--local util_IsOBBIntersectingOBB = util.IsOBBIntersectingOBB --huy not server side
local util_IntersectRayWithOBB = util.IntersectRayWithOBB
local math_ceil = math.ceil
local stepDiv = 1
local tracePos = Vector(0, 0, 0)
function hg.organism.Trace(pos, dir, boxs, center, endDis, organs, ricochetable, funcInput, ...)
	tracePos:Set(pos)
	local hitBoxs = {}
	local tracePoses = {}
	local inputHole, outputHole = {}, {}
	local inBody, hitSomeOne
	local box
	local stepDis = 1 / stepDiv
	local distance = math_ceil(dir:Length())
	dir:Normalize()
	dir = dir * stepDis
	
	local distancereal = distance

	for i = 0, distance, stepDis do
		hitSomeOne = nil
		for i = 1, #boxs do
			box = boxs[i]
			
			local _, normal = util_IntersectRayWithOBB(tracePos - dir * 10, dir * 100, box[1], box[2], box[3], box[4])

			local hit = util.IsOBBIntersectingOBB(tracePos, dir:Angle(), -Vector(0,distance / 50,distance / 50),Vector(stepDis,distance / 50,distance / 50), box[1], box[2], box[3], box[4])
			
			if hit then
				if not inBody then
					inBody = true
					inputHole[#inputHole + 1] = Vector(tracePos[1], tracePos[2], tracePos[3])
				end

				if not hitBoxs[i] and distance > 0 then
					hitBoxs[i] = true
					local dir2
					local ricoAng = 0
					local dirSub, dirAdd = 0, nil
					local randomness
					local bonemul = organs[box[6]] and organs[box[6]][box[7]][2] or 0
					local prot = (organs[box[6]] and organs[box[6]][box[7]][8] or 0) / distance
					local likelyToRicochet
					
					if ricochetable then
						if SERVER and normal then
							normal:Rotate(box[2])
							ricoAng = math.deg(math.acos(math.abs(normal:Dot(dir:GetNormalized()))))
							
							if ricoAng > 60 * distance / 15 then
								local NewVec = dir:Angle()
								NewVec:RotateAroundAxis(normal,180)
								dir2 = -NewVec:Forward() * stepDis
							end
						end

						randomness = math.random(150) <= math.max(ricoAng - 60 * distance / 10,10) / 30 * 100
						
						likelyToRicochet = dir2 and ((bonemul >= 0.5 and randomness) or prot >= 1)
						likelyToRicochet = likelyToRicochet and (ricoAng > 60 * distance / 15)
					end
					--if not likelyToRicochet then
						dirSub, dirAdd = funcInput(box, hit, likelyToRicochet, ...)
					--end

					if dirAdd then
						dir:Add(dirAdd / 10)
						dir:Normalize()
					end
					
					if likelyToRicochet then--and dirSub * 100 >= math.random(50) then
						dir = -(-dir2)
					end
					
					distance = distance - distance * dirSub
				end

				hitSomeOne = true
			end

			if not hit then
				local hit = util_IntersectRayWithOBB(tracePos, dir * 100, box[1], box[2], box[3], box[4])
				if hit then
					tracePos = hit
				end
			end
		end

		if inBody and not hitSomeOne then
			outputHole[#outputHole + 1] = Vector(tracePos[1], tracePos[2], tracePos[3])
			inBody = nil
		end

		tracePos:Add(dir)
		
		if SERVER then
			tracePoses[#tracePoses + 1] =  tostring(tracePos[1]).." "..tostring(tracePos[2]).." "..tostring(tracePos[3])--Vector(tracePos[1],tracePos[2],tracePos[3])
		end
		if i > distance or (tracePos - center):Length() > endDis then break end
	end
	
	return tracePos, hitBoxs, inputHole, outputHole, tracePoses, dir, distance
end

function hg.organism.Trace_Bullet(organs)
	local organ = box[6] and organs[box[6]][box[7]]
	return organ and organ[2] or 0
end

if SERVER then return end
local render_DrawW
local white, red, blue, black = Color(255, 255, 255), Color(255, 0, 0), Color(0, 0, 255), Color(0, 0, 0)
local hg_show_hitbox = ConVarExists("hg_show_hitbox") and GetConVar("hg_show_hitbox") or CreateClientConVar("hg_show_hitbox", "0", false, false, "shows custom players hitboxes, work only for admins or with sv_cheats 1 enabled")
local hg_show_hitbox_dir = ConVarExists("hg_show_hitbox_dir") and GetConVar("hg_show_hitbox_dir") or CreateClientConVar("hg_show_hitbox_dir", "0", false, false, "work only for admins or with sv_cheats 1 enabled")
render_DrawWireframeBox = render.DrawWireframeBox
hook.Add("PostDrawTranslucentRenderables", "homigrad-organism", function()
	if not hg_show_hitbox:GetBool() then return end
	if not LocalPlayer():IsAdmin() then return end
	for i, ply in pairs(player.GetAll()) do
		if ply == LocalPlayer() then continue end
		ply = hg.GetCurrentCharacter(ply)
		local organs = hg.organism.GetHitBoxOrgans(ply:GetModel(), ply)
		local boxs, pos, sphere = hg.organism.ShootMatrix(ply, organs)
		if hg_show_hitbox_dir:GetFloat() > 0 then
			local dir = Vector(hg_show_hitbox_dir:GetFloat(), 0, 0)
			dir:Rotate(LocalPlayer():EyeAngles())
			local distance = math_ceil(dir:Length())
			local start = LocalPlayer():GetEyeTrace().HitPos -- Vector(1005.879456,608.151123,-77.997421)
			local endPos, hitBoxs, inputHole, outputHole = hg.organism.Trace(start, dir, boxs, pos, sphere, organs, nil, hg.organism.Trace_Bullet, organs)
			--render.DrawWireframeBox(endPos, angZero, -box, box)
			
			render.DrawWireframeBox(start, LocalPlayer():EyeAngles(), -Vector(0,distance / 50,distance / 50),Vector(distance / 1,distance / 50,distance / 50))
			for i = 1, #boxs do
				local box = boxs[i]
				local organ = box[6] and organs[box[6]][box[7]]
				render_DrawWireframeBox(box[1], box[2], box[3], box[4], (hitBoxs[i] and white) or (organ and organ[6]) or black)
			end

			for i = 1, #inputHole do
				render.DrawWireframeSphere(inputHole[i], 1, 16, 16, red)
			end

			for i = 1, #outputHole do
				render.DrawWireframeSphere(outputHole[i], 0.5, 16, 16, blue)
			end
		else
			for i = 1, #boxs do
				local box = boxs[i]
				local organ = box[6] and organs[box[6]][box[7]]
				render_DrawWireframeBox(box[1], box[2], box[3], box[4], (organ and organ[6]) or black)
			end
		end
		--render.DrawWireframeSphere(pos,sphere,16,16,color2)
	end
end)