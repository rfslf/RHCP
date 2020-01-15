-- Normal frame translucent
noteBackdrop = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background" ,
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 18,
    insets = { left = 5 , right = 5 , top = 5 , bottom = 5 }
}

-- Thinnner frame translucent template
noteBackdrop2 = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background" ,
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 10,
    insets = { left = 2 , right = 2 , top = 3 , bottom = 1 }
}
-- Clear frame - no translucent background
noteBackdrop3 = {
    bgFile = nil,
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 6,
    insets = { left = 2 , right = 2 , top = 3 , bottom = 1 }
}

--CUSTOM NOTEBOX
-- custom note editbox for some anounces on boss
CustomNoteEditBoxFrame = CreateFrame("Frame", "CustomNoteEditBoxFrame", RHEL_MainFrame);
CustomNoteEditBoxFrame.CustomNoteEditBoxText = CustomNoteEditBoxFrame:CreateFontString("CustomNoteEditBoxText", "OVERLAY", "GameFontNormal");
CustomNoteEditBoxFrame.CustomNoteTextCount = CustomNoteEditBoxFrame:CreateFontString("CustomNoteTextCount", "OVERLAY", "GameFontWhiteTiny");
CustomNoteEditBoxFrame.CustomNoteEditBox = CreateFrame("EditBox", "CustomNoteEditBox", CustomNoteEditBoxFrame);
CustomNoteEditBoxFrame.CustomNoteEditBox:SetAutoFocus(false);
-- custom note scroll frame
CustomNoteEditBoxFrame.CustomNoteScrollFrame = CreateFrame("ScrollFrame", "CustomNoteScrollFrame", CustomNoteEditBoxFrame);
-- custom note slider
CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider = CreateFrame("Slider", "CustomNoteScrollFrameSlider" , CustomNoteEditBoxFrame.CustomNoteScrollFrame , "UIPanelScrollBarTemplate");
CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextUp = CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider:CreateFontString("CustomNoteScrollFrameSliderOverlayTextUp", "OVERLAY");
CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextDown = CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider:CreateFontString("CustomNoteScrollFrameSliderOverlayTextDown", "OVERLAY");
--CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider:Hide();
--custom note window details
CustomNoteEditBoxFrame.CustomNoteTextCount:SetPoint("BOTTOMRIGHT", CustomNoteEditBoxFrame, "TOPRIGHT", -5, 1);
CustomNoteEditBoxFrame.CustomNoteTextCount:Hide();
CustomNoteEditBoxFrame.CustomNoteEditBoxText:SetPoint("BOTTOMLEFT", CustomNoteEditBoxFrame, "TOPLEFT", 5, 0);
CustomNoteEditBoxFrame.CustomNoteEditBoxText:SetText("Custom Notes:");
CustomNoteEditBoxFrame.CustomNoteEditBoxText:SetJustifyH("LEFT");
CustomNoteEditBoxFrame.CustomNoteEditBoxText:SetWidth(123);
CustomNoteEditBoxFrame.CustomNoteEditBoxText:SetWordWrap(false);
CustomNoteEditBoxFrame.CustomNoteEditBox:SetPoint("TOPLEFT", CustomNoteEditBoxFrame, "TOPLEFT", 2, -1.5);
CustomNoteEditBoxFrame.CustomNoteEditBox:SetSize(120, 80);
CustomNoteEditBoxFrame.CustomNoteEditBox:SetTextInsets(7, 7, 6, 6);
CustomNoteEditBoxFrame.CustomNoteEditBox:SetMaxLetters(255);
CustomNoteEditBoxFrame.CustomNoteEditBox:EnableMouse(true);
CustomNoteEditBoxFrame.CustomNoteEditBox:SetMultiLine(true);
CustomNoteEditBoxFrame.CustomNoteEditBox:SetSpacing(1);
CustomNoteEditBoxFrame.CustomNoteEditBox:ClearFocus();
CustomNoteEditBoxFrame.CustomNoteEditBox:SetText("Hello!")

