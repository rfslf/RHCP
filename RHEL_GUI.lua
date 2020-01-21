local MainMenu_x, MainMenu_y = 1024, 512
local totalHealers = 8
local additionalTanks = true
--local totalTanks = 4 + 4 * additionalTargets
local checkbuttonSize = 15
local healerFrame_x = 110
local healerFrame_y = 250
local healerFrame_delta = 7
local CheckButton_Start_x = 6
local CheckButton_Start_y = -65
local CheckButton_Step_x = 23
local CheckButton_Step_y = -20
local CheckButton_Step_delta = -7

RHEL_GUI = {};

RHEL_GUI.noteBackdrop = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background" ,
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 18,
    insets = { left = 5 , right = 5 , top = 5 , bottom = 5 }
}

-- Thinnner frame translucent template
RHEL_GUI.noteBackdrop2 = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background" ,
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
RHEL_GUI.RHEL_MainMenu:SetBackdrop(RHEL_GUI.noteBackdrop);

-- Checkbox generator
function createCheckbutton(parent, x_loc, y_loc, displayname, text)
	local checkbutton = CreateFrame("CheckButton", displayname, parent, "UICheckButtonTemplate");
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
	checkbutton:SetSize(checkbuttonSize,checkbuttonSize)
	getglobal(checkbutton:GetName() .. 'Text'):SetText(text);
	checkbutton:SetScript("OnClick", nil)
	local checkbuttonfont=checkbutton:CreateFontString(checkbutton, "OVERLAY", "GameFontNormal")
	checkbuttonfont:SetPoint("TOPLEFT", -10, 0)
	checkbuttonfont:SetSize(checkbuttonSize,checkbuttonSize)
	return checkbutton;
end

for i = 1, totalHealers do	
	-- Healer frame.
	local healerFrame = "RHEL_healerFrame"..i
	RHEL_GUI.RHEL_MainMenu.healerFrame = CreateFrame("Frame", "RHEL_healerFrame"..i, RHEL_MainMenu);
	RHEL_GUI.RHEL_MainMenu.healerFrame:SetSize(healerFrame_x, healerFrame_y);
	RHEL_GUI.RHEL_MainMenu.healerFrame:SetBackdrop(RHEL_GUI.noteBackdrop);
	RHEL_GUI.RHEL_MainMenu.healerFrame:SetPoint("TOPLEFT", (healerFrame_x * (i-1)  + healerFrame_delta * (i + 1)), -150);
	
	-- Healer EditBox
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox = CreateFrame("EditBox", "RHEL_healerEditBox"..i, RHEL_GUI.RHEL_MainMenu.healerFrame, "InputBoxTemplate");
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetSize(90, 24);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetPoint("TOP", 0, -40);																																	
--	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBox:SetScript("OnClick", nil)			
	
	-- Healer EditBox frame
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame = CreateFrame("Frame", "RHEL_HealerClass"..i, RHEL_GUI.RHEL_MainMenu.healerFrame);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:SetSize(24, 24);
	
	local texture = "texture"..i
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture = RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame:CreateTexture(nil, "Background", RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame, "TranslucentFrameTemplate")
 	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetTexture("Interface\\AddOns\\RHEL\\Icons\\Warrior")
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetPoint("TOPLEFT", RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame, 10, -20);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetWidth ( 24 );
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_healerEditBoxFrame.texture:SetHeight ( 24 );

	-- Heals checkboxes
	for j = 1, 4 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-1)), CheckButton_Start_y
		local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	for j = 5, 8 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-5)), CheckButton_Start_y + CheckButton_Step_y
		local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	for j = 9, 12 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-9)), CheckButton_Start_y + 2 * CheckButton_Step_y
		local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	if additionalTanks then
		for j = 13, 16 do
			local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-13)), CheckButton_Start_y + 3 * CheckButton_Step_y
			local RHELCheckButton = "RHELCheckButton1_"..i.."_"..j
			RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
		end
	end
	
	-- Buffs checkboxes
	for j = 1, 4 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-1)), CheckButton_Start_y + 4 * CheckButton_Step_y + CheckButton_Step_delta
		local RHELCheckButton = "RHELCheckButton2_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	for j = 5, 8 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-5)), CheckButton_Start_y + 5 * CheckButton_Step_y + CheckButton_Step_delta
		local RHELCheckButton = "RHELCheckButton2_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	
	-- Dispells checkboxes
	for j = 1, 4 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-1)), CheckButton_Start_y + 6 * CheckButton_Step_y + 2 * CheckButton_Step_delta
		local RHELCheckButton = "RHELCheckButton3_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	for j = 5, 8 do
		local CheckButton_Poz_x, CheckButton_Poz_y = (CheckButton_Start_x + CheckButton_Step_x * (j-5)), CheckButton_Start_y + 7 * CheckButton_Step_y + 2 * CheckButton_Step_delta
		local RHELCheckButton = "RHELCheckButton3_"..i.."_"..j
		RHEL_GUI.RHEL_MainMenu.healerFrame.RHELCheckButton = createCheckbutton(RHEL_GUI.RHEL_MainMenu.healerFrame, CheckButton_Poz_x, CheckButton_Poz_y, RHELCheckButton, j);
	end
	
	-- Wisp Button
	local wisp_button = "wisp_button"..i
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button = CreateFrame("Button", wisp_button, RHEL_GUI.RHEL_MainMenu.healerFrame, "UIPanelButtonTemplate");
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetText(i);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetSize(60,30);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetPoint("TOPRIGHT", "RHEL_healerFrame"..i, -10, -10);
	RHEL_GUI.RHEL_MainMenu.healerFrame.RHEL_button:SetScript("OnClick", nil)
	
