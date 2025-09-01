-- Path scripthooked:lua\\homigrad\\appearance\\sh_appearance.lua"
-- Scripthooked by ???
local RandomNames = {
    [1] = { -- MaleNames
        "Mike",
        "Dave",
        "Michel",
        "Jhon",
        "Fred",
        "Michiel",
        "Mikeoxmal", --trolled
        "Steven",
        "Sergio",
        "Joel",
        "Samuel",
        "Larry",
        "Sean",
        "Thomas",
        "Jose",
        "Bobby",
        "Richard",
        "David"
    },
    [2] = { -- FemaleNames
        "Denise",
        "Joyce",
        "Jane",
        "Sara",
        "Emily",
        "Charlotte",
        "Cathy",
        "Ruth",
        "Julia",
        "Tanya",
        "Wanda",
        "Elizabeth",
        "Nicole",
        "Stacey",
        "Mary",
        "Anna",
        "Diana"
    }
}
local PlayerModels = {
    [1] = {},
    [2] = {}
}
for i = 1, 9 do
    table.insert(PlayerModels[1],"models/player/Group01/male_0"..i..".mdl")
end
for i = 1, 6 do
    table.insert(PlayerModels[2],"models/player/Group01/female_0"..i..".mdl")
end

local SubMaterials = {
    -- Male
    ["models/player/Group01/male_01.mdl"] = 3,
    ["models/player/Group01/male_02.mdl"] = 2,
    ["models/player/Group01/male_03.mdl"] = 4,
    ["models/player/Group01/male_04.mdl"] = 4,
    ["models/player/Group01/male_05.mdl"] = 4,
    ["models/player/Group01/male_06.mdl"] = 0,
    ["models/player/Group01/male_07.mdl"] = 4,
    ["models/player/Group01/male_08.mdl"] = 0,
    ["models/player/Group01/male_09.mdl"] = 2,
    -- FEMKI
    ["models/player/Group01/female_01.mdl"] = 2,
    ["models/player/Group01/female_02.mdl"] = 3,
    ["models/player/Group01/female_03.mdl"] = 3,
    ["models/player/Group01/female_04.mdl"] = 1,
    ["models/player/Group01/female_05.mdl"] = 2,
    ["models/player/Group01/female_06.mdl"] = 4
}

local СlothesStyles = {
    ["normal"] = { [1] = "models/humans/male/group01/normal", [2] = "models/humans/female/group01/normal" },
    ["formal"] = { [1] = "models/humans/male/group01/formal", [2] = "models/humans/female/group01/formal" },
    ["plaid"] = { [1] = "models/humans/male/group01/plaid", [2] = "models/humans/female/group01/plaid" },
    ["striped"] = { [1] = "models/humans/male/group01/striped", [2] = "models/humans/female/group01/striped" },
    ["young"] = { [1] = "models/humans/male/group01/young", [2] = "models/humans/female/group01/young" },
    ["cold"] = { [1] = "models/humans/male/group01/cold", [2] = "models/humans/female/group01/cold" },
    ["casual"] = { [1] = "models/humans/male/group01/casual", [2] = "models/humans/female/group01/casual" }
}

local AllowСlothesTexture = {
    "models/humans/male/group01/normal", "models/humans/female/group01/normal",
    "models/humans/male/group01/formal", "models/humans/female/group01/formal",
    "models/humans/male/group01/plaid", "models/humans/female/group01/plaid",
    "models/humans/male/group01/striped", "models/humans/female/group01/striped",
    "models/humans/male/group01/young", "models/humans/female/group01/young",
    "models/humans/male/group01/cold", "models/humans/female/group01/cold",
    "models/humans/male/group01/casual", "models/humans/female/group01/casual"
}

local СlothesStylesRandoms = {
    [1] = { [1] = "models/humans/male/group01/normal", [2] = "models/humans/female/group01/normal" },
    [2] = { [1] = "models/humans/male/group01/formal", [2] = "models/humans/female/group01/formal" },
    [3] = { [1] = "models/humans/male/group01/plaid", [2] = "models/humans/female/group01/plaid" },
    [4] = { [1] = "models/humans/male/group01/striped", [2] = "models/humans/female/group01/striped" },
    [5] = { [1] = "models/humans/male/group01/young", [2] = "models/humans/female/group01/young" },
    [6] = { [1] = "models/humans/male/group01/cold", [2] = "models/humans/female/group01/cold" },
    [7] = { [1] = "models/humans/male/group01/casual", [2] = "models/humans/female/group01/casual" }
}

