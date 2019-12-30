-- Author      : Virgo
-- Create Date : 12/19/2019 7:43:57 PM

local version = 0.4
local totalHealers = 8

local RaidNameList = {"Molten Core","Onyxia & Outdoors","Blackwing Lair","Naxxramas", "Custome"};
local BossNameList = {};
BossNameList.MC = {"Trash","Lucifron","Magmadar","Gehennas","Garr","Baron Geddon",
				   "Shazzrah","Golemagg","Sulfuron","Majordomo","Ragnaros"};
BossNameList.Onyxia = {"Onyxia","Azuregos","Kazzak"};
BossNameList.BWL = {"Trash","Razorgore","Vaelastrasz","Broodlord","Firemaw",
					"Ebonroc","Flamegor","Chromaggus","Nefarian"}   
BossNameList.NAX = {"Trash","Anub'Rekhan","Grand Widow Faerlina","Maexxna",
					"Noth the Plaguebringer","Heigan the Unclean","Loatheb",
					"Instructor Razuvious","Gothic the Harvester","The Four Horsemen",
					"Patchwerk","Grobbulus","Gluth","Thaddius","Sapphiron","Kel'Thuzad"};
BossNameList.Custome = {"Frame_1","Frame_2","Frame_3","Frame_4"};
				   

--Add command line reaction. DONE
SLASH_RHEL_SLASHCMD1 = '/RHEL'
SLASH_RHEL_SLASHCMD2 = '/rhel'
SlashCmdList["RHEL_SLASHCMD"] = function(msg)
    RHEL_MainFrame:Show()
end

--Variables loading detection. CHECK
local VariablesLoaded

RHEL_MainFrame:RegisterEvent("ADDON_LOADED")
RHEL_MainFrame:SetScript("OnEvent", function(self,event,addon)
	if eveny == "ADDON_LOADED" and addon == "RHEL" then
		print("Varaibles loaded")
		VariablesLoaded = true
		RHEL_VariablesLoaded()
	end
end)

--Greetings. DONE
function RHEL_Loaded()
	print('RaidHealersEasyLife loaded. Type /rhel to open menu. Version '..version);
--	RHEL_MainFrame:Hide();
end

--Frame starts moving. DONE
function RHEL_OnMouseDown()
	RHEL_MainFrame:StartMoving()
end

--Frame stops moving. DONE
function RHEL_OnMouseUp()
	RHEL_MainFrame:StopMovingOrSizing()
end

--Defaults values to variables or load saved. TO DO
local login = true

function RHEL_VariablesLoaded()
-- For the first time RHEL_Heals is loaded; initialize heals to defaults.
	if RHEL_Heals == nil then 
--						 1	   2     3     4     5     6     7     8    MT    T2	T3	  T4
		RHEL_Heals = {{false,false,false,false,false,false,false,false,true,false,false,false},
					  {false,false,false,false,false,false,false,false,true,false,false,false},
					  {false,false,false,false,false,false,false,false,true,true,false,false},
					  {false,false,false,false,false,false,false,false,false,true,false,false},
					  {true,false,true,false,true,false,true,false,true,false,true,false},
					  {true,false,true,false,true,false,true,false,true,false,true,false},
					  {false,true,false,true,false,true,false,true,false,true,false,true},
					  {false,true,false,true,false,true,false,true,false,true,false,true}};
--						 1	   2    3     4    5     6    7     8    MT    T2	T3	  T4					  
	end
-- For first time RHEL_Healers is loaded; initialize healers to NameNumber.
	if RHEL_Healers == nil then 
		for i=1, totalHealers do
			RHEL_Healers[i] = "Name"..i;
		end 
	end
	RHEL_HealersLoad();
	RHEL_HealsLoad();
end

--Load healers on load. CHECK
function RHEL_HealersLoad()
	for i = 1, totalHealers do
		_G['HealerName'..i]:SetText(RHEL_Healers[i]);
	end
end

--Load heals checkboxes on load. Optimaze
function RHEL_HealsLoad()
	for i = 1, totalHealers do
		for j = 1, 12 do
			if RHEL_Heals[i][j] then
				_G['CheckButton1' .. i .. "_"..j]:SetChecked(true);
			else
				_G['CheckButton1' .. i .. "_"..j]:SetChecked(false);
			end
		end
	end
