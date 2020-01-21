local totalHealers = 8
local additionalTanks = true
local Tanks = {"MT","OT", "T3", "T4", "A", "B", "C", "D"}
-- Healer frame pozitions
local HealerFrame_Start_x, HealerFrame_Start_y, HealerFrame_Region = 10, -120, "TOPLEFT"
local HealerFrame_x, HealerFrame_y = 900, 60
local HealerFrame_delta = -7
-- CheckButton pozitions
local CheckButton_Start_x, CheckButton_Start_y, CheckButton_Start_Region = 140, 0, "LEFT"
local CheckButton_Step_x, CheckButton_Step_y = 24, 4
local CheckButton_Step_delta = 10
local CheckButton_Size = 18
-- Icon pozition
local Icon_Start_x, Icon_Start_y, Icon_Region = 10, 0, "LEFT"
local Icon_Size = 20
-- EditBox pozition
local EditBox_Start_x, EditBox_Start_y, EditBox_Region = 10, 0, "LEFT"
local EditBox_Size_x, EditBox_Size_y = 90, 20
-- Button pozition
local Button_Start_x, Button_Start_y, Button_Region = -30, 0, "RIGHT"
local Button_Size_x, Button_Size_y = 60, 30
-- Anounce button
local Anounce_Size_x, Anounce_Size_y = 120, 50
local Anounce_Start_x, Anounce_Start_y, Anounce_Region = 250, 70, "BOTTOMLEFT"
local Anounce_delta = 220
-- ToChannel button
local ToChannel_Size_x = 20
local ToChannel_Start_x, ToChannel_Start_y, ToChannel_Region = 50, 70, "BOTTOMLEFT"
local ToChannel_delta = -25
local ToChannelFont_Size_x, ToChannelFont_Size_y = 80, 20
-- Channel EditBox
local ChannelEditBox_Size_x, ChannelEditBox_Size_y = 20, 40
local ChannelEditBox_Start_x, ChannelEditBox_Start_y, ChannelEditBox_Region = 50, 70, "BOTTOMLEFT"
-- Main menu pozition
local MainMenu_Start_x, MainMenu_Start_y, MainMenu_Region = 0, 0, "CENTER"
local MainMenu_x, MainMenu_y = HealerFrame_Start_x * 2 + HealerFrame_x, abs(HealerFrame_Start_y) + totalHealers * (HealerFrame_y + HealerFrame_delta)

RHEL_GUI = {};

RHEL_GUI.noteBackdrop = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 18,
    insets = { left = 5 , right = 5 , top = 5 , bottom = 5 }
}

-- Thinnner frame translucent template
RHEL_GUI.noteBackdrop2 = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 10,
    insets = { left = 2 , right = 2 , top = 3 , bottom = 1 }
}

-- Clear frame - no translucent background
RHEL_GUI.noteBackdrop3 = {
    bgFile = nil,
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 6,
    insets = { left = 2 , right = 2 , top = 3 , bottom = 1 }
}
-- "TranslucentFrameTemplate"
RHEL_GUI.RHEL_MainMenu = CreateFrame("Frame", "RHEL_MainMenu", UIParent);
RHEL_GUI.RHEL_MainMenu.RHEL_MainMenuCloseButton = CreateFrame( "Button", "RHEL_MainMenuCloseButton", RHEL_GUI.RHEL_MainMenu, "UIPanelCloseButton");
RHEL_GUI.RHEL_MainMenu.RHEL_MainMenuCloseButton:SetPoint( "TOPRIGHT", RHEL_MainMenu, 3, 3);
RHEL_GUI.RHEL_MainMenu:SetSize(MainMenu_x, MainMenu_y);
RHEL_GUI.RHEL_MainMenu:SetMovable(true);
RHEL_GUI.RHEL_MainMenu:EnableMouse(true);
RHEL_GUI.RHEL_MainMenu:SetToplevel (true);
RHEL_GUI.RHEL_MainMenu:SetPoint ("CENTER", 0 , 0);
RHEL_GUI.RHEL_MainMenu:SetBackdrop(RHEL_GUI.noteBackdrop2);

-- Checkbox generator
function createCheckbutton(parent, x_loc, y_loc, name, text)
	local checkbutton = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate");
	checkbutton:SetPoint(CheckButton_Start_Region, x_loc, y_loc);
	checkbutton:SetSize(CheckButton_Size, CheckButton_Size)
	getglobal(checkbutton:GetName() .. 'Text'):SetText(text);
	checkbutton:SetScript("OnClick", nil)
	local checkbuttonfont=checkbutton:CreateFontString(checkbutton, "OVERLAY", "GameFontNormal")
	checkbuttonfont:SetPoint("TOPLEFT", -10, 0)
	checkbuttonfont:SetSize(CheckButton_Size,CheckButton_Size)
	return checkbutton;
