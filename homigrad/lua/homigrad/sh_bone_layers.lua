-- Path scripthooked:lua\\homigrad\\sh_bone_layers.lua"
-- Scripthooked by ???
hg.bone = hg.bone or {} -- пост травматический синдром личности
--local hg.bone = hg.bone
hg.bone.matrixManual = {"ValveBiped.Bip01_Head1", "ValveBiped.Bip01_Spine", "ValveBiped.Bip01_Spine1", "ValveBiped.Bip01_Spine2", "ValveBiped.Bip01_Spine4", "ValveBiped.Bip01_Pelvis", "ValveBiped.Bip01_R_Clavicle", "ValveBiped.Bip01_R_UpperArm", "ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_Hand", "ValveBiped.Bip01_L_Clavicle", "ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_Hand", "ValveBiped.Bip01_R_Thigh", "ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_R_Foot", "ValveBiped.Bip01_R_Toe0", "ValveBiped.Bip01_L_Thigh", "ValveBiped.Bip01_L_Calf", "ValveBiped.Bip01_L_Foot", "ValveBiped.Bip01_R_Finger0","ValveBiped.Bip01_L_Finger0","ValveBiped.Bip01_L_Finger02"}
local tbl = {"head", "spine", "spine1", "spine2", "spine4", "pelvis", "r_clavicle", "r_upperarm", "r_forearm", "r_hand", "l_clavicle", "l_upperarm", "l_forearm", "l_hand", "r_thigh", "r_calf", "r_foot", "r_toe0", "l_thigh", "l_calf", "l_foot", "r_finger0","l_finger0","l_finger02"}
local newTbl = {}
for i, name in pairs(tbl) do
	newTbl[name] = i
end

hg.bone.matrixManual_Name = newTbl
local matrixManual = hg.bone.matrixManual
local matrix, matrixSet
local layers = {0.2, 0.8}
local function create(ply)
	if ply.boneLayers then
		for i = 1, #layers do
			hg.bone.MatrixZero(ply, i)
		end
	end

	ply.boneLayers = {}
	ply.layersMatrix = {}
	for i = 1, #matrixManual do
		--ply.layersMatrix[i] = {}--{Vector(0, 0, 0), Angle(0, 0, 0)}
	end

	for i = 1, #layers do
		local matrix, matrixSet = {}, {}
		for i = 1, #matrixManual do
			matrix[i] = {Vector(0, 0, 0), Angle(0, 0, 0)}
			matrixSet[i] = {Vector(0, 0, 0), Angle(0, 0, 0)}
		end

		ply.boneLayers[i] = {[3] = layers[i]}--{matrix, matrixSet, layers[i]}
	end
end

hook.Add("Player Spawn", "homigrad-bones", function(ply) create(ply) end)
local CurTime, LerpVector, LerpAngle = CurTime, LerpVector, LerpAngle
local m, mSet, mAngle, mPos
local vecZero, angZero = Vector(0, 0, 0), Angle(0, 0, 0)
local tickInterval = engine.TickInterval
local FrameTime = FrameTime
local math_min = math.min
local mul = 1
local timeHuy = CurTime()
local hook_Run = hook.Run
local angle = FindMetaTable("Angle")

function math.EqualWithTolerance(val1, val2, tol)
    return math.abs(val1 - val2) <= tol
end

function angle:IsEqualTol(ang, tol)
    if (tol == nil) then
        return self == ang
    end

    return math.EqualWithTolerance(self[1], ang[1], tol)
        and math.EqualWithTolerance(self[2], ang[2], tol)
        and math.EqualWithTolerance(self[3], ang[3], tol)
end

function angle:AngIsEqualTo(otherAng, huy)
	if not angle.IsEqualTol then return false end
	return self:IsEqualTol(otherAng, huy)
end

