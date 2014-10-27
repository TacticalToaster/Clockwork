--[[
	© 2014 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local COMMAND = Clockwork.command:New("ActorEdit");
COMMAND.tip = "Edit an actor at your target position.";
COMMAND.text = "[number Animation]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "a";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = player:GetEyeTraceNoCursor().Entity;
	
	if (IsValid(target)) then
		if (target:GetClass() == "cw_actor") then
			local actorTable = cwActors:GetTableFromEntity(target);
			
			player.cwActorSetup = true;
			player.cwActorAnim = tonumber(arguments[1]);
			player.cwActorPos = target:GetPos();
			player.cwActorAng = target:GetAngles();
			player.cwActorHitPos = player:GetEyeTraceNoCursor().HitPos;
			
			if (!player.cwActorAnim and type(arguments[1]) == "string") then
				player.cwActornAnim = tonumber(_G[arguments[1]]);
			end;
			
			if (!player.cwActorAnim and actorTable.animation) then
				player.cwActorAnim = actorTable.animation;
			end;
			
			Clockwork.datastream:Start(player, "ActorEdit", actorTable);
			
			for k, v in pairs(cwSalesmen.salesmen) do
				if (target == v) then
					target.cwCash = nil;
					target:Remove();
					cwSalesmen.salesmen[k] = nil;
					cwSalesmen:SaveSalesmen();
					
					return;
				end;
			end;
		else
			Clockwork.player:Notify(player, "This entity is not an actor!");
		end;
	else
		Clockwork.player:Notify(player, "You must look at a valid entity!");
	end;
end;

COMMAND:Register();