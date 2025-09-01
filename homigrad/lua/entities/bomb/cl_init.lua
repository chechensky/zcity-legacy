-- Path scripthooked:lua\\entities\\bomb\\cl_init.lua"
-- Scripthooked by ???

include("shared.lua")
local model = ClientsideModel("models/jmod/explosives/bombs/c4/w_c4_planted.mdl")
model:SetNoDraw(true)

local lply = LocalPlayer()
local offsetAng = Angle(-90,0,0)
local offsetVec = Vector(0,0,0)
local looklerp = 1
local vecZero,angZero = Vector(0,0,0),Angle(0,0,0)
local addDir = Angle(0,0,0)
local addDirAdd = Angle(0,0,0)
function ENT:Draw()
	local view = render.GetViewSetup()

	addDir = Lerp(0.9,angZero,addDir)
	addDirAdd = Lerp(0.2,addDirAdd,addDir)

	lply = LocalPlayer()
	local pos = view.origin + view.angles:Forward() * 25
	local ang = view.angles

	local dir = util.AimVector(view.angles,view.fov,gui.MouseX(),gui.MouseY(),ScrW(),ScrH())
	dir = dir:Angle()
	local _,dir = WorldToLocal(vecZero,dir,vecZero,view.angles)
	dir[2] = -dir[2]
	dir[1] = -dir[1]
	dir = dir / 3
	dir = dir + addDirAdd
	ang:Add(dir)

	local pos,ang = LocalToWorld(offsetVec,offsetAng,pos,ang)

	looklerp = Lerp(0.1,looklerp,self.islooked and 0 or 1)
	desiredpos = Lerp(looklerp,pos,self:GetPos())
	desiredang = Lerp(looklerp,ang,self:GetAngles())

	model:SetPos(desiredpos)
	model:SetAngles(desiredang)
	model:SetModelScale(0.5)
	model:DrawModel()
end

function ENT:Think()
end

function ENT:Initialize()
end

function ENT:OnRemove()
end

surface.CreateFont("ZB_InterfaceMedium", {
    font = "Bahnschrift",
    size = ScreenScale(10),
    extended = true,
    weight = 400,
    antialias = true
})

surface.CreateFont("ZB_InterfaceMediumLarge", {
    font = "Bahnschrift",
    size = 35,
    extended = true,
    weight = 400,
    antialias = true
})

surface.CreateFont("ZB_InterfaceLarge", {
    font = "Bahnschrift",
    size = ScreenScale(20),
    extended = true,
    weight = 400,
    antialias = true
})

surface.CreateFont("ZB_InterfaceHumongous", {
    font = "Bahnschrift",
    size = 200,
    extended = true,
    weight = 400,
    antialias = true
})

local CreateMenu

local bomb
net.Receive("bomb_look",function()
	if IsValid(bomb) then
		bomb.islooked = false
	end
	bomb = net.ReadEntity()
	bomb = IsValid(bomb) and bomb
	
	if bomb then
		bomb.islooked = true
	end
	
	CreateMenu(bomb)
end)

local offsetVec1,offsetAng1 = Vector(4,5,6.7),Angle(0,-90,0)
hook.Add("PostDrawOpaqueRenderables","Draw3D2DFrameBomb",function()
	if IsValid(model) and IsValid(bombMenu) then
		local pos,ang = LocalToWorld(offsetVec1, offsetAng1, model:GetPos(), model:GetAngles())
		vgui.Start3D2D(pos, ang, 0.012 * 0.5)
			bombMenu:Paint3D2D()
		vgui.End3D2D()
	end
end)

if IsValid(bombMenu) then
	bombMenu.bomb.islooked = nil
	bombMenu:Remove()
	bombMenu = nil
end

local colGray = Color(122,122,122,255)
local colBlue = Color(130,10,10)
local colBlueUp = Color(160,30,30)
local col = Color(255,255,255,255)

local colSpect1 = Color(75,75,75,255)
local colSpect2 = Color(85,85,85,255)

local colorBG = Color(55,55,55,255)
local colorBGBlacky = Color(40,40,40,255)

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