local HMCDTransfer = {
        -- Male
        ["male01"] = {"models/player/Group01/male_01.mdl", 1},
        ["male02"] = {"models/player/Group01/male_02.mdl", 1},
        ["male03"] = {"models/player/Group01/male_03.mdl", 1},
        ["male04"] = {"models/player/Group01/male_04.mdl", 1},
        ["male05"] = {"models/player/Group01/male_05.mdl", 1},
        ["male06"] = {"models/player/Group01/male_06.mdl", 1},
        ["male07"] = {"models/player/Group01/male_07.mdl", 1},
        ["male08"] = {"models/player/Group01/male_08.mdl", 1},
        ["male09"] = {"models/player/Group01/male_09.mdl", 1},
        -- FEMKI
        ["female01"] = {"models/player/Group01/female_01.mdl", 2},
        ["female02"] = {"models/player/Group01/female_02.mdl", 2},
        ["female03"] = {"models/player/Group01/female_03.mdl", 2},
        ["female04"] = {"models/player/Group01/female_04.mdl", 2},
        ["female05"] = {"models/player/Group01/female_05.mdl", 2},
        ["female06"] = {"models/player/Group01/female_06.mdl", 2}
}

local DefaultApperanceTable = {
    Gender = 0, --  (1) = male or (2) = female  / FUCK YOU IF YOU WANNA BE NI...
    Name = "", -- Player CustomName...
    Model = "", -- GMODModel?
    Color = Color(255,255,255),
    СlothesStyle = "",  -- "normal" = Standard GMOD
    Attachmets = "" -- Таблица внешней одежды по типу шапки и так далее... -- ПОТОМ!
}

if SERVER then
    util.AddNetworkString("GetAppearance")
end

function SetAppearance(ply, appearance)
    if not CLIENT then return end
    if not file.Exists("zcity","DATE") then file.CreateDir("zcity/") end

    file.Write("zcity/appearance.json",util.TableToJSON(appearance))
    net.Start("GetAppearance")
        net.WriteTable( GetAppearance() or GetRandomAppearance() )
    net.SendToServer()
end

