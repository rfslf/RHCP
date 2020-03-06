RHEL_Author = "Virgo-Zenedar"
RHEL_Version = "0.11.0"
RHEL_Date = "02/25/2020"

RHEL = {};

local tanks = {"MT","OT", "T3", "T4", "A", "B", "C", "D"};
local RaidNameList = {"Molten Core","Onyxia&Outdoors","Blackwing Lair","Ahn'Qiraj","Naxxramas", "Custome"};
local dungeons = {["Molten Core"] = "MC", ["Onyxia&Outdoors"] = "Onyxia",
    ["Blackwing Lair"] = "BWL", ["Ahn'Qiraj"] = "AQ", ["Naxxramas"] = "NAX", ["Custome"] = "Custome"};
local BossNameList = {};
BossNameList.MC = {"Trash","Lucifron","Magmadar","Gehennas","Garr","Baron Geddon",
	"Shazzrah","Golemagg","Sulfuron","Majordomo","Ragnaros"};
BossNameList.Onyxia = {"Onyxia","Azuregos","Kazzak"};
BossNameList.BWL = {"Trash","Razorgore","Vaelastrasz","Broodlord","Firemaw",
	"Ebonroc","Flamegor","Chromaggus","Nefarian"};
BossNameList.AQ = {"Trash","The Prophet Skeram", "The Bug Trio", "Battleguard Sartura",
    "Fankriss", "Princess Huhuran", "The Twin Emperors", "Viscidus",
	"Ouro", "C'Thun"};
BossNameList.NAX = {"Trash","Anub'Rekhan","Faerlina","Maexxna",
	"Noth","Heigan the Unclean","Loatheb",
	"Instructor Razuvious","Gothic","The Four Horsemen",
	"Patchwerk","Grobbulus","Gluth","Thaddius","Sapphiron","Kel'Thuzad"};
BossNameList.Custome = {"Frame_1","Frame_2","Frame_3","Frame_4"};

-- Method:          RHEL.Report ( string , boolean )
-- What it Does:    Sends message to default channel
-- Purpose:         Necessary function for report to user
RHEL.Report = function (str, err)
	if not str then return; end;
	if err == nil then
		DEFAULT_CHAT_FRAME:AddMessage("|c006969FFRHEL: " .. tostring(str) .. "|r");
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c006969FFRHEL:|r " .. "|c00FF0000Error|r|c006969FF - " .. tostring(str) .. "|r");
	end
end

local revRaidNameList = {};
for i,v in ipairs(RaidNameList) do
	revRaidNameList[v] = i;
end
local revBossNameList = {};

--Frame starts moving. DONE
function RHEL_OnMouseDown(frame)
	frame:StartMoving();
end

--Frame stops moving. DONE
function RHEL_OnMouseUp(frame)
	frame:StopMovingOrSizing();
end		   

--Add slash command line logic. TO DO
SLASH_RHEL_SLASHCMD1 = '/RHEL'
SLASH_RHEL_SLASHCMD2 = '/rhel'
SlashCmdList["RHEL_SLASHCMD"] = function(input)
    local command;
    if input ~= nil and string.lower(input) ~= nil then
        command = string.lower(input);
	end
	
	if input == nil or input:trim() == "" then
		if RHEL_MainMenu ~= nil and not RHEL_MainMenu:IsVisible() then
			RHEL_MainMenu:Show();
		elseif RHEL_MainMenu ~= nil and RHEL_MainMenu:IsVisible() then
            RHEL_MainMenu:Hide();
		else
			RHEL.Report(RHEL_loc["Main menu frame not ready"], true);
		end
	elseif command == "mini" then
        if RHEL_Mini ~= nil and not RHEL_Mini:IsVisible() then
			RHEL_Mini:Show();
		elseif RRHEL_MiniFrame ~= nil and RHEL_Mini:IsVisible() then
            RHEL_Mini:Hide();
		else
			RHEL.Report(RHEL_loc["Mini menu frame not ready"], true);
		end
	elseif command == "option" then
		RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Hide();
		RHEL_GUI.RHEL_Mini.RHEL_Info:Show();
		RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:Hide();
		RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:Hide();
		RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:Show();
	elseif command == 'help' then
		RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame:Hide();
		RHEL_GUI.RHEL_Mini.RHEL_Info:Show();
		RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Help:Show();
		RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.About:Hide();
		RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option:Hide();
	else
		RHEL.Report(RHEL_loc["Invalid Command. Type '/rhel help'!"], true);
	end
end
-- Method:          RHEL.Loaded ()
-- What it Does:    Send message when addon loaded
-- Purpose:         Greeting user
RHEL.Loaded = function ()
	RHEL.Report(RHEL_loc["LEGEND"] .. RHEL_Version);