CreateMenu = function(bomb)
	if IsValid(bombMenu) then
		bombMenu:Remove()
		bombMenu = nil
	end

	if not bomb then
		if IsValid(bombMenu) then
			bombMenu.bomb.islooked = nil
			bombMenu:Remove()
			bombMenu = nil
		end
		return
	end

	Dynamic = 0
	bombMenu = vgui.Create("DPanel")
	bombMenu.bomb = bomb
	local sizeX,sizeY = ScrW() ,ScrH()
	local posX,posY = ScrW() / 2 - sizeX / 2,ScrH() / 2 - sizeY / 2
	
	bombMenu:SetPos(posX,posY)
	bombMenu:SetSize(sizeX,sizeY)
	bombMenu:SetBackgroundColor(colGray)
	bombMenu:MakePopup()
	bombMenu:ParentToHUD()
	--bombMenu:SetKeyboardInputEnabled(false)
	
	local x,y = sizeX / 2 + 60, 100, sizeX / 2 - 50
	local w1,h1 = sizeX / 2 - 175, sizeY / 2 - 125

	local txt = ""

	bombMenu.keypress = false
	bombMenu.Paint = function(self,w,h)
		--BlurBackground(self)
		surface.SetDrawColor(0, 0, 0, 122)
		surface.DrawRect(x,y,w1,h1)
		surface.SetDrawColor(122, 122, 122, 255)
		--surface.DrawOutlinedRect(x,y,w1,h1)
		surface.SetDrawColor(math.Round(CurTime() * 2)%2==0 and 255 or 0, 0, 0, 255)
		surface.DrawRect(x + 50,y + 50,20,20)

		surface.SetFont( "ZB_InterfaceHumongous" )
		surface.SetTextColor(col.r,col.g,col.b,col.a)
		local lenghtX, lenghtY = surface.GetTextSize(txt)
		
		local txtcopy = txt
		
		surface.SetTextPos(x + 30,y + 100)
		surface.DrawText(txt)
	end

	bombMenu.Think = function()
		local view = render.GetViewSetup()
		local dir = util.AimVector(view.angles,view.fov,gui.MouseX(),gui.MouseY(),ScrW(),ScrH())
		dir = dir:Angle()
		local _,dir = WorldToLocal(vecZero,dir,vecZero,view.angles)
		dir[2] = -dir[2]
		dir[1] = -dir[1]
		dir = dir / 5
		
		if input.IsMouseDown(MOUSE_LEFT) then
			if not bombMenu.keypress then
				addDir = -(-dir)
			end
			bombMenu.keypress = true
		else
			bombMenu.keypress = false
		end
	end

	--print(input.IsKeyDown(KEY_D))
	--[[local closebutton = vgui.Create("DButton",bombMenu)
	closebutton:SetPos(5,5)
	closebutton:SetSize(ScrW() / 8,ScrH() / 16)
	closebutton:SetText("")

	function closebutton:TestHover( x, y )
		return false
	end

	closebutton.DoClick = function()
		if IsValid(bombMenu) then
			bombMenu:Remove()
			bombMenu = nil
		end
		bomb.islooked = nil
	end

	closebutton.Paint = function(self,w,h)
		surface.SetDrawColor( 0, 0, 0, 122)
        surface.DrawRect( 0, 0, w, h, 2.5 )
		surface.SetDrawColor( 122, 122, 122, 255)
        surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
		surface.SetFont( "ZB_InterfaceLarge" )
		surface.SetTextColor(col.r,col.g,col.b,col.a)
		local lengthX, lengthY = surface.GetTextSize("Close")
		surface.SetTextPos( w / 2 - lengthX / 2, h / 2 - lengthY / 2)
		surface.DrawText("Close")
	end--]]

	local grid = vgui.Create("DGrid",bombMenu)
	
	grid:SetPos(x + 14,y + 530)
	grid:SetCols(5)
	grid:SetColWide(156)
	grid:SetRowHeight(184)
	
	for i = 1, 10 do
		local but = vgui.Create("DButton")
		if i == 10 then i = 0 end
		but:SetText(i)
		but:SetSize(138,150)
		but.DoClick = function()
			--if surface.GetTextSize(txt) >= 56 then return end
			if #txt >= 8 then return end
			txt = txt..i
		end
		function but:TestHover( x, y )
			return false
		end
		grid:AddItem(but)
	end

	local clearbut = vgui.Create("DButton",bombMenu)
	clearbut:SetPos(x + 100,y + 300)
	clearbut:SetSize(ScrW() / 8,ScrH() / 16)
	clearbut:SetText("")

	function clearbut:TestHover( x, y )
		return false
	end

	clearbut.DoClick = function()
		txt = ""
	end

	clearbut.Paint = function(self,w,h)
		surface.SetDrawColor( 0, 0, 0, 122)
        surface.DrawRect( 0, 0, w, h, 2.5 )
		surface.SetDrawColor( 122, 122, 122, 255)
        surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
		surface.SetFont( "ZB_InterfaceLarge" )
		surface.SetTextColor(col.r,col.g,col.b,col.a)
		local lengthX, lengthY = surface.GetTextSize("Clear")
		surface.SetTextPos( w / 2 - lengthX / 2, h / 2 - lengthY / 2)
		surface.DrawText("Clear")
	end

	local enterbut = vgui.Create("DButton",bombMenu)
	enterbut:SetPos(x + 100 + ScrW() / 8 + 50,y + 300)
	enterbut:SetSize(ScrW() / 8,ScrH() / 16)
	enterbut:SetText("")

	function enterbut:TestHover( x, y )
		return false
	end

	enterbut.DoClick = function()
		if IsValid(bombMenu) then
			bombMenu.bomb.islooked = nil
			bombMenu:Remove()
			bombMenu = nil
		end
		net.Start("bomb_enter")
		net.WriteString(txt)
		net.SendToServer()
	end

	enterbut.Paint = function(self,w,h)
		surface.SetDrawColor( 0, 0, 0, 122)
        surface.DrawRect( 0, 0, w, h, 2.5 )
		surface.SetDrawColor( 122, 122, 122, 255)
        surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
		surface.SetFont( "ZB_InterfaceLarge" )
		surface.SetTextColor(col.r,col.g,col.b,col.a)
		local lengthX, lengthY = surface.GetTextSize("Enter")
		surface.SetTextPos( w / 2 - lengthX / 2, h / 2 - lengthY / 2)
		surface.DrawText("Enter")
	end

	return bombMenu
end

