-- Path scripthooked:lua\\entities\\attachment_base\\cl_init.lua"
-- Scripthooked by ???
include("shared.lua")
function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
end

function ENT:Initialize()
	self.model = ClientsideModel(self.Model, RENDERGROUP_OPAQUE)
end

function ENT:OnRemove()
	if IsValid(self.model) then
		self.model:Remove()
		self.model = nil
	end
end