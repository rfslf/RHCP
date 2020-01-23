-- Author      : Virgo
-- Create Date : 12/19/2019 7:43:57 PM
-- Update	   : 01/23/2020

local version = "0.9.0"
local total_healers = 8
local tanks = {"MT","OT", "T3", "T4", "A", "B", "C", "D"}
local total_tanks
if additional_tanks then
	total_tanks = 8
else
	total_tanks = 4
end

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

function RHEL_print(str, err)
	if not str then return; end;
	if err == nil then
		DEFAULT_CHAT_FRAME:AddMessage("|c006969FFRHEL: " .. tostring(str) .. "|r");
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c006969FFRHEL:|r " .. "|c00FF0000Error|r|c006969FF - " .. tostring(str) .. "|r");
	end
end

local revRaidNameList = {}
for i,v in ipairs(RaidNameList) do
	revRaidNameList[v] = i
end
local revBossNameList = {}

--Frame starts moving. DONE
function RHEL_OnMouseDown()
	RHEL_MainMenu:StartMoving()
end

--Frame stops moving. DONE
function RHEL_OnMouseUp()
	RHEL_MainMenu:StopMovingOrSizing()
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
		if RHEL_GUI.RHEL_MainMenu ~= nil and not RHEL_GUI.RHEL_MainMenu:IsVisible() then
			RHEL_GUI.RHEL_MainMenu:Show();
		elseif RHEL_GUI.RHEL_MainMenu ~= nil and RHEL_GUI.RHEL_MainMenu:IsVisible() then
            RHEL_GUI.RHEL_MainMenu:Hide();
		else
			RHEL_print("Main menu is not ready. Try one more time.", true)
		end
	elseif command == "mini" then
        if RHEL_MiniFrame ~= nil and not RHEL_MiniFrame:IsVisible() then
			RHEL_MiniFrame:Show();
		elseif RRHEL_MiniFrame ~= nil and RHEL_MiniFrame:IsVisible() then
            RHEL_MiniFrame:Hide();
		else
			RHEL_print("Mini menu is not ready. Try one more time.", true)
		end
	elseif command == "option" or command == 'help' then
		RHEL_print("Wo-wo-wo, take it easy! Not ready yet.")
	else
		RHEL_print("Invalid Command. Type '/rhel help'!", true)
	end
end

--Greetings. DONE
function RHEL_Loaded()
	RHEL_print('RaidHealersEasyLife loaded. Type /rhel to open. Version '..version);
	RHEL_MainMenu:Hide();
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
	if (RHEL_Heals[RHEL_Raid][RHEL_Boss] == nil) or (table.getn(RHEL_Heals[RHEL_Raid][RHEL_Boss]) ~= total_healers) then
--		    	 1	   2     3     4     5     6     7     8    MT    OT	T3	  T4    A    B    C     D
		RHEL_Heals[RHEL_Raid][RHEL_Boss] = {
		    {false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,true,true,false,false,false,false,false,false},
			{false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false},
			{true,false,true,false,true,false,true,false,false,false,false,false,false,false,false,false},
			{true,false,true,false,true,false,true,false,false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true,false,false,false,false,false,false,false,false},
			{false,true,false,true,false,true,false,true,false,false,false,false,false,false,false,false}};
--	      	 1	   2    3     4    5     6    7     8    MT    OT	T3	  T4    A    B    C     D					  
	end
end

-- For the first time RHEL_Buffs is loaded; initialize buffs to defaults. DONE
function RHEL_BuffsDefault()
	if RHEL_Buffs == nil then
		RHEL_Buffs={}
	end
	if (RHEL_Buffs[RHEL_Raid] == nil) or (table.getn(RHEL_Buffs[RHEL_Raid]) ~= total_healers) then
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

-- For the first time RHEL_Dispells is loaded; initialize dispells to defaults. DONE
function RHEL_DispellsDefault()
	if RHEL_Dispells == nil then
		RHEL_Dispells={}
	end
	if (RHEL_Dispells[RHEL_Raid] == nil) or (table.getn(RHEL_Dispells[RHEL_Raid]) ~= total_healers) then
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