local hg_anims_draw_distance = ConVarExists("hg_anims_draw_distance") and GetConVar("hg_anims_draw_distance") or CreateClientConVar("hg_anims_draw_distance", 1024, true, nil, "distance to draw anims (0 = infinite)", 0, 4096)
local hg_anim_fps = ConVarExists("hg_anim_fps") and GetConVar("hg_anim_fps") or CreateClientConVar("hg_anim_fps", 66, true, nil, "fps to draw anims (0 = maximum fps available)", 0, 250)
local tolerance = 0
local player_GetAll = player.GetAll
local timeFrame = 0
hook.Add("Think", "homigrad-bones", function()

	mul = FrameTime() / tickInterval()
	
	for i = 1, #player_GetAll() do
		local ply = player_GetAll()[i]
		if not IsValid(ply) or not ply:Alive() or IsValid(ply.FakeRagdoll) then continue end

		local dist = CLIENT and LocalPlayer():GetPos():Distance(ply:GetPos()) or 0
		local drawdistance = CLIENT and hg_anims_draw_distance:GetInt() or 0
		if CLIENT and dist > drawdistance and drawdistance ~= 0 then continue end
		if CLIENT and (not ply.shouldTransmit or ply.NotSeen) then continue end
		
		
		local layers = ply.boneLayers
		local layersMatrix = ply.layersMatrix
		if CLIENT and ply ~= LocalPlayer() then
			--local diff = (ply:GetPos() - LocalPlayer():EyePos()):GetNormalized()
			
			--if LocalPlayer():GetAimVector():Dot(diff) / diff:Length() <= 0.1 then continue end
			
			if dist > drawdistance / 4 then
				--local mins,maxs = ply:GetModelBounds()
				local pos = ply:EyePos()
				--[[mins:Add(pos)
				maxs:Add(pos)
		
				local urf = maxs--upper right forward point
				local dlb = mins--lower left backward point
		
				local ulf = -(-urf)--upper left forward point
				ulf.x = dlb.x
		
				local ulb = -(-ulf)--upper left backward point
				ulb.y = dlb.y
		
				local urb = -(-ulb)--upper right backward point
				urb.x = urf.x
		
				local drb = -(-urb)
				drb.z = dlb.z
		
				local dlf = -(-ulf)
				dlf.z = dlb.z
		
				local drf = -(-urf)
				drf.z = dlb.z--]]
				
				local view = render.GetViewSetup()
				local visible = util.TraceLine({start = pos,endpos = view.origin,filter = {LocalPlayer(),ply},mask = MASK_VISIBLE})
				
				if visible.Hit then continue end
			end
		end
		
		if CLIENT then ply:SetupBones() end

		if not layers or not layersMatrix then
			create(ply)
			continue
		end

		for i = 1, #layers do
			hg.bone.MatrixClear(ply, i)
		end
		
		

		for i in pairs(layersMatrix) do
			local m = layersMatrix[i]
			if not m or not m[1] or not m[2] then continue end
			
			if not m[1]:IsEqualTol(vecZero, tolerance) then m[1]:Set(vecZero) end
			if not m[2]:AngIsEqualTo(angZero, tolerance) then m[2]:Set(angZero) end
		end

		hook_Run("Bones", ply)
		
		if CLIENT and hg_anim_fps:GetInt() != 0 and (CurTime() - (ply.timeFrame or 0)) < (1 / hg_anim_fps:GetFloat()) then continue end
		if CLIENT then ply.timeFrame = CurTime() end
		
		for i = 1, #layers do
			local layer = layers[i]
			
			if not layer[1] or not layer[2] or not layer[3] then continue end
			local matrix, matrixSet = layer[1], layer[2]
			
			local ft = SERVER and FrameTime() or math.max(FrameTime(),1 / hg_anim_fps:GetFloat())

			local serverframetime = SERVER and ft or engine.ServerFrameTime()
						
			local asd = serverframetime
			local lerp = ft / asd * 1 * layer[3] * 1
			
			for i  in pairs(matrixSet) do
				m = matrix[i]
				if not m then continue end
				
				mSet = matrixSet[i]
				mPos = m[1]
				mAngle = m[2]
				if not mPos:IsEqualTol(vecZero, tolerance) then layersMatrix[i][1] = layersMatrix[i][1] + mPos end
				if not mAngle:AngIsEqualTo(angZero, tolerance) then layersMatrix[i][2] = layersMatrix[i][2] + mAngle end

				local bone = ply:LookupBone(matrixManual[i])
				if not bone then continue end
				if layer[3] == 1 then
					if not mSet[1]:IsEqualTol(ply:GetManipulateBonePosition(bone), tolerance) then mPos:Set(mSet[1]) end
					if not mSet[2]:AngIsEqualTo(ply:GetManipulateBoneAngles(bone), tolerance) then mAngle:Set(mSet[2]) end
				else
					if not mSet[1]:IsEqualTol(ply:GetManipulateBonePosition(bone), tolerance) then mPos:Set(LerpVectorFT(lerp, mPos, mSet[1])) end
					if not mSet[2]:AngIsEqualTo(ply:GetManipulateBoneAngles(bone), tolerance) then mAngle:Set(LerpAngleFT(lerp, mAngle, mSet[2])) end
				end
			end
		end
		
		for i in pairs(layersMatrix) do
			local layer = layersMatrix[i]
			
			local bone = ply:LookupBone(matrixManual[i])
			if not bone or not layer or not layer[1] or not layer[2] then --lol
				continue
			end
	
			if not layer[1]:IsEqualTol(ply:GetManipulateBonePosition(bone), tolerance) then ply:ManipulateBonePosition(bone, layer[1], false) end
			if not layer[2]:AngIsEqualTo(ply:GetManipulateBoneAngles(bone), tolerance) then ply:ManipulateBoneAngles(bone, layer[2], false) end
		end
	end
end)

