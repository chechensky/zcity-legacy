-- Path scripthooked:lua\\entities\\armor_base\\cl_init.lua"
-- Scripthooked by ???
include("shared.lua")
function ENT:Draw()
	if not self.PhysModel then
		self:DrawModel()
		return
	end

	local model = self.model
	local pos, ang = LocalToWorld(self.PhysPos, self.PhysAng, self:GetPos(), self:GetAngles())
	model:SetRenderOrigin(pos)
	model:SetRenderAngles(ang)
	model:DrawModel()
end

function ENT:Think()
end

local huyChlen = {}
function ENT:Initialize()
	self.model = ClientsideModel(self.Model, RENDERGROUP_OPAQUE)
end

function ENT:OnRemove()
	if IsValid(self.model) then
		self.model:Remove()
		self.model = nil
	end
end