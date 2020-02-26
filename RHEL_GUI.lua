local tanks = {"MT", "OT", "T3", "T4", "A", "B", "C", "D"}
RHEL_color = {}
RHEL_color.DRUID = {1.00, 0.49, 0.04} -- Orange
RHEL_color.HUNTER = {0.67, 0.83, 0.45} -- Green
RHEL_color.MAGE = {0.25, 0.78, 0.92} -- Light Blue
RHEL_color.PALADIN = {0.96,	0.55, 0.73} -- Pink
RHEL_color.PRIEST = {1.00, 1.00, 1.00} -- White
RHEL_color.ROGUE = {1.00, 0.96, 0.41} -- Yellow*
RHEL_color.SHAMAN = {0.00, 0.44, 0.87} -- Blue
RHEL_color.WARLOCK = {0.53, 0.53, 0.93} -- Purple
RHEL_color.WARRIOR = {0.78, 0.61, 0.43} -- Tan

RHEL_GUI = {};
-- Bold frame translucent template
RHEL_GUI.RHEL_Backdrop = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 18,
    insets = { left = 5 , right = 5 , top = 5 , bottom = 5 }
}
-- Thinnner frame translucent template
RHEL_GUI.RHEL_Backdrop2 = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 10,
    insets = { left = 2 , right = 2 , top = 3 , bottom = 1 }
}
-- Clear frame - no translucent background
RHEL_GUI.RHEL_Backdrop3 = {
    bgFile = nil,
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 6,
    insets = { left = 2 , right = 2 , top = 3 , bottom = 1 }
}

