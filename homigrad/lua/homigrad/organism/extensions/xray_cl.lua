-- Path scripthooked:lua\\homigrad\\organism\\tier_1\\cl_statistics.lua"
-- Scripthooked by ???
--organism_otherply = organism_otherply or {}
--net.Receive("organism_sendply", function() organism_otherply = net.ReadTable() end)

local white = Color(255, 255, 255)
local red = Color(255, 0, 0)
net.Receive("test234", function()
	local origin, dir = net.ReadVector(), net.ReadVector()
	debugoverlay.Sphere(origin, 1, 10, white)
	debugoverlay.Sphere(origin + dir, 1, 10, red)
end)

local owner
net.Receive("wound_debug", function()
	owner = net.ReadEntity()
	owner.wounds = net.ReadTable()
end)

local timeHuy
local ent = NULL
local model = "models/Humans/Group01/Female_03.mdl"
local pos = Vector(0,0,0)
local bones = {}
local tracePoses,normal = {},Vector(0,0,0)
local hitBoxs = {}
local dmg = 0
local matpos
local matang
if IsValid(csmodel) then
	csmodel:Remove()
end
csmodel = ClientsideModel("models/Humans/Group01/Female_03.mdl",RENDERMODE_TRANSCOLOR)
csmodel:SetNoDraw(true)
if IsValid(skiletmodel) then
	skiletmodel:Remove()
end
skiletmodel = ClientsideModel("models/player/sniper elite 3/skeleton_playermodel.mdl",RENDERMODE_TRANSCOLOR)
skiletmodel:SetNoDraw(true)
skiletmodel:SetBodyGroups("1110")
skiletmodel:AddEffects( EF_BONEMERGE )
skiletmodel:SetParent(csmodel)

--skiletmodel:ManipulateBoneAngles( 0, Angle(0,0,0), false )

if IsValid(bulletmodel) then
	bulletmodel:Remove()
end
bulletmodel = ClientsideModel("models/weapons/bt_762.mdl",RENDERMODE_TRANSCOLOR)
bulletmodel:SetNoDraw(true)
local organs,boxs,pos,sphere
local angle = Angle(25,0,0)

local localpos,localang,bone = Vector(0,0,0),Angle(0,0,0),0

HitsOrg = HitsOrg or {}
local angZero = Angle(0,0,0)
local vecFull = Vector(1,1,1)
local iter = 1
currentPos = Vector(0,0,0)
local function TracePlaying(index)
	local index = iter
	if not HitsOrg[index] then return end
	hitBoxs = HitsOrg[index].hitBoxs
	dmg = HitsOrg[index].dmg
	matpos = HitsOrg[index].matpos
	matang = HitsOrg[index].matang
	bones = HitsOrg[index].bones
	model = HitsOrg[index].model
	patron = HitsOrg[index].bullet
	traceBullet = HitsOrg[index].trace
	currentPos = HitsOrg[index].trace.StartPos
	inBody = HitsOrg[index].inBody
	local posxx = HitsOrg[index].pos
	size = 2
	csmodel:SetPos(posxx)
	csmodel:SetModel(model)
	csmodel:SetColor(Color(255,255,255))

	for i,func in pairs(csmodel:GetCallbacks("BuildBonePositions")) do
		csmodel:RemoveCallback("BuildBonePositions",i)
	end

	csmodel:AddCallback("BuildBonePositions",function()
		for i = 0,csmodel:GetBoneCount() do
			if not bones[i] or not csmodel:GetBoneMatrix(i) then continue end
			
			csmodel:SetBoneMatrix(i,bones[i])
		end
	end)
	timeHuy = 0
end	

hook.Add("Player Death","qweqwtmkwxczxcowww",function(ply)
	if ply != LocalPlayer() or #HitsOrg == 0 then return end

	iter = #HitsOrg
	if iter > 0 then
		TracePlaying(iter)
	end
end)

hook.Add("Player Spawn", "fmgkdfkg", function(ply)
	if ply == LocalPlayer() and not OverrideSpawn then
		HitsOrg = {}
	end
end)

net.Receive("tracePosesSend", function()
	local ent = net.ReadEntity()
	local hitBoxs = net.ReadTable()
	local dmg = net.ReadFloat()--actually pen
	local matpos = net.ReadVector()
	local matang = net.ReadAngle()
	local traces = net.ReadTable()
	local inBody = net.ReadBool()

	local model = ent:GetModel()
	local bones = {}

	--ent:ManipulateBoneScale(ent:LookupBone("ValveBiped.Bip01_Head1"),Vector(1,1,1))
	
	for i = 0,ent:GetBoneCount() do
		bones[i] = ent:GetBoneMatrix(i)
		if bones[i] then
			bones[i]:SetScale(vecFull)
		end
	end

	table.insert(HitsOrg,{
		pos = ent:GetPos(),
		hitBoxs = hitBoxs,
		dmg = dmg,
		matpos = matpos,
		matang = matang,
		bones = bones,
		model = model,
		trace = traces,
		inBody = inBody,
		--bullet = ammotype,
	})
end)

