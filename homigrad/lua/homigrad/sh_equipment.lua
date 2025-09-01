-- Path scripthooked:lua\\homigrad\\sh_equipment.lua"
-- Scripthooked by ???
function hg.GetCurrentArmor(ply)
	return ply.armors
end

if SERVER then
	function hg.AddArmor(ply, equipment)
		if equipment and istable(equipment) then
			for i,equipment1 in pairs(equipment) do
				hg.AddArmor(ply, equipment1)
			end
			return
		end
		equipment = string.Replace(equipment,"ent_armor_","")
		local placement
		for plc, tbl in pairs(hg.armor) do
			placement = tbl[equipment] and tbl[equipment][1] or placement
		end

		if not placement then
			print("sh_equipment.lua: no such equipment as: " .. equipment)
			return false
		end

		if ply.armors[placement] then
			hg.DropArmor(ply, ply.armors[placement])
		end
		
		ply.armors[placement] = equipment
		
		ply:SyncArmor()
		return true
	end

	function hg.DropArmor(ply, equipment)
		if not table.HasValue(ply.armors, equipment) then return false end
		local placement
		for plc, tbl in pairs(hg.armor) do
			placement = tbl[equipment] and tbl[equipment][1] or placement
		end

		if not placement then
			print("sh_equipment.lua: no such equipment as: " .. equipment)
			return false
		end

		if hg.armor[placement][equipment] then
			local equipmentEnt = ents.Create("ent_armor_" .. equipment)
			equipmentEnt:Spawn()
			equipmentEnt:SetPos(ply:EyePos())
			equipmentEnt:SetAngles(ply:EyeAngles())
			local phys = equipmentEnt:GetPhysicsObject()
			if IsValid(phys) then phys:SetVelocity(ply:EyeAngles():Forward() * 100) end
			if IsValid(equipmentEnt) then table.RemoveByValue(ply.armors, equipment) end
			ply:SyncArmor()
			return true
		end
	end
end

