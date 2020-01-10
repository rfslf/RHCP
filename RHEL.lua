-- Author      : Virgo
-- Create Date : 12/19/2019 7:43:57 PM
-- Update	   : 10/01/2020

local version = "0.7.2"
local totalHealers = 8

local RaidNameList = {"Molten Core","Onyxia & Outdoors","Blackwing Lair","Ahn'Qiraj","Naxxramas", "Custome"};
local dungeons = {["Molten Core"] = "MC", ["Onyxia & Outdoors"] = "Onyxia",
    ["Blackwing Lair"] = "BWL", ["Ahn'Qiraj"] = "AQ", ["Naxxramas"] = "NAX", ["Custome"] = "Custome"}
local BossNameList = {};
BossNameList.MC = {"Trash","Lucifron","Magmadar","Gehennas","Garr","Baron Geddon",
	"Shazzrah","Golemagg","Sulfuron","Majordomo","Ragnaros"};
BossNameList.Onyxia = {"Onyxia","Azuregos","Kazzak"};
BossNameList.BWL = {"Trash","Razorgore","Vaelastrasz","Broodlord","Firemaw",
	"Ebonroc","Flamegor","Chromaggus","Nefarian"};
BossNameList.AQ = {"Trash","The Prophet Skeram", "The Bug Trio", "Battleguard Sartura",
    "Fankriss the Unyielding", "Princess Huhuran", "The Twin Emperors", "Viscidus",
	"Ouro", "C'Thun"};
BossNameList.NAX = {"Trash","Anub'Rekhan","Grand Widow Faerlina","Maexxna",
	"Noth the Plaguebringer","Heigan the Unclean","Loatheb",
	"Instructor Razuvious","Gothic the Harvester","The Four Horsemen",
	"Patchwerk","Grobbulus","Gluth","Thaddius","Sapphiron","Kel'Thuzad"};
BossNameList.Custome = {"Frame_1","Frame_2","Frame_3","Frame_4"};

local revRaidNameList = {}
for i,v in ipairs(RaidNameList) do
	revRaidNameList[v] = i
end
local revBossNameList = {}

--Frame starts moving. DONE
function RHEL_OnMouseDown()
	RHEL_MainFrame:StartMoving()
end

--Frame stops moving. DONE
function RHEL_OnMouseUp()
	RHEL_MainFrame:StopMovingOrSizing()
end		   

--Add command line reaction. DONE
SLASH_RHEL_SLASHCMD1 = '/RHEL'
SLASH_RHEL_SLASHCMD2 = '/rhel'
SLASH_RHEL_SLASHCMD3 = '/????'
SlashCmdList["RHEL_SLASHCMD"] = function(msg)
    RHEL_MainFrame:Show()
end

--Greetings. DONE
function RHEL_Loaded()
	print('RaidHealersEasyLife loaded. Type /rhel to open menu. Version '..version);
	RHEL_MainFrame:Hide();
end

--Reverse Raid-Boss table. DONE
function RHEL_RaidBossReverse()
	revBossNameList = {}
	for i,v in ipairs(BossNameList[dungeons[RHEL_Raid]]) do
		revBossNameList[v] = i
    end
end

-- For the first time RHEL_Heals is loaded; initialize heals to defaults. DONE
function RHEL_HealsDefault()
	if RHEL_Heals == nil then
		RHEL_Heals={}
	end
	if RHEL_Heals[RHEL_Raid] == nil then
		RHEL_Heals[RHEL_Raid]={}
	end
	if (RHEL_Heals[RHEL_Raid][RHEL_Boss] == nil) or (table.getn(RHEL_Heals[RHEL_Raid][RHEL_Boss]) ~= totalHealers) then
--		    	 1	   2     3     4     5     6     7     8    MT    T2	T3	  T4
		RHEL_Heals[RHEL_Raid][RHEL_Boss] = {
		    {false,false,false,false,false,false,false,false,true,false,false,false},
			{false,false,false,false,false,false,false,false,true,false,false,false},
			{false,false,false,false,false,false,false,false,true,true,false,false},
			{false,false,false,false,false,false,false,false,false,true,false,false},
			{true,false,true,false,true,false,true,false,false,false,false,false},
			{true,false,true,false,true,false,true,false,false,false,false,false},
			{false,true,false,true,false,true,false,true,false,false,false,false},
			{false,true,false,true,false,true,false,true,false,false,false,false}};
