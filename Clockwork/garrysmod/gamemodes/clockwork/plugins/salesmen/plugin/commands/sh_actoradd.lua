--[[
	© 2014 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local COMMAND = Clockwork.command:New("ActorAdd");
COMMAND.tip = "Add a actor at your target position.";
COMMAND.text = "[number Animation]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "a";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	player.cwActorSetup = true;
	player.cwActorAnim = tonumber(arguments[1]);
	player.cwActorHitPos = player:GetEyeTraceNoCursor().HitPos;
	
	if (!player.cwActorAnim and type(arguments[1]) == "string") then
		player.cwActorAnim = tonumber(_G[arguments[1]]);
	end;
	
	Clockwork.datastream:Start(player, "ActorAdd", true);
end;

COMMAND:Register();