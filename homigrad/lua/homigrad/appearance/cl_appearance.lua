-- Path scripthooked:lua\\homigrad\\appearance\\cl_appearance.lua"
-- Scripthooked by ???
--["Name accessories"] = {"models/captainbigbutt/skeyler/accessories/glasses01.mdl", "ValveBiped.Bip01_Head1", {Vector(2.1,3,0),Angle(0,-70,-90),.9} -- MalePos,{Vector(2.75,2,0),Angle(0,-70,-90),.8} -- female pos,false,0},
--

local whitelist = {
	weapon_physgun = true,
	gmod_tool = true,
	gmod_camera = true,
	weapon_crowbar = true,
	weapon_pistol = true,
	weapon_crossbow = true
}

function RenderAccessories(ply, accessories)
	--print(ply)
	if not IsValid(ply) or not ply.accessories then
		return
	end
	if ply.accessories == "none" then return end
	
	if ply:IsPlayer() and not ply:Alive() and not IsValid(ply.FakeRagdoll) then return end
	--print(ply)

	local wep = ply:IsPlayer() and ply:GetActiveWeapon()
	islply = ply == LocalPlayer() and GetViewEntity() == LocalPlayer()
	if islply and IsValid(wep) and whitelist[wep:GetClass()] then
		if ply.modelAccess then
			for arm, model in pairs(ply.modelAccess) do
				if IsValid(model) then
					model:Remove()
					model = nil
				end
			end	
		end

		ply.modelAccess = {}
		return
	end
	
	local ent = hg.GetCurrentCharacter(ply)
	local onlylocal = onlylocal or false
	--print(LocalPlayer():GetAimVector():Dot(diff) / diff:Length())
	if not ent.shouldTransmit or (ent.NotSeen and LocalPlayer():Alive()) then
		if not ply.modelAccess then return end
		for arm, model in pairs(ply.modelAccess) do
			if IsValid(model) then
				model:Remove()
				model = nil
			end
		end
		return
	end

	local accessData = hg.Accessories[accessories]
	if not accessData then return end
	if ply.armors and accessData["placement"] and ply.armors[accessData["placement"]] then return end
	
	DrawAccesories(ply,ent,accessories,accessData,islply)
end

function DrawAccesories(ply,ent,accessories,accessData,islply)
	if not accessories then return end
	if not accessData then return end
	ply.modelAccess = ply.modelAccess or {}
	if not IsValid(ply.modelAccess[accessories]) then
		if not accessData["model"] then return end
		ply.modelAccess[accessories] = ClientsideModel(accessData["model"])
		ply:CallOnRemove("RemoveAccessories",function() 
			if IsValid(ply.modelAccess[accessories]) then
				ply.modelAccess[accessories]:Remove()
				ply.modelAccess[accessories] = nil
			end
		end)
	end
	local model = ply.modelAccess[accessories]
	
	if not IsValid(model) then return end
		
	local matrix = ent:GetBoneMatrix(ent:LookupBone(accessData["bone"]))
	if not matrix then
		model:SetNoDraw(true)
		return
	end
	
	local bonePos, boneAng = matrix:GetTranslation(), matrix:GetAngles()
	local fem = ThatPlyIsFemale(ent)
	local pos, ang = LocalToWorld(accessData[fem and "fempos" or "malepos"][1], accessData[fem and "fempos" or "malepos"][2], bonePos, boneAng)
	
	model:SetRenderOrigin(pos)
	model:SetRenderAngles(ang)
	model:SetModelScale( accessData[fem and "fempos" or "malepos"][3] )
	model:SetSkin( accessData["skin"] )
	if accessData["bonemerge"] then
		model:SetParent(ply)
		model:AddEffects(EF_BONEMERGE)
	end
	model:SetupBones()
	model:SetNoDraw(true)
	
	if not (islply and accessData.norender) then model:DrawModel() end
end

hook.Add("PostDrawOpaqueRenderables", "player-accessories", function()
    local ents = ents.FindByClass("prop_ragdoll")
    table.Add(ents, player.GetAll())
    
    for i,ent in ipairs(ents) do
        if not IsValid(ent) or not ent.accessories then continue end

        RenderAccessories(ent, ent.accessories)
    end
end)

hook.Add("OnNetVarSet","AccessoriesVarSet",function(index, key, var)
    if key == "Accessories" then
        timer.Simple(.1,function()
            local ent = Entity(index)
            ent.accessories = var
        end)
    end
end)