--	      	 1	   2    3     4    5     6    7     8    MT    T2	T3	  T4					  
	end
end

-- For the first time RHEL_Buffs is loaded; initialize buffs to defaults. DONE
function RHEL_BuffsDefault()
	if RHEL_Buffs == nil then
		RHEL_Buffs={}
	end
	if (RHEL_Buffs[RHEL_Raid] == nil) or (table.getn(RHEL_Buffs[RHEL_Raid]) ~= totalHealers) then
--		      1	     2     3     4     5     6     7     8
		RHEL_Buffs[RHEL_Raid] = {
		    {true,false,true,false,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,true,false,true,false},
			{false,false,false,false,false,false,false,false},	
			{false,false,false,false,false,false,false,false},
			{false,true,false,true,false,false,false,false},
			{false,false,false,false,false,false,false,false},
			{false,false,false,false,false,true,false,true}};
--	      		1	  2    3     4     5     6    7     8					  
	end
end

-- For the first time RHEL_Dispells is loaded; initialize dispells to defaults. CHECK
function RHEL_DispellsDefault()
	if RHEL_Dispells == nil then
		RHEL_Dispells={}
	end
	if (RHEL_Dispells[RHEL_Raid] == nil) or (table.getn(RHEL_Dispells[RHEL_Raid]) ~= totalHealers) then
--		      1	     2     3     4     5     6     7     8
		RHEL_Dispells[RHEL_Raid] = {
		    {true,false,true,false,true,false,true,false},
			{false,false,false,false,false,false,false,false},
			{true,false,true,false,true,false,true,false},
			{false,false,false,false,true,false,true,false},
			{false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true},
			{false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true}};
--	      		1	  2    3     4     5     6    7   8					  
	end
end

--Set defaults values to variables. TO DO
function RHEL_VariablesDefaultSet()
-- For the first time RHEL_Raid RHEL_Boss is loaded; initialize to defaults.
	if (RHEL_Raid == nil) or (RHEL_Boss == nil) or (dungeons[RHEL_Raid] == nil) then
		RHEL_Raid = RaidNameList[6];
		RHEL_Boss = BossNameList[RHEL_Raid][1];
	else
		RHEL_RaidBossReverse();
		if revBossNameList[RHEL_Boss] == nil then
			RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1];
		end
	end

-- For the first time RHEL_Channel is loaded; initialize channel to 5. DONE
	if RHEL_Channel == nil then
		RHEL_Channel = 5;
	end

-- For first time RHEL_Healers is loaded; initialize healers to NameNumber. DONE
	if RHEL_Healers == nil then
		RHEL_Healers = {};
		for i = 1, totalHealers do
			RHEL_Healers[i] = "Name"..i;
		end 
	end

	RHEL_HealsDefault();
	RHEL_BuffsDefault();
	RHEL_DispellsDefault();
end

--Load saved Raid&Boss. CHECK
function RHEL_RaidBossSaved()
	RaidName_OnSelect(revRaidNameList[RHEL_Raid]);
	UIDropDownMenu_SetText(RaidNameDropdown, RHEL_Raid);
	if revBossNameList[RHEL_Boss] == nil then
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1]
	end
--	print(revBossNameList[RHEL_Boss])
	BossName_OnSelect(revBossNameList[RHEL_Boss]);
end

--Variables loading detection. CHECK 
local VariablesLoaded
local FirstTime = true
local oneTimer = true
local frame = CreateFrame("FRAME", "RHEL");
--frame:RegisterEvent("VARIABLES_LOADED");
--frame:SetScript("OnEvent", function(self, event, ...)
frame:RegisterEvent("PLAYER_LOGIN");
frame:SetScript("OnEvent", function(self, event, ...)
	if (event == "PLAYER_LOGIN" and FirstTime) then
--		frame:UnregisterEvent("PLAYER_LOGIN");
		FirstTime = false;
		VariablesLoaded = true;
		RHEL_VariablesDefaultSet();

		if oneTimer then
			oneTimer = false;	
			RHEL_RaidBossSaved();
		end

		RHEL_HealersLoad();
		RHEL_ChannelLoad();
--		RHEL_HealsLoad();
--		RHEL_BuffsLoad();
--		RHEL_DispellsLoad();
	end
end);
 
--Healers on load. DONE
function RHEL_HealersLoad()
	for i = 1, totalHealers do
		_G['HealerName'..i]:SetText(RHEL_Healers[i]);
	end
end

--Heals checkboxes on load. Optimaze
function RHEL_HealsLoad()
	print("RHEL: Healers load for ",RHEL_Raid,RHEL_Boss)
	for i = 1, totalHealers do
		for j = 1, 12 do
			if type(RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]) == "boolean" then
				checker = RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]
			else
				checker = false
				RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] = false
			end
			_G['CheckButton1' .. i .. "_"..j]:SetChecked(checker);
		end
	end
