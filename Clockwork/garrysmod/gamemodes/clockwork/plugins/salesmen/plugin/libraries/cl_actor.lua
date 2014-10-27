--[[
	© 2014 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

Clockwork.actor = Clockwork.kernel:NewLibrary("Actor");

-- A function to get the actor text.
function Clockwork.actor:GetText()
	return self.text;
end;

-- A function to get the actor panel.
function Clockwork.actor:GetPanel()
	return self.panel;
end;

-- A function to get the actor model.
function Clockwork.actor:GetModel()
	return self.model;
end;

-- A function to get the actor name.
function Clockwork.actor:GetName()
	return self.name;
end;

-- A function to get actor sound.
function Clockwork.actor:GetSound()
	return self.sound;
end;