end

--Reverse Raid-Boss table. DONE
function RHEL_RaidBossReverse()
	revBossNameList = {};
	for i,v in ipairs(BossNameList[dungeons[RHEL_Raid]]) do
		revBossNameList[v] = i;
    end
end

-- For the first time RHEL_Heals is loaded; initialize heals to defaults. DONE
function RHEL_HealsDefault()
	if RHEL_Heals == nil then
		RHEL_Heals={};
	end
	if RHEL_Heals[RHEL_Raid] == nil then
		RHEL_Heals[RHEL_Raid]={};
	end
	if (RHEL_Heals[RHEL_Raid][RHEL_Boss] == nil) or (table.getn(RHEL_Heals[RHEL_Raid][RHEL_Boss]) < RHEL_Total) then
--		    	 1	   2     3     4     5     6     7     8    MT    OT	T3	  T4    A    B    C     D
		RHEL_Heals[RHEL_Raid][RHEL_Boss] = {
		    {false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,true,true,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false},
			{true,false,true,false,true,false,true,false,false,false,false,false,false,false,false,false},
			{true,false,true,false,true,false,true,false,false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true,false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true,false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}};
--	      	 1	   2    3     4    5     6    7     8    MT    OT	T3	  T4    A    B    C     D					  
	end
end

-- For the first time RHEL_Buffs is loaded; initialize buffs to defaults. DONE
function RHEL_BuffsDefault()
	if RHEL_Buffs == nil then
		RHEL_Buffs={};
	end
	if (RHEL_Buffs[RHEL_Raid] == nil) or (table.getn(RHEL_Buffs[RHEL_Raid]) < RHEL_Total) then
--		      1	     2     3     4     5     6     7     8
		RHEL_Buffs[RHEL_Raid] = {
		    {true,false,true,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,true,false,true,false},
			{false,false,false,false,false,false,false,false},	
			{false,false,false,false,false,false,false,false},
			{false,true,false,true,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,true,false,true},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false}};
--	      		1	  2    3     4     5     6    7     8					  
	end
end

-- For the first time RHEL_Dispells is loaded; initialize dispells to defaults. DONE
function RHEL_DispellsDefault(raid, boss)
	if RHEL_Dispells == nil then
		RHEL_Dispells={};
	end
	if RHEL_Dispells[raid] == nil then
		RHEL_Dispells[raid]={};
	end
	if (RHEL_Dispells[raid][boss] == nil) or (table.getn(RHEL_Dispells[raid][boss]) < RHEL_Total) then
--		      1	     2     3     4     5     6     7     8
		RHEL_Dispells[raid][boss] = {
		    {true,false,true,false,true,false,true,false},
			{false,false,false,false,false,false,false,false},
			{true,false,true,false,true,false,true,false},
			{false,false,false,false,true,false,true,false},
			{false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true},
			{false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false}};
--	      		1	  2    3     4     5     6    7   8					  
	end
end

--Set defaults values to variables. DONE
function RHEL_VariablesDefaultSet()
-- For the first time RHEL_Raid RHEL_Boss is loaded; initialize to defaults.
	if (RHEL_Raid == nil) or (RHEL_Boss == nil) or (dungeons[RHEL_Raid] == nil) then
		RHEL_Raid = RaidNameList[6];
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1];
	else
		RHEL_RaidBossReverse();
		if revBossNameList[RHEL_Boss] == nil then
			RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1];
		end
	end
-- First value for RHEL_Total
	if RHEL_Total == nil then
		RHEL_Total = 10;
	elseif RHEL_Total < 6 then
		RHEL_Total = 8;
	elseif RHEL_Total > 14 then
		RHEL_Total = 12;		
	end
-- First value fot RHEL_Add_Tanks
	if RHEL_Add_Tanks == nil then
		RHEL_Add_Tanks = true;
	end
	if RHEL_Add_Tanks then
		total_tanks = 8;
	else
		total_tanks = 4;
	end
-- First value fot RHEL_OwnDispells	
	if RHEL_OwnDispells == nil then
		RHEL_OwnDispells = false;
	end
-- For first time RHEL_BossNote is loaded. CHECK
	if RHEL_BossNote == nil then
		RHEL_BossNote = {};
	end	
-- For first time RHEL_ownTips is loaded. CHECK
	if RHEL_ownTips == nil then
		RHEL_ownTips = {};
	end
-- For the first time RHEL_Channel is loaded; initialize channel to 5. DONE
	if RHEL_Channel == nil or RHEL_Channel == "" then
		RHEL_Channel = 5;
	end