local vecZero, angZero = Vector(0, 0, 0), Angle(0, 0, 0)
function hg.bone.MatrixZero(ply, i)
	local layer = ply.boneLayers[i]
	if not layer then return end
	local matrix, matrixSet = layer[1], layer[2]
	if not matrix or not matrixSet then return end
	for i in pairs(matrixSet) do
		m = matrix[i]
		if not m or not m[1] or not m[2] then continue end
		mSet = matrixSet[i]
		if not mSet or not mSet[1] or not mSet[2] then continue end
		m[1]:Set(vecZero)
		m[2]:Set(angZero)
		mSet[1]:Set(vecZero)
		mSet[2]:Set(angZero)
		ply:ManipulateBonePosition(ply:LookupBone(matrixManual[i]), vecZero, false)
		ply:ManipulateBoneAngles(ply:LookupBone(matrixManual[i]), angZero, false)
	end
end

local vecZero, angZero = Vector(0, 0, 0), Angle(0, 0, 0)
function hg.bone.MatrixClear(ply, i)
	local layer = ply.boneLayers[i]
	local matrixSet = layer[2]
	if not matrixSet then return end
	
	for i in pairs(matrixSet) do
		m = matrixSet[i]
		--if not m or not m[1] or not m[2] then continue end
		if not m[1]:IsEqualTol(vecZero, tolerance) then m[1]:Set(vecZero) end
		if not m[2]:AngIsEqualTo(angZero, tolerance) then m[2]:Set(angZero) end
	end
end

local vecZero, angZero = Vector(0, 0, 0), Angle(0, 0, 0)
--local hg.bone = hg.bone
local layer, name
function hg.bone.Add(ply, layerID, lookup_name, vec, ang, lerp)
	if not ply.boneLayers then
		create(ply)
		return
	end

	local boneid = hg.bone.matrixManual_Name[lookup_name]
	if not boneid then
		error("cant lookup bone '" .. lookup_name .. "'")
		return
	end
	
	layer = ply.boneLayers[layerID][1] and ply.boneLayers[layerID][1][boneid]
	if not layer then
		ply.boneLayers[layerID][1] = ply.boneLayers[layerID][1] or {}
		ply.boneLayers[layerID][2] = ply.boneLayers[layerID][2] or {}
		ply.boneLayers[layerID][1][boneid] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
		ply.boneLayers[layerID][2][boneid] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
		layer = ply.boneLayers[layerID][1][boneid]
	end

	if not ply.layersMatrix[boneid] then
		ply.layersMatrix[boneid] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
	end

	layer[1]:Add(vec or vecZero)
	layer[2]:Add(ang or angZero)
end

function hg.bone.SetAdd(ply, layerID, lookup_name, vec, ang)
	if not ply.boneLayers then
		create(ply)
		return
	end

	local boneid = hg.bone.matrixManual_Name[lookup_name]
	if not boneid then
		error("cant lookup bone '" .. lookup_name .. "'")
		return
	end
	
	layer = ply.boneLayers[layerID][2] and ply.boneLayers[layerID][2][boneid]
	
	if not layer then
		ply.boneLayers[layerID][1] = ply.boneLayers[layerID][1] or {}
		ply.boneLayers[layerID][2] = ply.boneLayers[layerID][2] or {}
		ply.boneLayers[layerID][1][boneid] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
		ply.boneLayers[layerID][2][boneid] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
		layer = ply.boneLayers[layerID][1][boneid]
	end
	
	if not ply.layersMatrix[boneid] then
		ply.layersMatrix[boneid] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
	end
	
	layer[1]:Add(vec or vecZero)
	layer[2]:Add(ang or angZero)
end