function main_menu()
	-- Healer frame pozitions
	local tank_frame = 20
	local healer_frame_start_x, healer_frame_start_y, healer_frame_finish_y, healer_frame_region = 6, -70 - ((RHEL_Add_Tanks and 1 or 0) + 1)*tank_frame, 0, "TOPLEFT"
	local healer_frame_x, healer_frame_y = 790, 42
	local healer_frame_delta = 0
	-- CheckButton pozitions
	local check_button_start_x, check_button_start_y, check_button_start_region = 180, 0, "LEFT"
	local check_button_step_x, check_button_step_y = 32, 8
	local check_button_step_delta = 16
	local check_button_size = 22
	-- AllGroupsButton pozitions
	local all_button_start_x, all_button_start_region = 46, "CENTER"
	local all_button_step_delta = 144
	local all_button_size = 18
	-- Icon pozition
	local icon_start_x, icon_start_y, icon_region = 10, 0, "LEFT"
	local icon_size = 20
	-- EditBox pozition
	local editbox_start_x, editbox_start_y, editbox_region = 40, 0, "LEFT"
	local editbox_size_x, editbox_size_y = 110, 20
	-- Insert button pozition
	local ins_button_start_x, ins_button_start_y, ins_button_region = 150, 0, "LEFT"
	local ins_button_size_x, ins_button_size_y = 30, 20
	-- Wisper button pozition
	local button_start_x, button_start_y, button_region = -10, 0, "RIGHT"
	local button_size_x, button_size_y = 40, 30
	-- Anounce button pozition
	local anounce_size_x, anounce_size_y = 120, 40
	local anounce_start_x, anounce_start_y, anounce_region = 254, 10, "BOTTOMLEFT"
	local anounce_delta = 210
	-- ToChannel button pozition
	local to_channel_size = 18
	local to_channel_start_x, to_channel_start_y, to_channel_region = 30, 34, "BOTTOMLEFT"
	local to_channel_delta = -15
	local to_channel_font_size_x, to_channel_font_size_y = 80, 20
	-- Channel EditBox pozition
	local channel_editbox_size_x, channel_editbox_size_y = 18, 40
	local channel_editbox_start_x, channel_editbox_start_y, channel_editbox_region = 124, 23, "BOTTOMLEFT"
	-- Tanks pozition 
	local tank_editbox_start_x, tank_editbox_start_y, tank_editbox_region = 46, -68, "TOPLEFT"
	local tank_editbox_step_x, tank_editbox_step_y = 196, 20
	local tank_icon_start_x, tank_icon_start_y, tank_icon_region = 16, -68, "TOPLEFT"
	local tank_ins_button_start_x, tank_ins_button_start_y, tank_ins_button_region = 155, -68, "TOPLEFT"
	-- DropDown menu pozition
	local raid_name_dropdown_start_x, raid_name_dropdown_start_y, raid_name_dropdown_region = 3, -20, "TOPLEFT"
	local raid_name_dropdown_delta = 144
	-- Warning checkbox
	local warning_check_size_x, warning_check_size_y = 25, 25
	local warning_check_start_x, warning_check_start_y, warning_check_region = 18, -44, "TOPLEFT"
	-- BossNote Window
	local boss_note_size_x, boss_note_size_y = 430, 62
	local boss_note_start_x, boss_note_start_y, boss_note_region = -70, -4, "TOPRIGHT"

	-- Main menu pozition
	local main_menu_start_x, main_menu_start_y, main_menu_region = 0, 0, "CENTER"
	local main_menu_x, main_menu_y = healer_frame_start_x * 2 + healer_frame_x, abs(healer_frame_start_y) + RHEL_Total * (healer_frame_y + abs(healer_frame_delta)) + (2.5 + 0.3 * (RHEL_Add_Tanks and 1 or 0)) * tank_frame + healer_frame_finish_y

	-- Main window. "TranslucentFrameTemplate"
	RHEL_GUI.RHEL_MainMenu = CreateFrame("Frame", "RHEL_MainMenu", UIParent);
	RHEL_GUI.RHEL_MainMenu.RHEL_MainMenuCloseButton = CreateFrame( "Button", "RHEL_MainMenuCloseButton", RHEL_GUI.RHEL_MainMenu, "UIPanelCloseButton");
	RHEL_GUI.RHEL_MainMenu.RHEL_MainMenuCloseButton:SetPoint("TOPRIGHT", RHEL_MainMenu, 3, 3);
	RHEL_GUI.RHEL_MainMenu:SetSize(main_menu_x, main_menu_y);
	RHEL_GUI.RHEL_MainMenu:SetMovable(true);
	RHEL_GUI.RHEL_MainMenu:EnableMouse(true);
	RHEL_GUI.RHEL_MainMenu:SetToplevel(true);
	RHEL_GUI.RHEL_MainMenu:SetPoint("CENTER", 0 , 0);
	RHEL_GUI.RHEL_MainMenu:SetBackdrop(RHEL_GUI.RHEL_Backdrop2);
	RHEL_GUI.RHEL_MainMenu:SetScript("OnMouseDown", function(self)
		RHEL_OnMouseDown(self);
	end);
	RHEL_GUI.RHEL_MainMenu:SetScript("OnMouseUp", function(self)
		RHEL_OnMouseUp(self);
	end);

	-- Raid dropdown
	RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown = CreateFrame("Frame", "RaidNameDropdown", RHEL_GUI.RHEL_MainMenu, "UIDropDownMenuTemplate");
	RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown:SetPoint(raid_name_dropdown_region, raid_name_dropdown_start_x, raid_name_dropdown_start_y);
	UIDropDownMenu_SetWidth(RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown, 115) 
	local RaidNameDropdownFont = RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown, "OVERLAY", "GameFontNormalSmall");		
	RaidNameDropdownFont:SetPoint("TOPRIGHT", -30, 10);	
	RaidNameDropdownFont:SetText("Raid Name");	
	UIDropDownMenu_Initialize(RaidNameDropdown, RHEL_RaidNameDropdown_OnLoad);

	-- Boss dropdown
	RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown = CreateFrame("Frame", "BossNameDropdown", RHEL_GUI.RHEL_MainMenu, "UIDropDownMenuTemplate");
	RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown:SetPoint(raid_name_dropdown_region, raid_name_dropdown_start_x + raid_name_dropdown_delta, raid_name_dropdown_start_y);
	UIDropDownMenu_SetWidth(RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown, 128) 
	local BossNameDropdownFont = RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown, "OVERLAY", "GameFontNormalSmall");		
	BossNameDropdownFont:SetPoint("TOPLEFT", 30, 10);	
	BossNameDropdownFont:SetText("Boss Name");	
	UIDropDownMenu_Initialize(BossNameDropdown, RHEL_BossNameDropdown_OnLoad);

	-- Warning CheckButton
	RHEL_GUI.RHEL_MainMenu.RHEL_WarningCheck = CreateFrame("CheckButton", "CheckButtonWarning", RHEL_GUI.RHEL_MainMenu, "UICheckButtonTemplate");
	RHEL_GUI.RHEL_MainMenu.RHEL_WarningCheck:SetPoint(warning_check_region, warning_check_start_x, warning_check_start_y);
	RHEL_GUI.RHEL_MainMenu.RHEL_WarningCheck:SetSize(warning_check_size_x, warning_check_size_y);
	local WarningCheckFont = RHEL_GUI.RHEL_MainMenu.RHEL_WarningCheck:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_WarningCheck, "OVERLAY", "GameFontNormal");	
	WarningCheckFont:SetPoint("TOPLEFT", 25, 0);
	WarningCheckFont:SetSize(200,25);
	CheckButtonWarningText:SetText("Warning on healers death");
	RHEL_GUI.RHEL_MainMenu.RHEL_WarningCheck:SetScript("OnClick", function(self) 
		RHEL_ClickOnWarningCheckBox();
	end);

	-- Tanks
	local total_tanks
	if RHEL_Add_Tanks then
		total_tanks = 8
	else
		total_tanks = 4
	end
	for  i = 1, total_tanks do
		-- Tank EditBox
		local tank_editbox = "TankName" .. i
		RHEL_GUI.RHEL_MainMenu.tank_editbox = CreateFrame("EditBox", "TankName"..i, RHEL_GUI.RHEL_MainMenu, "InputBoxTemplate");
		RHEL_GUI.RHEL_MainMenu.tank_editbox:SetSize(editbox_size_x, editbox_size_y);
		RHEL_GUI.RHEL_MainMenu.tank_editbox:SetMaxLetters(12);
		RHEL_GUI.RHEL_MainMenu.tank_editbox:SetAutoFocus(false);
		if i <= 4 then
			RHEL_GUI.RHEL_MainMenu.tank_editbox:SetPoint(tank_editbox_region, tank_editbox_start_x + tank_editbox_step_x * (i-1), tank_editbox_start_y);	
		else
			RHEL_GUI.RHEL_MainMenu.tank_editbox:SetPoint(tank_editbox_region, tank_editbox_start_x + tank_editbox_step_x * (i-5), tank_editbox_start_y - tank_editbox_step_y);
		end
		RHEL_GUI.RHEL_MainMenu.tank_editbox:SetScript("OnEscapePressed", function(self)
			self:ClearFocus();    
		end);
		RHEL_GUI.RHEL_MainMenu.tank_editbox:SetScript("OnTabPressed", function(self)
			if i == total_tanks then
				HealerName1:SetFocus();
			else
				_G["TankName"..(i+1)]:SetFocus();
			end
		end);
		RHEL_GUI.RHEL_MainMenu.tank_editbox:SetScript("OnTextChanged", function(self)
			RHEL_TankNameChange(self); -- TO DO
		end);
	
		-- Tank icon frame
		local tank_icon = "TankClass"..i
		RHEL_GUI.RHEL_MainMenu.tank_icon = CreateFrame("Frame", "TankClass"..i, RHEL_GUI.RHEL_MainMenu);
		RHEL_GUI.RHEL_MainMenu.tank_icon:SetSize(icon_size, icon_size);
		if i <= 4 then
			RHEL_GUI.RHEL_MainMenu.tank_icon:SetPoint(tank_icon_region, tank_icon_start_x + tank_editbox_step_x * (i-1), tank_icon_start_y);
		else 
			RHEL_GUI.RHEL_MainMenu.tank_icon:SetPoint(tank_icon_region, tank_icon_start_x + tank_editbox_step_x * (i-5), tank_icon_start_y - tank_editbox_step_y);
		end
		local texture = "TankClassIcon"..i
		RHEL_GUI.RHEL_MainMenu.tank_icon.texture = RHEL_GUI.RHEL_MainMenu.tank_icon:CreateTexture("TankClassIcon"..i, "Background");
		RHEL_GUI.RHEL_MainMenu.tank_icon.texture:SetPoint("CENTER");
		RHEL_GUI.RHEL_MainMenu.tank_icon.texture:SetTexture("Interface\\AddOns\\RHEL\\Icons\\WARRIOR")
		RHEL_GUI.RHEL_MainMenu.tank_icon.texture:SetSize(icon_size, icon_size);

		-- Tank Insert Button
		local ins_button = "TankIns_button"..i
		RHEL_GUI.RHEL_MainMenu.ins_button = CreateFrame("Button", ins_button, RHEL_GUI.RHEL_MainMenu, "UIPanelButtonTemplate");
		RHEL_GUI.RHEL_MainMenu.ins_button:SetText(tanks[i]);
		RHEL_GUI.RHEL_MainMenu.ins_button:SetSize(ins_button_size_x, ins_button_size_y);
		if i <= 4 then
			RHEL_GUI.RHEL_MainMenu.ins_button:SetPoint(tank_ins_button_region, tank_ins_button_start_x + tank_editbox_step_x * (i-1), tank_ins_button_start_y);
		else
			RHEL_GUI.RHEL_MainMenu.ins_button:SetPoint(tank_ins_button_region, tank_ins_button_start_x + tank_editbox_step_x * (i-5), tank_ins_button_start_y - tank_editbox_step_y);
		end
		RHEL_GUI.RHEL_MainMenu.ins_button:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				RHEL_TankInsert(self); -- TO DO
			end
		end);
	end

	-- Checkbox generator
	function createCheckbutton(parent, x_loc, y_loc, name, text, role, hlr, ckckbx)
		local checkbutton = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate");
		checkbutton:SetPoint(check_button_start_region, x_loc, y_loc);
		checkbutton:SetSize(check_button_size, check_button_size);
		getglobal(checkbutton:GetName() .. 'Text'):SetText(text);
		checkbutton:SetScript("OnClick", function(self)
			RHEL_ClickOnCheckBox(role, hlr, ckckbx);
		end);
		local checkbuttonfont=checkbutton:CreateFontString(checkbutton, "OVERLAY", "GameFontNormal");
		checkbuttonfont:SetPoint("TOPLEFT", -10, 0);
		checkbuttonfont:SetSize(check_button_size,check_button_size);
		return checkbutton;
	end

	-- "All groups" radiobutton generator
	function createAllGroupsButton(parent, x_loc, y_loc, name, role, hlr)
		local AllGroupsbutton = CreateFrame("CheckButton", name, parent, "UIRadioButtonTemplate");
		AllGroupsbutton:SetPoint("CENTER", x_loc, y_loc);
		AllGroupsbutton:SetSize(all_button_size, all_button_size)
		AllGroupsbutton:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				RHEL_ClickOnAll(role, hlr);
			end
		end);
		local AllGroupsbuttonfont = AllGroupsbutton:CreateFontString(AllGroupsbutton, "OVERLAY", "GameFontNormal")
		AllGroupsbuttonfont:SetPoint("CENTER", 20, 0)
		AllGroupsbuttonfont:SetSize(20, 20)
		return AllGroupsbutton;
	end

	for i = 1, RHEL_Total do	
		-- Healer frame.
		local healerFrame = "RHEL_healerFrame"..i
		RHEL_GUI.RHEL_MainMenu.healerFrame = CreateFrame("Frame", "RHEL_healerFrame"..i, RHEL_MainMenu);
		RHEL_GUI.RHEL_MainMenu.healerFrame:SetSize(healer_frame_x, healer_frame_y);
		RHEL_GUI.RHEL_MainMenu.healerFrame:SetBackdrop(RHEL_GUI.RHEL_Backdrop2);
		RHEL_GUI.RHEL_MainMenu.healerFrame:SetPoint(healer_frame_region, healer_frame_start_x, healer_frame_start_y + (-healer_frame_y + healer_frame_delta) * (i-1));
	
		-- Healer EditBox
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox = CreateFrame("EditBox", "HealerName"..i, RHEL_GUI.RHEL_MainMenu.healerFrame, "InputBoxTemplate");
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetMaxLetters(12);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetSize(editbox_size_x, editbox_size_y);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetPoint(editbox_region, editbox_start_x, editbox_start_y);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetAutoFocus(false);																																	
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetScript("OnEscapePressed", function(self)
			getglobal("HealerName"..(i)):ClearFocus();    
		end);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetScript("OnTabPressed", function(self)
			if i == RHEL_Total then
				HealerName1:SetFocus();
			else
				getglobal("HealerName"..(i+1)):SetFocus();
			end
		end);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetScript("OnTextChanged", function(self)
			RHEL_HealerNameChange(self);
		end);
	
		-- Healer EditBox frame
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame = CreateFrame("Frame", "HealerClass"..i, RHEL_GUI.RHEL_MainMenu.healerFrame);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:SetSize(icon_size, icon_size);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:SetPoint("LEFT", 10 , 0);
	--	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:SetBackdrop(RHEL_GUI.RHEL_Backdrop2);
	
		local texture = "HealerClassIcon"..i
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture = RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:CreateTexture( "HealerClassIcon"..i, "Background");
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetPoint("CENTER");
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetTexture("Interface\\AddOns\\RHEL\\Icons\\WARRIOR")
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetSize(icon_size, icon_size);

		-- Healer insert Button
		local ins_button = "Ins_button"..i
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_ins_button = CreateFrame("Button", ins_button, RHEL_GUI.RHEL_MainMenu.healerFrame, "UIPanelButtonTemplate");
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_ins_button:SetText('Ins');
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_ins_button:SetSize(ins_button_size_x, ins_button_size_y);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_ins_button:SetPoint(ins_button_region, "RHEL_healerFrame"..i, ins_button_start_x, ins_button_start_y);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_ins_button:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				RHEL_HealerInsert(self);
			end
		end);

		-- Heals checkboxes
		for j = 1, 8 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (check_button_start_x + check_button_step_x * (j-1)), check_button_start_y + check_button_step_y
			local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j, 1, i, j);
		end
		for j = 9, 12 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (check_button_start_x + check_button_step_x * (j-9)), check_button_start_y - check_button_step_y
			local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, tanks[j-8], 1, i, j);
		end
		if RHEL_Add_Tanks then
			for j = 13, 16 do
				local CheckButton_Poz_x, CheckButton_Poz_y = (check_button_start_x + check_button_step_x * (j-9)), check_button_start_y - check_button_step_y
				local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
				RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, tanks[j-8], 1, i, j);
			end
		end
	
		-- Buffs checkboxes
		for j = 1, 4 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (check_button_start_x + (8 * check_button_step_x  + check_button_step_delta) + check_button_step_x  * (j-1)), check_button_start_y + check_button_step_y
			local RHELCheckButton = "RHELCheckButton2_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j , 2, i, j);
		end
		for j = 5, 8 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (check_button_start_x + (8 * check_button_step_x  + check_button_step_delta) + check_button_step_x  * (j-5)), check_button_start_y - check_button_step_y
			local RHELCheckButton = "RHELCheckButton2_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j , 2, i, j);
		end
		-- Dispells checkboxes
		for j = 1, 4 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (check_button_start_x + (12 * check_button_step_x + 2 * check_button_step_delta) + check_button_step_x  * (j-1)), check_button_start_y + check_button_step_y
			local RHELCheckButton = "RHELCheckButton3_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j , 3, i, j);
		end
		for j = 5, 8 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (check_button_start_x + (16 * check_button_step_x + 2 * check_button_step_delta) + check_button_step_x  * (j-9)), check_button_start_y - check_button_step_y
			local RHELCheckButton = "RHELCheckButton3_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j , 3, i, j);
		end
		-- All groups radio
		RHEL_GUI.RHEL_MainMenu.healerFrame.All_heals = createAllGroupsButton(RHEL_GUI.RHEL_MainMenu.healerFrame, all_button_start_x, 0, "RHEL_AllGroupsHeal"..i, 1, i)
		RHEL_GUI.RHEL_MainMenu.healerFrame.All_buffs = createAllGroupsButton(RHEL_GUI.RHEL_MainMenu.healerFrame, all_button_start_x + all_button_step_delta, 0, "RHEL_AllGroupsBuff"..i, 2, i)
		RHEL_GUI.RHEL_MainMenu.healerFrame.All_dispells = createAllGroupsButton(RHEL_GUI.RHEL_MainMenu.healerFrame, all_button_start_x + 2 * all_button_step_delta, 0, "RHEL_AllGroupsDisp"..i, 3, i)

		-- Wisp Button
		local wisp_button = "wisp_button"..i
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_wisp_button = CreateFrame("Button", wisp_button, RHEL_GUI.RHEL_MainMenu.healerFrame, "UIPanelButtonTemplate");
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_wisp_button:SetText(i);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_wisp_button:SetSize(button_size_x,button_size_y);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_wisp_button:SetPoint(button_region, "RHEL_healerFrame"..i, button_start_x, button_start_y);
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_wisp_button:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				RHEL_HealerWisper(i);
			end
		end);
	end

	-- Anounce generator
	function createAnouncebutton(parent, x_loc, y_loc, name, text)
		local anouncebutton = CreateFrame("Button", name, parent, "UIPanelButtonTemplate");
		anouncebutton:SetPoint(anounce_region, x_loc, y_loc);
		anouncebutton:SetSize(anounce_size_x, anounce_size_y)
		getglobal(anouncebutton:GetName() .. 'Text'):SetText(text);
		anouncebutton:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				if self:GetName() == "RHEL_HealAnounce" then
					RHEL_HealAnounce();
				elseif self:GetName() == "RHEL_BuffAnounce" then
					RHEL_BuffAnounce()
				elseif self:GetName() == "RHEL_DispellAnounce" then
					RHEL_DispellAnounce()
				else
					RHEL.Report("Anounce error", true)
				end
			end
		end);
		return anouncebutton;
	end

	RHEL_GUI.RHEL_MainMenu.RHEL_HealButton = createAnouncebutton(RHEL_GUI.RHEL_MainMenu, anounce_start_x, anounce_start_y, "RHEL_HealAnounce", "Heals anounce")
	RHEL_GUI.RHEL_MainMenu.RHEL_BuffButton = createAnouncebutton(RHEL_GUI.RHEL_MainMenu, anounce_start_x + anounce_delta, anounce_start_y, "RHEL_BuffAnounce", "Buffs anounce")
	RHEL_GUI.RHEL_MainMenu.RHEL_DispellButton = createAnouncebutton(RHEL_GUI.RHEL_MainMenu, anounce_start_x + anounce_delta + 4 * check_button_step_x + check_button_step_delta, anounce_start_y, "RHEL_DispellAnounce", "Dispells anounce")

	-- ToChannel generator
	function createTochannelbutton(parent, x_loc, y_loc, name, text, selection)
		local tochannelbutton = CreateFrame("CheckButton", name, parent, "UIRadioButtonTemplate");
		tochannelbutton:SetPoint(to_channel_region, x_loc, y_loc);
		tochannelbutton:SetSize(to_channel_size, to_channel_size)
		getglobal(tochannelbutton:GetName() .. 'Text'):SetText(text);
		if selection then
			tochannelbutton:SetChecked(selection);
		end
		tochannelbutton:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				RHEL_SwapAnounceTo(self);
			end
		end);
		local tochannelbuttonfont=tochannelbutton:CreateFontString(tochannelbutton, "OVERLAY", "GameFontNormal")
		tochannelbuttonfont:SetPoint("TOPLEFT", 20, 0)
		tochannelbuttonfont:SetSize(to_channel_font_size_x, to_channel_font_size_y)
		return tochannelbutton;
	end

	RHEL_GUI.RHEL_MainMenu.RHELtoChannel = createTochannelbutton(RHEL_GUI.RHEL_MainMenu, to_channel_start_x, to_channel_start_y, 'to_Channel', 'To Сhannel', true)
	RHEL_GUI.RHEL_MainMenu.RHELtoRaid = createTochannelbutton(RHEL_GUI.RHEL_MainMenu, to_channel_start_x, to_channel_start_y + to_channel_delta, 'to_Raid', 'To Raid', false)
	RHEL_GUI.RHEL_MainMenu.RHELRaidWarning = createTochannelbutton(RHEL_GUI.RHEL_MainMenu, to_channel_start_x, to_channel_start_y + 2 * to_channel_delta, 'RaidWarning', 'Raid warning', false)

	--ToChannel EditBox 
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber = CreateFrame("EditBox", "ChannelNumber", RHEL_GUI.RHEL_MainMenu, "InputBoxTemplate");
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetMaxLetters(2);
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetNumeric(true);
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetAutoFocus(false);
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetSize(channel_editbox_size_x, channel_editbox_size_y);
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetPoint(channel_editbox_region, channel_editbox_start_x, channel_editbox_start_y);
	local RHEL_ChannelEditBoxFont = RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber, "OVERLAY", "GameFontNormal")
	RHEL_ChannelEditBoxFont:SetPoint("TOPLEFT", -18, -10)
	RHEL_ChannelEditBoxFont:SetSize(channel_editbox_size_x,channel_editbox_size_x)
	RHEL_ChannelEditBoxFont:SetText("/");
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetScript("OnEscapePressed", function(self)
			self:ClearFocus();
		end);
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetScript("OnTextChanged", function(self)
			RHEL_ChannelChange();
		end);																															
	RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetScript("OnTabPressed", function(self)
			HealerName1:SetFocus();
		end);

	RHEL_GUI.RHEL_MainMenu:Show()

	-- Boss note frame
	RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow = CreateFrame("Frame", "BossNoteWindow", RHEL_GUI.RHEL_MainMenu);
	RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow:SetBackdrop(RHEL_GUI.RHEL_Backdrop);
	RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow:SetSize(boss_note_size_x, boss_note_size_y);
	RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow:SetPoint(boss_note_region, boss_note_start_x, boss_note_start_y);

	-- Boss note editbox
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox = CreateFrame("EditBox", "BossNoteEditBox", RHEL_GUI.RHEL_MainMenu);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetPoint("TOP", RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow, "TOP", 0, 0);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetPoint("BOTTOM", RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow, "BOTTOM", 0, 0);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetSize(boss_note_size_x, boss_note_size_y);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetTextInsets(8, 9, 9, 8);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetMaxLetters(230);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetMultiLine(true);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetSpacing(1);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:EnableMouse(true);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetFrameStrata("HIGH");
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetAutoFocus(false);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetFont("Interface\\AddOns\\RHEL\\fonts\\Arial.TTF", 10, "OUTLINE, MONOCHROME")
	--RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE, MONOCHROME")
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetScript("OnEscapePressed", function(self)
		self:ClearFocus();    
	end);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetScript("OnEnterPressed", function(self)
		self:ClearFocus();    
	end);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetScript("OnTabPressed", function(self)
		self:ClearFocus();
	end);
	RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetScript("OnTextChanged", function(self)
			RHEL_ownTips[RHEL_Boss] = true
			RHEL_BossNote[RHEL_Raid][RHEL_Boss] = RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:GetText(); -- TO DO	    
	end);
	-- Note button
	RHEL_GUI.RHEL_MainMenu.BossNoteButton = CreateFrame("Button", "RHEL_BossNoteButton", RHEL_GUI.RHEL_MainMenu, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_MainMenu.BossNoteButton:SetSize(40, 30);
	RHEL_GUI.RHEL_MainMenu.BossNoteButton:SetPoint("TOPRIGHT", RHEL_GUI.RHEL_MainMenu, -20, -20);
	RHEL_GUI.RHEL_MainMenu.BossNoteButton:SetText("Note");
	RHEL_GUI.RHEL_MainMenu.BossNoteButton:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			RHEL.SendMessage(RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:GetText())
		end
	end);
	RHEL_MainMenu:Hide();