end

RHEL_GUI.RHEL_MainMenu:Show()

--[[BossNoteWindow = CreateFrame("Frame", "BossNoteWindow", RHEL_MainFrame);
BossNoteEditBox = CreateFrame("EditBox", "BossNoteEditBox", RHEL_MainFrame);

BossNoteTitle = RHEL_MainFrame:CreateFontString("BossNoteTitle", "OVERLAY", "GameFontNormalSmall");
BossNoteTitle:SetPoint("BOTTOMLEFT", BossNoteWindow, "TOPLEFT", 5, 0);
BossNoteTitle:SetText("Boss Note:");
BossNoteTitle:SetJustifyH("LEFT");
BossNoteTitle:SetWidth(120);
BossNoteTitle:SetWordWrap(false);
BossnoteFontString2 = BossNoteWindow:CreateFontString("BossnoteFontString2", "OVERLAY", "GameFontWhiteTiny");

 -- Edit Note
BossNoteWindow:SetPoint( "RIGHT" , RHEL_MainFrame , -15 , 10 );
BossnoteFontString2:SetPoint("TOPLEFT", BossPlayerOfficerNoteWindow, 8, -7);
BossnoteFontString2:SetWordWrap(true);
BossnoteFontString2:SetSpacing(1);
BossnoteFontString2:SetWidth(108);
BossnoteFontString2:SetJustifyH("LEFT");
BossnoteFontString2:SetMaxLines(3);
BossNoteWindow:SetBackdrop(noteBackdrop);
BossNoteWindow:SetSize(125,40);
BossNoteEditBox:SetPoint("TOP", BossNoteWindow, "TOP", 0, 0);
BossNoteEditBox:SetPoint("BOTTOM", BossNoteWindow, "BOTTOM", 0, 0);
BossNoteEditBox:SetSize(125,45);
BossNoteEditBox:SetTextInsets(8, 9, 9, 8);
BossNoteEditBox:SetMaxLetters(255);
BossNoteEditBox:SetMultiLine(true);
BossNoteEditBox:SetSpacing (1);
BossNoteEditBox:EnableMouse(true);
BossNoteEditBox:SetFrameStrata("HIGH");
BossNoteEditBox:SetText("hello!") ]]--
