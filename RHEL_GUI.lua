local MainMenu_x, MainMenu_y = 1000, 760
local totalHealers = 8
local additionalTanks = true
--local totalTanks = 4 + 4 * additionalTargets
local checkbuttonSize = 10
local healerFrame_x = 100
local healerFrame_y = 200
local healerFrame_delta = 5
local CheckButton_Start_x = 10
local CheckButton_Start_y = -25
local CheckButton_Step_x = 20
local CheckButton_Step_y = -20
local CheckButton_Step_delta = -5

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

RHEL_GUI.RHEL_MainMenu = CreateFrame("Frame", "RHEL_MainMenu", UIParent, "TranslucentFrameTemplate");
RHEL_GUI.RHEL_MainMenu.RHEL_MainMenuCloseButton = CreateFrame( "Button" , "RHEL_MainMenuCloseButton" , RHEL_GUI.RHEL_MainMenu , "UIPanelCloseButton");

RHEL_GUI.RHEL_MainMenu:SetSize(MainMenu_x, MainMenu_y);
RHEL_GUI.RHEL_MainMenu:SetMovable(true);
RHEL_GUI.RHEL_MainMenu:EnableMouse(true);
RHEL_GUI.RHEL_MainMenu:SetBackdrop(RHEL_GUI.noteBackdrop);

-- Checkbox generator
function createCheckbutton(parent, x_loc, y_loc, displayname)
	local checkbutton = CreateFrame("CheckButton", displayname, parent, "UICheckButtonTemplate");
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
	checkbutton:SetSize(checkbuttonSize,checkbuttonSize)
	getglobal(checkbutton:GetName() .. 'Text'):SetText(displayname);
	checkbutton:SetScript("OnClick", nil)
	local checkbuttonfont=checkbutton:CreateFontString(checkbutton, "OVERLAY", "GameFontNormal")
	checkbuttonfont:SetPoint("TOPLEFT", -10, 0)
	checkbuttonfont:SetSize(checkbuttonSize,checkbuttonSize)
	return checkbutton;
end

for i = 1, totalHealers do	
	-- Healer frame.
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i] = CreateFrame("Frame", "RHEL_healerFrame"..i, RHEL_MainMenu, "InputBoxTemplate");
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]:SetSize(healerFrame_x, healerFrame_y);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]:SetBackdrop(RHEL_GUI.noteBackdrop);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]:SetPoint("TOPLEFT", 100, -200);
	
	-- Healer EditBox
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBox = CreateFrame("EditBox", "RHEL_healerEditBox"..i, "RHEL_healerFrame"..i);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBox:SetSize(80, 24);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBox:SetPoint("TOPLEFT", 10, -50);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBox:SetScript("OnClick", nil)			
	
	-- Healer EditBox frame
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBoxFrame = CreateFrame("Frame", "RHEL_HealerClass"..i, "RHEL_healerFrame"..i, "InputBoxTemplate");
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBoxFrame:SetSize(24, 24);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBoxFrame.texture = CreateTexture(nil, "Background", RHEL_healerEditBoxFrame)
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_healerEditBoxFrame.texture:SetTexture("Interface\AddOns\RHEL\Icons\Warrior")
	
	-- Heals checkboxes
	for j = 1, 4 do
		local RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y = (RHEL_CheckButton_Start_x + RHEL_CheckButton_Step_x * (j-1)), RHEL_CheckButton_Start_y 
		RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]._G["RHELCheckButton1_"..i.."_"..j] = createCheckbutton("RHEL_healerFrame"..i, RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y, "RHELCheckButton1_"..i.."_"..j);
	end
	for j = 5, 8 do
		local RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y = (RHEL_CheckButton_Start_x + RHEL_CheckButton_Step_x * (j-1)), RHEL_CheckButton_Start_y + RHEL_CheckButton_Step_y
		RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]._G["RHELCheckButton1_"..i.."_"..j] = createCheckbutton("RHEL_healerFrame"..i, RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y, "RHELCheckButton1_"..i.."_"..j);
	end
	for j = 9, 12 do
		local RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y = (RHEL_CheckButton_Start_x + RHEL_CheckButton_Step_x * (j-1)), RHEL_CheckButton_Start_y + 2 * RHEL_CheckButton_Step_y
		RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]._G["RHELCheckButton1_"..i.."_"..j] = createCheckbutton("HEL_healerFrame"..i, RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y, "RHELCheckButton1_"..i.."_"..j);
	end
	if additionalTanks then
		for j = 13, 16 do
			local RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y = (RHEL_CheckButton_Start_x + RHEL_CheckButton_Step_x * (j-1)), RHEL_CheckButton_Start_y + 3 * RHEL_CheckButton_Step_y
			RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]._G["RHELCheckButton1_"..i.."_"..j] = createCheckbutton(RHEL_healerFrame, RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y, "RHELCheckButton1_"..i.."_"..j);
		end
	end
	
	-- Buffs checkboxes
	for j = 1, 8 do
		local RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y = (RHEL_CheckButton_Start_x + RHEL_CheckButton_Step_x * (j-1)), RHEL_CheckButton_Start_y + 4 * RHEL_CheckButton_Step_y + RHEL_CheckButton_Step_delta
		RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i]._G["RHELCheckButton2_"..i.."_"..j] = createCheckbutton(RHEL_healerFrame, RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y, "RHELCheckButton2_"..i.."_"..j);
	end
	
	-- Dispells checkboxes
	for j = 1, 8 do
		local RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y = (RHEL_CheckButton_Start_x + RHEL_CheckButton_Step_x * (j-1)), RHEL_CheckButton_Start_y + 5 * RHEL_CheckButton_Step_y + RHEL_CheckButton_Step_delta
		RHEL_GUI.RHEL_MainMenu.RHEL_healerFrame._G["RHELCheckButton3_"..i.."_"..j] = createCheckbutton(RHEL_healerFrame, RHEL_CheckButton_Poz_x, RHEL_CheckButton_Poz_y, "RHELCheckButton3_"..i.."_"..j);
	end
	
	-- Wisp Button
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_button = CreateFrame("Button", "RHEL_button"..i  , "RHEL_healerFrame"..i, "UIPanelButtonTemplate" );
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_button:SetText(i);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_button:SetSize(80,40);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_button:SetPoint("TOPLEFT", "RHEL_healerFrame"..i, 10, -170);
	RHEL_GUI.RHEL_MainMenu._G["RHEL_healerFrame"..i].RHEL_button:SetScript("OnClick", nil)
	
end



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