end

function mini_menu()
	-- Mini menu pozition
	local mini_menu_start_x, mini_menu_start_y, mini_menu_region = 0, 90, "LEFT"
	local mini_menu_size_x, mini_menu_size_y = 180, 25

	-- Mini window frame
	RHEL_GUI.RHEL_Mini = CreateFrame("Frame", "RHEL_Mini", UIParent);
	RHEL_GUI.RHEL_Mini.MiniFont = RHEL_GUI.RHEL_Mini:CreateFontString(RHEL_GUI.RHEL_Mini, "OVERLAY", "GameFontNormalSmall");
	RHEL_GUI.RHEL_Mini.MiniFont:SetPoint("LEFT", 8, 0);
	RHEL_GUI.RHEL_Mini.MiniFont:SetTextColor(1, 0.8196079, 0)	
	if RHEL_Raid then
		RHEL_GUI.RHEL_Mini.MiniFont:SetText(RHEL_Raid);
	end	
	-- RHEL_GUI.RHEL_Mini:SetBackdrop(RHEL_GUI.RHEL_Backdrop2);
	RHEL_GUI.RHEL_Mini.RHEL_MiniCloseButton = CreateFrame( "Button", "RHEL_MiniCloseButton", RHEL_GUI.RHEL_Mini, "UIPanelCloseButton");
	RHEL_GUI.RHEL_Mini.RHEL_MiniCloseButton:SetPoint("TOPRIGHT", RHEL_Mini, 3, 3);
	RHEL_GUI.RHEL_Mini.RHEL_MainButton = CreateFrame("Button", "RHEL_MainButton", RHEL_GUI.RHEL_Mini, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_MainButton:SetSize(20, 19);
	RHEL_GUI.RHEL_Mini.RHEL_MainButton:SetPoint("RIGHT", RHEL_Mini, -24, 0);
	RHEL_GUI.RHEL_Mini.RHEL_MainButton:SetText("#");
	RHEL_GUI.RHEL_Mini.RHEL_MainButton:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			if not RHEL_MainMenu:IsVisible() then
				RHEL_MainMenu:Show()
			elseif RHEL_MainMenu:IsVisible() then
				RHEL_MainMenu:Hide()
			else
				RHEL.Report("Show main from mini frame problem", true)
			end
		end
	end);
	RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton = CreateFrame("Button", "RHEL_MiniMizeButton", RHEL_GUI.RHEL_Mini, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetSize(20, 19);
	RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetPoint("RIGHT", RHEL_Mini, -44, 0);
	RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetText("_");
	RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			if not RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:IsVisible() then
				RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Show();
				RHEL_GUI.RHEL_Mini.RHEL_Info:Hide();
			elseif RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:IsVisible() then
				RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Hide();
			else
				RHEL.Report("Show offspring frame problem", true)
			end
		end
	end);
	RHEL_GUI.RHEL_Mini.RHEL_HelpButton = CreateFrame("Button", "RHEL_HelpButton", RHEL_GUI.RHEL_Mini, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_HelpButton:SetSize(20, 19);
	RHEL_GUI.RHEL_Mini.RHEL_HelpButton:SetPoint("RIGHT", RHEL_Mini, -64, 0);
	RHEL_GUI.RHEL_Mini.RHEL_HelpButton:SetText("?");
	RHEL_GUI.RHEL_Mini.RHEL_HelpButton:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			if RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:IsVisible() then
				RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Hide()
			end
			if not RHEL_GUI.RHEL_Mini.RHEL_Info:IsVisible() then
				RHEL_GUI.RHEL_Mini.RHEL_Info:Show()
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:Hide();
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:Show();
			else
				RHEL_GUI.RHEL_Mini.RHEL_Info:Hide()
			end
		end
	end);
	RHEL_GUI.RHEL_Mini:SetSize(mini_menu_size_x, mini_menu_size_y);
	RHEL_GUI.RHEL_Mini:SetMovable(true);
	RHEL_GUI.RHEL_Mini:EnableMouse(true);
	RHEL_GUI.RHEL_Mini:SetToplevel(true);
	RHEL_GUI.RHEL_Mini:SetPoint(mini_menu_region, mini_menu_start_x, mini_menu_start_y);
	RHEL_GUI.RHEL_Mini:SetBackdrop(RHEL_GUI.RHEL_Backdrop2);


	-- Mini dropdown pozition
	local mini_dropdown_size_x, mini_dropdown_size_y = 188, 25
	local mini_dropdown_start_x, mini_dropdown_start_y, mini_dropdown_region = -14, -24, "TOP"
	-- Mini buttons
	local mini_anounce_start_x, mini_anounce_start_y, mini_anounce_region = -54, 2, "BOTTOM"
	local mini_anounce_size_x, mini_anounce_size_y = 50, 20
	local mini_anounce_delta = 58
	-- Mini healer frame
	local mini_healer_frame_size_x, mini_healer_frame_size_y = 180, 21
	local mini_healer_frame_start_x, mini_healer_frame_start_y, mini_healer_region = 0, 50, "TOP"
	local mini_healer_frame_delta = 21
	-- Mini wisp_button
	local mini_button_size_x, mini_button_size_y = 30, 20
	local mini_button_region, mini_button_start_x, mini_button_start_y = "RIGHT", -5, 0
	-- Mini offspring frame
	local mini_offspring_size_x, mini_offspring_size_y = 180, mini_healer_frame_delta * RHEL_Total + mini_button_size_y + 2 * mini_dropdown_size_y
	local mini_offspring_start_x, mini_offspring_start_y, mini_offspring_region = 0, 0, "TOP"
	-- Language dropdown pozition
	local lang_dropdown_size_x, lang_dropdown_size_y = 120, 25
	local lang_dropdown_start_x, lang_dropdown_start_y, lang_dropdown_region = 0, 25, "BOTTOM"

	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame = CreateFrame("Frame", "RHEL_MiniOffspringFrame", RHEL_GUI.RHEL_Mini);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:SetSize(mini_offspring_size_x, mini_offspring_size_y);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:SetBackdrop(RHEL_GUI.RHEL_Backdrop3);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:SetAlpha(0.75);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:SetPoint(mini_offspring_region, mini_offspring_start_x, mini_offspring_start_y);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Hide()

	-- Mini dropdown
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown = CreateFrame("Frame", "RHEL_MiniDropdown", RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, "UIDropDownMenuTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown:SetPoint(mini_dropdown_region, mini_dropdown_start_x, mini_dropdown_start_y);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown:SetSize(mini_dropdown_size_x, mini_dropdown_size_y);
	UIDropDownMenu_SetWidth(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown, 125) 
	--local MiniDropdownFont = RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown, "OVERLAY", "GameFontNormalSmall");	
	--MiniDropdownFont:SetPoint("LEFT", 20, 20);	
	--MiniDropdownFont:SetText("Boss:");	
	UIDropDownMenu_Initialize(RHEL_MiniDropdown, RHEL_BossNameDropdown_OnLoad);

	--Mini info button
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_InfoButton = CreateFrame("Button", "RHEL_InfoButton", RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_InfoButton:SetSize(mini_button_size_x, mini_button_size_y);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_InfoButton:SetPoint("TOPRIGHT", RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, -6, -28);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_InfoButton:SetText("N");
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_InfoButton:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			RHEL.SendMessage(RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:GetText())
		end
	end);

	-- Mini wisp frame
	local MiniHealerFont = {}
	for i = 1, RHEL_Total do
		_G["mini_healer_frame"..i] = CreateFrame("Frame", "mini_healer_frame"..i, RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame);
		_G["mini_healer_frame"..i]:SetSize(mini_healer_frame_size_x, mini_healer_frame_size_y);
	--	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame:SetBackdrop(RHEL_GUI.RHEL_Backdrop3);
		_G["mini_healer_frame"..i]:SetPoint(mini_healer_region, mini_healer_frame_start_x, -(mini_healer_frame_start_y + (mini_healer_frame_delta) * (i-1)));
		_G["mini_healer_frame"..i].MiniHealerFont = _G["mini_healer_frame"..i]:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, "OVERLAY", "GameFontWhite");
	--	_G["mini_healer_frame"..i].MiniHealerFont:SetTextColor(0,0.9,0.9,1)
		_G["mini_healer_frame"..i].MiniHealerFont:SetPoint("LEFT", 10, 0);

	-- Wisp Button
		local mini_wisp_button = "mini_wisp_button"..i
		_G["mini_healer_frame"..i].mini_wisp_button = CreateFrame("Button", mini_wisp_button, RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, "UIPanelButtonTemplate");
		_G["mini_healer_frame"..i].mini_wisp_button:SetText(i);
		_G["mini_healer_frame"..i].mini_wisp_button:SetSize(mini_button_size_x, mini_button_size_y);
		_G["mini_healer_frame"..i].mini_wisp_button:SetPoint(mini_button_region, "mini_healer_frame"..i, mini_button_start_x, mini_button_start_y);
		_G["mini_healer_frame"..i].mini_wisp_button:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				RHEL_HealerWisper(i);
			end
		end);
	end
	
	-- Mini buttons
	-- Anounce generator
	function createMiniAnouncebutton(parent, x_loc, y_loc, name, text)
		local anouncebutton = CreateFrame("Button", name, parent, "UIPanelButtonTemplate");
		anouncebutton:SetPoint(mini_anounce_region, x_loc, y_loc);
		anouncebutton:SetSize(mini_anounce_size_x, mini_anounce_size_y)
		getglobal(anouncebutton:GetName() .. 'Text'):SetText(text);
		anouncebutton:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				if self:GetName() == "MiniHeals" then
					RHEL_HealAnounce();
				elseif self:GetName() == "MiniBuffs" then
					RHEL_BuffAnounce()
				elseif self:GetName() == "MiniDispells" then
					RHEL_DispellAnounce()
				else
					RHEL.Report("Anounce from mini window error", true)
				end
			end
		end);
		return anouncebutton;
	end

	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_HealButton = createMiniAnouncebutton(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, mini_anounce_start_x, mini_anounce_start_y, "MiniHeals", "Heal")
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_BuffButton = createMiniAnouncebutton(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, mini_anounce_start_x + mini_anounce_delta, mini_anounce_start_y, "MiniBuffs", "Buff")
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_DispellButton = createMiniAnouncebutton(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, mini_anounce_start_x + 2 * mini_anounce_delta, mini_anounce_start_y, "MiniDispells", "Disp")
		
	RHEL_GUI.RHEL_Mini:SetScript("OnMouseDown", function(self)
		RHEL_OnMouseDown(self);
	end);
	RHEL_GUI.RHEL_Mini:SetScript("OnMouseUp", function(self)
		RHEL_OnMouseUp(self);
	end);

	-- Info frame
	-- Mini info frame
	local mini_info_size_x, mini_info_size_y = 180, 300
	local mini_info_start_x, mini_info_start_y, mini_info_region = 0, 0, "TOP"
	RHEL_GUI.RHEL_Mini.RHEL_Info = CreateFrame("Frame", "RHEL_Info", RHEL_GUI.RHEL_Mini);