local boneID
function hg.bone.Apply(ply, layerID, lookup_name, lerp)
	boneID = hg.bone.matrixManual_Name[lookup_name]
	if not boneID then
		error("cant lookup bone '" .. lookup_name .. "'")
		return
	end

	layer = ply.boneLayers[layerID]
	
	if not layer then
		ply.boneLayers[layerID][1] = ply.boneLayers[layerID][1] or {}
		ply.boneLayers[layerID][2] = ply.boneLayers[layerID][2] or {}
		ply.boneLayers[layerID][1][boneID] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
		ply.boneLayers[layerID][2][boneID] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
		layer = ply.boneLayers[layerID][1][boneID]
	end
	
	if not ply.layersMatrix[boneID] then
		ply.layersMatrix[boneID] = {Vector(0, 0, 0), Angle(0, 0, 0),layers[layerID]}
	end

	matrix, matrixSet = layer[1][boneID], layer[2][boneID]
	matrix[1]:Set(LerpVector(lerp, matrix[1], matrixSet[1]))
	matrix[2]:Set(LerpAngle(lerp, matrix[2], matrixSet[2]))
end

local angZero = Angle(0, 0, 0)
local angZero1 = Angle(0, 0, 0)
local vecZero = Vector(0, 0, 0)
local vecZero1 = Vector(0, 0, 0)
function hg.bone.Get(ply, lookup_name)
	boneID = hg.bone.matrixManual_Name[lookup_name]
	if not boneID then
		error("cant lookup bone '" .. lookup_name .. "'")
		return
	end

	local ang = angZero
	ang:Set(angZero1)
	local vec = vecZero
	vec:Set(vecZero1)
	for i = 1, #ply.boneLayers do
		local layer = ply.boneLayers[i]
		vec:Add(layer[1][boneID][1])
		ang:Add(layer[1][boneID][2])
	end
	
	return vec, ang
end
--[[
0       ValveBiped.Bip01_Pelvis
1       ValveBiped.Bip01_Spine
2       ValveBiped.Bip01_Spine1
3       ValveBiped.Bip01_Spine2
4       ValveBiped.Bip01_Spine4
5       ValveBiped.Bip01_Neck1
6       ValveBiped.Bip01_Head1
7       ValveBiped.forward
8       ValveBiped.Bip01_R_Clavicle
9       ValveBiped.Bip01_R_UpperArm
10      ValveBiped.Bip01_R_Forearm
11      ValveBiped.Bip01_R_Hand
12      ValveBiped.Anim_Attachment_RH
13      ValveBiped.Bip01_L_Clavicle
14      ValveBiped.Bip01_L_UpperArm
15      ValveBiped.Bip01_L_Forearm
16      ValveBiped.Bip01_L_Hand
17      ValveBiped.Anim_Attachment_LH
18      ValveBiped.Bip01_R_Thigh
19      ValveBiped.Bip01_R_Calf
20      ValveBiped.Bip01_R_Foot
21      ValveBiped.Bip01_R_Toe0
22      ValveBiped.Bip01_L_Thigh
23      ValveBiped.Bip01_L_Calf
24      ValveBiped.Bip01_L_Foot
25      ValveBiped.Bip01_L_Toe0
26      ValveBiped.Bip01_L_Finger4
27      ValveBiped.Bip01_L_Finger41
28      ValveBiped.Bip01_L_Finger42
29      ValveBiped.Bip01_L_Finger3
30      ValveBiped.Bip01_L_Finger31
31      ValveBiped.Bip01_L_Finger32
32      ValveBiped.Bip01_L_Finger2
33      ValveBiped.Bip01_L_Finger21
34      ValveBiped.Bip01_L_Finger22
35      ValveBiped.Bip01_L_Finger1
36      ValveBiped.Bip01_L_Finger11
37      ValveBiped.Bip01_L_Finger12
38      ValveBiped.Bip01_L_Finger0
39      ValveBiped.Bip01_L_Finger01
40      ValveBiped.Bip01_L_Finger02
41      ValveBiped.Bip01_R_Finger4
42      ValveBiped.Bip01_R_Finger41
43      ValveBiped.Bip01_R_Finger42
44      ValveBiped.Bip01_R_Finger3
45      ValveBiped.Bip01_R_Finger31
46      ValveBiped.Bip01_R_Finger32
47      ValveBiped.Bip01_R_Finger2
48      ValveBiped.Bip01_R_Finger21
49      ValveBiped.Bip01_R_Finger22
50      ValveBiped.Bip01_R_Finger1
51      ValveBiped.Bip01_R_Finger11
52      ValveBiped.Bip01_R_Finger12
53      ValveBiped.Bip01_R_Finger0
54      ValveBiped.Bip01_R_Finger01
55      ValveBiped.Bip01_R_Finger02
]]
--