end

--Buffs checkboxes on load. Optimaze
function RHEL_BuffsLoad()
	for i = 1, totalHealers do
		for j = 1, 8 do
			checker = RHEL_Buffs[RHEL_Raid][i][j]
			_G['CheckButton2' .. i .. "_".. j]:SetChecked(checker);
		end
	end
end

--Dispells checkboxes on load. Optimaze
function RHEL_DispellsLoad()
	for i = 1, totalHealers do
		for j = 1, 8 do
			checker = RHEL_Dispells[RHEL_Raid][i][j]
			_G['CheckButton3' .. i .. "_"..j]:SetChecked(checker);
		end
	end
end

function RHEL_ChannelLoad()
	ChannelNumber:SetText(RHEL_Channel);
end

--Send message to raid or channel. DONE
function RHEL_SendMessage(msg)
--	print(RHEL_Channel)
	if string.len(msg) > 255 then
		print("RHEL:Long message."..string.len(msg))
	else
		if toRaid:GetChecked() and not toChannel:GetChecked() then
			SendChatMessage(msg ,"RAID");
	--		C_ChatInfo.SendAddonMessage("RHEL", msg, "RAID");
		elseif not toRaid:GetChecked() and toChannel:GetChecked() then
			SendChatMessage(msg ,"CHANNEL", nil, RHEL_Channel);
		else
			print('RHEL:Error while sending message')
		end
	end
end

--Click on heals anounce. DONE
function RHEL_HealAnounce()
	local anounce = RHEL_Raid.." - "..RHEL_Boss..": HEALINGS!"
	local message = ""
	for i = 1, totalHealers do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message1 = "[" .. _G['HealerName'..i]:GetText() .. " - "
			local message2 = ""
			if RHEL_Heals[RHEL_Raid][RHEL_Boss][i] then
				message2 = "Groups: "
				for j = 1, 8 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] then
						message2 = message2 .. j .. ", "
					end
				end	
				message2 = string.sub(message2, 1, -3)  .. "."
				if message2 == "Groups." then
					message2 = ""
				end
				for j = 9, 12 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] then
						if j == 9 then
							message2 = message2 .. " MT"
						else
							message2 = message2 .. " OT" .. (j-9)
						end
					end
				end
			end
			if message2 ~= "" then
				message = message .. message1 .. message2 .. "] "	
			end
		end
	end
	RHEL_SendMessage(anounce)
	RHEL_SendMessage(message)
end

--Click on buffs anounce. TO DO
function RHEL_BuffAnounce()
	local anounce = RHEL_Raid..": BUFFS!"
	local message = ""
	for i = 1,totalHealers do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message1 = "[" .. _G['HealerName'..i]:GetText() .. " - "
			local message2 = "Groups: "
			if RHEL_Buffs[RHEL_Raid][i] then
				for j = 1, 8 do
					if RHEL_Buffs[RHEL_Raid][i][j] then
						message2 = message2 .. j .. ", "
					end
				end
			end
			if message2 ~= "Groups: " then
				message = message .. message1 .. string.sub(message2, 1, -3) .. "] "	
			end
		end
	end
	RHEL_SendMessage(anounce)
	RHEL_SendMessage(message)
end

--Click on buffs anounce. TO DO
function RHEL_DispellAnounce()
	local anounce = RHEL_Raid..": DISPELLS!"
	local message = ""
	for i = 1,totalHealers do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message1 = "[" .. _G['HealerName'..i]:GetText() .. " - "
			local message2 = "Groups: "
			if RHEL_Dispells[RHEL_Raid][i] then
				for j = 1, 8 do
					if RHEL_Dispells[RHEL_Raid][i][j] then
						message2 = message2 .. j .. ", "
					end
				end
			end
			if message2 ~= "Groups: " then
				message = message .. message1 .. string.sub(message2, 1, -3) .. "] "	
			end
		end
	end
	RHEL_SendMessage(anounce)
	RHEL_SendMessage(message)
