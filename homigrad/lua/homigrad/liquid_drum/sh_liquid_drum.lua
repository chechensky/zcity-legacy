-- Path scripthooked:lua\\homigrad\\liquid_drum\\sh_liquid_drum.lua"
-- Scripthooked by ???
hg.drumsLoaded = false
hg.drums = hg.drums or {}
hg.gasolinePath = hg.gasolinePath or {}
hg.gasolineEntities = hg.gasolineEntities or {}
local math_random = math.random
local vecZero = Vector(0, 0, 0)
local angZero = Angle(0, 0, 0)
local math_Round = math.Round
local math_max = math.max
local whitelistModels = {
	["models/props_c17/oildrum001_explosive.mdl"] = true,
	["models/props_junk/gascan001a.mdl"] = true,
	["models/props_junk/metalgascan.mdl"] = true,
}
local vecHole = {
	["models/props_c17/oildrum001_explosive.mdl"] = Vector(10, 0, 0),
	["models/props_junk/gascan001a.mdl"] = Vector(0, -7, 11),
	["models/props_junk/metalgascan.mdl"] = Vector(0, -7, 11),
}
if SERVER then
	local function addDrum(ent)
		if not IsValid(ent) then return end
		if whitelistModels[ent:GetModel()] then
			local maxs, mins = ent:OBBMaxs(), ent:OBBMins()
			local vec = vecZero
			vec:Set(vecHole[ent:GetModel()])
			--vec:Rotate(ent:GetAngles())
			local pos = maxs + mins + vec
			hg.drums[ent:EntIndex()] = {
				Entity = ent,
				Volume = math_random(1, ent:OBBMaxs()[3]),
				high_point = {
					[1] = {pos, CurTime()}
				}
			}
		end
	end

	local ents_GetAll = ents.GetAll
	hook.Add("PlayerInitialSpawn", "drum_spawn2", function()
		if not hg.drumsLoaded then
			for i, ent in pairs(ents_GetAll()) do
				addDrum(ent)
			end
		end
	end)

	hook.Add("OnEntityCreated", "drum_spawn", function(ent) timer.Simple(0, function() addDrum(ent) end) end)
end

