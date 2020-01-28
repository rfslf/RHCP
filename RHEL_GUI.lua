local total_healers = 8
RHEL_Add_Tanks = true
local tanks = {"MT", "OT", "T3", "T4", "A", "B", "C", "D"}
-- Healer frame pozitions
local tank_frame = 40
local healer_frame_start_x, healer_frame_start_y, healer_frame_finish_y, healer_frame_region = 10, -70 - tank_frame, 10, "TOPLEFT"
local healer_frame_x, healer_frame_y = 780, 50
local healer_frame_delta = -3
-- CheckButton pozitions
local check_button_start_x, check_button_start_y, check_button_start_region = 180, 0, "LEFT"
local check_button_step_x, check_button_step_y = 32, 8
local check_button_step_delta = 16
local check_button_size = 22
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
local raid_name_dropdown_start_x, raid_name_dropdown_start_y, raid_name_dropdown_region = 15, -20, "TOPLEFT"
local raid_name_dropdown_delta = 130
-- Warning checkbox
local warning_check_size_x, warning_check_size_y = 25, 25
local warning_check_start_x, warning_check_start_y, warning_check_region = 30, -44, "TOPLEFT"
-- BossNote Window
local boss_note_size_x, boss_note_size_y = 140, 60
local boss_note_start_x, boss_note_start_y, boss_note_region = -200, -20, "RIGHT"
-- Main menu pozition
local main_menu_start_x, main_menu_start_y, main_menu_region = 0, 0, "CENTER"
local main_menu_x, main_menu_y = healer_frame_start_x * 2 + healer_frame_x, abs(healer_frame_start_y) + total_healers * (healer_frame_y + abs(healer_frame_delta)) + tank_frame + healer_frame_finish_y

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
RHEL_Loaded();
RHEL_GUI.RHEL_MainMenu:SetScript("OnMouseDown", function(self)
	RHEL_OnMouseDown(self);
end);
RHEL_GUI.RHEL_MainMenu:SetScript("OnMouseUp", function(self)
	RHEL_OnMouseUp(self);
end);

-- Raid dropdown
RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown = CreateFrame("Frame", "RaidNameDropdown", RHEL_GUI.RHEL_MainMenu, "UIDropDownMenuTemplate");
RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown:SetPoint(raid_name_dropdown_region, raid_name_dropdown_start_x, raid_name_dropdown_start_y);
local RaidNameDropdownFont = RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_RaidNameDropdown, "OVERLAY", "GameFontNormalSmall");		
RaidNameDropdownFont:SetPoint("TOPRIGHT", 65, 10);	
RaidNameDropdownFont:SetText("Raid Name");	
UIDropDownMenu_Initialize(RaidNameDropdown, RHEL_RaidNameDropdown_OnLoad);

-- Boss dropdown
RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown = CreateFrame("Frame", "BossNameDropdown", RHEL_GUI.RHEL_MainMenu, "UIDropDownMenuTemplate");
RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown:SetPoint(raid_name_dropdown_region, raid_name_dropdown_start_x + raid_name_dropdown_delta, raid_name_dropdown_start_y);
local BossNameDropdownFont = RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_BossNameDropdown, "OVERLAY", "GameFontNormalSmall");		
BossNameDropdownFont:SetPoint("TOPRIGHT", 65, 10);	
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

for i = 1, total_healers do	
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
		if i == total_healers then
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
				RHEL_print("Anounce error", true)
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

