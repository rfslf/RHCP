-- Author      : Virgo
-- Create Date : 12/19/2019 7:43:57 PM

local version = 0.3
local totalHealers = 8

local RaidNameList = {"Molten Core","Onyxia's Lair & Outdoors","Blackwing Lair","Naxxramas", "Custome"};
local BossNameList = {};
BossNameList.Onyxia = {"Onyxia","Azuregos","Kazzak"};
BossNameList.MC = {"Trash","Lucifron","Magmadar","Gehennas","Garr","Baron Geddon",
				   "Shazzrah","Golemagg","Sulfuron","Majordomo","Ragnaros"};
BossNameList.BWL = {"Trash","Razorgore","Vaelastrasz","Broodlord","Firemaw",
					"Ebonroc","Flamegor","Chromaggus","Nefarian"}   
BossNameList.NAX = {"Trash","Anub'Rekhan","Grand Widow Faerlina","Maexxna",
					"Noth the Plaguebringer","Heigan the Unclean","Loatheb",
					"Instructor Razuvious","Gothic the Harvester","The Four Horsemen",
					"Patchwerk","Grobbulus","Gluth","Thaddius","Sapphiron","Kel'Thuzad"};
				   
local VariablesLoaded

SLASH_RHEL_SLASHCMD1 = '/RHEL'
SLASH_RHEL_SLASHCMD2 = '/rhel'
SlashCmdList["RHEL_SLASHCMD"] = function(msg)
    RHEL_MainFrame:Show()
end

function RHEL_Loaded()
--CHECK
	print('RaidHealersEasyLife loaded. Type /rhel for menu. Version '..version);
--	RHEL_MainFrame:Hide();
end

function RHEL_OnMouseDown()
--DONE
	RHEL_MainFrame:StartMoving()
end

function RHEL_OnMouseUp()
--DONE
	RHEL_MainFrame:StopMovingOrSizing()
end

function RHEL_VariablesLoaded(event)
--TO DO
	if(event == "VARIABLES_LOADED") then
		if RHEL_Heals == nil then
			RHEL_Heals = {{false,false,false,false,false,false,false,false,true,false,false,false},
						  {false,false,false,false,false,false,false,false,true,false,false,false},
						  {false,false,false,false,false,false,false,false,true,true,false,false},
						  {false,false,false,false,false,false,false,false,false,true,false,false},
						  {true,false,true,false,true,false,true,false,true,false,true,false},
						  {true,false,true,false,true,false,true,false,true,false,true,false},
						  {false,true,false,true,false,true,false,true,false,true,false,true},
						  {false,true,false,true,false,true,false,true,false,true,false,true}}; 
--							  1	   2    3     4    5     6    7     8    MT    T2	T3	  T4
-- This is the first time this addon is loaded; initialize heals to defaults.
		end
		if RHEL_Healers == nil then
			for i, totalHealers do
				RHEL_Healers[i] = "Name"..i;
-- This is the first time this addon is loaded; initialize healers to NameNumber.
		end
		RHEL_HealersLoad();
		RHEL_HealsLoad();
		VariablesLoaded = true
	end
end

function RHEL_HealersLoad()
--CHECK
	for i = 1, totalHealers do
		_G['HealerName'..i]:SetText(RHEL_Healers[i])
	end
end

function RHEL_HealsLoad()
--Optimaze
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

function RHEL_HealAnounce()
--DONE
	local anounce = "HEALINGS: "
	for i = 1,totalHealers do
		local message = "[" .. _G['HealerName'..i]:GetText() .. " -"

		if RHEL_Heals[i] then
			for j = 1, 12 do
				if RHEL_Heals[i][j] then
					if j < 9 then
						message = message .. " Group" .. j
					elseif j == 9 then
						message = message .. " MT"
					elseif j > 9 then
						message = message .. " T" .. (j-8)
					end
				end
			end
		end	
		anounce = anounce .. message .. "]  "
	end
	print(anounce)
end

function ClickOnHealCheckBox(healer,target)
--CHECK
	local isChecked
--	isChecked = CheckButton11_1:GetChecked()
    isChecked=_G['CheckButton1' .. healer.. '_'..target]:GetChecked();
--	CheckButton11_1:SetChecked(not isChecked)
--	_G['CheckButton1' .. healer.. '_'..target]:SetChecked(not isChecked);
	RHEL_Heals[healer][target] = isChecked
	print(RHEL_Heals[healer][target])
end

function HealerNameChange(healer)
--CHECK
-- for example
-- healer:GetName() get HealerName1
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
	local id = tonumber(string.sub(healer:GetName(),11))
	UpdateHealerClass(id);
	RHEL_Healers[id] = _G['HealerName'..id]:GetText()
end

function UpdateHealerClass(icon)
--CHECK
	local localizedClass, englishClass, classIndex =  UnitClass(_G["HealerName"..icon]:GetText());
	if englishClass ~= nil then
		_G["HealerClass"..icon.."Texture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
		_G["HealerClass"..icon.."DragTexture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
	else
		_G["HealerClass"..icon.."Texture"]:SetTexture(nil);
		_G["HealerClass"..icon.."DragTexture"]:SetTexture(nil);
	end
end

function EditBox_OnEscapePressed(number)
--CHECK
	_G["HealerName"..number]:SetAutoFocus(false)
--	RHEL_MainFrame:Hide()
end


local info = {};

function RaidNameDropdown_OnLoad()
--TO DO
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

function RaidName_OnSelect(value)
--TO DO
	if (UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= value) then
		UIDropDownMenu_SetSelectedValue(_G["RaidNameDropdown"], value);
		UIDropDownMenu_ClearAll(_G["BossNameDropdown"]);
		BossNameDropdown_OnLoad();
	end
end

function BossNameDropdown_OnLoad()
--TO DO
	if (VariablesLoaded == false) then
		return;
	end;
	
	local x;
	local List = {};
	
	if UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]) ~= nil then
		List = select(UIDropDownMenu_GetSelectedValue(_G["RaidNameDropdown"]),BossNameList.KZ, BossNameList.GL, BossNameList.ML, BossNameList.SSC, BossNameList.TK, BossNameList.MH, BossNameList.BT, BossNameList.SWP, BossNameList.NAX, BossNameList.OS, BossNameList.EOE, BossNameList.VoA, BossNameList.Ulduar, BossNameList.TotC, BossNameList.TotGC, BossNameList.Onyxia, BossNameList.IC, BossNameList.RS, BossNameList.BH, BossNameList.BoT, BossNameList.BWD, BossNameList.TotFW, BossNameList.Firelands, BossNameList.DragonSoul);
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
			RHEL_MainFrame:LoadFromFile(UIDropDownMenu_GetText(_G["RaidNameDropdown"]).." - "..UIDropDownMenu_GetText(_G["BossNameDropdown"]));
		end
	end
end

function BossName_OnSelect(value)
--TO DO
	UIDropDownMenu_SetSelectedValue(_G["BossNameDropdown"], value);
	RHEL_MainFrame:LoadFromFile(UIDropDownMenu_GetText(_G["RaidNameDropdown"]).." - "..UIDropDownMenu_GetText(_G["BossNameDropdown"]));
end