CustomNoteEditBoxFrame:SetBackdrop(noteBackdrop);
CustomNoteEditBoxFrame:SetPoint("TOPLEFT", RHEL_MainFrame, "BOTTOMLEFT", 0, -10);
CustomNoteEditBoxFrame:SetSize(125, 85);
CustomNoteEditBoxFrame:EnableMouse(true);
CustomNoteEditBoxFrame:SetScript("OnMouseDown", function (_, button)
	if button == "LeftButton" then
		CustomNoteEditBoxFrame.CustomNoteEditBox:Show();
		CustomNoteEditBoxFrame.CustomNoteEditBox:SetFocus();
	end
end);
CustomNoteEditBoxFrame.CustomNoteScrollFrame:SetScrollChild(CustomNoteEditBoxFrame.CustomNoteEditBox);
CustomNoteEditBoxFrame.CustomNoteScrollFrame:SetSize(123, 74);
CustomNoteEditBoxFrame.CustomNoteScrollFrame:SetPoint("Bottom", CustomNoteEditBoxFrame, "BOTTOM", 1, 5);
CustomNoteEditBoxFrame.CustomNoteScrollFrame:EnableMouseWheel(true);
CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider:SetOrientation("VERTICAL");
CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider:SetSize(12, 51)
CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider:SetPoint("TOPLEFT", CustomNoteEditBoxFrame, "TOPRIGHT", 2, -17.5);
CustomNoteEditBoxFrame.CustomNoteScrollFrameSlider:SetValue(0);
CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextUp:SetPoint("CENTER", CustomNoteScrollFrameSliderScrollUpButton, 0, 0);
--CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextUp:SetFont([[Interface\AddOns\Guild_Roster_Manager\media\fonts\Arial.TTF]], 12)
CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextUp:SetText ("▲");
CustomNoteScrollFrameSliderScrollUpButton:SetNormalTexture(nil);
CustomNoteScrollFrameSliderScrollUpButton:SetBackdrop(noteBackdrop3);
CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextDown:SetPoint("CENTER", CustomNoteScrollFrameSliderScrollDownButton, 0, 0);
--CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextDown:SetFont([[Interface\AddOns\Guild_Roster_Manager\media\fonts\Arial.TTF]], 12)
CustomNoteEditBoxFrame.CustomNoteScrollFrameSliderOverlayTextDown:SetText("▼");
CustomNoteScrollFrameSliderScrollDownButton:SetNormalTexture(nil);
CustomNoteScrollFrameSliderScrollDownButton:SetBackdrop(noteBackdrop3);
CustomNoteScrollFrameSliderThumbTexture:SetAlpha(0.45);
CustomNoteScrollFrameSliderScrollUpButton:SetSize (14, 12);
CustomNoteScrollFrameSliderScrollDownButton:SetSize(14, 12);
CustomNoteScrollFrameSliderThumbTexture:SetSize(14, 16);

BossNoteWindow = CreateFrame("Frame", "BossNoteWindow", RHEL_MainFrame);
BossNoteEditBox = CreateFrame("EditBox", "BossNoteEditBox", RHEL_MainFrame);

BossNoteTitle = RHEL_MainFrame:CreateFontString("BossNoteTitle", "OVERLAY", "GameFontNormalSmall");
BossNoteTitle:SetPoint("BOTTOMLEFT", BossNoteWindow, "TOPLEFT", 5, 0);
BossNoteTitle:SetText("Boss Note:");
BossNoteTitle:SetJustifyH("LEFT");
BossNoteTitle:SetWidth(120);
BossNoteTitle:SetWordWrap(false);
BossnoteFontString2 = BossNoteWindow:CreateFontString("BossnoteFontString2", "OVERLAY", "GameFontWhiteTiny");

 -- Officer Note
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
BossNoteEditBox:SetText("hello!")


local uniquealyzer = 1;
function createCheckbutton(parent, x_loc, y_loc, displayname)
	uniquealyzer = uniquealyzer + 1;
	
	local checkbutton = CreateFrame("CheckButton", "CheckButton12_2" .. uniquealyzer, parent, "UICheckButtonTemplate");
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
	checkbutton:SetSize(25,25)
	getglobal(checkbutton:GetName() .. 'Text'):SetText(displayname);
	checkbutton:SetScript("OnClick", ClickOnHealCheckBox(2,12))
	local checkbuttonfont:CreateFontString(checkbutton, "OVERLAY", "GameFontNormal")
	checkbuttonfont:SetPoint("TOPLEFT", -20, 0)
	checkbuttonfont:SetSize(25,25)
	return checkbutton;
end

RHELCheckButton = RHEL.createCheckbutton(RHEL_MainFrame, 400, -250 "CheckButton12_13");
			
<CheckButton name="CheckButton12_13" inherits="UICheckButtonTemplate" text="CheckButton12_13">
	<Size>
		<AbsDimension x="25" y="25" />
	</Size>
	<Anchors>
		<Anchor point="TOPLEFT" x="350" y="-245" />
	</Anchors>
	<Layers>
		<Layer level="OVERLAY">
			<FontString inherits="GameFontNormal" text="T4">
				<Size x="25" y="25" />
				<Anchors>
					<Anchor point="TOPLEFT" x="-20" y="0" />
				</Anchors>
			</FontString>
		</Layer>
	</Layers>
	<Scripts>
		<OnClick>
			ClickOnHealCheckBox(2,12);
		</OnClick>
	</Scripts>
</CheckButton>