function draw.RotatedText( text, x, y, font, color, ang)
	render.PushFilterMag( TEXFILTER.ANISOTROPIC )
	render.PushFilterMin( TEXFILTER.ANISOTROPIC )

	local m = Matrix()
	m:Translate( Vector( x, y, 0 ) )
	m:Rotate( Angle( 0, ang, 0 ) )

	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )

	m:Translate( -Vector( w / 2, h / 2, 0 ) )

	cam.PushModelMatrix( m )
		draw.DrawText( text, font, 0, 0, color )
	cam.PopModelMatrix()

	render.PopFilterMag()
	render.PopFilterMin()
end

local traveltime = 30
local sizeX, sizeY = ScrW(), ScrH()
local posX, posY = 0, 0
local lply = LocalPlayer()

function hg.DeathCamAvailable(ply)
	return timeHuy and ((timeHuy + traveltime) > CurTime()) and #HitsOrg > 0
end
local delta = 0
hook.Add("CreateMove","delta-counting-hg",function(cmd)
	delta = cmd:GetMouseWheel()
end)

local len = 50
local fovddd = 90
local minFOV, maxFOV = 30, 120
local fovSpeed = 2
local testVal = 0
hook.Add("InputMouseApply", "testMouseWheel", function(cmd, x, y, ang)
	if cmd:GetMouseWheel() <= -1 then
		fovddd = math.Clamp(fovddd + 5, minFOV, maxFOV)
	end
	if cmd:GetMouseWheel() >= 1 then
		fovddd = math.Clamp(fovddd - 5, minFOV, maxFOV)
	end
end)
hook.Add("Think", "ScrollToChangeFOV", function()
    if input.IsMouseDown(MOUSE_WHEEL_UP) then
        fovddd = math.Clamp(fovddd - fovSpeed, minFOV, maxFOV)
    elseif input.IsMouseDown(MOUSE_WHEEL_DOWN) then
        fovddd = math.Clamp(fovddd + fovSpeed, minFOV, maxFOV)
    end
end)
function hg.DeathCam(ply,origin,angles,fov,znear,zfar)
	lply = lply or LocalPlayer()
	if not lply:Alive() then
		len = math.Clamp(len - delta * 10,10,50)
		if timeHuy == 0 then timeHuy = CurTime() end
		if lply:KeyDown(IN_RELOAD) then timeHuy = nil hg.hits = {} end
		if timeHuy and ((timeHuy + traveltime) > CurTime()) then
			local tbl = traceBullet

			local startPos = tbl.StartPos
			local endPos = tbl.HitPos
			local direction = (endPos - startPos):GetNormalized()
			local offset = direction * (inBody == true and 3 or 25)
			local newEndPos = endPos + offset
			currentPos = LerpVector(0.02, currentPos, newEndPos)

			local view = {
				origin = currentPos+angles:Forward()*-len,
				angles = angles,
				fov = fovddd,
				drawviewer = true
			}

			return view
		end
	end
end
local weight = ScreenScale(100)
local colblack = Color(0,0,0,255)
local colyellow = Color(255,217,0)
local colred = Color(135,0,0,255)
local attpressed
local attpressed2
local mathuy = Material("color")
local meat = Material("models/flesh")

