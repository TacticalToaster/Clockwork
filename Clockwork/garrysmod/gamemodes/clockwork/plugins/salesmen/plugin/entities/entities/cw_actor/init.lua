--[[
	© 2014 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

Clockwork.kernel:IncludePrefixed("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:DrawShadow(true);
	self:SetSolid(SOLID_BBOX);
	self:PhysicsInit(SOLID_BBOX);
	self:SetMoveType(MOVETYPE_NONE);
	self:SetUseType(SIMPLE_USE);
end

-- A function to setup the actor.
function ENT:SetupActor(name, physDesc, animation)
	self:SetNetworkedString("Name", name);
	self:SetNetworkedString("PhysDesc", physDesc);
	self:SetupAnimation(animation);
end;

-- A function to talk to a player.
function ENT:TalkToPlayer(player, text, default)
	Clockwork.player:Notify(player, self:GetNetworkedString("Name").." says \""..(text or default).."\"");
end;

-- Called to setup the animation.
function ENT:SetupAnimation(animation)
	if (animation and animation != -1) then
		self:ResetSequence(animation);
	else
		self:ResetSequence(4);
	end;
end;

-- Called when the entity is used.
function ENT:Use(activator, caller)
	if (IsValid(activator) and activator:IsPlayer()) then
		if (activator:GetEyeTraceNoCursor().HitPos:Distance(self:GetPos()) < 196) then
			Clockwork.plugin:Call("PlayerUseActor", activator, self);
		end;
	end;
end;