--[[
-- Boss note frame
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow = CreateFrame("Frame", "BossNoteWindow", RHEL_GUI.RHEL_MainMenu);
RHEL_GUI.RHEL_MainMenu.BossNoteWindow:SetBackdrop(RHEL_GUI.RHEL_Backdrop);
RHEL_GUI.RHEL_MainMenu.BossNoteWindow:SetSize(boss_note_size_x, boss_note_size_y);
RHEL_GUI.RHEL_MainMenu.BossNoteWindow:SetPoint(boss_note_region, boss_note_start_x, boss_note_start_y);
]]--
--[[
-- Boss note editbox
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox = CreateFrame("EditBox", "BossNoteEditBox", RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetPoint("TOP", RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow, "TOP", 0, 0);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetPoint("BOTTOM", RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow, "BOTTOM", 0, 0);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetSize(boss_note_size_x, boss_note_size_y);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetTextInsets(8, 9, 9, 8);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetMaxLetters(255);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetMultiLine(true);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetSpacing(1);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:EnableMouse(true);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetFrameStrata("HIGH");
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetText("hello!")
]]--
--[[
-- Title for BossNote
local BossNoteTitle = RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox, "OVERLAY", "GameFontNormalSmall");
BossNoteTitle:SetPoint("BOTTOMLEFT", BossNoteWindow, "TOPLEFT", 5, 0);
BossNoteTitle:SetText("Boss Note:");
BossNoteTitle:SetJustifyH("LEFT");
BossNoteTitle:SetWidth(120);
BossNoteTitle:SetWordWrap(false);
]]--
--[[
-- Edit Note
BossnoteFontString2 = BossNoteWindow:CreateFontString("BossnoteFontString2", "OVERLAY", "GameFontWhiteTiny");
BossnoteFontString2:SetPoint("TOPLEFT", BossPlayerOfficerNoteWindow, 8, -7);
BossnoteFontString2:SetWordWrap(true);
BossnoteFontString2:SetSpacing(1);
BossnoteFontString2:SetWidth(108);
BossnoteFontString2:SetJustifyH("LEFT");
BossnoteFontString2:SetMaxLines(3);
]]--

-- Mini dropdown pozition
local mini_dropdown_size_x, mini_dropdown_size_y = 160, 25
local mini_dropdown_start_x, mini_dropdown_start_y, mini_dropdown_region = 0, -25, "TOP"
-- Mini buttons
local mini_anounce_start_x, mini_anounce_start_y, mini_anounce_region = -50, 6, "BOTTOM"
local mini_anounce_size_x, mini_anounce_size_y = 50, 30
local mini_anounce_delta = 50
-- Mini healer frame
local mini_healer_frame_size_x, mini_healer_frame_size_y = 160, 22
local mini_healer_frame_start_x, mini_healer_frame_start_y, mini_healer_region = 0, 40, "TOP"
local mini_healer_frame_delta = 23
-- Mini wisp_button
local mini_button_size_x, mini_button_size_y = 30, 20
local mini_button_region, mini_button_start_x, mini_button_start_y = "RIGHT", -5, 0
-- Mini menu pozition
local mini_menu_start_x, mini_menu_start_y, mini_menu_region = 0, 0, "LEFT"
local mini_menu_size_x, mini_menu_size_y = 160, 20
-- Mini offspring frame
local mini_offspring_size_x, mini_offspring_size_y = 160, mini_healer_frame_delta * total_healers + mini_button_size_y + 2 * mini_dropdown_size_y
local mini_offspring_start_x, mini_offspring_start_y, mini_offspring_region = 0, 0, "BOTTOM"

-- Mini window frame
RHEL_GUI.RHEL_Mini = CreateFrame("Frame", "RHEL_Mini", UIParent);
-- RHEL_GUI.RHEL_Mini:SetBackdrop(RHEL_GUI.RHEL_Backdrop2);
RHEL_GUI.RHEL_Mini.RHEL_MiniCloseButton = CreateFrame( "Button", "RHEL_MiniCloseButton", RHEL_GUI.RHEL_Mini, "UIPanelCloseButton");
RHEL_GUI.RHEL_Mini.RHEL_MiniCloseButton:SetPoint("TOPRIGHT", RHEL_Mini, 3, 3);
RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton = CreateFrame("Button", "RHEL_MiniMizeButton", RHEL_GUI.RHEL_Mini, "UIPanelButtonTemplate");
RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetSize(20, 10);
RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetPoint("TOPRIGHT", RHEL_Mini, 10, 3);
RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetText("_");
RHEL_GUI.RHEL_Mini.RHEL_MiniMizeButton:SetScript("OnClick", function(self, button)
	if button == "LeftButton" then
		if not RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:IsVisible() then
			RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Show()
		elseif RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:IsVisible() then
			RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Hide()
		else
			RHEL_print("Show offspring frame problem", true)
		end
	end);