--	PanelTemplates_SetNumTabs(RHEL_GUI.RHEL_Mini.RHEL_Info, 3);
	RHEL_GUI.RHEL_Mini.RHEL_Info:SetSize(mini_info_size_x, mini_info_size_y);
	RHEL_GUI.RHEL_Mini.RHEL_Info:SetBackdrop(RHEL_GUI.RHEL_Backdrop3);
	RHEL_GUI.RHEL_Mini.RHEL_Info:SetAlpha(0.75);
	RHEL_GUI.RHEL_Mini.RHEL_Info:SetPoint("TOP", 0, 0);
	--RHEL_GUI.RHEL_Mini.RHEL_Info.InfoFont = RHEL_GUI.RHEL_Mini.RHEL_Info:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info, "OVERLAY", "GameFontNormalSmall");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.InfoFont:SetPoint("TOP", 0, -10);
	--RHEL_GUI.RHEL_Mini.RHEL_Info.InfoFont:SetTextColor(1, 0.8196079, 0)
	--RHEL_GUI.RHEL_Mini.RHEL_Info.InfoFont:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE, MONOCHROME")	
	--RHEL_GUI.RHEL_Mini.RHEL_Info.InfoFont:SetText("Riad healer easy life")
	-- Tab frame
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame = CreateFrame("Frame", "RHEL_TabFrame", RHEL_GUI.RHEL_Mini.RHEL_Info);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame:SetSize(mini_info_size_x - 6, mini_info_size_y - 54);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame:SetPoint("BOTTOM", 0, 29);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame:SetBackdrop(RHEL_GUI.RHEL_Backdrop);
	-- Help tab
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help = CreateFrame("Frame", "Tab1", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:SetID("1")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:SetPoint("TOPLEFT")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:SetPoint("BOTTOMRIGHT")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font0 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font0:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font0:SetPoint("TOPLEFT", 10, -10);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font0:SetText("Slash commands:")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font1 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font1:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font1:SetPoint("TOPLEFT", 10, -30);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font1:SetText("/rhel - main frame")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font2 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font2:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font2:SetPoint("TOPLEFT", 10, -50);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font2:SetText("/rhel mini - compact frame")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font3 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font3:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font3:SetPoint("TOPLEFT", 10, -70);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font3:SetText("/rhel help - help")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font4 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font4:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font4:SetPoint("TOPLEFT", 10, -90);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font4:SetText("/rhel option - options")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font5 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font5:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font5:SetPoint("CENTER", 0, -40);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font5:SetText("More on site:")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font6 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font6:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font6:SetPoint("CENTER", 0, -60);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font6:SetText("github.com/rfslf/RHEL")
--	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font7 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help, "OVERLAY", "GameFontNormal");
--	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font7:SetTextColor(0,0.9,0.9,1)
--	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font7:SetPoint("CENTER", 0, -80);
--	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help.Font7:SetText("curseforge.com/wow/addons/rhel")
	-- Help tab button