end

--Click on heals anounce. Add skip empty healer
function RHEL_HealAnounce()
	local anounce = "HEALINGS: "
	for i = 1,totalHealers do
		if _G['HealerName'..i]:GetText() ~= nil then
			local message1 = "[" .. _G['HealerName'..i]:GetText() .. " -"
			local message2 = ""
			if RHEL_Heals[i] then
				for j = 1, 12 do
					if RHEL_Heals[i][j] then
						if j < 9 then
							message2 = message2 .. " Group" .. j
						elseif j == 9 then
							message2 = message2 .. " MT"
						elseif j > 9 then
							message2 = message2 .. " T" .. (j-8)
						end
					end
				end
			end
			if message2 ~= "" then
				anounce = anounce .. message1 .. message2 .. "]  "	
			end
		end
	end
	print(anounce)
end

--Click on buffs anounce. TO DO
function RHEL_BuffAnounce()
	print("Buffs")
end

--Click on buffs anounce. TO DO
function RHEL_DispellAnounce()
	print("Dispells")
end

--Click on healers personal anounce. Add skiping on empty healer
function RHEL_HealerWisper(number);
	local healer = _G['HealerName'..number]:GetText()
	local wisper = ""
	if healer ~= nil then
		wisper = healer .. ": "
		if RHEL_Heals[number] then
			for j = 1, 12 do
				if RHEL_Heals[number][j] then
					if j < 9 then
						wisper = wisper .. " Group" .. j
					elseif j == 9 then
						wisper = wisper .. " MT"
					elseif j > 9 then
						wisper = wisper .. " T" .. (j-8)
					end
				end
			end
		end
		print(wisper)
	end
end

--Click on checkbox reaction. CHECK
function ClickOnHealCheckBox(healer,target)
	local isChecked
    isChecked=_G['CheckButton1' .. healer.. '_'..target]:GetChecked();
	RHEL_Heals[healer][target] = isChecked
--	print(RHEL_Heals[healer][target])
end

--Healer name editing reaction. CHECK
-- for example
-- healer:GetName() get HealerName1
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
function HealerNameChange(healer)
	local id = tonumber(string.sub(healer:GetName(),11))
	UpdateHealerClass(id);
	RHEL_Healers[id] = _G['HealerName'..id]:GetText()
end

--Select icon for healer. CHECK
function UpdateHealerClass(icon)
	local localizedClass, englishClass, classIndex =  UnitClass(_G["HealerName"..icon]:GetText());
	if englishClass ~= nil then
		_G["HealerClass"..icon.."Texture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
		_G["HealerClass"..icon.."DragTexture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
	else
		_G["HealerClass"..icon.."Texture"]:SetTexture(nil);
		_G["HealerClass"..icon.."DragTexture"]:SetTexture(nil);
	end
end

--Removes focus from healer name window. CHECK
function EditBox_OnEscapePressed(number)
	_G["HealerName"..number]:ClearFocus()
--	RHEL_MainFrame:Hide()
end

--Swap chat to anounce. TO DO
function SwapAnounceTo()
	if toChannel:GetChecked then
		toRaid:SetChecked(false)
	else
		toRaid:SetChecked(true)
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
	if (UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= value) then
		UIDropDownMenu_SetSelectedValue(_G["RaidNameDropdown"], value);
		UIDropDownMenu_ClearAll(_G["BossNameDropdown"]);
		BossNameDropdown_OnLoad();
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
		List = select(UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]),BossNameList.MC, BossNameList.Onyxia, BossNameList.BWL, BossNameList.NAX, BossNameList.Custome);
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
		if _G["RHEL_MainFrame"]:IsShown() then
			print(UIDropDownMenu_GetText(_G["RaidNameDropdown"]).." - "..UIDropDownMenu_GetText(_G["BossNameDropdown"]));
		end
	end
end

--Set boss name on select. CHECK
function BossName_OnSelect(value)
	UIDropDownMenu_SetSelectedValue(_G["BossNameDropdown"], value);
	print(UIDropDownMenu_GetText(_G["RaidNameDropdown"]).." - "..UIDropDownMenu_GetText(_G["BossNameDropdown"]));
end