RHEL_GUI.RHEL_Mini:SetSize(mini_menu_size_x, mini_menu_size_y);
RHEL_GUI.RHEL_Mini:SetMovable(true);
RHEL_GUI.RHEL_Mini:EnableMouse(true);
RHEL_GUI.RHEL_Mini:SetToplevel(true);
RHEL_GUI.RHEL_Mini:SetPoint(mini_menu_region, mini_menu_start_x, mini_menu_start_y);
RHEL_GUI.RHEL_Mini:SetBackdrop(RHEL_GUI.RHEL_Backdrop2);
-- Mini offspring frame
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame = CreateFrame("Frame", "RHEL_MiniOffspringFrame", RHEL_GUI.RHEL_Mini);
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:SetSize(mini_offspring_size_x, mini_offspring_size_y);
-- RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:SetBackdrop(RHEL_GUI.RHEL_Backdrop3);
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:SetPoint(mini_offspring_region, mini_offspring_start_x, mini_menu_offspring_y);
local MiniOffspringFont = RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, "OVERLAY", "GameFontNormalSmall");
MiniOffspringFont:SetPoint("LEFT", 0, 0);	
MiniOffspringFont:SetText(RHEL_Boss);	

-- Mini dropdown
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown = CreateFrame("Frame", "RHEL_MiniDropdown", RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, "UIDropDownMenuTemplate");
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown:SetPoint(raid_name_dropdown_region, mini_dropdown_start_x, mini_dropdown_start_y);
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown:SetSize(mini_dropdown_size_x, mini_dropdown_size_y);
local MiniDropdownFont = RHEL_GUI.RHEL_Mini.RHEL_MiniDropdown:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown, "OVERLAY", "GameFontNormalSmall");	
MiniDropdownFont:SetPoint("LEFT", 10, 10);	
MiniDropdownFont:SetText("Boss:");	
UIDropDownMenu_Initialize(RHEL_MiniDropdown, RHEL_BossNameDropdown_OnLoad);

-- Mini wisp frame
for i = 1, total_healers do
	local mini_healer_frame = "mini_healer_frame"..i
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame = CreateFrame("Frame", "mini_healer_frame"..i, RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame:SetSize(mini_healer_frame_size_x, mini_healer_frame_size_y);
--	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame:SetBackdrop(RHEL_GUI.RHEL_Backdrop3);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame:SetPoint(mini_healer_region, mini_healer_frame_start_x, -(mini_healer_frame_start_y + (mini_healer_frame_delta) * (i-1)));
	local MiniHealerFont = RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame:CreateFontString(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame, "OVERLAY", "GameFontWhite");
	MiniHealerFont:SetPoint("LEFT", 10, 0);	
	MiniHealerFont:SetText(_G["HealerClass"..i]:GetText());
	
-- Wisp Button
	local mini_wisp_button = "mini_wisp_button"..i
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame.mini_wisp_button = CreateFrame("Button", mini_wisp_button, RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame.mini_wisp_button:SetText(i);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame.mini_wisp_button:SetSize(mini_button_size_x, mini_button_size_y);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame.mini_wisp_button:SetPoint(mini_button_region, "mini_healer_frame"..i, mini_button_start_x, mini_button_start_y);
	RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.mini_healer_frame.mini_wisp_button:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			RHEL_HealerWisper(i);
		end
	end);
end
	
-- Mini buttons
-- Anounce generator
function createAnouncebutton(parent, x_loc, y_loc, name, text)
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
				RHEL_print("Mini anounce error", true)
			end
		end
	end);
	return anouncebutton;
end

RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_HealButton = createAnouncebutton(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, mini_anounce_start_x, mini_anounce_start_y, "MiniHeals", "Heal")
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_BuffButton = createAnouncebutton(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, mini_anounce_start_x + mini_anounce_delta, mini_anounce_start_y, "MiniBuffs", "Buff")
RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_DispellButton = createAnouncebutton(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame, mini_anounce_start_x + 2 * mini_anounce_delta, mini_anounce_start_y, "MiniDispells", "Disp")
		
RHEL_GUI.RHEL_Mini:SetScript("OnMouseDown", function(self)
	RHEL_OnMouseDown(self);
end);
RHEL_GUI.RHEL_Mini:SetScript("OnMouseUp", function(self)
	RHEL_OnMouseUp(self);
end);
