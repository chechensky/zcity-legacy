-- Path scripthooked:lua\\homigrad\\optionsmenu\\cl_menu.lua"
-- Scripthooked by ???
--

local modes = {}
modes.slider = function(optiondata, panel)
    -- optiondata = {convar = "convarname",desc = "descreption", min = 123, max = 123}
    local DermaNumSlider = vgui.Create( "DNumSlider", panel )
    DermaNumSlider:Dock( TOP )
    DermaNumSlider:DockMargin(10,5,5,2.5)	
    DermaNumSlider:SetSize(50,45)	
    DermaNumSlider:SetText( optiondata.convar .. "\n" .. optiondata.desc )	
    DermaNumSlider:SetMin( optiondata.min )				 	
    DermaNumSlider:SetMax( optiondata.max )				
    DermaNumSlider:SetDecimals( 0 )				
    DermaNumSlider:SetConVar( optiondata.convar )	
    DermaNumSlider:SizeToContents()
end
modes.switcher = function(optiondata, panel)
    -- optiondata = {convar = "convarname",desc = "descreption"}
    local DermaCheckbox = panel:Add( "DCheckBoxLabel" )
	DermaCheckbox:Dock( TOP )
    DermaCheckbox:DockMargin(10,5,10,2.5)
	DermaCheckbox:SetText( optiondata.convar .. "\n" .. optiondata.desc )
	DermaCheckbox:SetConVar( optiondata.convar )
	DermaCheckbox:SetValue( GetConVar(optiondata.convar):GetBool() )
	DermaCheckbox:SizeToContents()		
end
modes.binder = function(optiondata, panel)
    -- optiondata = {convar = "convarname",desc = "descreption"}
end

local options = {}

-- optiondata = {desc = "descreption", and mode vars}
function hg.AddOptionPanel( convarname, mode, optiondata, category )
    optiondata = optiondata or {}
    category = category or "other"
    optiondata.convar = convarname

    options[category] = options[category] or {}

    options[category][convarname] = {mode, optiondata}
end

hg.AddOptionPanel( "hg_potatopc", "switcher", {desc = "Enables weaker effects. Use for weak PCs"}, "optimization" )
hg.AddOptionPanel( "hg_dynamic_mags", "switcher", {desc = "Enables the \"floating Ammo HUD\" feature"}, "other" )
hg.AddOptionPanel( "hg_anims_draw_distance", "slider", {desc = "Changes the rendering distance of animations\nCan help increase FPS | 0 - inf",min = 0,max = 4096}, "optimization" )
hg.AddOptionPanel( "hg_attachment_draw_distance", "slider", {desc = "Changes the rendering distance of attachments\nCan help increase FPS | 0 - inf",min = 0,max = 4096}, "optimization" )
hg.AddOptionPanel( "hg_old_notificate", "switcher", {desc = "Enables old damage notifications (in chat)",min = 0,max = 4096}, "other" )

local red = Color(75,25,25)
local redselected = Color(150,0,0)

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

local function CreateOptionsMenu()
    local sizeX,sizeY = ScrW() / 3.2 ,ScrH() / 2.2
	local posX,posY = ScrW() / 2 - sizeX / 2,ScrH() / 2 - sizeY / 2

    local MainFrame = vgui.Create("DFrame") -- The name of the panel we don't have to parent it.
    MainFrame:SetPos( posX, posY ) -- Set the position to 100x by 100y. 
    MainFrame:SetSize( sizeX, sizeY ) -- Set the size to 300x by 200y.
    MainFrame:SetTitle( "ZCity options" ) -- Set the title in the top left to "Derma Frame".
    MainFrame:MakePopup() -- Makes your mouse be able to move around.
    function MainFrame:Paint( w, h )
        draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 0, 0, 0, 140) )
        BlurBackground(MainFrame)
        surface.SetDrawColor( 255, 0, 0, 128)
        surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
    end

    local DScrollPanel = vgui.Create("DScrollPanel", MainFrame)
	DScrollPanel:SetPos(10, 50)
	DScrollPanel:SetSize(sizeX - 20, sizeY - 60)
	function DScrollPanel:Paint( w, h )
		BlurBackground(self)

		surface.SetDrawColor( 255, 0, 0, 128)
        surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
	end

    local DLabel = vgui.Create( "DLabel", DScrollPanel )
    DLabel:Dock(TOP)
    DLabel:DockMargin(20,5,5,2.5)
    DLabel:SetText( "Optimization" )

    for k,v in pairs(options["optimization"]) do
       
        modes[v[1]](v[2],DScrollPanel)
    end
    
    local DLabel = vgui.Create( "DLabel", DScrollPanel )
    DLabel:Dock(TOP)
    DLabel:DockMargin(20,15,5,2.5)
    DLabel:SetText( "Other" )

    for k,v in pairs(options["other"]) do
       
        modes[v[1]](v[2],DScrollPanel)
    end
end

concommand.Add("hg_options",function()
    CreateOptionsMenu()
end)