-- For the first time RHEL_Channel is loaded; initialize channel to 5. DONE
	if RHEL_Channel == nil then
		RHEL_Channel = 5;
	end

-- For first time RHEL_Healers is loaded; initialize healers to NameNumber. DONE
	if RHEL_Healers == nil then
		RHEL_Healers = {};
		for i = 1, total_healers do
			RHEL_Healers[i] = "Name"..i;
		end 
	end
-- For first time RHEL_Tanks is loaded; initialize tanks/ DONE
	if RHEL_Tanks == nil then
		RHEL_Tanks = {};
		for i = 1, total_tanks do
			RHEL_Healers[i] = tanks[i];
		end 
	end

	RHEL_HealsDefault();
	RHEL_BuffsDefault();
	RHEL_DispellsDefault();
end

--Load saved Raid&Boss. OPTIMAZE
function RHEL_RaidBossSaved()
	RHEL_RaidBossReverse()
	RaidName_OnSelect(revRaidNameList[RHEL_Raid]);
	UIDropDownMenu_SetText(RaidNameDropdown, RHEL_Raid);
	if RHEL_Boss == nil or revBossNameList[RHEL_Boss] == nil then
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1]
	end
	BossName_OnSelect(revBossNameList[RHEL_Boss]);
end

--Healers on load. DONE
function RHEL_HealersLoad()
	for i = 1, total_healers do
		_G['HealerName'..i]:SetText(RHEL_Healers[i]);
	end
end

--Tanks on load. DONE
function RHEL_TanksLoad()
	for i = 1, total_tanks do
		_G['TankName'..i]:SetText(RHEL_Tanks[i]);
	end
end

--Heals checkboxes on load. DONE
function RHEL_HealsLoad()
--	print("RHEL: Healers load for ",RHEL_Raid,RHEL_Boss)
	for i = 1, total_healers do
		for j = 1, 12 do
			if type(RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]) == "boolean" then
				checker = RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]
			else
				checker = false
				RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] = false
			end
			_G['RHELCheckButton1' .."_".. i .. "_"..j]:SetChecked(checker);
		end
		if additional_tanks then
			for j = 13, 16 do
				if type(RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]) == "boolean" then
					checker = RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j]
				else
					checker = false
					RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] = false
				end
				_G['RHELCheckButton1' .."_".. i .. "_"..j]:SetChecked(checker);
			end	
		end
	end
end

--Buffs checkboxes on load. DONE
function RHEL_BuffsLoad()
	for i = 1, total_healers do
		for j = 1, 8 do
			checker = RHEL_Buffs[RHEL_Raid][i][j]
			_G['RHELCheckButton2' .."_".. i .. "_".. j]:SetChecked(checker);
		end
	end
end

--Dispells checkboxes on load. DONE
function RHEL_DispellsLoad()
	for i = 1, total_healers do
		for j = 1, 8 do
			checker = RHEL_Dispells[RHEL_Raid][i][j]
			_G['RHELCheckButton3' .."_".. i .. "_"..j]:SetChecked(checker);
		end
	end
end

function RHEL_ChannelLoad()
	ChannelNumber:SetText(RHEL_Channel);
end

--Send message to raid or channel. DONE
function RHEL_SendMessage(msg)
	if string.len(tostring(msg)) > 255 then
		RHEL_print("Too long message."..string.len(msg), true)
	else
		if toRaid:GetChecked() and not ChannelNumber:GetChecked() then
			SendChatMessage(tostring(msg), "RAID");
		elseif not toRaid:GetChecked() and ChannelNumber:GetChecked() then
			SendChatMessage(tostring(msg), "CHANNEL", nil, RHEL_Channel);
		else
			RHEL_print('while sending message', true)
		end
	end
end