if CLIENT then
	local whitelist = {
		weapon_physgun = true,
		gmod_tool = true,
		gmod_camera = true,
		weapon_crowbar = true,
		weapon_pistol = true,
		weapon_crossbow = true
	}

	local models_female = {
		["models/player/group01/female_01.mdl"] = true,
		["models/player/group01/female_02.mdl"] = true,
		["models/player/group01/female_03.mdl"] = true,
		["models/player/group01/female_04.mdl"] = true,
		["models/player/group01/female_05.mdl"] = true,
		["models/player/group01/female_06.mdl"] = true,
		["models/player/group03/female_01.mdl"] = true,
		["models/player/group03/female_02.mdl"] = true,
		["models/player/group03/female_03.mdl"] = true,
		["models/player/group03/female_04.mdl"] = true,
		["models/player/group03/female_05.mdl"] = true,
		["models/player/group03/police_fem.mdl"] = true
	}

	local PixVis
	hook.Add("Initialize", "SetupPixVis", function() PixVis = util.GetPixelVisibleHandle() end)
	local islply

	local blmodels = {
		["models/monolithservers/kerry/swat_male_02.mdl"] = true,
		["models/monolithservers/kerry/swat_male_04.mdl"] = true,
		["models/monolithservers/kerry/swat_male_07.mdl"] = true,
		["models/monolithservers/kerry/swat_male_08.mdl"] = true,
		["models/monolithservers/kerry/swat_male_09.mdl"] = true,
	}

	local function DrawArmors(ply, armors)
		--print(ply)
		if not IsValid(ply) or not ply.armors then
			return
		end
		
		if ply:IsPlayer() and not ply:Alive() and not IsValid(ply.FakeRagdoll) then return end

		

		local wep = ply:IsPlayer() and ply:GetActiveWeapon()
		islply = ply == LocalPlayer() and GetViewEntity() == LocalPlayer()
		if islply and IsValid(wep) and whitelist[wep:GetClass()] then
			if ply.modelArmor then
				for arm, model in pairs(ply.modelArmor) do
					if IsValid(model) then
						model:Remove()
						model = nil
					end
				end	
			end

			ply.modelArmor = {}
			return
		end
		
		local ent = hg.GetCurrentCharacter(ply)
		if not ent.shouldTransmit or (ent.NotSeen and LocalPlayer():Alive()) or blmodels[ent:GetModel()] then
			if not ply.modelArmor then return end
			for arm, model in pairs(ply.modelArmor) do
				if IsValid(model) then
					model:Remove()
					model = nil
				end
			end
			return
		end

		for placement, armor in pairs(armors) do
			local armorData = hg.armor[placement][armor]
			ply.modelArmor = ply.modelArmor or {}
			ply.modelArmor[armor] = IsValid(ply.modelArmor[armor]) and ply.modelArmor[armor] or ClientsideModel(armorData["model"])
			local model = ply.modelArmor[armor]
			
			if not IsValid(model) then return end
			
			local matrix = ent:GetBoneMatrix(ent:LookupBone(armorData["bone"]))
			if not matrix then
				model:SetNoDraw(true)
				return
			end

			local bonePos, boneAng = matrix:GetTranslation(), matrix:GetAngles()
			local fem = ThatPlyIsFemale(ent)
			bonePos:Add(boneAng:Forward() * (fem and armorData.femPos[1] or 0) + boneAng:Up() * (fem and armorData.femPos[2] or 0) + boneAng:Right() * (fem and armorData.femPos[3] or 0))
			local pos, ang = LocalToWorld(armorData[3], armorData[4], bonePos, boneAng)
			model:SetRenderOrigin(pos)
			model:SetRenderAngles(ang)
			model:SetModelScale( (fem and armorData.femscale) or armorData.scale or 1 )
			if armorData.material then model:SetSubMaterial(0, armorData.material) end
			model:SetupBones()
			model:SetNoDraw(true)
			if not (islply and armorData.norender) then model:DrawModel() end
		end
	end

	--[[local function PlySeeEntity(ply,entys)
		local ply = hg.GetCurrentCharacter(ply)
		local att = ply:LookupAttachment("eyes")
		if att then
			att = ply:GetAttachment(att)
		else
			local tr = {
				start = ply:EyePos(),
				endpos = entys:GetPos(),
				filter = ply
			}
			return util.TraceLine(tr).Entity
		end
	
		local tr = {}
		tr.start = att.Pos
		tr.endpos = entys:GetPos()
		tr.filter = ply

		return util.TraceLine(tr).Entity
	end]]--

	local lply = LocalPlayer()

	hook.Add("PostDrawOpaqueRenderables", "player-armor", function()
		local ents = ents.FindByClass("prop_ragdoll")
		table.Add(ents,player.GetAll())
		
		for i,ent in ipairs(ents) do
			if not IsValid(ent) or not ent:GetNetVar("Armor") then continue end
			DrawArmors(ent, ent:GetNetVar("Armor"))
		end
	end)

	hook.Add("OnNetVarSet","ArmorVarSet",function(index, key, var)
		if key == "Armor" then
			timer.Simple(.1,function()
				local ent = Entity(index)
				ent.armors = var
			end)
		end
	end)

	local mat = Material("sprites/mat_jack_hmcd_helmover")
	loopingsound = nil
	hook.Add("RenderScreenspaceEffects", "renderHelmetThingy", function()
		lply = LocalPlayer()

		if GetViewEntity() != lply then
			if loopingsound then
				lply:StopLoopingSound(loopingsound)
			end
			return
		end

		local armors = lply.armors -- предавать всю таблицу это же бред?

		if armors and armors["face"] then
			local custommat = hg.armor.face[armors["face"]].viewmaterial
			surface.SetDrawColor(255,255,255,255)
			surface.SetMaterial(custommat or mat)
			surface.DrawTexturedRect(-1, -1, ScrW()+1, ScrH()+1)

			if hg.armor.face[armors["face"]].loopsound then
				loopingsound = lply:StartLoopingSound(hg.armor.face[armors["face"]].loopsound)
			end
		else
			if loopingsound then
				lply:StopLoopingSound(loopingsound)
			end
		end
		
		if armors and armors["head"] then
			local custommat = hg.armor.head[armors["head"]].viewmaterial
			surface.SetDrawColor(255,255,255,255)
			surface.SetMaterial(custommat or mat)
			surface.DrawTexturedRect(-1, -1, ScrW()+1, ScrH()+1)
		end
	end)

	local function equipmentMenu()
		RunConsoleCommand("hg_get_equipment")
	end
	
	hook.Add("radialOptions", "equipment", function()
		local tbl = LocalPlayer().armors or {}
		local organism = LocalPlayer().organism or {}

		if not organism.Otrub and table.Count(tbl) > 0 then
			local tbl = {equipmentMenu, "Drop Equipment"}
			hg.radialOptions[#hg.radialOptions + 1] = tbl
			--local tbl = {dropEquipmentMenu,"Modify Equipment"}
			--hg.radialOptions[#hg.radialOptions + 1] = tbl
		end
	end)

	concommand.Add("hg_add_equipment", function(ply, cmd, args)
		local att = args[1]
		net.Start("hg_add_equipment")
		net.WriteString(att)
		net.SendToServer()
	end)

	concommand.Add("hg_drop_equipment", function(ply, cmd, args)
		local att = args[1]
		net.Start("hg_drop_equipment")
		net.WriteString(att)
		net.SendToServer()
	end)
else
	util.AddNetworkString("hg_add_equipment")
	util.AddNetworkString("hg_drop_equipment")

	net.Receive("hg_drop_equipment", function(len, ply)
		local equipment = net.ReadString()
		
		if not ply.organism.canmove then return end

		hg.DropArmor(ply, equipment)
	end)
end

if CLIENT then
	local CreateMenu
	local function dropArmor(arm)
		RunConsoleCommand("hg_drop_equipment", arm)
	end

	local plyEquipment = plyEquipment or {}
	local armors = plyEquipment or {}
	local drop = true
	local gray = Color(200, 200, 200)
	local blue = Color(200, 200, 255)
	local red = Color(75,25,25)
	local redselected = Color(150,0,0)
	local whitey = Color(255, 255, 255)
	local menuPanel
	local chosen2

	local blurMat = Material("pp/blurscreen")
    local Dynamic = 0
	local function BlurBackground(panel)
		if not (IsValid(panel) and panel:IsVisible()) then return end
        local layers, density, alpha = 1, 1, 155
        local x, y = panel:LocalToScreen(0, 0)
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.SetMaterial(blurMat)
        local FrameRate, Num, Dark = 1 / FrameTime(), 5, 190

        for i = 1, Num do
            blurMat:SetFloat("$blur", (i / layers) * density * Dynamic)
            blurMat:Recompute()
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
        end

        surface.SetDrawColor(0, 0, 0, Dark * Dynamic)
        surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
        Dynamic = math.Clamp(Dynamic + (1 / FrameRate) * 7, 0, 1)
	end

	CreateMenu = function()
		Dynamic = 0
		local lply = LocalPlayer()
		
		plyEquipment = lply.armors or lply:GetNetVar("Armor",{})
		
		if not plyEquipment or table.Count(plyEquipment) == 0 then return end

		local sizeX, sizeY = ScrW() / 6, 100 + (table.Count(plyEquipment)) * 20
		gray.a = 255
		blue.a = 255
		if IsValid(menuPanel) then
			menuPanel:Remove()
			menuPanel = nil
		end

		local onwep
		menuPanel = vgui.Create("DFrame")
		menuPanel:SetTitle("Armor menu")
		menuPanel:SetPos(ScrW() / 2 - sizeX / 2, ScrH() / 2 - sizeY / 2)
		menuPanel:SetSize(sizeX, sizeY)
		menuPanel:MakePopup()
		menuPanel:SetKeyBoardInputEnabled(false)
		function menuPanel:Paint( w, h )
			draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 0, 0, 0, 140) )
            BlurBackground(menuPanel)
            surface.SetDrawColor( 255, 0, 0, 128)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
		end
		local armorPanel = vgui.Create("DCategoryList", menuPanel)
		armorPanel:Dock(FILL)
		function armorPanel:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 140) )
		end
		local Equip = armorPanel:Add("Armor")
		function Equip:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 44, 0, 0, 140) )
		end

		local chosen
		local add

		for placement, armor in pairs(plyEquipment) do
			local button = Equip:Add("")
			button:SetSize(0,25)
			button:DockMargin(0,0,0,2.5)
			if chosen2 and chosen2[1] == i and chosen2[2] then
				chosen = button
				add = true
			end

			button.armor = armor
			button.DoClick = function()
				chosen = button
				chosen2 = {i, true}
				add = false
			end

			button.Paint = function(self, w, h)
				button.a = Lerp(0.1,button.a or 100,button:IsHovered() and 255 or 150)
				draw.RoundedBox(0, 0, 0, w, h, chosen == self and Color(redselected.r,redselected.g,redselected.b,button.a) or Color(red.r,red.g,red.b,button.a))
				draw.DrawText(language.GetPhrase(armor), "DermaDefault", w / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end

		local button = vgui.Create("DButton", menuPanel)
		button:SetSize(sizeX, 25)
		button:Dock(BOTTOM)
		button:DockMargin(0, 5, 0, 0)
		button:SetText("")
		button.Paint = function(self, w, h)
			button.a = Lerp(0.1,button.a or 100,button:IsHovered() and 255 or 150)
			draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,button.a))
			draw.DrawText(drop and "Drop armor" or "Add armor", "DermaDefault", w / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		button.DoClick = function()
			if not chosen then return end
			dropArmor(chosen.armor)
			if IsValid(menuPanel) then
				menuPanel:Remove()
				menuPanel = nil
			end
		end
	end

	concommand.Add("hg_get_equipment", function(ply, cmd, args)
		if ply == LocalPlayer() then
			CreateMenu()
		end
	end)
end