-- For first time RHEL_Healers is loaded; initialize healers to NameNumber. DONE
	if RHEL_Healers == nil then
		RHEL_Healers = {};
	end
	for i = 1, RHEL_Total do
		if not RHEL_Healers[i] then
			RHEL_Healers[i] = "Name"..i;
		end 
	end
-- For first time RHEL_Tanks is loaded; initialize tanks. DONE
	if RHEL_Tanks == nil then
		RHEL_Tanks = {};
	end
	for i = 1, total_tanks do
		if not RHEL_Tanks[i] then
			RHEL_Tanks[i] = tanks[i];
		end 
	end

	RHEL_HealsDefault();
	RHEL_BuffsDefault();
	RHEL_DispellsDefault(RHEL_Raid, RHEL_Boss);
end

--Load saved Raid&Boss. OPTIMAZE
function RHEL_RaidBossSaved()
	RHEL_RaidBossReverse();
	RHEL_RaidName_OnSelect(revRaidNameList[RHEL_Raid]);
	UIDropDownMenu_SetText(RaidNameDropdown, RHEL_Raid);
	if RHEL_Boss == nil or revBossNameList[RHEL_Boss] == nil then
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1];
	end
	RHEL_BossName_OnSelect(revBossNameList[RHEL_Boss]);
end

-- Method:          RHEL.LangSaved()
-- What it Does:    Load saved language
-- Purpose:         This is for language of announces in raid or via wisper.
RHEL.LangSaved = function()
	if not RHEL_lang or not revLang[RHEL_lang] then
		RHEL_lang = 'English';
--		if RHEL_lang == '1' then
--			UIDropDownMenu_SetText(RHEL_Lang_Dropdown, "English");
--		else
--			UIDropDownMenu_SetText(RHEL_Lang_Dropdown, "Russian");
--		end
	end
	RHEL.LangDropdown_OnSelect(revLang[RHEL_lang])
end

--Healers on load. DONE
function RHEL_HealersLoad()
	for i = 1, RHEL_Total do
		_G['HealerName'..i]:SetText(RHEL_Healers[i]);
		_G["mini_healer_frame"..i].MiniHealerFont:SetText(RHEL_Healers[i]);
		-- TO DO if text color does not changed
		local localizedClass, englishClass, classIndex =  UnitClass(RHEL_Healers[i]);		
		if englishClass then
			_G["mini_healer_frame"..i].MiniHealerFont:SetTextColor(RHEL_color[englishClass][1],RHEL_color[englishClass][2], RHEL_color[englishClass][3]);
		end
	end
end

--Tanks on load. DONE
function RHEL_TanksLoad()
	for i = 1, total_tanks do
		_G['TankName'..i]:SetText(RHEL_Tanks[i]);
	end
end

--Heals checkboxes on load. DONE
local checker
function RHEL_HealsLoad()
--	print("RHEL: Healers load for ",RHEL_Raid,RHEL_Boss)
	for i = 1, RHEL_Total do
		for j = 1, 12 do
			if type(RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]) == "boolean" then
				checker = RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j];
			else
				checker = false;
				RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] = false;
			end
			_G['RHELCheckButton1' .."_".. i .. "_"..j]:SetChecked(checker);
		end
		if additional_tanks then
			for j = 13, 16 do
				if type(RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]) == "boolean" then
					checker = RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j];
				else
					checker = false;
					RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] = false;
				end
				_G['RHELCheckButton1' .."_".. i .. "_"..j]:SetChecked(checker);
			end	
		end
	end
end

--Buffs checkboxes on load. DONE
function RHEL_BuffsLoad()
	for i = 1, RHEL_Total do
		for j = 1, 8 do
			checker = RHEL_Buffs[RHEL_Raid][i][j];
			_G['RHELCheckButton2' .."_".. i .. "_".. j]:SetChecked(checker);
		end
	end
end

--Dispells checkboxes on load. DONE
function RHEL_DispellsLoad()
	RHEL_RaidBossReverse();
	for i = 1, RHEL_Total do
		for j = 1, 8 do
			if RHEL_OwnDispells then
				checker = RHEL_Dispells[RHEL_Raid][RHEL_Boss][i][j];
			else
				RHEL_DispellsDefault(RHEL_Raid, BossNameList[dungeons[RHEL_Raid]][1]);
				checker = RHEL_Dispells[RHEL_Raid][BossNameList[dungeons[RHEL_Raid]][1]][i][j];
			end
			_G['RHELCheckButton3' .."_".. i .. "_"..j]:SetChecked(checker);
		end
	end
end

