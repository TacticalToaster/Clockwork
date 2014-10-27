--[[
	© 2014 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local COMMAND = Clockwork.command:New("ActorRemove");
COMMAND.tip = "Remove a actor at your target position.";
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = player:GetEyeTraceNoCursor().Entity;
	
	if (IsValid(target)) then
		if (target:GetClass() == "cw_actor") then
			for k, v in pairs(cwActors.actors) do
				if (target == v) then
					target:Remove();
					cwActors.actors[k] = nil;
					cwActors:SaveActors();
					
					Clockwork.player:Notify(player, "You have removed a actor.");
					
					return;
				end;
			end;
		else
			Clockwork.player:Notify(player, "This entity is not a actor!");
		end;
	else
		Clockwork.player:Notify(player, "You must look at a valid entity!");
	end;
end;

COMMAND:Register();