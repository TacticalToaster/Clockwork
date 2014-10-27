--[[
	© 2014 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	local actorName = Clockwork.actor:GetName();
	
	self:SetTitle(actorName);
	self:SetBackgroundBlur(true);
	self:SetDeleteOnClose(false);
	
	-- Called when the button is clicked.
	function self.btnClose.DoClick(button)
		CloseDermaMenus();
		self:Close(); self:Remove();
		
		Clockwork.datastream:Start("ActorAdd", {
			physDesc = Clockwork.actor.physDesc,
			model = Clockwork.actor.model,
			text = Clockwork.actor.text,
			name = Clockwork.actor.name,
			sound = Clockwork.actor.sound
		});
		
		Clockwork.actor.physDesc = nil;
		Clockwork.actor.model = nil;
		Clockwork.actor.text = nil;
		Clockwork.actor.name = nil;
		Clockwork.actor.sound = nil;
		
		gui.EnableScreenClicker(false);
	end;
	
	self.settingsPanel = vgui.Create("cwPanelList");
 	self.settingsPanel:SetPadding(2);
 	self.settingsPanel:SetSpacing(3);
 	self.settingsPanel:SizeToContents();
	self.settingsPanel:EnableVerticalScrollbar();
	
	self.settingsForm = vgui.Create("cwForm");
	self.settingsForm:SetPadding(4);
	self.settingsForm:SetName("Settings");
	
	self.settingsPanel:AddItem(self.settingsForm);
	
	self.physDesc = self.settingsForm:TextEntry("The physical description of the actor.");
	self.model = self.settingsForm:TextEntry("The model of the actor.");
	self.sound = self.settingsForm:TextEntry("Sound emitted by actor.");
	
	self.physDesc:SetValue(Clockwork.actor.physDesc);
	self.model:SetValue(Clockwork.actor.model);
	self.sound:SetValue(Clockwork.actor.sound);
	
	self.responsesForm = vgui.Create("cwForm");
	self.responsesForm:SetPadding(4);
	self.responsesForm:SetName("Responses");
	self.settingsForm:AddItem(self.responsesForm);

	self.text = self.responsesForm:TextEntry("When player interacts with actor.");
	
	if (!Clockwork.actor.text) then
		self.text:SetValue("Sometimes, I dream about cheese!");
	end;
	
	self.propertySheet = vgui.Create("DPropertySheet", self);
		self.propertySheet:SetPadding(4);
		self.propertySheet:AddSheet("Settings", self.settingsPanel, "icon16/tick.png", nil, nil, "View possible items for trading.");
	Clockwork.kernel:SetNoticePanel(self);
end;

-- A function to rebuild a panel.
function PANEL:RebuildPanel(panelList, typeName, inventory)
	panelList:Clear(true);
	
	if (table.Count(categories) > 0) then
		for k, v in pairs(categories) do
			local collapsibleCategory = Clockwork.kernel:CreateCustomCategoryPanel(v.category, panelList);
				collapsibleCategory:SetCookieName("Actor"..typeName..v.category);
			panelList:AddItem(collapsibleCategory);
			 
			local categoryList = vgui.Create("DPanelList", collapsibleCategory);
				categoryList:EnableHorizontal(true);
				categoryList:SetAutoSize(true);
				categoryList:SetPadding(4);
				categoryList:SetSpacing(4);
			collapsibleCategory:SetContents(categoryList);
		end;
	end;
end;

-- A function to rebuild the panel.
function PANEL:Rebuild()
end;

-- Called each frame.
function PANEL:Think()
	self:SetSize(ScrW() * 0.5, ScrH() * 0.75);
	self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2));
	
	Clockwork.actor.text = self.text:GetValue();
	Clockwork.actor.physDesc = self.physDesc:GetValue();
	Clockwork.actor.model = self.model:GetValue();
	Clockwork.actor.sound = self.sound:GetValue();
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout(w, h)
	DFrame.PerformLayout(self);
	
	if (self.propertySheet) then
		self.propertySheet:StretchToParent(4, 28, 4, 4);
	end;
end;

vgui.Register("cwActor", PANEL, "DFrame");