-- BossNote: load custome or defaults if no RHEL_ownTips[RHEL_Boss]. Check
function RHEL_BossNoteLoad()
	if RHEL_BossNote ~= nil then
		if RHEL_BossNote[RHEL_Raid] ~= nil then
			if RHEL_BossNote[RHEL_Raid][RHEL_Boss] ~= nil then
				if RHEL_ownTips[RHEL_Boss] then
					RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetText(RHEL_BossNote[RHEL_Raid][RHEL_Boss]);
					return;
				end			
			end
		else
			RHEL_BossNote[RHEL_Raid] = {}
		end
	else
		RHEL_BossNote[RHEL_Raid] = {};
	end
--	print(RHEL_loc[RHEL_Boss])
	if RHEL_loc[RHEL_Boss] then
		RHEL_BossNote[RHEL_Raid][RHEL_Boss] = RHEL_loc[RHEL_Boss];
		RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetText(RHEL_loc[RHEL_Boss]);
	else
		RHEL_GUI.RHEL_MainMenu.BossNoteEditBox:SetText(RHEL_Boss);
	end
--	RHEL.Report("No custome note. Load defualts.");
end

function RHEL_ChannelLoad()
	ChannelNumber:SetText(RHEL_Channel);
end

-- Method:          RHEL.SendMessage(string)
-- What it Does:    Send message to raid or channel
-- Purpose:         This is for announces in raid or via wisper.
RHEL.SendMessage = function (msg)
--	if string.len(tostring(msg)) > 255 then
	if #msg > 255 then
		local msg_cut_rev = string.reverse(string.sub(msg, 1, 255));
		local delim, delim_end = string.find(msg_cut_rev, "%]");

		if delim then
			local msg_cut = string.reverse(string.sub(msg_cut_rev, delim));
			RHEL.SendMessage(msg_cut);
			RHEL.SendMessage(string.sub(msg, string.len(tostring(msg_cut)) + 1));
		else
			RHEL.Report(RHEL_loc["Long message, total "] .. #msg .. RHEL_loc[" symbols."], true);
		end
--		RHEL_SendMessage(string.sub(msg, 255))
	else
		if to_Raid:GetChecked() and not to_Channel:GetChecked() then
			SendChatMessage(tostring(msg), "RAID");
		elseif to_Channel:GetChecked() and  not RaidWarning:GetChecked() then
			SendChatMessage(tostring(msg), "CHANNEL", nil, RHEL_Channel);
		elseif RaidWarning:GetChecked() and not to_Raid:GetChecked() then
			SendChatMessage(tostring(msg), "RAID_WARNING");
		else
			RHEL.Report(RHEL_loc['Wrong channel.'], true);
		end
	end
end


-- Anounce part about healings. CHECK
-- Groups: 1, 2, 3... Name, OT.
function RHEL_Healings(position)
	local msg = "";
	if RHEL_Heals[RHEL_Raid][RHEL_Boss][position] then
		msg = RHEL_loc["Groups: "];
		local heal_count = 0;
		for j = 1, 8 do
			if RHEL_Heals[RHEL_Raid][RHEL_Boss][position][j] then
				heal_count = heal_count + 1;
				msg = msg .. j .. ",";
			end
		end
		if heal_count == 0 then
			msg = "";
		elseif heal_count == 8 then
			msg = RHEL_loc["All groups."];
		else
			msg = string.sub(msg, 1, -2)  .. ".";
		end
		heal_count = 0;
		for j = 9, (8 + total_tanks) do
			if RHEL_Heals[RHEL_Raid][RHEL_Boss][position][j] then
				heal_count = heal_count + 1;
				if _G['TankName'..(j-8)]:GetText() == "" then
					msg = msg  .. tanks[j-8] .. ",";
				else
					msg = msg  .. _G['TankName'..(j-8)]:GetText() .. ",";
				end
			end
		end
		if heal_count ~= 0 then
			msg = string.sub(msg, 1, -2);
		end
	end
	return msg
end

-- Anounce part about buffings. CHECK
-- All groups or fallen.
function RHEL_Buffings(position)
	local msg = RHEL_loc["Groups: "];
	local buff_count = 0;
	if RHEL_Buffs[RHEL_Raid][position] then		
		for j = 1, 8 do
			if RHEL_Buffs[RHEL_Raid][position][j] then
				buff_count = buff_count + 1;
				msg = msg .. j .. ",";
			end
		end
	end
	if buff_count == 0 then
		msg = "";
	elseif buff_count == 8 then
		msg = RHEL_loc["All groups or fallen"];
	else
		msg = string.sub(msg, 1, -2);
	end
	return msg
end

-- Anounce part about dispellings. CHECK
-- All groups.
function RHEL_Dispellings(position)
	local msg = RHEL_loc["Groups: "];
	local dispel_count = 0
	if RHEL_OwnDispells then
		if RHEL_Dispells[RHEL_Raid][RHEL_Boss][position] then		
			for j = 1, 8 do
				if RHEL_Dispells[RHEL_Raid][RHEL_Boss][position][j] then
					dispel_count = dispel_count + 1;
					msg = msg .. j .. ",";
				end
			end
		end
	else
		for j = 1, 8 do
			if RHEL_Dispells[RHEL_Raid][BossNameList[dungeons[RHEL_Raid]][1]][position][j] then
				dispel_count = dispel_count + 1;
				msg = msg .. j .. ",";
			end
		end
	end
	if dispel_count == 0 then
		msg = "";
	elseif dispel_count == 8 then
		msg = RHEL_loc["All groups."];
	else
		msg = string.sub(msg, 1, -2);
	end
	return msg
end

--Click on heals anounce. DONE
function RHEL_HealAnounce()
	local anounce = RHEL_Raid .. " - " .. RHEL_Boss .. RHEL_loc[": HEALINGS!"];
	local message1 = "";
	for i = 1, RHEL_Total do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message2 = "[" .. _G['HealerName'..i]:GetText() .. "-";
			local message3 = RHEL_Healings(i);
			if message3 ~= "" then
				message1 = message1 .. message2 .. message3 .. "] ";
			end
		end
	end
	RHEL.SendMessage(anounce);
	RHEL.SendMessage(message1);
end

--Click on buffs anounce. DONE
function RHEL_BuffAnounce()
	local anounce = RHEL_Raid..RHEL_loc[": BUFFS!"];
	local message1 = "";
	for i = 1, RHEL_Total do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message2 = "[" .. _G['HealerName'..i]:GetText() .. "-";
			local message3 = RHEL_Buffings(i);
			if message3 ~= "" then
				message1 = message1 .. message2 .. message3 .. "] "	;
			end
		end
	end
	RHEL.SendMessage(anounce);
	RHEL.SendMessage(message1);
end

--Click on buffs anounce. DONE
function RHEL_DispellAnounce()
	local anounce = RHEL_Raid..": DISPELLS!";
	local message1 = "";
	for i = 1, RHEL_Total do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message2 = "[" .. _G['HealerName'..i]:GetText() .. "-";		
			local message3 = RHEL_Dispellings(i);
			if message3 ~= "" then
				message1 = message1 .. message2 .. message3 .. "] ";
			end
		end
	end
	RHEL.SendMessage(anounce);
	RHEL.SendMessage(message1);
end

--Click on healers personal anounce. DONE
function RHEL_HealerWisper(number)
	local healer = _G['HealerName'..number]:GetText();
	local wisper = healer .. RHEL_loc[" in "] .. RHEL_Raid .. RHEL_loc[" on "] .. RHEL_Boss .. ": ";
	if healer ~= "" then
		if (UnitInRaid(healer) or UnitInParty(healer)) then
			local HealsPart = RHEL_Healings(number);
			if HealsPart ~= '' then
				HealsPart = RHEL_loc["[Heals-"] .. HealsPart .. "] ";
			end
			
			local BuffsPart = RHEL_Buffings(number);
			if BuffsPart ~= '' then		
				BuffsPart = RHEL_loc["[Buffs-"] .. BuffsPart .. "] ";
			end

			local DispellsPart = RHEL_Dispellings(number);
			if DispellsPart ~= '' then		
				DispellsPart = RHEL_loc["[Dispells-"] .. DispellsPart .. "]";
			end

			SendChatMessage(wisper..HealsPart..BuffsPart..DispellsPart, "WHISPER", nil, healer);	
		else
			RHEL.Report(healer .. RHEL_loc[" is not in your raid or party"], true);
		end
	end
end

--Click on heals, buffs, dispells checkbox reaction. DONE
function RHEL_ClickOnCheckBox(role,healer,target)
--	print(RHEL_Raid,RHEL_Boss)
	local isChecked;
    isChecked=_G['RHELCheckButton'..role .. '_' .. healer.. '_'..target]:GetChecked();
	if role == 1 then
		RHEL_Heals[RHEL_Raid][RHEL_Boss][healer][target] = isChecked;
	elseif role == 2 then
		RHEL_Buffs[RHEL_Raid][healer][target] = isChecked;
	elseif role == 3 then
		if RHEL_OwnDispells then
			RHEL_Dispells[RHEL_Raid][RHEL_Boss][healer][target] = isChecked;
		else 
			RHEL_Dispells[RHEL_Raid][BossNameList[dungeons[RHEL_Raid]][1]][healer][target] = isChecked;
		end
	else
		RHEL.Report(RHEL_loc["Click on checkbox with unknown role"], true);
	end
end

--Click on all groups heals, buffs, dispells checkbox reaction. DONE
function RHEL_ClickOnAll(role,healer)
--	print(RHEL_Raid,RHEL_Boss)
	local isChecked;
	for target = 1, 8 do
		if role == 1 then
			isChecked=_G['RHEL_AllGroupsHeal'..healer]:GetChecked();
			_G['RHELCheckButton'..role .. '_' .. healer.. '_'..target]:SetChecked(isChecked);
			RHEL_Heals[RHEL_Raid][RHEL_Boss][healer][target] = isChecked;
		elseif role == 2 then
			isChecked=_G['RHEL_AllGroupsBuff'..healer]:GetChecked();
			_G['RHELCheckButton'..role .. '_' .. healer.. '_'..target]:SetChecked(isChecked);
			RHEL_Buffs[RHEL_Raid][healer][target] = isChecked;
		elseif role == 3 then
			isChecked=_G['RHEL_AllGroupsDisp'..healer]:GetChecked();
			_G['RHELCheckButton'..role .. '_' .. healer.. '_'..target]:SetChecked(isChecked);
			if RHEL_OwnDispells then
				RHEL_Dispells[RHEL_Raid][RHEL_Boss][healer][target] = isChecked;
			else 
				RHEL_Dispells[RHEL_Raid][BossNameList[dungeons[RHEL_Raid]][1]][healer][target] = isChecked;
			end
		else
			RHEL.Report(RHEL_loc["Click on checkbox with unknown role"], true);
		end
	end
end

--Healer insert reaction. CHECK
-- for example
-- healer:GetName() get "Ins_button1"
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
function RHEL_HealerInsert(healer)
	local id = tonumber(string.sub(healer:GetName(),11));
	local name, realm = UnitName("target");
	if (UnitInRaid(name) or UnitInParty(name) or UnitInBattleground(name)) then
		local englishClass = RHEL_UpdateClass(id, 'Healer');
		RHEL_Healers[id] = name;
		_G['HealerName'..id]:SetText(name);
		_G["mini_healer_frame"..id].MiniHealerFont:SetText(name);
		if englishClass then
			_G["mini_healer_frame"..id].MiniHealerFont:SetTextColor(RHEL_color[englishClass][1],RHEL_color[englishClass][2], RHEL_color[englishClass][3]);
		end
	else
		RHEL.Report(RHEL_loc["Wrong target or not friendly player"], true);
	end
end

--Healer name editing reaction. DONE
-- for example
-- healer:GetName() get "HealerName1"
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
function RHEL_HealerNameChange(healer)
	local id = tonumber(string.sub(healer:GetName(),11));
	local englishClass = RHEL_UpdateClass(id, 'Healer');
	RHEL_Healers[id] = _G['HealerName'..id]:GetText();
	if RHEL_Healers[id] then
		_G["mini_healer_frame"..id].MiniHealerFont:SetText(RHEL_Healers[id]);
		if englishClass then
			_G["mini_healer_frame"..id].MiniHealerFont:SetTextColor(RHEL_color[englishClass][1],RHEL_color[englishClass][2], RHEL_color[englishClass][3]);
		end
	end
end

--Select icon for target. DONE
function RHEL_UpdateClass(icon, class)
	local localizedClass, englishClass, classIndex =  UnitClass(_G[class.."Name"..icon]:GetText());
	if englishClass ~= nil then
		_G[class.."ClassIcon"..icon]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
--		_G[class.."Name"..icon.."DragTexture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
	else
		_G[class.."ClassIcon"..icon]:SetTexture(nil);
--		_G[class.."Name"..icon.."DragTexture"]:SetTexture(nil);
	end
	return englishClass
end

-- Tank insert reaction. CHECK
function RHEL_TankInsert(tank)
	local id = tonumber(string.sub(tank:GetName(),15));
	local name, realm = UnitName("target");
	if (UnitInRaid(name) or UnitInParty(name) or UnitInBattleground(name)) then
		RHEL_UpdateClass(id, 'Tank');
		RHEL_Tanks[id] = name;
		_G['TankName'..id]:SetText(name);
	else
		RHEL.Report(RHEL_loc["Wrong target or not friendly player"], true);
	end
end

--Tank name editing reaction. CHECK
function RHEL_TankNameChange(tank)
	local id = tonumber(string.sub(tank:GetName(),9));
	RHEL_UpdateClass(id, 'Tank');
	RHEL_Tanks[id] = _G['TankName'..id]:GetText();
end	

--Channel editing reaction. DONE
function RHEL_ChannelChange()
	RHEL_Channel = ChannelNumber:GetText();
end

--Swap chat to anounce. DONE
function RHEL_SwapAnounceTo(to)
	if to == to_Channel then
		to_Raid:SetChecked(false);
		to_Channel:SetChecked(true);
		RaidWarning:SetChecked(false);
	elseif to == to_Raid then
		to_Raid:SetChecked(true);
		to_Channel:SetChecked(false);
		RaidWarning:SetChecked(false);
	else
		to_Raid:SetChecked(false);
		to_Channel:SetChecked(false);
		RaidWarning:SetChecked(true);
	end
end

--RaidName menu. CHECK
local info = {};
function RHEL_RaidNameDropdown_OnLoad()
	if (VariablesLoaded == false) then
		return;
	end;
	
	local x;
	local List = RaidNameList;
	for x = 1, getn(List) do
		info.text = List[x];
		info.value = x;
		info.owner = _G["RaidNameDropdown"]:GetParent();
		info.func = function() RHEL_RaidName_OnSelect(x) end;
		info.checked = nil;
		UIDropDownMenu_AddButton(info);
	end
end

--Set raid name on select. CHECK 
function RHEL_RaidName_OnSelect(value)
	if (VariablesLoaded == false) then
		return;
	end;
	RHEL_Raid = RaidNameList[value];
	if (RHEL_Raid == nil) then
		RHEL_Raid = RaidNameList[6];
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1];
	end
	
	if (UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= value) then
		UIDropDownMenu_SetSelectedValue(_G["RaidNameDropdown"], value);
		UIDropDownMenu_ClearAll(_G["BossNameDropdown"]);
		UIDropDownMenu_ClearAll(_G["RHEL_MiniDropdown"]);
		RHEL_BossNameDropdown_OnLoad();
	end
	
	RHEL_BuffsDefault();
	RHEL_BuffsLoad();
	RHEL_DispellsDefault(RHEL_Raid, RHEL_Boss);
	RHEL_DispellsLoad();
	RHEL_RaidBossReverse();
	if RHEL_Boss == nil or revBossNameList[RHEL_Boss] == nil then
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1];
		-- next rows needed for saved varisables and after raid menu choose load
		RHEL_BossNoteLoad();
		RHEL_HealsDefault();
		RHEL_HealsLoad();
		RHEL_DispellsDefault(RHEL_Raid, RHEL_Boss);
		RHEL_DispellsLoad();
	end
	RHEL_GUI.RHEL_Mini.MiniFont:SetText(RHEL_Raid);