--Click on heals anounce. DONE
function RHEL_HealAnounce()
	local anounce = RHEL_Raid.." - "..RHEL_Boss..": HEALINGS!"
	local message1 = ""
	for i = 1, total_healers do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message2 = "[" .. _G['HealerName'..i]:GetText() .. " - "
			local message3 = ""
			if RHEL_Heals[RHEL_Raid][RHEL_Boss][i] then
				message3 = "Groups: "
				local heal_count = 0
				for j = 1, 8 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] then
						heal_count = heal_count + 1
						message3 = message3 .. j .. ", "
					end
				end
				if heal_count == 0 then
					message3 = ""
				elseif heal_count == 8 then
					message3 = "All groups."
				else
					message3 = string.sub(message3, 1, -3)  .. "."
				end
				heal_count = 0
				for j = 9, 12 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] then
						heal_count = heal_count + 1
						message3 = message3 .. ' ' .. tanks[j-8]
					end
				end
				if additional_tanks then
					for j = 13, 16 do
						if RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] then
							heal_count = heal_count + 1
							message3 = message3 .. ' ' .. tanks[j-8]
						end
					end
				end
				if heal_count == 0 then
					message3 = ""
				else
					message3 = string.sub(message3, 1, -2)
				end
			end
			if message3 ~= "" then
				message1 = message1 .. message2 .. message3 .. "] "	
			end
		end
	end
	RHEL_SendMessage(anounce)
	RHEL_SendMessage(message1)
end

--Click on buffs anounce. DONE
function RHEL_BuffAnounce()
	local buff_count
	local anounce = RHEL_Raid..": BUFFS!"
	local message = ""
	for i = 1,total_healers do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message1 = "[" .. _G['HealerName'..i]:GetText() .. " - "
			local message2 = "Groups: "
			if RHEL_Buffs[RHEL_Raid][i] then
				buff_count = 0
				for j = 1, 8 do
					if RHEL_Buffs[RHEL_Raid][i][j] then
						buff_count = buff_count + 1
						message2 = message2 .. j .. ", "
					end
				end
			end
			if buff_count == 0 then
				message1 = ""
			elseif buff_count == 8 then
				message = message .. message1 .. "All groups or fallen] "
			else
				message = message .. message1 .. string.sub(message2, 1, -3) .. "] "
			end
		end
	end
	RHEL_SendMessage(anounce)
	RHEL_SendMessage(message)
end

--Click on buffs anounce. DONE
function RHEL_DispellAnounce()
	local dispell_count
	local anounce = RHEL_Raid..": DISPELLS!"
	local message = ""
	for i = 1,total_healers do
		if _G['HealerName'..i]:GetText() ~= "" then
			local message1 = "[" .. _G['HealerName'..i]:GetText() .. " - "
			local message2 = "Groups: "
			if RHEL_Dispells[RHEL_Raid][i] then
				dispell_count = 0
				for j = 1, 8 do
					if RHEL_Dispells[RHEL_Raid][i][j] then
						dispell_count = dispell_count + 1
						message2 = message2 .. j .. ", "
					end
				end
			end
			if dispell_count == 0 then
				message1 = ""
			elseif dispell_count == 8 then
				message = message .. message1 .. "All groups] "
			else
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
		if not (UnitInRaid(healer) or UnitInParty(healer)) then
			RHEL_print(healer .." is not in your raid or party", true)
		else
			local HealsPart = "[Heals - "
			if RHEL_Heals[RHEL_Raid][RHEL_Boss][number] then
				local heal_count = 0
				for j = 1, 8 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][number][j] then					
						heal_count = heal_count + 1
						HealsPart = HealsPart .. " Group" .. j .. ","
					end
				end			
				if 	heal_count == 8 then
					HealsPart = "[Heals - All groups,"
				end		
				for j = 9, 12 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][number][j] then
						HealsPart = HealsPart .. ' ' .. tanks[j-9] .. ","
					end
				end	
				if additional_tanks then
					for j = 13, 16 do
						if RHEL_Heals[RHEL_Raid][RHEL_Boss][number][j] then
							HealsPart = HealsPart .. ' ' .. tanks[j-9] .. ","
						end
					end
				end
			end
			HealsPart = string.sub(HealsPart, 1, -2) .. "] "
		
			local BuffsPart = "[Buff groups - "
			local buff_count = 0
			if RHEL_Buffs[RHEL_Raid][number] then			
				for j = 1, 8 do
					if RHEL_Buffs[RHEL_Raid][number][j] then
						buff_count = buff_count + 1
						BuffsPart = BuffsPart .. j .. ", "
					end
				end	
			end
			if buff_count == 0 then 
				BuffsPart = " "
			elseif buff_count == 8 then
				BuffsPart = "[Buff all groups or fallen] "
			else
				BuffsPart = string.sub(BuffsPart, 1, -3) .. "] "
			end

			local DispellsPart = "[Dispell groups - "
			local dispell_count = 0
			if RHEL_Dispells[RHEL_Raid][number] then
				for j = 1, 8 do
					if RHEL_Dispells[RHEL_Raid][number][j] then
						dispell_count = dispell_count + 1
						DispellsPart = DispellsPart .. j .. ", "
					end
				end	
			end
			if dispell_count == 0 then
				DispellsPart = " "
			elseif dispell_count == 8 then
				DispellsPart = "[Dispell all groups] " 
			else
				DispellsPart = string.sub(DispellsPart, 1, -3) .. "]"
			end

			SendChatMessage(wisper..HealsPart..BuffsPart..DispellsPart, "WHISPER", nil, healer)
		end
	end