end

--Click on healers personal anounce. DONE
function RHEL_HealerWisper(number)
	local healer = _G['HealerName'..number]:GetText()
	local wisper = healer .. " in " .. RHEL_Raid .." on " .. RHEL_Boss .. ": "
	if healer ~= "" then
--		wisper = healer .. ". "
		local HealsPart = "[Heals - "
		if RHEL_Heals[RHEL_Raid][RHEL_Boss][number] then
			for j = 1, 12 do
				if RHEL_Heals[RHEL_Raid][RHEL_Boss][number][j] then
					if j < 9 then
						HealsPart = HealsPart .. " Group" .. j
					elseif j == 9 then
						HealsPart = HealsPart .. " MT"
					elseif j > 9 then
						HealsPart = HealsPart .. " OT" .. (j-9)
					end
				end
			end	
		end
		HealsPart = HealsPart .. "] "
		
		local BuffsPart = "[Buff groups - "
		if RHEL_Buffs[RHEL_Raid][number] then
			for j = 1, 8 do
				if RHEL_Buffs[RHEL_Raid][number][j] then
					BuffsPart = BuffsPart .. j .. " "
				end
			end	
		end
		if BuffsPart == "[Buff groups - " then
			BuffsPart = " "
		else
			BuffsPart = BuffsPart .. "] "
		end

		local DispellsPart = "[Dispell groups - "
		if RHEL_Dispells[RHEL_Raid][number] then
			for j = 1, 8 do
				if RHEL_Dispells[RHEL_Raid][number][j] then
					DispellsPart = DispellsPart .. j .. " "
				end
			end	
		end
		if DispellsPart == "[Dispell groups - " then
			DispellsPart = " "
		else
			DispellsPart = DispellsPart .. "] "
		end

		SendChatMessage(wisper..HealsPart..BuffsPart..DispellsPart, "WHISPER", nil, healer)
--		print(wisper..HealsPart..BuffsPart..DispellsPart)
	end
end

--Click on heals checkbox reaction. CHECK
function ClickOnHealCheckBox(healer,target)
--	print(RHEL_Raid,RHEL_Boss)
	local isChecked
    isChecked=_G['CheckButton1' .. healer.. '_'..target]:GetChecked();
	RHEL_Heals[RHEL_Raid][RHEL_Boss][healer][target] = isChecked
end

--Click on buffs checkbox reaction. CHECK
function ClickOnBuffCheckBox(buffer,target)
	local isChecked
    isChecked=_G['CheckButton2' .. buffer.. '_'..target]:GetChecked();
	RHEL_Buffs[RHEL_Raid][buffer][target] = isChecked
end

--Click on dispells checkbox reaction. CHECK
function ClickOnDispellCheckBox(buffer,target)
	local isChecked
    isChecked=_G['CheckButton3' .. buffer.. '_'..target]:GetChecked();
	RHEL_Dispells[RHEL_Raid][buffer][target] = isChecked
end

--Healer name editing reaction. DONE
-- for example
-- healer:GetName() get HealerName1
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
function HealerNameChange(healer)
	local id = tonumber(string.sub(healer:GetName(),11))
	UpdateHealerClass(id);
	RHEL_Healers[id] = _G['HealerName'..id]:GetText()
end

--Channel editing reaction. Optimaze
function ChannelChange()
	RHEL_Channel = ChannelNumber:GetText()
end