end

--BossName menu. CHECK
function RHEL_BossNameDropdown_OnLoad()
	if (VariablesLoaded == false) then
		return;
	end;
	
	local x;
	local List = {};

	if UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= nil then
		List = select(UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]),BossNameList.MC, BossNameList.Onyxia, BossNameList.BWL, BossNameList.AQ, BossNameList.NAX, BossNameList.Custome);
	end

	for x=1, getn(List) do
		info.text = List[x];
		info.value = x;
		info.owner = _G["BossNameDropdown"]:GetParent();
		info.hasarrow = true;
		info.func = function() RHEL_BossName_OnSelect(x) end;
		info.checked = nil;
		UIDropDownMenu_AddButton(info);
	end
	
	if UIDropDownMenu_GetSelectedValue(_G["BossNameDropdown"]) == nil then
		UIDropDownMenu_SetSelectedValue(_G["BossNameDropdown"],1);
		UIDropDownMenu_SetText(_G["BossNameDropdown"],List[1]);
	end
	if RHEL_GUI.RHEL_Mini then
		if UIDropDownMenu_GetSelectedValue(RHEL_GUI.RHEL_Mini.RHEL_OffspringFrame.RHEL_MiniDropdown) == nil then
		UIDropDownMenu_SetSelectedValue(_G["RHEL_MiniDropdown"],1);
		UIDropDownMenu_SetText(_G["RHEL_MiniDropdown"],List[1]);
		end
	end