hook.Add("HUDPaint","homigrad-wound-debug",function()
	lply = lply or LocalPlayer()
	if not lply:Alive() then
		if timeHuy == 0 then timeHuy = CurTime() end
		if (lply:KeyDown(IN_ATTACK2) or lply:KeyDown(IN_MOVERIGHT)) and timeHuy and #HitsOrg != 0 then
			if not attpressed then
				local next_ = iter + 1
				iter = next_ > #HitsOrg and 1 or next_
				TracePlaying(i)
				attpressed = true
			end
		else
			attpressed = nil
		end

		if (lply:KeyDown(IN_ATTACK) or lply:KeyDown(IN_MOVELEFT)) and timeHuy and #HitsOrg != 0 then
			if not attpressed2 then
				local next_ = iter - 1
				iter = next_ < 1 and #HitsOrg or next_
				TracePlaying(i)
				attpressed2 = true
			end
		else
			attpressed2 = nil
		end
		if timeHuy and ((timeHuy + traveltime) > CurTime()) then
			local tbl = traceBullet
			local startPos = tbl.StartPos
			local OendPos = tbl.HitPos

			local direction = (OendPos - startPos):GetNormalized()
			local offset = direction * (inBody == true and 3 or 25)
			local endPos = OendPos + offset

			local part = 1 - ((timeHuy + traveltime) - CurTime()) / traveltime
			local alpha = ((timeHuy + traveltime) - CurTime()) / 0.2
			local alpha2 = math.Clamp(1 - ((timeHuy + traveltime) - CurTime()) / 0.5,0,1)	

			--draw.RoundedBox(0,posX,posY,sizeX,sizeY,Color(0,0,0,255*alpha))
			angle = angle + Angle(0,0.25,0)

			cam.Start3D()
			
				render.SetStencilWriteMask( 0xFF )
				render.SetStencilTestMask( 0xFF )
				render.SetStencilReferenceValue( 0 )
				render.SetStencilCompareFunction( STENCIL_ALWAYS )
				render.SetStencilPassOperation( STENCIL_KEEP )
				render.SetStencilFailOperation( STENCIL_KEEP )
				render.SetStencilZFailOperation( STENCIL_KEEP )
				render.ClearStencil()
				
				render.SetStencilEnable( true )
				render.SetStencilReferenceValue( 1 )
				render.SetStencilCompareFunction( STENCIL_ALWAYS )
				render.SetStencilPassOperation( STENCIL_REPLACE )
				--render.SetStencilZFailOperation( STENCIL_DECR )

				csmodel:DrawModel()

				render.SetStencilCompareFunction( STENCIL_EQUAL )
				render.SetStencilPassOperation( STENCIL_INCR )
				render.SetStencilZFailOperation( STENCIL_INCR )
				local huyalpha = alpha * 0.2 / traveltime
				huyalpha = huyalpha > 0.2 and 1 or huyalpha / 0.2
				render.SetMaterial(mathuy)
				render.DrawSphere(currentPos,7 * huyalpha,50,50,colblacka)
				
				render.SetStencilReferenceValue( 2 )
				--bulletmodel:DrawModel()

				render.SetStencilReferenceValue( 2 )
				render.SetStencilPassOperation( STENCIL_KEEP )
				render.SetStencilZFailOperation( STENCIL_KEEP )
				render.SetStencilCompareFunction( STENCIL_EQUAL )
				render.ClearBuffersObeyStencil( 0, 0, 0, 0, true )

				cam.Start2D()
					surface.SetDrawColor(155,0,0,15)
					surface.DrawTexturedRect(0,0,ScrW(),ScrH(),0)
				cam.End2D()
				skiletmodel:DrawModel()
				cam.Start2D()
					surface.SetDrawColor(155,0,0,95)
					surface.DrawTexturedRect(0,0,ScrW(),ScrH(),0)
				cam.End2D()

				organs = hg.organism.GetHitBoxOrgans(model, csmodel)
				boxs,pos,sphere = hg.organism.ShootMatrix(csmodel, organs)

				--local endPos, hitBoxs2, inputHole, outputHole = hg.organism.Trace(point1, point2 - point1, boxs, pos, sphere, organs, nil, hg.organism.Trace_Bullet, organs)
				
				for i = 1,#boxs do
					local box = boxs[i]
					local organ = box[6] and organs[box[6]][box[7]]
					if not hitBoxs[i] then continue end
					
					local col = Color((organ and organ[6] or white):Unpack())
					col.a = 50
					render.DrawWireframeBox(box[1], box[2], box[3], box[4], col, false)
				end
				
				render.SetStencilEnable( false )

				for i = 1,#boxs do
					local box = boxs[i]
					local organ = box[6] and organs[box[6]][box[7]]
					if not hitBoxs[i] then continue end

					--if organ and hitorgans[i] then
					--	cam.Start2D()
					--		draw.SimpleText(hg.organism.translationTbl[organ[1]] or organ[1], "HomigradFontSmall", box[1]:ToScreen().x + math.sin(CurTime()%(i))^3 * (5%i),box[1]:ToScreen().y + math.cos(CurTime()%(i)) * (5%i), organ and organ[6])
					--	cam.End2D()
					--end
					
				end
				white.r = 255
				white.g = 255
				white.b = 255
				white.a = 255
				render.SetColorMaterial()
				render.DrawBox(currentPos, (startPos - endPos):Angle(), -Vector(1,0.3,0.3), Vector(1,0.3,0.3), colyellow)
				render.DrawWireframeBox(currentPos, (startPos - endPos):Angle(), -Vector(1,0.3,0.3), Vector(1,0.3,0.3), colyellow)

				local length = startPos:Distance(endPos)

				render.DrawWireframeBox(startPos, (startPos - endPos):Angle(), -Vector(1, 0.5, 0.5), Vector(-length, 0.5, 0.5), colblack)

				--for i=1,#tbl-1 do
				--	render.DrawWireframeBox(tbl[i], (tbl[i+1] - tbl[i]):Angle(), -Vector(0,size * 0.9,size * 0.9),Vector((tbl[i+1] - tbl[i]):Length(),size * 0.9,size * 0.9),Color(0,0,0,100))
				--end

				--bulletmodel:SetPos(currentPos)
				--bulletmodel:SetAngles(-(startPos - endPos):Angle())
				--bulletmodel:SetModelScale(0.4)
				--bulletmodel:DrawModel()
				--render.DrawLine(point1,point2,color_white,false)
				
			cam.End3D()

			draw.RotatedText("LMB or R to skip",posX + 155 ,posY+85,"HomigradFontLarge",Color(135,0,0,255*alpha),15)

			draw.SimpleText("Hit "..tostring(iter).." of "..tostring(#HitsOrg)..".", "HomigradFontBig", ScrW() / 3 * 2, ScrH() / 10, color_white)
		end
	end
end)