--Select icon for healer. DONE
function UpdateHealerClass(icon)
	local localizedClass, englishClass, classIndex =  UnitClass(_G["HealerName"..icon]:GetText());
	if englishClass ~= nil then
		_G["HealerClass"..icon.."Texture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
--		_G["HealerClass"..icon.."DragTexture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
	else
		_G["HealerClass"..icon.."Texture"]:SetTexture(nil);
--		_G["HealerClass"..icon.."DragTexture"]:SetTexture(nil);
	end
end

--Removes focus from healer name window. CHECK
function EditBox_OnEscapePressed(number)
	_G["HealerName"..number]:ClearFocus()
	--	RHEL_MainFrame:Hide()
end

--Removes focus from channel name window. CHECK
function Channel_OnEscapePressed()
	ChannelNumber:ClearFocus()
end

--Swap chat to anounce. TO DO
function SwapAnounceTo(to)
	if to == toChannel then
		toRaid:SetChecked(false)
		toChannel:SetChecked(true)
	else
		toRaid:SetChecked(true)
		toChannel:SetChecked(false)
	end
end

--RaidName menu. CHECK
local info = {};

function RaidNameDropdown_OnLoad()
	if (VariablesLoaded == false) then
		return;
	end;
	
	local x;
	local List = RaidNameList;
	for x=1,getn(List) do
		info.text = List[x];
		info.value = x;
		info.owner = _G["RaidNameDropdown"]:GetParent();
		info.func = function() RaidName_OnSelect(x) end;
		info.checked = nil;
		UIDropDownMenu_AddButton(info);
	end
end

--Set raid name on select. CHECK 
function RaidName_OnSelect(value)
	if (VariablesLoaded == false) then
		return;
	end;

	RHEL_Raid = RaidNameList[value]
	if (RHEL_Raid == nil) then
		RHEL_Raid = RaidNameList[6]
		RHEL_Boss = BossNameList[RHEL_Raid][1]
	end
	if (UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= value) then
		UIDropDownMenu_SetSelectedValue(_G["RaidNameDropdown"], value);
		UIDropDownMenu_ClearAll(_G["BossNameDropdown"]);
		print("508")
		BossNameDropdown_OnLoad();
	end
--	print(RHEL_Raid, "RaidNameDropdown")
	RHEL_BuffsDefault();
	RHEL_BuffsLoad();
	RHEL_DispellsDefault();
	RHEL_DispellsLoad();
--	RHEL_RaidBossReverse()
	RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1]
--	print(RHEL_Boss, "BossNameDropdown")
	print("519")
	RHEL_HealsDefault();
	RHEL_HealsLoad();

end

--BossName menu. CHECK
function BossNameDropdown_OnLoad()
	if (VariablesLoaded == false) then
		return;
	end;
	
	local x;
	local List = {};
	
	if UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= nil then
		List = select(UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]),BossNameList.MC, BossNameList.Onyxia, BossNameList.BWL, BossNameList.AQ, BossNameList.NAX, BossNameList.Custome);
	end

	for x=1,getn(List) do
		info.text = List[x];
		info.value = x;
		info.owner = _G["BossNameDropdown"]:GetParent();
		info.hasarrow = true;
		info.func = function() BossName_OnSelect(x) end;
		info.checked = nil;
		UIDropDownMenu_AddButton(info);
	end
	
	if(UIDropDownMenu_GetSelectedValue(_G["BossNameDropdown"]) == nil) then
		UIDropDownMenu_SetSelectedValue(_G["BossNameDropdown"],1)
		UIDropDownMenu_SetText(_G["BossNameDropdown"],List[1])
	end
end

--Set boss name on select. CHECK
function BossName_OnSelect(value)
	if (VariablesLoaded == false) then
		return;
	end;
--	RHEL_RaidBossReverse();
	UIDropDownMenu_SetSelectedValue(_G["BossNameDropdown"], value);
	UIDropDownMenu_SetText(_G["BossNameDropdown"],BossNameList[dungeons[RHEL_Raid]][value])
--	print(UIDropDownMenu_GetText(_G["RaidNameDropdown"]).." - "..UIDropDownMenu_GetText(_G["BossNameDropdown"]));
	RHEL_Boss = UIDropDownMenu_GetText(_G["BossNameDropdown"])
--	print(RHEL_Boss,BossNameList[dungeons[RHEL_Raid]][value], value, "BossNameDropdown2")
	print("565")
	RHEL_HealsDefault();
	RHEL_HealsLoad();
--	RHEL_VariablesDefaultSet()
end

--Prep fro death anonce. TO DO
function RHEL_ReportDeath(guid, name, flags)
	print('RHEL:death', guid, name, flags)
end

local DeathFrame = CreateFrame("FRAME", "RHEL");
DeathFrame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

--Prep fro death anonce. TO DO
function DeathFrame:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	local instance = select(2, IsInInstance())
	if not (UnitInRaid(destName) or UnitInParty(destName)) then return end

	if (event == "UNIT_DIED" and instance == "raid") or (event == "UNIT_DIED" and instance == "party") then
		RHEL_ReportDeath(destGUID, destName, destRaidFlags)
	end
end
DeathFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

--Check if works
function DeathFrame:ADDON_LOADED(addon)
	if addon ~= "RHEL" then 
		return
	else
		print("RHEL:Loaded")
	end
end
DeathFrame:RegisterEvent("ADDON_LOADED")
	
--for debug
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