end

--Click on heals, buffs, dispells checkbox reaction. DONE
function ClickOnCheckBox(role,healer,target)
--	print(RHEL_Raid,RHEL_Boss)
	local isChecked
    isChecked=_G['RHELCheckButton'..role .. '_' .. healer.. '_'..target]:GetChecked();
	if role == 1 then
		RHEL_Heals[RHEL_Raid][RHEL_Boss][healer][target] = isChecked;
	elseif role == 2 then
		RHEL_Buffs[RHEL_Raid][healer][target] = isChecked;
	elseif role == 3 then
		RHEL_Dispells[RHEL_Raid][healer][target] = isChecked;
	else
		RHEL_print("Click on checkbox with unknown role", true)
	end
end

--Healer insert reaction. CHECK
-- for example
-- healer:GetName() get "Ins_button1"
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
function HealerInsert(healer)
	local id = tonumber(string.sub(healer:GetName(),11))
	local name, realm = UnitName("target")
	if (UnitInRaid(name) or UnitInParty(name) or UnitInBattleground(name)) in
		UpdateClass(id, 'Healer');
		RHEL_Healers[id] = name;
		_G['HealerName'..id]:SetText(name);
	else
		RHEL_print("Wrong target or not friendly player", true)
	end
end

--Healer name editing reaction. DONE
-- for example
-- healer:GetName() get "HealerName1"
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
function HealerNameChange(healer)
	local id = tonumber(string.sub(healer:GetName(),11));
	UpdateClass(id, 'Healer');
	RHEL_Healers[id] = _G['HealerName'..id]:GetText()
end