function GetRandomAppearance()
    local Appearance = DefaultApperanceTable
    Appearance["Gender"] = math.random(1,2)
    Appearance["Name"] = RandomNames[Appearance["Gender"]][math.random(#RandomNames[Appearance["Gender"]])]
    Appearance["Model"] = PlayerModels[Appearance["Gender"]][math.random(#PlayerModels[Appearance["Gender"]])]
    Appearance["Color"] = ColorRand()
    Appearance["СlothesStyle"] = СlothesStylesRandoms[math.random(#СlothesStylesRandoms)][Appearance["Gender"]]
    Appearance["Attachmets"] = table.GetKeys(hg.Accessories)[math.random(#table.GetKeys(hg.Accessories))] -- потом
    return Appearance
end
if CLIENT then
    net.Receive("GetAppearance",function() -- CLIENT 
        net.Start("GetAppearance")
            net.WriteTable( GetAppearance() )
        net.SendToServer()
    end)
end
if SERVER then
    net.Receive("GetAppearance",function(len, ply) -- SERVER
        ply.Appearance = net.ReadTable()
    end)
end

function GetAppearance(ply) -- Returns appearance table
    if SERVER and ply:IsBot() then ply.Appearance = GetRandomAppearance() return end
    if CLIENT then
        if file.Exists( "zcity/appearance.json", "DATA" ) then return util.JSONToTable( file.Read("zcity/appearance.json","DATA") ) end
            return GetRandomAppearance()
    elseif SERVER then
        net.Start("GetAppearance")
        net.Send(ply)
        -- Read ply.Appearance 
    end
end

if SERVER then
    -- Player(2):SetNetVar("Accessories", "nerd glasses")
    function ApplyAppearance(ply)
        GetAppearance(ply)

        timer.Simple(0,function()
            local Appearance = ply.Appearance or GetRandomAppearance()
            if not table.HasValue(PlayerModels[Appearance.Gender],Appearance.Model) or not table.HasValue(AllowСlothesTexture,Appearance.СlothesStyle) then ply:ChatPrint("zcity/appearance.json have invalid variables.. Seting random Appearance") Appearance = GetRandomAppearance() end
            --PrintTable(Appearance)
            ply:SetModel(Appearance.Model)
            ply:SetPlayerColor(Vector(Appearance.Color.r / 255,Appearance.Color.g / 255,Appearance.Color.b / 255))
            --print(SubMaterials[Appearance.Model])
            ply:SetSubMaterial()
            ply:SetSubMaterial(SubMaterials[Appearance.Model],Appearance.СlothesStyle)
            ply:SetNWString("PlayerName",Appearance.Name)
            ply:SetNetVar("Accessories", Appearance.Attachmets)
            ply.CurAppearance = Appearance
        end)
    end

    function ApplyAppearanceRagdoll(ent, ply)
        if (IsValid(ent) or IsValid(ply)) then
            --GetAppearance(ply)
            local Appearance = ply.CurAppearance or DefaultApperanceTable
            --PrintTable(ply.Appearance)
            --PrintTable(Appearance)
            ent:SetSubMaterial()
            ent:SetSubMaterial(SubMaterials[Appearance.Model],Appearance.СlothesStyle)
            ent:SetNWString("PlayerName",Appearance.Name)
            --ent:SetNetVar("Accessories", Appearance.Attachmets)
        end
    end

    hook.Add("PlayerDeath","setaccessories",function(ply)
        if IsValid(ply.FakeRagdoll) then
            local Appearance = ply.CurAppearance or DefaultApperanceTable
            ply.FakeRagdoll:SetNetVar("Accessories", ply:GetNetVar("Accessories"))
            ply:SetNetVar("Accessories","none")
         end
    end)

        hook.Add("PlayerInitialSpawn","SetAppearance",function(ply)
            ApplyAppearance(ply)
        end)
        hook.Add("PlayerSpawn","SetAppearance",function(ply)
            if OverrideSpawn then return end
            ApplyAppearance(ply)
        end)
end

local FemPlayerModels = {
}
for i = 1, 6 do
	table.insert(FemPlayerModels,"models/player/group01/female_0" .. i .. ".mdl")
end

for i = 1, 6 do
    table.insert(FemPlayerModels,"models/monolithservers/mpd/female_0" .. i .. "_2.mdl")
end

for i = 1, 6 do
    table.insert(FemPlayerModels,"models/monolithservers/mpd/female_0" .. i .. ".mdl")
end

function ThatPlyIsFemale(ply)
    return table.HasValue(FemPlayerModels,ply:GetModel())
end

-- Appearance MENU
if CLIENT then
    local gradient_d = Material("vgui/gradient-d")
    local blurMat = Material("pp/blurscreen")
    local Dynamic = 0
    local red = Color(150,0,0)

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

    local function AppearanceMenu()
        Dynamic = 0
        local AppearanceTable = GetAppearance()

        local BaseFrame = vgui.Create( "DFrame" )
        BaseFrame:SetSize( 400, 500 )
        BaseFrame:Center()
        BaseFrame:SetTitle( "Appearance Menu" ) 
        BaseFrame:SetVisible( true ) 
        BaseFrame:SetDraggable( false ) 
        BaseFrame:ShowCloseButton( true ) 
        BaseFrame:MakePopup()
        function BaseFrame:Paint( w, h )
            draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 0, 0, 0, 140) )
            surface.SetDrawColor(AppearanceTable.Color.r, AppearanceTable.Color.g, AppearanceTable.Color.b, 100)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect( 0, 0, w, h )
            BlurBackground(BaseFrame)
            surface.SetDrawColor( 255, 0, 0, 128)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
        end

        local PlayerModelPanel = vgui.Create( "DPanel", BaseFrame )
        PlayerModelPanel:Dock( LEFT )
        PlayerModelPanel:SetSize(190,450)
        PlayerModelPanel:DockMargin(2.5,0,0,5)
        function PlayerModelPanel:Paint( w, h )
            --surface.SetDrawColor(AppearanceTable.Color.r, AppearanceTable.Color.g, AppearanceTable.Color.b, 40)
            --surface.SetMaterial(gradient_d)
            --surface.DrawTexturedRect( 0, 0, w, h )
        end

        local PlayerModel = vgui.Create( "DModelPanel", PlayerModelPanel )
        PlayerModel:SetSize(200,480)
        PlayerModel:SetModel( util.IsValidModel( AppearanceTable.Model ) and AppearanceTable.Model or "models/player/alyx.mdl" )
        PlayerModel:SetFOV( 35 )
        function PlayerModel:LayoutEntity( Entity ) 
            Entity.Angles = Entity.Angles or Angle(0,0,0)
            Entity.Angles = Entity.Angles + Angle(0,0.5,0)
            Entity:SetNWVector("PlayerColor",Vector(AppearanceTable.Color.r / 255, AppearanceTable.Color.g / 255, AppearanceTable.Color.b / 255))
            Entity:SetAngles(Entity.Angles)
            Entity:SetSubMaterial()
            Entity:SetSubMaterial(SubMaterials[AppearanceTable.Model],AppearanceTable.СlothesStyle)
            Entity.accessories = AppearanceTable.Attachmets
        end

        function PlayerModel:PostDrawModel(Entity)
            DrawAccesories(Entity, Entity, AppearanceTable.Attachmets, hg.Accessories[AppearanceTable.Attachmets],false)
        end

        function PlayerModel.Entity:GetPlayerColor() return end

        local BasePanel = vgui.Create( "DPanel", BaseFrame )
        BasePanel:Dock( RIGHT )
        BasePanel:SetSize(190,450)
        BasePanel:DockMargin(0,0,2.5,5)
        function BasePanel:Paint( w, h )
        end

        local Label = vgui.Create( "DLabel", BasePanel )
        Label:Dock( TOP )
        Label:SetSize(200,15)
        Label:DockMargin( 10, 5, 2, 0 )
        Label:SetText("Name:")
        Label:SetTextColor(color_white)

        local TextEntry = vgui.Create( "DTextEntry", BasePanel ) -- create the form as a child of frame
        TextEntry:Dock( TOP )
        TextEntry:SetSize(200,30)
        TextEntry:DockMargin( 2, 5, 2, 0 )
        TextEntry:SetValue(AppearanceTable.Name)
        TextEntry.OnChange = function( self )
            AppearanceTable.Name = self:GetValue()	-- print the textentry text as a chat message
        end
        function TextEntry:Paint( w, h )
            self.a = Lerp(0.1,self.a or 100,self:IsHovered() and 255 or 150)
            draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,self.a))
            surface.SetDrawColor( color_black)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
            draw.SimpleText(self:GetValue(),"DermaDefault", 7.5, h / 2, color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end

        local Label = vgui.Create( "DLabel", BasePanel )
        Label:Dock( TOP )
        Label:SetSize(200,15)
        Label:DockMargin( 10, 5, 2, 0 )
        Label:SetText("Sex:")
        Label:SetTextColor(color_white)

        local GenderSelector = vgui.Create( "DComboBox", BasePanel )
        GenderSelector:Dock( TOP )
        GenderSelector:DockMargin( 2,5,2,0 )
        GenderSelector:SetSize( 200, 30 )
        GenderSelector:SetValue( ( ( AppearanceTable.Gender == 1 and "Male" ) or ( AppearanceTable.Gender == 2 and "Female" ) ) or "Male")
        GenderSelector:AddChoice( "Male" )
        GenderSelector:AddChoice( "Female" )
        GenderSelector:SetTextColor(color_white)
        function GenderSelector:Paint( w, h )
            self.a = Lerp(0.1,self.a or 100,self:IsHovered() and 255 or 150)
            draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,self.a))
            surface.SetDrawColor( color_black)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
        end

        local Label = vgui.Create( "DLabel", BasePanel )
        Label:Dock( TOP )
        Label:SetSize(200,15)
        Label:DockMargin( 10, 5, 2, 0 )
        Label:SetText("Model:")
        Label:SetTextColor(color_white)

        local ModelSelector = vgui.Create( "DComboBox", BasePanel )
        ModelSelector:Dock( TOP )
        ModelSelector:DockMargin( 2,5,2,0 )
        ModelSelector:SetSize( 200, 30 )
        ModelSelector:SetTextColor(color_white)
        ModelSelector:SetValue( AppearanceTable.Model )
        for k, v in ipairs(PlayerModels[AppearanceTable.Gender]) do
            ModelSelector:AddChoice( v )
        end
        function ModelSelector:Paint( w, h )
            self.a = Lerp(0.1,self.a or 100,self:IsHovered() and 255 or 150)
            draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,self.a))
            surface.SetDrawColor( color_black)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
        end

        ModelSelector.OnSelect = function( self, index, value )
            PlayerModel:SetModel(value)
            AppearanceTable.Model = value
        end
        local Style = "normal"
        GenderSelector.OnSelect = function( self, index, value )
            PlayerModel:SetModel(index == 1 and "models/player/Group01/male_01.mdl" or index == 2 and "models/player/Group01/female_01.mdl")
            ModelSelector:Clear()
            ModelSelector:SetValue( index == 1 and "models/player/Group01/male_01.mdl" or index == 2 and "models/player/Group01/female_01.mdl" )
            AppearanceTable.Gender = index
            AppearanceTable.Model = index == 1 and "models/player/Group01/male_01.mdl" or index == 2 and "models/player/Group01/female_01.mdl"
            --print(Style)
            AppearanceTable.СlothesStyle = СlothesStyles[Style or "normal"][index]
            for k, v in ipairs(PlayerModels[index]) do
                ModelSelector:AddChoice( v )
            end
        end

        local Mixer = vgui.Create("DColorMixer", BasePanel)
        Mixer:Dock(TOP)	
        Mixer:SetPalette(false)	
        Mixer:SetSize(0,100)
        Mixer:DockMargin( 5,5,5,0 )
        Mixer:SetAlphaBar(false)
        Mixer:SetWangs(false)
        Mixer:SetColor(AppearanceTable.Color)
        function Mixer:ValueChanged(value)
            AppearanceTable.Color = value
        end

        local Label = vgui.Create( "DLabel", BasePanel )
        Label:Dock( TOP )
        Label:SetSize(200,15)
        Label:DockMargin( 10, 2.5, 2, 0 )
        Label:SetText("Clothes:")
        Label:SetTextColor(color_white)

        local ColthesStyle = vgui.Create( "DComboBox", BasePanel )
        ColthesStyle:Dock( TOP )
        ColthesStyle:DockMargin( 2,5,2,0 )
        ColthesStyle:SetSize( 200, 30 )
        ColthesStyle:SetTextColor(color_white)
        for k, v in pairs(СlothesStyles) do
            ColthesStyle:AddChoice( k )
        end
        ColthesStyle:SetValue( "normal" )
        ColthesStyle.OnSelect = function( self, index, value )
            Style = value
            AppearanceTable.СlothesStyle = СlothesStyles[value][AppearanceTable.Gender]
        end
        function ColthesStyle:Paint( w, h )
            self.a = Lerp(0.1,self.a or 100,self:IsHovered() and 255 or 150)
            draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,self.a))
            surface.SetDrawColor( color_black)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
        end

        local Attachments = vgui.Create( "DComboBox", BasePanel )
        Attachments:Dock( TOP )
        Attachments:DockMargin( 2,5,2,0 )
        Attachments:SetSize( 200, 30 )
        Attachments:SetTextColor(color_white)
        for k, v in pairs(hg.Accessories) do
            if v.disallowinapperance then continue end
            Attachments:AddChoice( k )
        end
        Attachments:SetValue( (not istable(AppearanceTable.Attachmets) and AppearanceTable.Attachmets) and AppearanceTable.Attachmets or "none" )
        Attachments.OnSelect = function( self, index, value )
            AppearanceTable.Attachmets = value
        end
        function Attachments:Paint( w, h )
            self.a = Lerp(0.1,self.a or 100,self:IsHovered() and 255 or 150)
            draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,self.a))
            surface.SetDrawColor( color_black)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
        end

        local ApplyButton = vgui.Create( "DButton", BasePanel )
        ApplyButton:Dock( BOTTOM )
        ApplyButton:DockMargin( 2,5,2,5 )
        ApplyButton:SetSize( 250, 30 )
        ApplyButton:SetTextColor(color_white)
        ApplyButton:SetText("Set Appearance")
        ApplyButton.DoClick = function()
            SetAppearance(LocalPlayer(), AppearanceTable)
            BaseFrame:Close()
            LocalPlayer():ChatPrint("Appearance successfully changed!")
        end
        function ApplyButton:Paint( w, h )
            self.a = Lerp(0.1,self.a or 100,self:IsHovered() and 255 or 150)
            draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,self.a))
            surface.SetDrawColor( color_black)
            surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
        end

        if file.Exists("homicide_identity.txt","DATA") then
            local RawData = string.Split(file.Read("homicide_identity.txt","DATA"),"\n")
            local ApplyHMCDButton = vgui.Create( "DButton", BasePanel )
            ApplyHMCDButton:Dock( BOTTOM )
            ApplyHMCDButton:DockMargin( 2,5,2,0 )
            ApplyHMCDButton:SetSize( 250, 30 )
            ApplyHMCDButton:SetTextColor(color_white)
            ApplyHMCDButton:SetText("Try to transfer" .. ( ( #RawData == 7 and " Cat's HMCD " ) or " HMCD " ) .. "Appearance")
            function ApplyHMCDButton:Paint( w, h )
                self.a = Lerp(0.1,self.a or 100,self:IsHovered() and 255 or 150)
                draw.RoundedBox(0, 0, 0, w, h, Color(red.r,red.g,red.b,self.a))
                surface.SetDrawColor( color_black)
                surface.DrawOutlinedRect( 0, 0, w, h, 2.5 )
            end
            ApplyHMCDButton.DoClick = function()
                if #RawData == 10 then
                    local DatName = string.Replace(RawData[1],"_"," ")
                    --LocalPlayer():ConCommand("homicide_identity "..DatName.." "..RawData[2].." "..RawData[3].." "..RawData[4].." "..RawData[5].." "..RawData[6].." "..RawData[7].." "..RawData[8].." "..RawData[9].." "..DatAccessory)
                    AppearanceTable = DefaultApperanceTable
                    AppearanceTable.Name = DatName
                    AppearanceTable.Gender = HMCDTransfer[RawData[2]][2]
                    AppearanceTable.Model = HMCDTransfer[RawData[2]][1]
                    AppearanceTable.Color = Color( RawData[3] * 255, RawData[4] * 255, RawData[5] * 255 )
                    AppearanceTable.СlothesStyle = СlothesStyles[RawData[9]][AppearanceTable.Gender]
                    SetAppearance(LocalPlayer(), AppearanceTable)
                    BaseFrame:Close()
                    LocalPlayer():ChatPrint("Transfer HMCD Appearance successfully!")
                elseif #RawData == 7 then
                    local DatName = string.Replace(RawData[1],"_"," ")
                    --LocalPlayer():ConCommand("homicide_identity "..DatName.." "..RawData[2].." "..RawData[3].." "..RawData[4].." "..RawData[5].." "..RawData[6].." "..RawData[7].." "..RawData[8].." "..RawData[9].." "..DatAccessory)
                    AppearanceTable = DefaultApperanceTable
                    AppearanceTable.Name = DatName
                    AppearanceTable.Gender = HMCDTransfer[RawData[2]][2]
                    AppearanceTable.Model = HMCDTransfer[RawData[2]][1]
                    AppearanceTable.Color = Color( RawData[3] * 255, RawData[4] * 255, RawData[5] * 255 )
                    AppearanceTable.СlothesStyle = СlothesStyles[RawData[6]][AppearanceTable.Gender]
                    AppearanceTable.Attachmets = 
                    SetAppearance(LocalPlayer(), AppearanceTable)
                    BaseFrame:Close()
                    LocalPlayer():ChatPrint("Transfer Cat's HMCD Appearance successfully!")
                else
                    BaseFrame:Close()
                    LocalPlayer():ChatPrint("Transfer Appearance failed :(")
                end
            end
        end
    end

    concommand.Add( "hg_appearance_menu", function( ply, cmd, args )
        AppearanceMenu()
    end )
end