end

for i = 1, totalHealers do	
	-- Healer frame.
	local healerFrame = "RHEL_healerFrame"..i
	RHEL_GUI.RHEL_MainMenu.healerFrame = CreateFrame("Frame", "RHEL_healerFrame"..i, RHEL_MainMenu);
	RHEL_GUI.RHEL_MainMenu.healerFrame:SetSize(HealerFrame_x, HealerFrame_y);
	RHEL_GUI.RHEL_MainMenu.healerFrame:SetBackdrop(RHEL_GUI.noteBackdrop3);
	RHEL_GUI.RHEL_MainMenu.healerFrame:SetPoint(HealerFrame_Region, HealerFrame_Start_x, HealerFrame_Start_y + (-HealerFrame_y + HealerFrame_delta) * (i-1));
	
	-- Healer EditBox
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox = CreateFrame("EditBox", "RHEL_healerEditBox"..i, RHEL_GUI.RHEL_MainMenu.healerFrame, "InputBoxTemplate");
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetSize(EditBox_Size_x, EditBox_Size_y);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetPoint(EditBox_Region, EditBox_Start_x, EditBox_Start_y);																																	
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetScript("OnEscapePressed", function(self)
		self:ClearFocus();    
    end);			
	
	-- Healer EditBox frame
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame = CreateFrame("Frame", "RHEL_HealerClass"..i, RHEL_GUI.RHEL_MainMenu.healerFrame);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:SetSize(Icon_Size, Icon_Size);
	
	local texture = "texture"..i
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture = RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:CreateTexture(nil, "Background", RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame, "TranslucentFrameTemplate")
 	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetTexture("Interface\\Addons\\RHEL\\Icons\\Warrior")
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetPoint(Icon_Region, RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame, Icon_Start_x, Icon_Start_y);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetWidth(Icon_Size);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetHeight(Icon_Size);

	-- Heals checkboxes
	for j = 1, 8 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-1)), CheckButton_Start_y + CheckButton_Step_y + CheckButton_Size
		local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	for j = 9, 12 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-9)), CheckButton_Start_y - CheckButton_Size
		local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	if additionalTanks then
		for j = 13, 16 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-9)), CheckButton_Start_y - CheckButton_Size
			local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, Tanks[j]);
		end
	end
	
	-- Buffs checkboxes
	for j = 1, 8 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + (CheckButton_Step_x + CheckButton_Step_delta) * (j-1)), CheckButton_Start_y
		local RHELCheckButton = "RHELCheckButton2_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	
	-- Dispells checkboxes
	for j = 1, 8 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + (CheckButton_Step_x + CheckButton_Step_delta) * (j-1)), CheckButton_Start_y
		local RHELCheckButton = "RHELCheckButton3_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	
	-- Wisp Button
	local wisp_button = "wisp_button"..i
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button = CreateFrame("Button", wisp_button, RHEL_GUI.RHEL_MainMenu.healerFrame, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetText(i);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetSize(Button_Size_x,Button_Size_н);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetPoint(Button_Region, "RHEL_healerFrame"..i, Button_Start_x, Button_Start_н);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetScript("OnClick", nil)
	
end

-- Anounce generator
function createAnouncebutton(parent, x_loc, y_loc, name, text)
	local anouncebutton = CreateFrame("Button", name, parent, "UIPanelButtonTemplate");
	anouncebutton:SetPoint(Anounce_Region, x_loc, y_loc);
	anouncebutton:SetSize(Anounce_Size_x, Anounce_Size_y)
	getglobal(anouncebutton:GetName() .. 'Text'):SetText(text);
	anouncebutton:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			_G[self]()
		end
	end);
	return anouncebutton;
end

RHEL_GUI.RHEL_MainMenu.RHEL_HealButton = createAnouncebutton(RHEL_GUI.RHEL_MainMenu, Anounce_Start_x, Anounce_Start_y, "RHEL_HealAnounce", "Heals anounce")
RHEL_GUI.RHEL_MainMenu.RHEL_BuffButton = createAnouncebutton(RHEL_GUI.RHEL_MainMenu, Anounce_Start_x + Anounce_delta, Anounce_Start_y, "RHEL_BuffAnounce", "Buffs anounce")
RHEL_GUI.RHEL_MainMenu.RHEL_DispellButton = createAnouncebutton(RHEL_GUI.RHEL_MainMenu, Anounce_Start_x + 2 * Anounce_delta, Anounce_Start_y, "RHEL_DispellAnounce", "Dispells anounce")