--PrintTable(ents.GetAll())
if SERVER then
	util.AddNetworkString("drums_debug")
	util.AddNetworkString("gas particle")
	local time = CurTime()
	local CurTime = CurTime
	hook.Add("Think", "drum_think", function()
		if time > CurTime() then return end
		time = time + 0.1
		for i, drum in pairs(hg.drums) do
			hook.Run("Drum Think", i, drum)
		end
	end)

	hook.Add("PostCleanupMap","removetrailsofevidence",function()
		hg.drums = {}
		hg.gasolinePath = {}
		hg.gasolineEntities = {}
	end)
	
	hook.Add("Drum Think", "Main", function(i, drum)
		local ent = drum.Entity
		if not IsValid(ent) then
			hg.drums[i] = nil
			return
		end
		--[[net.Start("drums_debug")
		net.WriteTable(hg.drums)
		net.WriteTable(hg.gasolinePath)
		net.WriteTable(hg.gasolineEntities)
		net.Broadcast()--]]
		local pos = ent:GetPos()
		local maxs, mins, center = ent:OBBMaxs(), ent:OBBMins(), ent:OBBCenter()
		for i, point in pairs(drum.high_point) do
			local high_point = vecZero
			high_point:Set(point[1])
			high_point:Rotate(ent:GetAngles())
			--local center = ent:OBBCenter()
			--center:Rotate(ent:GetAngles())
			--local volumePos = center + Vector(0,0,drum.Volume - ent:OBBCenter()[3])
			local center = ent:OBBCenter()
			center:Rotate(ent:GetAngles())
			local dot = math.max(math.abs(vector_up:Dot(ent:GetUp())), 0.99)
			local volumePos = center + Vector(0, 0, drum.Volume / dot - ent:OBBCenter()[3])
			volumePos:Add(ent:GetVelocity() / 8)
			if math_Round(high_point[3], 1) < math_Round(volumePos[3], 1) then
				drum.Volume = math_max(drum.Volume - 0.1, 0)
				drum.leaking = true
				drum.loopsound = ent:StartLoopingSound("ambient/water/leak_1.wav")
				local tr = {}
				tr.start = pos + high_point
				tr.endpos = tr.start + -vector_up * 256
				tr.filter = ent
				tr = util.TraceLine(tr)
				if tr.Hit and tr.Entity == Entity(0) then
					if (drum.lastFireCreated or 0) < CurTime() then
						drum.lastFireCreated = CurTime() + 0.2
						table.insert(hg.gasolinePath,tr.HitPos)
						--local firepos = ents.Create("fire_ent")
						--firepos:Spawn()
						--firepos:SetPos(tr.HitPos)
					end
				elseif tr.Entity != Entity(0) then
					hg.gasolineEntities[tr.Entity:EntIndex()] = (hg.gasolineEntities[tr.Entity:EntIndex()] and hg.gasolineEntities[tr.Entity:EntIndex()] + 1 or 1)
				end
				net.Start("gas particle")
				net.WriteVector(pos + high_point)
				net.WriteVector(vector_up * 0 + ent:GetVelocity() + VectorRand(-15, 15) + (pos + high_point - (center + ent:GetPos())):GetNormalized() * 60)
				net.WriteEntity(ent)
				net.Broadcast()
			else
				if drum.loopsound then
					ent:StopLoopingSound(drum.loopsound)
					drum.loopsound = nil
				end
				drum.leaking = false
			end

			if point[2] < CurTime() then point[2] = point[2] + 0.1 end
		end

		if drum.Volume <= 0.5 then
			if drum.loopsound then
				ent:StopLoopingSound(drum.loopsound)
				drum.loopsound = nil
			end
			hg.drums[i] = nil
		end
	end)

	hook.Add("EntityTakeDamage", "drum_damage", function(ent, dmgInfo)
		if hg.drums[ent:EntIndex()] then
			if dmgInfo:IsDamageType(DMG_BULLET + DMG_BUCKSHOT) then
				local dmgPos = dmgInfo:GetDamagePosition()
				local localPos, localAng = WorldToLocal(dmgPos, angZero, ent:GetPos(), ent:GetAngles())
				local drum = hg.drums[ent:EntIndex()]
				drum.high_point[#drum.high_point + 1] = {localPos, CurTime()}
			end
			return true
		end
	end)
else
	net.Receive("drums_debug", function() hg.drums = net.ReadTable() hg.gasolinePath = net.ReadTable() hg.gasolineEntities = net.ReadTable() end)
	hook.Add("HUDPaint","drum_client",function()
		if true then return end
		
        for i,drum in pairs(hg.drums) do
            local ent = drum.Entity
			
            if not IsValid(ent) then
                hg.drums[i] = nil
                continue
            end
            
            local pos = ent:GetPos()
            local maxs, mins, center = ent:OBBMaxs(),ent:OBBMins(),ent:OBBCenter()

            local leaking = false
            for i, point in pairs(drum.high_point) do
                local high_point = vecZero

                high_point:Set(point[1])
                high_point:Rotate(ent:GetAngles())

                --surface.DrawRect(pos:ToScreen().x,pos:ToScreen().y,10,10)

                local center = ent:OBBCenter()
                center:Rotate(ent:GetAngles())

                local dot = math.max(math.abs(vector_up:Dot(ent:GetUp())),0.99)
                
                local volumePos = center + Vector(0,0,(drum.Volume / (dot) - ent:OBBCenter()[3]))
                volumePos:Add(ent:GetVelocity() / 8)
                /*
                local center = ent:OBBCenter()
                center:Rotate(ent:GetAngles())

                local aa,ab = ent:OBBMaxs(),ent:OBBMins()
                local min,max = ent:GetRotatedAABB(aa, ab)

                center[3] = max[3]
                local volumePos = center - Vector(0,0,45 - drum.Volume)

                --слишком сложно
                */
                

                surface.DrawRect((pos + volumePos):ToScreen().x,(pos + volumePos):ToScreen().y,10,10)
                surface.DrawRect((pos + high_point):ToScreen().x,(pos + high_point):ToScreen().y,10,10)
                
                /*
                local aa,ab = ent:OBBMaxs(),ent:OBBMins()
                local _,max = ent:GetRotatedAABB(aa, ab)
                surface.DrawRect((pos + a):ToScreen().x,(pos + b):ToScreen().y,10,10)

                --не...
                */
                
                --[[if math_Round(high_point[3],1) < math_Round(volumePos[3],1) then
                    if point[2] < CurTime() then
                        addGasPart(pos + high_point,ent:GetUp() * 25 + ent:GetVelocity() + VectorRand(-15,15),nil,math_random(3,6),math_random(3,6),ent)
                    end
                    leaking = true
                end--]]
            end
            
            --[[if leaking and drum.Volume > 1 then
                if not IsValid(ent.Sound) then
                    sound.PlayFile( "sound/ambient/water/leak_1.wav", "3d noplay noblock", function(station,errCode,errStr)
                        if (IsValid(station)) then
                            drum.Entity.Sound = station
                            station:SetVolume(0.1)
                            station:Play()
                            station:EnableLooping(true)
                            station:SetPos(pos)
                        end
                    end)
                else
                    ent.Sound:SetPos(pos)
                end
            else
                if IsValid(ent.Sound) then
                    ent.Sound:Stop()
                end
            end--]]
        end

		for i,pos in pairs(hg.gasolinePath) do
			surface.SetDrawColor(255,255,255,255)
			surface.DrawRect(pos:ToScreen().x,pos:ToScreen().y,10,10)
		end

		for index,amount in pairs(hg.gasolineEntities) do
			local ent = Entity(index)
			local pos = ent:GetPos() + ent:OBBCenter()
			surface.SetDrawColor(math.min(amount * 10,255),0,0,255)
			surface.DrawRect(pos:ToScreen().x,pos:ToScreen().y,10,10)
		end
    end)
	hook.Add("EntityRemoved", "remove_drum_sound", function(ent) if IsValid(ent.Sound) then ent.Sound:Stop() end end)
end