--Select icon for target. DONE
function UpdateClass(icon, class)
	local localizedClass, englishClass, classIndex =  UnitClass(_G[class.."Name"..icon]:GetText());
	if englishClass ~= nil then
		_G[class.."Name"..icon.."Texture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
--		_G[class.."Name"..icon.."DragTexture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
	else
		_G[class.."Name"..icon.."Texture"]:SetTexture(nil);
--		_G[class.."Name"..icon.."DragTexture"]:SetTexture(nil);
	end
end

-- Tank insert reaction. CHECK
function TankInsert(tank)
	local id = tonumber(string.sub(healer:GetName(),15))
	local name, realm = UnitName("target")
	if (UnitInRaid(name) or UnitInParty(name) or UnitInBattleground(name)) in
		UpdateTankClass(id, 'Tank');
		RHEL_Tanks[id] = name;
		_G['TankName'..id]:SetText(name);
	else
		RHEL_print("Wrong target or not friendly player", true)
	end
end

--Tank name editing reaction. CHECK
function TankNameChange(tank)
	local id = tonumber(string.sub(tank:GetName(),15));
	UpdateTankClass(id, 'Tank');
	RHEL_Tanks[id] = _G['TankName'..id]:GetText()
end	

--Channel editing reaction. DONE
function ChannelChange()
	RHEL_Channel = ChannelNumber:GetText();
end

--Swap chat to anounce. DONE
function SwapAnounceTo(to)
	if to == to_Channel then
		to_Raid:SetChecked(false)
		to_Channel:SetChecked(true)
	else
		to_Raid:SetChecked(true)
		to_Channel:SetChecked(false)
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
		print("483")
		RHEL_Raid = RaidNameList[6]
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1]
	end
	
	if (UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= value) then
		UIDropDownMenu_SetSelectedValue(_G["RaidNameDropdown"], value);
		UIDropDownMenu_ClearAll(_G["BossNameDropdown"]);
--		print("489")
		BossNameDropdown_OnLoad();
	end
	
	RHEL_BuffsDefault();
	RHEL_BuffsLoad();
	RHEL_DispellsDefault();
	RHEL_DispellsLoad();
	RHEL_RaidBossReverse()
	if RHEL_Boss == nil or revBossNameList[RHEL_Boss] == nil then
--		RHEL_print("499")
		RHEL_Boss = BossNameList[dungeons[RHEL_Raid]][1]
		-- next 2 rows needed for saved varisables and after raid menu chose load
		RHEL_HealsDefault();
		RHEL_HealsLoad();
	end
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

	for x=1, getn(List) do
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
--	print("548")
--	print(RHEL_Raid, RHEL_Boss)
	RHEL_HealsDefault();
	RHEL_HealsLoad();
--	RHEL_VariablesDefaultSet()
end

--Healer death warning. CHECK
function RHEL_ReportDeath(guid, name, flags)
	for i = 1, total_healers do
		if RHEL_Healers[i] == name then
			
			local HealsPart = " is dead. Heal "
			if RHEL_Heals[RHEL_Raid][RHEL_Boss][i] then
				local heal_count = 0
				for j = 1, 8 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] then					
						heal_count = heal_count + 1
						HealsPart = HealsPart .. " Group" .. j .. ","
					end
				end			
				if 	heal_count == 8 then
					HealsPart = " is dead. Heal all groups,"
				end		
				for j = 9, 12 do
					if RHEL_Heals[RHEL_Raid][RHEL_Boss][i][j] then
						if j == 9 then
							HealsPart = HealsPart .. " MT" .. ","
						elseif j > 9 then
							HealsPart = HealsPart .. " OT" .. (j-9) .. ","
						end
					end
				end	
			end	
			if HealsPart ~= " is dead. Heal " then
				HealsPart = string.sub(HealsPart, 1, -2) .. "!"
				local dthmsg = name..HealsPart
				if to_Raid:GetChecked() and not to_Channel:GetChecked() then
					SendChatMessage(tostring(dthmsg), "RAID");
				else
					RHEL_print(dthmsg)
				end
			end
		end
	end
end

local RHEL_Frame = CreateFrame("FRAME", "RHEL");
RHEL_Frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

--Prep for death anonce. Check
function RHEL_Frame:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local _, subevent, _, _, _, _, _, guid, name, flags = CombatLogGetCurrentEventInfo();
	local instance = select(2, IsInInstance())
	if not UnitInRaid(name) then return end

	if (subevent == "UNIT_DIED" and (instance == "raid")) then
--	if (subevent == "UNIT_DIED") then
		RHEL_ReportDeath(guid, name, flags)
	end
end


--Alternative variant for SavedVariables load. CHECK
local VariablesLoaded = false
function RHEL_Frame:ADDON_LOADED(addon)
	if addon ~= "RHEL" or VariablesLoaded then 
		return
	else
		VariablesLoaded = true;
		RHEL_VariablesDefaultSet();
		RHEL_RaidBossSaved();
		RHEL_TanksLoad();
		RHEL_HealersLoad();
		RHEL_ChannelLoad();
--		RHEL_print("Saved variables loaded")
	end
end
RHEL_Frame:RegisterEvent("ADDON_LOADED")

--Click on warning checkbox reaction. CHECK
--local warningChecked = false
function ClickOnWarningCheckBox()
--   warningChecked = CheckButtonWarning:GetChecked();
--	RHEL_print('warning click', true)
	if CheckButtonWarning:GetChecked() then
		RHEL_Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	else
		RHEL_Frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end
end
	
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