-- ToChannel generator
function createTochannelbutton(parent, x_loc, y_loc, name, text, selection)
	local tochannelbutton = CreateFrame("CheckButton", name, parent, "UIRadioButtonTemplate");
	tochannelbutton:SetPoint(ToChannel_Region, x_loc, y_loc);
	tochannelbutton:SetSize(ToChannel_Size, ToChannel_Size)
	getglobal(tochannelbutton:GetName() .. 'Text'):SetText(text);
	tochannelbutton:SetScript("OnLoad", function(self)
		self:SetChecked(selection);
	end);
	tochannelbutton:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			SwapAnounceTo(self);
		end
	end);
	local tochannelbuttonfont=tochannelbutton:CreateFontString(checkbutton, "OVERLAY", "GameFontNormal")
	tochannelbuttonfont:SetPoint("TOPLEFT", 20, 0)
	tochannelbuttonfont:SetSize(ToChannelFont_Size_x, ToChannelFont_Size_y)
	return tochannelbutton;
end

RHEL_GUI.RHEL_MainMenu.RHELtoChannel = createTochannelbutton(RHEL_GUI.RHEL_MainMenu, ToChannel_Start_x, ToChannel_Start_y, 'toChannel', 'To Сhannel', true)
RHEL_GUI.RHEL_MainMenu.RHELtoRaid = createTochannelbutton(RHEL_GUI.RHEL_MainMenu, ToChannel_Start_x, ToChannel_Start_y + ToChannel_delta, 'toRaid', 'To Raid', true

--ToChannel EditBox 
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber = CreateFrame("EditBox", "ChannelNumber", RHEL_GUI.RHEL_MainMenu, "InputBoxTemplate");
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetMaxLetters(2);
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetNumeric();
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetAutoFocus(false);
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetSize(ChannelEditBox_Size_x, ChannelEditBox_Size_y);
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetPoint(ChannelEditBox_Region, ChannelEditBox_Start_x, ChannelEditBox_Start_y);
local RHEL_ChannelEditBoxFont = RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:CreateFontString(RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber, "OVERLAY", "GameFontNormal")
RHEL_ChannelEditBoxFont:SetPoint("TOPLEFT", -18, -10)
RHEL_ChannelEditBoxFont:SetSize(ChannelEditBox_Size_x,ChannelEditBox_Size_x)
RHEL_ChannelEditBoxFont:SetText("/");
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetScript("OnEscapePressed", function(self)
		Channel_OnEscapePressed();
	end);
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetScript("OnTextChanged", function(self)
		ChannelChange();
	end);																															
RHEL_GUI.RHEL_MainMenu.RHEL_ChannelNumber:SetScript("OnTabPressed", function(self)
		RHEL_healerEditBox1:SetFocus();
	end);

RHEL_GUI.RHEL_MainMenu:Show()

--[[RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow = CreateFrame("Frame", "BossNoteWindow", RHEL_GUI.RHEL_MainMenu);
RHEL_GUI.RHEL_MainMenu.BossNoteWindow:SetBackdrop(RHEL_GUI.noteBackdrop);
RHEL_GUI.RHEL_MainMenu.BossNoteWindow:SetSize(125,40);
RHEL_GUI.RHEL_MainMenu.BossNoteWindow:SetPoint("RIGHT", RHEL_GUI.RHEL_MainMenu, -15, 10);
--]]
--[[
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox = CreateFrame("EditBox", "BossNoteEditBox", RHEL_MainFrame, RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetPoint("TOP", BossNoteWindow, "TOP", 0, 0);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetPoint("BOTTOM", BossNoteWindow, "BOTTOM", 0, 0);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetSize(125,45);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetTextInsets(8, 9, 9, 8);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetMaxLetters(255);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetMultiLine(true);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetSpacing(1);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:EnableMouse(true);
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetFrameStrata("HIGH");
RHEL_GUI.RHEL_MainMenu.RHEL_BossNoteWindow.BossNoteEditBox:SetText("hello!")


BossNoteTitle = RHEL_MainFrame:CreateFontString("BossNoteTitle", "OVERLAY", "GameFontNormalSmall");
BossNoteTitle:SetPoint("BOTTOMLEFT", BossNoteWindow, "TOPLEFT", 5, 0);
BossNoteTitle:SetText("Boss Note:");
BossNoteTitle:SetJustifyH("LEFT");
BossNoteTitle:SetWidth(120);
BossNoteTitle:SetWordWrap(false);
BossnoteFontString2 = BossNoteWindow:CreateFontString("BossnoteFontString2", "OVERLAY", "GameFontWhiteTiny");

 -- Edit Note

BossnoteFontString2:SetPoint("TOPLEFT", BossPlayerOfficerNoteWindow, 8, -7);
BossnoteFontString2:SetWordWrap(true);
BossnoteFontString2:SetSpacing(1);
BossnoteFontString2:SetWidth(108);
BossnoteFontString2:SetJustifyH("LEFT");
BossnoteFontString2:SetMaxLines(3);

 ]]--
