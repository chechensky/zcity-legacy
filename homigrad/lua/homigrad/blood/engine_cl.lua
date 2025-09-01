-- Path scripthooked:lua\\homigrad\\organism\\tier_1\\modules\\particles\\cl_main.lua"
-- Scripthooked by ???
local fps = 1 / 24
local delay = 0
local math_min = math.min
local CurTime, FrameTime = CurTime, FrameTime
bloodparticels_hook = bloodparticels_hook or {}
local bloodparticels_hook = bloodparticels_hook
hook.Add("PostDrawOpaqueRenderables", "bloodpartciels", function()
	local time = CurTime()
	--if not bloodparticels_hook then return end
	if delay > time then
		local animpos = math_min((delay - time) / fps, 1)
		--if not bloodparticels_hook[1] then return end
		bloodparticels_hook[1](animpos)
	else
		delay = time + fps
		--if not bloodparticels_hook[2] then return end
		bloodparticels_hook[2](fps)
	end
end)