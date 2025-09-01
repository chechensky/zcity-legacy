-- Path scripthooked:lua\\homigrad\\sh_inventory.lua"
-- Scripthooked by ???
if SERVER then
	local blackList = {
		["weapon_hands_sh"] = true,
		["weapon_zombclaws"] = true
	}

	function hg.CreateInv(ply)
		ply.inventory = {}
		local inv = ply.inventory
		inv.Weapons = {}
		for i, wep in pairs(ply:GetWeapons()) do
			if blackList[wep:GetClass()] then continue end
			inv.Weapons[wep:GetClass()] = {wep:Clip1(), wep.attachments}
		end

		inv.Ammo = ply:GetAmmo()
		inv.Armor = {}
		inv.Attachments = {}
		ply:SetNetVar("Inventory", inv)
	end

	function hg.RenewInv(ply)
	end

	hook.Add("Player Spawn", "homigrad-inventory", function(ply)
		hg.CreateInv(ply)
	end)

	hook.Add("WeaponEquip", "homigrad-inventory", function(wep, ply)
	end)

	hook.Add("PlayerDroppedWeapon", "homigrad-inventory", function(ply, wep)
	end)

	hook.Add("PlayerAmmoChanged", "homigrad-inventory", function(ply)
		if not ply.inventory then return end
		ply.inventory.Ammo = ply:GetAmmo()
		ply:SetNetVar("Inventory", ply.inventory)
	end)

	local vecZero = Vector(0, 0, 0)
	hook.Add("PlayerDropWeapon", "homigrad-inventory", function(ply)
	end)

	function GAMEMODE:PlayerLoadout(ply)
	end

	hook.Add("DoPlayerDeath", "homigrad-inventory", function(ply) hook.Run("PlayerDropWeapon", ply) end)
	hook.Add("PostPlayerDeath", "homigrad-inventory", function(ply)
	end)

	local functions = {
		["Weapons"] = function(ply, ent, wep)
			if ply.inventory.Weapons[wep] or (ent:IsPlayer() and IsValid(ent:GetActiveWeapon()) and ent:GetActiveWeapon():GetClass() == wep) then return end
			if not ent.inventory.Weapons[wep] then return end
			local weapon = weapons.Get(wep)
			if not weapon then return end
			if not hg.weaponInv.CanInsert(ply, weapon) then return end
			local weapon = ply:Give(wep)
			weapon.DontEquipInstantly = true
			local tbl = ent.inventory.Weapons[wep]
			weapon:SetClip1(tbl[1])
			weapon.attachments = tbl[2]
			if weapon.SyncAtts then weapon:SyncAtts() end
			ent.inventory.Weapons[wep] = nil
			if ent:IsPlayer() then ent:StripWeapon(wep) end
		end,
		["Ammo"] = function(ply, ent, ammo, amt)
			local amt2 = ent.inventory.Ammo[tonumber(ammo)]
			if not amt or amt ~= amt2 then return end
			ply:GiveAmmo(amt, game.GetAmmoName(ammo), true)
			--ent.inventory.Ammo[tonumber(ammo)] = nil
			if ent:IsPlayer() then
				ent:SetAmmo(0, game.GetAmmoName(ammo))
			else
				ent.inventory.Ammo[tonumber(ammo)] = nil
			end
		end,
		["Armor"] = function(ply, ent, placement, armor)
			if (not ent.armors[placement]) or (ent.armors[placement] ~= armor) or ply.armors[placement] then return end
			ply.armors[placement] = armor
			ent.armors[placement] = nil
		end,
		["Attachments"] = function(ply, ent, att, tbl)
			if not table.HasValue(ent.inventory.Attachments, tbl) then return end
			ply.inventory.Attachments[#ply.inventory.Attachments + 1] = tbl
			ent.inventory.Attachments[table.KeyFromValue(ent.inventory.Attachments, tbl)] = nil
			table.ClearKeys(ent.inventory.Attachments, false)
		end,
		["Money"] = function(ply, ent)
			local money = ent:GetNetVar("zb_Scrappers_RaidMoney", 0)
			ply:SetNetVar("zb_Scrappers_RaidMoney", ply:GetNetVar("zb_Scrappers_RaidMoney", 0) + money)
			ent:SetNetVar("zb_Scrappers_RaidMoney", 0)
		end,
	}

	util.AddNetworkString("ply_take_item")
	net.Receive("ply_take_item", function(len, ply)
		if (ply.cooldown or 0) > CurTime() then return end
		ply.cooldown = CurTime() + 0.5

		local tblIndex = net.ReadString()
		local thing = net.ReadString()
		local tbl = net.ReadTable()
		local ent = net.ReadEntity()

		if ent:IsPlayer() and not IsValid(ent.FakeRagdoll) then return end

		if ent:GetPos():Distance(ply:GetPos()) > 125 then return end
		local func = functions[tblIndex]
		if func then func(ply, ent, thing, unpack(tbl)) end
		ply:SetNetVar("Inventory", ply.inventory)
		ent:SetNetVar("Inventory", ent.inventory)
		ply:SyncArmor()
		ent:SyncArmor()
	end)

	util.AddNetworkString("should_open_inv")
	local playerMeta = FindMetaTable("Player")
	function playerMeta:OpenInventory(ent)
		if not IsValid(ent) then return end
		if ent:IsPlayer() and not IsValid(ent.FakeRagdoll) then return end
		if ent:IsPlayer() then hg.RenewInv(ent) end
		if self:IsPlayer() then hg.RenewInv(self) end
		net.Start("should_open_inv")
		net.WriteEntity(ent)
		net.Send(self)
	end

	function playerMeta:GetLookTrace()
		if not IsValid(self) or not self:Alive() then return end
		local tr = {}
		local ent = IsValid(self.FakeRagdoll) and self.FakeRagdoll or self
		local att = ent:GetAttachment(ent:LookupAttachment("eyes"))
		if not att then return false end
		tr.start = att.Pos
		tr.endpos = att.Pos + self:EyeAngles():Forward() * 80
		tr.filter = ent
		return util.TraceLine(tr)
	end

	hook.Add("Player Think","loot-higgers",function(ply)
		if not ply:Alive() then return end
		if 1 then return end
		ply.keypressed = ply.keypressed or false
		--if not ply:GetLookTrace() then return end
		local trace = ply:GetLookTrace()
		
		if not trace then return end
		local ent = ply:GetLookTrace().Entity
		ent = ent
		
		if not IsValid(ent) or not ent.inventory then return end
		if ply:KeyDown(IN_ATTACK2) and ply:KeyDown(IN_USE) then
			if IsValid(ply.FakeRagdoll) then return end
			if not ply.keypressed then ply:OpenInventory(ent) end
			ply.keypressed = true
		else
			ply.keypressed = false
		end
	end)
else
	local OpenInv
	net.Receive("should_open_inv", function()
		local ent = net.ReadEntity()
		OpenInv(ent)
	end)

	local colRed = Color(255, 0, 0, 255)
	local colBlack2 = Color(100, 100, 100)
	local colBlack3 = Color(50, 50, 50, 120)
	local colBlue = Color(150, 150, 150)
	local buttons = {}
	local function nameThings(i, thing)
		if weapons.Get(i) then return weapons.Get(i).PrintName end
		if hg.armor and hg.armor[i] and hg.armor[i][thing] then return thing end
		if hg.attachmentslaunguage and hg.attachmentslaunguage[thing] then return thing end
		if i == "Money" then return "Money, " .. tostring(thing) .. "$" end
		return i
	end

	local function getIconThing(i, thing, tab)
		if tab == "Weapons" and weapons.Get(i) then
			local GunTable = weapons.Get(i)
			--print(GunTable.WepSelectIcon2)
			local Icon = (GunTable.WepSelectIcon2 ~= nil and GunTable.WepSelectIcon2) or GunTable.WepSelectIcon
			local Overide = GunTable.WepSelectIcon2 == nil and true or false
			local HaveIcon = true
			return Icon, HaveIcon, Overide, false
		end

		if tab == "Attachments" and hg.attachmentsIcons[thing] then
			local AttIcon = hg.attachmentsIcons[thing]
			local HaveIcon = true
			return AttIcon, HaveIcon, false, true
		end

		if tab == "Armor" then
			local AttIcon = hg.armorIcons[thing]
			local HaveIcon = true
			return AttIcon, HaveIcon, false, true
		end

		if tab == "Money" then
			local AttIcon = "scrappers/money_icon.png"
			local HaveIcon = true
			return AttIcon, HaveIcon, false
		end
	end

	local functions = {
		["Weapons"] = function(ply, ent, wep)
			local weapon = weapons.Get(wep)
			if not weapon or (ent:IsPlayer() and IsValid(ent:GetActiveWeapon()) and ent:GetActiveWeapon() == wep) then return end
			if not hg.weaponInv.CanInsert(ply, weapon) or ply:HasWeapon(wep) then return false end
			return true
		end,
		["Ammo"] = function(ply, ent, ammo, amt)
			if true then return true end
		end,
		["Armor"] = function(ply, ent, placement, armor)
			local armors = ply:GetNetVar("Armor",{})
			if armors[placement] then return false end
			if true then return true end
		end,
		["Attachments"] = function(ply, ent, att, tbl)
			if true then return true end
		end,
		["Money"] = function(ply, ent)
			if true then return true end
		end,
	}

	local cooldown = 0

	local function TakeItem(tblIndex, thing, item, owner)
		local item = istable(item) and item or {item}

		net.Start("ply_take_item")
		net.WriteString(tblIndex)
		net.WriteString(thing)
		net.WriteTable(item)
		net.WriteEntity(owner)
		net.SendToServer()
	end

	local plyMenu
	local chosen
	local chooseButton
	local chooseButtonHuy
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

	OpenInv = function(ent)
		local ply = LocalPlayer()
		Dynamic = 0
		local inv = ent:GetNetVar("Inventory")
		inv["Money"] = {}
		local entmoney = ent:GetNetVar("zb_Scrappers_RaidMoney") or 0
		if entmoney > 0 then inv["Money"]["Money"] = entmoney end
		local armor = ent:GetNetVar("Armor")
		inv["Armor"] = armor
		if not inv then return end
		if IsValid(plyMenu) then
			plyMenu:Remove()
			plyMenu = nil
		end

		local name = IsValid(ent) and ent:IsPlayer() and ent:Name() or ent:GetPlayerName() or ""
		local sizeX, sizeY = ScrW() / 3, ScrH() / 2.5
		plyMenu = vgui.Create("DFrame")
		plyMenu:SetTitle("")
		plyMenu:SetSize(sizeX, sizeY)
		plyMenu:Center()
		plyMenu:MakePopup()
		plyMenu:SetKeyBoardInputEnabled(false)
		plyMenu:ShowCloseButton(true)
		plyMenu.Paint = function(self, w, h)
			draw.RoundedBox(0, 2.5, 2.5, w - 5, h - 5, Color(0, 0, 0, 140))
			BlurBackground(plyMenu)
			surface.SetDrawColor(255, 0, 0, 128)
			surface.DrawOutlinedRect(0, 0, w, h, 2.5)
			--surface.SetDrawColor(100,100,100,250)
			--surface.DrawRect(w / 2 - 100, 10,200,20)
			draw.DrawText(name .. "'s inventory", "HomigradFontSmall", w / 2, 10, color_white, TEXT_ALIGN_CENTER)
		end

		local DScrollPanel = vgui.Create("DScrollPanel", plyMenu)
		DScrollPanel:SetPos(sizeX / 30, sizeY / 10)
		DScrollPanel:SetSize(sizeX - sizeX / 16, sizeY - sizeY / 5)
		function DScrollPanel:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
			surface.SetDrawColor(255, 0, 0, 128)
			surface.DrawOutlinedRect(0, 0, w, h, 2.5)
		end

		local sbar = DScrollPanel:GetVBar()
		function sbar:Paint(w, h)
		end

		function sbar.btnUp:Paint(w, h)
		end

		function sbar.btnDown:Paint(w, h)
		end

		function sbar.btnGrip:Paint(w, h)
		end

		local grid = vgui.Create("DGrid", DScrollPanel)
		grid:Dock(FILL)
		grid:DockMargin(14, 10, 0, 0)
		grid:SetCols(5)
		grid:SetColWide(sizeX / 5 - sizeX / 16 / 3)
		grid:SetRowHeight(sizeY / 6.5 + sizeY / 32)
		for tab, things in pairs(inv) do
			for i, thing in pairs(things) do
				local button = vgui.Create("DButton", plyMenu)
				button:SetText("")
				button:DockMargin(5, 0, 15, 0)
				button:SetSize(sizeX / 6, sizeY / 6)
				button.DoClick = function()
					if cooldown > CurTime() then return end
					if ent:IsPlayer() and not IsValid(ent.FakeRagdoll) then
						if IsValid(plyMenu) then
							plyMenu:Remove()
							plyMenu = nil
						end
						return
					end
					cooldown = CurTime() + 0.5

					local thing1 = istable(thing) and thing or {thing}

					if not functions[tab](ply, ent, i, unpack(thing1)) then return end
					
					TakeItem(tab, i, thing, ent)
					surface.PlaySound("arc9_eft_shared/generic_mag_pouch_in" .. math.random(7) .. ".ogg")
					grid.SoundKD = CurTime() + 0.2
					button:Remove()
					timer.Simple(0.5 * math.max(ply:Ping() / 50,1),function()
						--OpenInv(ent)
					end)
				end

				local name = nameThings(i, thing)
				button.col1 = 100
				button.Paint = function(self, w, h)
					button.col1 = Lerp(0.1, button.col1, button:IsHovered() and 255 or 100)
					if button:IsHovered() then
						button.SoundKD = button.SoundKD or 0
						if (grid.SoundKD or 0) < CurTime() and button.SoundKD < CurTime() then surface.PlaySound("arc9_eft_shared/generic_mag_pouch_out" .. math.random(7) .. ".ogg") end
						button.SoundKD = CurTime() + 0.1
					end

					surface.SetDrawColor(button.col1, 25, 25, 150)
					surface.DrawRect(0, 0, w, h)
					local Icon, HaveIcon, Overide, Quad = getIconThing(i, thing, tab)
					if Icon then
						button.Icon = button.Icon or (isstring(Icon) and Material(Icon)) or Icon -- Ну тут так, без выбора если что материал будет
					end

					if HaveIcon then
						if Overide then
							surface.SetTexture(button.Icon)
						else
							surface.SetMaterial(button.Icon)
						end

						surface.SetDrawColor(255, 255, 255)
						surface.DrawTexturedRect(Quad and w / 5 + 5 or 0 - 5, 5, Quad and (w / 2 + 2.5) or (w + 10), Quad and h / 1.3 or h - 10)
					end

					surface.SetDrawColor(colRed)
					surface.DrawOutlinedRect(0, 0, w, h, 1)
					local Text = (tab == "Ammo" and game.GetAmmoName(name)) or language.GetPhrase(name)
					local SubText = utf8.sub(Text, 14)
					Text = utf8.sub(Text, 1, 13) .. "\n" .. utf8.sub(Text, 14)
					draw.DrawText(Text, "DermaDefault", w / 2, (HaveIcon and h / ((#SubText > 0 and 1.65) or 1.3)) or h / 3, color_white, TEXT_ALIGN_CENTER)
				end

				grid:AddItem(button)
			end
		end
	end

	local vecZero = Vector(0, 0, 0)
	local angZero = Angle(0, 0, 0)
	local cameraPos, cameraAng
	local angRotate = Angle(0, 0, 0)
	local _cameraPos = Vector(20, 20, 10)
	local _cameraAng = Angle(10, 0, 0)
	local cam_Start3D = cam.Start3D
	local render_SuppressEngineLighting = render.SuppressEngineLighting
	local render_SetLightingOrigin = render.SetLightingOrigin
	local render_ResetModelLighting = render.ResetModelLighting
	local render_SetColorModulation = render.SetColorModulation
	local render_SetBlend = render.SetBlend
	local render_SetModelLighting = render.SetModelLighting
	local render_SetColorModulation = render.SetColorModulation
	local render_SetBlend = render.SetBlend
	local render_SuppressEngineLighting = render.SuppressEngineLighting
	local cam_IgnoreZ = cam.IgnoreZ
	local cam_End3D = cam.End3D
	local ClientsideModel = ClientsideModel
	local RealTime = RealTime
	WeaponByModel = {}
	WeaponByModel.weapon_physgun = {
		WorldModel = "models/weapons/w_physics.mdl",
		PrintName = "Physgun"
	}

	local function PrintWeaponInfo(self, x, y, alpha)
		if self.DrawWeaponInfoBox == false then return end
		if self.InfoMarkup == nil then
			local str
			local title_color = "<color=230,230,230,255>"
			local text_color = "<color=150,150,150,255>"
			str = "<font=HudSelectionText>"
			if self.Author ~= "" then str = str .. title_color .. "Автор:</color>\t" .. text_color .. self.Author .. "</color>\n" end
			--if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t"..text_color..self.Contact.."</color>\n\n" end
			--if ( self.Purpose != "" ) then str = str .. title_color .. "Purpose:</color>\n"..text_color..self.Purpose.."</color>\n\n" end
			if self.Instructions ~= "" then str = str .. title_color .. "Инструкция:</color>\t" .. text_color .. self.Instructions .. "</color>\n" end
			str = str .. "</font>"
			self.InfoMarkup = markup.Parse(str, 250)
		end

		--surface.DrawTexturedRect(x,y - 64 - 5,128,64)
		draw.RoundedBox(0, x, y, 260, self.InfoMarkup:GetHeight() + 2, Color(60, 60, 60, alpha))
		self.InfoMarkup:Draw(x + 5, y, nil, nil, alpha)
	end

	local vecHuy = Vector(0, 0, 0)
	DrawWeaponSelectionEX = function(self, x, y, wide, tall, alpha)
		local cameraPos = self.dwsPos or _cameraPos
		local mdl = self.WorldModel
		if mdl then
			local DrawModel = G_DrawModel
			local lply = LocalPlayer()
			if not IsValid(DrawModel) then
				G_DrawModel = ClientsideModel(mdl, RENDER_GROUP_OPAQUE_ENTITY)
				DrawModel = G_DrawModel
				DrawModel:SetNoDraw(true)
			else
				DrawModel:SetModel(mdl)
				cam_Start3D(cameraPos, (-cameraPos):Angle() - (self.cameraAng or _cameraAng), 70, x, y, wide, tall)
				--cam_IgnoreZ(true)
				render_SuppressEngineLighting(true)
				render_SetLightingOrigin(vecZero)
				render_ResetModelLighting(50 / 255, 50 / 255, 50 / 255)
				render_SetColorModulation(1, 1, 1)
				render_SetBlend(255)
				render_SetModelLighting(4, 1, 1, 1)
				angRotate:Set(angZero)
				angRotate[2] = 130 --RealTime() * 30 % 360
				angRotate:Add(self.dwsItemAng or angZero)
				local dir = Vector(0, 0, 0)
				dir:Set(self.dwsItemPos or vecZero)
				dir:Rotate(angRotate)
				local v1, v2 = DrawModel:GetModelBounds()
				vecHuy:Zero()
				local vec = vecHuy
				vec[1] = v1[1] * 1.3 + 15
				vec[2] = -v2[1] + 15
				vec[3] = v1[3] + 5
				dir:Add(vec)
				DrawModel:SetRenderAngles(angRotate)
				DrawModel:SetRenderOrigin(dir)
				DrawModel:DrawModel()
				render_SetColorModulation(1, 1, 1)
				render_SetBlend(1)
				render_SuppressEngineLighting(false)
				--cam_IgnoreZ(false)
				cam_End3D()
			end
		end

		if self.PrintWeaponInfo then PrintWeaponInfo(self, x + wide, y + tall, alpha) end
		return G_DrawModel
	end

	DrawWeaponSelection = function(self, x, y, w, h, alpha) DrawWeaponSelectionEX(self, x, y, w, h + 35, alpha) end
	OverridePaintIcon = function(self, x, y, w, h, obj) DrawWeaponSelectionEX(obj, x + 5, y + 5, w - 10, h - 30) end
end