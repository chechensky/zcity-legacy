--organism_otherply = organism_otherply or {}
--net.Receive("organism_sendply", function() organism_otherply = net.ReadTable() end)
local white = Color(255, 255, 255)
local black = Color(0, 0, 0, 200)
local list = {
	{"blood", 5000}, 
	{"bleed", 100, true}, 
	{"internalBleed", 10, true}, 
	"internalBleedHeal", 
	{"arteria", 1, true}, 
	{"rarmartery", 1, true}, 
	{"larmartery", 1, true}, 
	{"rlegartery", 1, true}, 
	{"llegartery", 1, true}, 
	{"spineartery", 1, true}, 
	false, {"alive", true}, 
	{"Otrub", true, true}, 
	{"health", 100, false}, false,
	{"pain", 5, true},
	{"immobilization", true},
	{"painkiller", 3, true},
	{"anesthetics",0,true},
	{"naloxone",0,true},
	{"shock", 5, true}, 
	{"hurt", 1, true}, 
	false, 
	{"adrenaline", 2, true},
	false, 
	{"stamina", {"stamina", "range"}}, 
	{{"stamina.max", "stamina", "max"}, 
	{"stamina", "range"}}, 
	{{"stamina.regen", "stamina", "regen"}, 1}, 
	{{"stamina.sub", "stamina", "sub"}, 1, true}, 
	false, 
	{"brain", 1, true}, 
	{"skull", 1, true}, 
	{"disorientation",1,true},
	{"jaw", 1, true}, false, 
	{"spine1", 1, true}, 
	{"spine2", 1, true}, 
	{"spine3", 1, true}, 
	{"chest", 1, true}, 
	{"pelvis", 1, true}, 
	false, 
	{"heart", 1, true}, 
	{"heartstop", true, true}, 
	{"pulse", 70}, false, 
	{"stomach", 1, true}, 
	{"liver", 1, true}, 
	{"intestines", 1, true}, 
	false, 
	{"lungsL", 1, true}, 
	{"lungsR", 1, true}, 
	{"trachea", 1, true}, 
	{"pneumothorax", 1, true}, 
	false, 
	{"o2", {"o2", "range"}}, 
	{{"o2.regen", "o2", "regen"}, 2}, 
	false, 
	{"lleg", 1, true}, 
	{"rleg", 1, true}, 
	{"larm", 1, true}, 
	{"rarm", 1, true},
}
local function LerpColor(lerp, source, set)
	return Lerp(lerp, source.r, set.r), Lerp(lerp, source.g, set.g), Lerp(lerp, source.b, set.b)
end

local function set(set)
	return set.r, set.g, set.b
end
--твое говно вообще-то это глуаинтер дурак лучше бы вы его не использовали я бы

local Round = math.Round -- какашки шарика вот что пиздец я это не делал я тут не лазил мдаа кал я егго уберу ща релоад акрауед ща
local red, green = Color(255, 0, 0), Color(0, 255, 0)
local function getTextTable(org)
	local textList = {}
	for i, v in pairs(list) do
		local text1, text2 = "", ""
		local value
		local r, g, b
		if type(v) == "table" then
			if type(v[1]) == "table" then
				if not org[v[1][2]] then continue end
				text1 = v[1][1]
				value = org[v[1][2]][v[1][3]]
			else
				if not org[v[1]] then continue end
				text1 = v[1]
				value = org[text1]
				if type(value) == "table" then value = value[1] end
			end

			if type(v[2]) == "boolean" then
				if value then
					r, g, b = set(v[3] and red or green)
				else
					r, g, b = set(v[3] and green or red)
				end
			elseif value then
				local max = v[2]
				if type(v[2]) == "string" then max = org[v[2]] end
				if type(v[2]) == "table" then max = org[v[2][1]][v[2][2]] end
				if not max then continue end
				local k = value ~= 0 and max ~= 0 and value / max or 0 --гандоны рот ебал тот кто придумал нан блядь
				if v[3] then
					r, g, b = LerpColor(1 - k, red, green)
				else
					r, g, b = LerpColor(k, red, green)
				end
			end

			text2 = tostring(value)
		elseif v == false then

		else
			if not org[v] then continue end
			text1 = tostring(v)
			text2 = org[v]
		end

		textList[#textList + 1] = {text1, text2, r, g, b}
	end
	return textList
end

local littleblack = Color(75, 75, 75, 25)
local ebalgmod = Color(0, 0, 0, 75)
local weight = 200
local developer = GetConVar("developer")
hook.Add("HUDPaint", "homigrad-organism-debug", function()
	local organism = LocalPlayer().organism or {}

	if table.IsEmpty(organism) then return end
	if not developer:GetBool() then return end
	if not LocalPlayer():IsAdmin() then return end
	local textList = getTextTable(organism)
	draw.RoundedBox(0, 15, 100, weight, #textList * 12, black)
	for i, text in pairs(textList) do
		local y = 100 + (i - 1) * 12
		if i % 2 == 0 then draw.RoundedBox(0, 15, y, weight, 12, littleblack) end
		if text[3] then
			ebalgmod.r = text[3]
			ebalgmod.g = text[4]
			ebalgmod.b = text[5]
			ebalgmod.a = 75
			draw.RoundedBox(0, 15, y, weight, 12, ebalgmod)
		end

		draw.SimpleText(text[1], "DefaultFixedDropShadow", 15, y, white)
		draw.SimpleText(text[2], "DefaultFixedDropShadow", 15 + weight, y, white, TEXT_ALIGN_RIGHT)
	end

	--our
	local trent = LocalPlayer():GetEyeTrace().Entity
	local organism_otherply = trent.organism
	
	if not organism_otherply or table.IsEmpty(organism_otherply) then return end
	local textList = getTextTable(organism_otherply)
	local w = ScrW()
	local x = w - 15 - weight
	draw.RoundedBox(0, x, 15, weight, #textList * 12, black)
	for i, text in pairs(textList) do
		local y = 15 + (i - 1) * 12
		if i % 2 == 0 then draw.RoundedBox(0, x, y, weight, 12, littleblack) end
		if text[3] then
			ebalgmod.r = text[3]
			ebalgmod.g = text[4]
			ebalgmod.b = text[5]
			ebalgmod.a = 75
			draw.RoundedBox(0, x, y, weight, 12, ebalgmod)
		end

		draw.SimpleText(text[1], "DefaultFixedDropShadow", w - 15, y, white, TEXT_ALIGN_RIGHT)
		draw.SimpleText(text[2], "DefaultFixedDropShadow", w - 15 - weight, y, white)
	end
end)