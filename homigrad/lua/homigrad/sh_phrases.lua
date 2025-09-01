-- Path scripthooked:lua\\homigrad\\sh_phrases.lua"
-- Scripthooked by ???
local phrases = {
	[1] = {
		[1] = {"vo/npc/male01/question", ".wav", 3, 31},
		[2] = {"vo/npc/male01/answer", ".wav", 1, 40},
		[3] = {"vo/npc/male01/sorry", ".wav", 1, 3},
		[4] = {"vo/npc/male01/squad_affirm", ".wav", 1, 9},
		[5] = {"vo/npc/male01/startle", ".wav", 1, 2},
		[6] = {"vo/npc/male01/vanswer", ".wav", 1, 14},
		[7] = {"vo/npc/male01/wetrustedyou", ".wav", 1, 2},
		[8] = {"vo/npc/male01/whoops", ".wav", 1, 1},
		[9] = {"vo/npc/male01/yeah", ".wav", 2, 2},
		[10] = {"vo/npc/male01/gordead_ans", ".wav", 1, 20},
		[11] = {"vo/npc/male01/heretohelp", ".wav", 1, 2},
		[12] = {"vo/npc/male01/holddownspot", ".wav", 1, 2}
	},
	[2] = {
		[1] = {"vo/npc/female01/question", ".wav", 3, 30},
		[2] = {"vo/npc/female01/answer", ".wav", 1, 40},
		[3] = {"vo/npc/female01/sorry", ".wav", 1, 3},
		[4] = {"vo/npc/female01/squad_affirm", ".wav", 1, 9},
		[5] = {"vo/npc/female01/startle", ".wav", 1, 2},
		[6] = {"vo/npc/female01/vanswer", ".wav", 1, 14},
		[7] = {"vo/npc/female01/wetrustedyou", ".wav", 1, 2},
		[8] = {"vo/npc/female01/whoops", ".wav", 1, 1},
		[9] = {"vo/npc/female01/yeah", ".wav", 2, 2},
		[10] = {"vo/npc/female01/gordead_ans", ".wav", 1, 20},
		[11] = {"vo/npc/female01/heretohelp", ".wav", 1, 2},
		[12] = {"vo/npc/female01/holddownspot", ".wav", 1, 2}
	}
}

local FemPlayerModels = {}
for i = 1, 6 do
	table.insert(FemPlayerModels,"models/player/group01/female_0" .. i .. ".mdl")
end

for i = 1, 6 do
    table.insert(FemPlayerModels,"models/monolithservers/mpd/female_0" .. i .. "_2.mdl")
end

for i = 1, 6 do
    table.insert(FemPlayerModels,"models/monolithservers/mpd/female_0" .. i .. ".mdl")
end

if CLIENT then
	local function randomPhrase()
		RunConsoleCommand("hg_phrase")
	end

	concommand.Add("hg_phrase", function(ply, cmd, args)
		local gender = ((table.HasValue(FemPlayerModels, LocalPlayer():GetModel()) and 2) or 1)
		local i = (#args > 0 and math.Clamp(tonumber(args[1]),1,#phrases[gender])) or math.random(#phrases[gender])
		if (#args < 2 and not #args == 0) then return end
 		local num = (#args > 1 and math.Clamp(tonumber(args[2]),phrases[gender][tonumber(i)][3],phrases[gender][tonumber(i)][4])) or math.random(phrases[gender][tonumber(i)][3], phrases[gender][tonumber(i)][4])
		net.Start("hg_phrase")
		net.WriteInt(i, 8)
		net.WriteInt(num, 8)
		net.SendToServer()
	end)

	hook.Add("radialOptions", "hg-phrase", function()
		local organism = LocalPlayer().organism or {}

		if not false then
			hg.radialOptions[#hg.radialOptions + 1] = {randomPhrase, "Random phrase"}
		end
	end)
else
	util.AddNetworkString("hg_phrase")
	net.Receive("hg_phrase", function(len, ply)
		if (ply.phrCld or 0) > CurTime() then return end
		if not IsValid(ply) or not ply:Alive() then return end
		if false then return end
		local gender = ((table.HasValue(FemPlayerModels, ply:GetModel()) and 2) or 1)
		local i = net.ReadInt(8)
		local num = net.ReadInt(8)
		local phr = phrases[gender][i]
		local random = num
		local huy = random < 10 and "0" or ""
		local phrase = phr[1] .. huy .. random .. phr[2]
		local ent = hg.GetCurrentCharacter(ply)
		ent:EmitSound(phrase)
		ply.phrCld = CurTime() + (SoundDuration(phrase) or 0)
		ply.lastPhr = phrase
	end)

	hook.Add("PlayerDeath", "StopPhrOnDeath",function(ply)
		ply:StopSound(ply.lastPhr or "")
		ply.phrCld = 0
	end)
end