end

--Set boss name on select. CHECK
function RHEL_BossName_OnSelect(value)
	if (VariablesLoaded == false) then
		return;
	end;
--	RHEL_RaidBossReverse();
	UIDropDownMenu_SetSelectedValue(_G["BossNameDropdown"], value);
	UIDropDownMenu_SetText(_G["BossNameDropdown"], BossNameList[dungeons[RHEL_Raid]][value]);
	UIDropDownMenu_SetSelectedValue(_G["RHEL_MiniDropdown"], value);
	UIDropDownMenu_SetText(_G["RHEL_MiniDropdown"], BossNameList[dungeons[RHEL_Raid]][value]);
	
--	print(UIDropDownMenu_GetText(_G["RaidNameDropdown"]).." - "..UIDropDownMenu_GetText(_G["BossNameDropdown"]));
	RHEL_Boss = UIDropDownMenu_GetText(_G["BossNameDropdown"]);
--	print(RHEL_Boss,BossNameList[dungeons[RHEL_Raid]][value], value, "BossNameDropdown2")
	RHEL_BossNoteLoad();	
	RHEL_HealsDefault();
	RHEL_HealsLoad();
	RHEL_DispellsDefault(RHEL_Raid, RHEL_Boss);
	RHEL_DispellsLoad();