--	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1 = CreateFrame("Button", "Tab1", RHEL_GUI.RHEL_Mini.RHEL_Info, "CharacterFrameTabButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1 = CreateFrame("Button", "Tab1", RHEL_GUI.RHEL_Mini.RHEL_Info, "CharacterFrameTabButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1:SetPoint("LEFT", 0, -135);
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1:SetText("Help");
--  RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1:SetSize ( 120 , 25 );
-- 	PanelTemplates_TabResize(tab, padding, absoluteSize, minWidth, maxWidth, absoluteTextSize)
--	PanelTemplates_TabResize(RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1, nil , 120 , 25 );
--	PanelTemplates_TabResize(RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1, nil, 50, 30, 80);
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab1:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
	--			PanelTemplates_SetTab(RHEL_GUI.RHEL_Mini.RHEL_Info, 1);
--				PanelTemplates_UpdateTabs("RHEL_Help");
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:Hide();
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:Show();
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:Hide();
			end
		end);
	-- Options tab
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option = CreateFrame("Frame", "Tab2", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:SetID("2")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:SetPoint("TOPLEFT")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:SetPoint("BOTTOMRIGHT")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font1 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font1:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font1:SetPoint("TOPLEFT", 10, -10);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font1:SetText("Total healers:")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider = CreateFrame ("Slider", "HealerSlider" , RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OptionsSliderTemplate" );
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:CreateFontString("HealerSliderText", "OVERLAY" , "GameFontNormalSmall");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText:SetPoint("TOP", -55, 10);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText:SetText("6");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText:SetWidth(30);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText2 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:CreateFontString("HealerSliderText", "OVERLAY" , "GameFontNormalSmall");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText2:SetPoint("TOP", -25, 10);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText2:SetText ("8");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText2:SetWidth (30);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText3 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:CreateFontString("HealerSliderText", "OVERLAY" , "GameFontNormalSmall");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText3:SetPoint("TOP", 0, 10);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText3:SetText ("10");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText3:SetWidth (30);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText4 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:CreateFontString("HealerSliderText", "OVERLAY" , "GameFontNormalSmall");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText4:SetPoint("TOP", 25, 10);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText4:SetText ("12");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText4:SetWidth (30);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText5 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:CreateFontString("HealerSliderText", "OVERLAY" , "GameFontNormalSmall");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText5:SetPoint("TOP", 55, 10);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText5:SetText("14");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider.HealerSliderText5:SetWidth(30);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:SetPoint("LEFT", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "CENTER", -70, 70);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:SetMinMaxValues(6, 14);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:SetObeyStepOnDrag(true);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:SetValueStep(1);

	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font2 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font2:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font2:SetPoint("TOPLEFT", 10, -80);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font2:SetText("Additional tanks:")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.AddTank = CreateFrame("CheckButton", "AddTank", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "UICheckButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.AddTank:SetPoint("TOPRIGHT", -10, -74);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.AddTank:SetSize(28,28);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.AddTank:SetChecked(RHEL_Add_Tanks)

	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font3 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font3:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font3:SetPoint("TOPLEFT", 10, -100);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font3:SetText("Dispell for every boss:")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.OwnDispells = CreateFrame("CheckButton", "OwnDispells", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "UICheckButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.OwnDispells:SetPoint("TOPRIGHT", -10, -94);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.OwnDispells:SetSize(28,28);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.OwnDispells:SetChecked(RHEL_OwnDispells)

	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font4 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	--RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font3:SetTextColor(0,0.9,0.9,1)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font4:SetPoint("TOPLEFT", 10, -165);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Font4:SetText("Language for announces:")
	-- Language dropdown
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.RHEL_Lang_Dropdown = CreateFrame("Frame", "RHEL_Lang_Dropdown", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "UIDropDownMenuTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.RHEL_Lang_Dropdown:SetPoint(lang_dropdown_region, lang_dropdown_start_x, lang_dropdown_start_y);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.RHEL_Lang_Dropdown:SetSize(lang_dropdown_size_x, lang_dropdown_size_y);
	UIDropDownMenu_SetWidth(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.RHEL_Lang_Dropdown, 75) 
	UIDropDownMenu_Initialize(RHEL_Lang_Dropdown, RHEL.LangDropdown_OnLoad);

	-- Option tab apply button
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Apply = CreateFrame("Button", "RHEL_MiniMizeButton", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Apply:SetSize(80, 30);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Apply:SetPoint("BOTTOM", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, 0, 90);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Apply:SetText("Reload UI");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.Apply:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			RHEL_Total = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:GetValue();
			RHEL_Add_Tanks = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.AddTank:GetChecked();
			RHEL_OwnDispells = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.OwnDispells:GetChecked();
--			print(RHEL_Total,RHEL_Add_Tanks,RHEL_OwnDispells)
			ReloadUI();
		end
	end);
	-- Option tab button
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab2 = CreateFrame("Button", "Tab2", RHEL_GUI.RHEL_Mini.RHEL_Info, "CharacterFrameTabButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab2:SetText("Options");
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab2:SetPoint("CENTER", 0, -135);
--	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab2:SetWidth(40);
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab2:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
	--			PanelTemplates_SetTab(RHEL_GUI.RHEL_Mini.RHEL_Info, 2);
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:Show();
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:Hide();
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:Hide();
			end
		end);
	
	-- About tab
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About = CreateFrame("Frame", "RHEL_About", RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:SetID("3")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:SetPoint("TOPLEFT")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:SetPoint("BOTTOMRIGHT")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font1 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font1:SetTextColor(RHEL_color.SHAMAN[1], RHEL_color.SHAMAN[2], RHEL_color.SHAMAN[3])
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font1:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE, MONOCHROME")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font1:SetPoint("CENTER", 0, 80);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font1:SetText("RAID")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font2 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font2:SetTextColor(RHEL_color.PRIEST[1], RHEL_color.PRIEST[2], RHEL_color.PRIEST[3])
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font2:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE, MONOCHROME")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font2:SetPoint("CENTER", 0, 60);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font2:SetText("HEALER")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font3 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font3:SetTextColor(RHEL_color.PALADIN[1], RHEL_color.PALADIN[2], RHEL_color.PALADIN[3])
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font3:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE, MONOCHROME")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font3:SetPoint("CENTER", 0, 40);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font3:SetText("EASY")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font4 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font4:SetTextColor(RHEL_color.DRUID[1], RHEL_color.DRUID[2], RHEL_color.DRUID[3])
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font4:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE, MONOCHROME")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font4:SetPoint("CENTER", 0, 20);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font4:SetText("LIFE")
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font5 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
--	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font5:SetTextColor(0.9,0.5,0.9,0.6)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font5:SetPoint("CENTER", 0, -20);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font5:SetText("Author: ".. RHEL_Author)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font6 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
--	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font6:SetTextColor(0.9,0.5,0.9,0.6)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font6:SetPoint("CENTER", 0, -35);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font6:SetText("Version: ".. RHEL_Version)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font7 = RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option, "OVERLAY", "GameFontNormal");
--	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font7:SetTextColor(0.9,0.5,0.9,0.6)
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font7:SetPoint("CENTER", 0, -50);
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About.Font7:SetText("Date: ".. RHEL_Date)
	-- About tab button
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab3 = CreateFrame("Button", "Tab3", RHEL_GUI.RHEL_Mini.RHEL_Info, "CharacterFrameTabButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab3:SetText("About");
--	PanelTemplates_TabResize(RHEL_GUI.RHEL_Mini.RHEL_Info.Tab3, nil , 20 , 25);
--	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab3:SetWidth(35);
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab3:SetPoint("RIGHT", 0, -135);
	RHEL_GUI.RHEL_Mini.RHEL_Info.Tab3:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
--				PanelTemplates_SetTab(RHEL_GUI.RHEL_Mini.RHEL_Info, 3);
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:Show();
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:Hide();
				RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:Hide();
			end
		end);
		
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:Hide();
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:Hide();
	RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:Hide();
	RHEL_GUI.RHEL_Mini.RHEL_Info:Hide()
end