end

-- Method:          RHEL.LangDropdown_OnLoad()
-- What it Does:    Load possible language for dropdown menu
-- Purpose:         This is for language of announces in raid or via wisper.
RHEL.LangDropdown_OnLoad = function()
	local x;
	local List = RHEL_loc.Languages;
	for x = 1, getn(List) do
		info.text = List[x];
		info.value = x;
		info.owner = _G["RHEL_Lang_Dropdown"]:GetParent();
		info.func = function() RHEL.LangDropdown_OnSelect(x) end;
		info.checked = nil;
		UIDropDownMenu_AddButton(info);
	end
end

-- Method:          RHEL.LangDropdown_OnSelect(string)
-- What it Does:    On select language for dropdown menu
-- Purpose:         This is for language of announces in raid or via wisper. 
RHEL.LangDropdown_OnSelect = function (value)
	if (UIDropDownMenu_GetSelectedValue(_G["RHEL_Lang_Dropdown"]) ~= value) then
		UIDropDownMenu_SetSelectedValue(_G["RHEL_Lang_Dropdown"], value);
		RHEL_lang = UIDropDownMenu_GetText(_G["RHEL_Lang_Dropdown"]);
	end
	RHEL.LangSelect(value);
end

-- Method:          RHEL.LangSelect(string)
-- What it Does:    Select chosen language for announce
-- Purpose:         This is for language of announces in raid or via wisper. 
RHEL.LangSelect = function (value)
	if value == 2 then
		RHEL_loc.Russian();
	else
		RHEL_lang = 1;
		RHEL_loc.English();
	end	
end

--Healer death warning. CHECK
function RHEL_ReportDeath(guid, name, flags)
	for i = 1, RHEL_Total do
		if RHEL_Healers[i] == name then
			local HealsPart = RHEL_Healings(i);	
			local dthmsg = name .. RHEL_loc[" is dead."];
			if HealsPart ~= "" then
				dthmsg = dthmsg .. RHEL_loc[" Heal "] .. HealsPart;
			end
			if to_Raid:GetChecked() then
				SendChatMessage(tostring(dthmsg), "RAID");
			elseif RaidWarning:GetChecked() then
				SendChatMessage(tostring(dthmsg), "RAID_WARNING");
			else
				RHEL.Report(dthmsg);
			end
		end
	end
end

local RHEL_Frame = CreateFrame("FRAME", "RHEL");
RHEL_Frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...);
end)

--Prep for death anonce. Check
function RHEL_Frame:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local _, subevent, _, srcGUID, srcName, _, _, guid, name, flags = CombatLogGetCurrentEventInfo();
	local instance = select(2, IsInInstance());
	if not UnitInRaid(name) then return end
	if (subevent == "UNIT_DIED" and (instance == "raid")) then
--	if (subevent == "UNIT_DIED") then
--		print(srcGUID, srcName)
		RHEL_ReportDeath(guid, name, flags);
	end
end


--Alternative variant for SavedVariables load. CHECK
local VariablesLoaded = false
function RHEL_Frame:ADDON_LOADED(addon)
	if addon ~= "RHEL" or VariablesLoaded then 
		return;
	else
		VariablesLoaded = true;
		RHEL_VariablesDefaultSet();
		main_menu();
		mini_menu();
		RHEL_GUI.RHEL_Mini.MiniFont:SetText(RHEL_Raid);
		RHEL_RaidBossSaved();
		RHEL_TanksLoad();
		RHEL_HealersLoad();
		RHEL_ChannelLoad();
		RHEL_GUI.RHEL_Mini.RHEL_Info.TabFrame.Option.HealerSlider:SetValue(RHEL_Total);
		RHEL.LangSaved();
		RHEL.Loaded()		
	end
end
RHEL_Frame:RegisterEvent("ADDON_LOADED");

--Click on warning checkbox reaction. CHECK
--local warningChecked = false
function RHEL_ClickOnWarningCheckBox()
--   warningChecked = CheckButtonWarning:GetChecked();
--	RHEL.Report('warning click', true)
	if CheckButtonWarning:GetChecked() then
		RHEL_Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	else
		RHEL_Frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end
end
	
--for debug
function dump(o)
   if type(o) == 'table' then
      local s = '{ ';
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ',';
      end
      return s .. '} ';
   else
      return tostring(o);
   end
end
