-- Author      : Virgo
-- Create Date : 12/19/2019 7:43:57 PM
-- RHEL_Heals={}
local vesion = 0.1

if RHEL_Heals == nil then
   	RHEL_Heals = {{false,true,false,false,true,false,false,false,true,false,false,false},
				  {false,true,false,false,false,false,false,true,false,false,false,false}}; 
	-- This is the first time this addon is loaded; initialize heals to false.
end

if RHEL_Healer == nil then
	RHEL_Healer = {" ","-"}
end

SLASH_RHEL_SLASHCMD1 = '/RHEL'
SLASH_RHEL_SLASHCMD2 = '/rhel'
SlashCmdList["RHEL_SLASHCMD"] = function(msg)
    RHEL_MainFrame:Show()
end

function RHEL_OnMouseDown()
	RHEL_MainFrame:StartMoving()
end

function RHEL_OnMouseUp()
	RHEL_MainFrame:StopMovingOrSizing()
end

function RHEL_HealsOnLoad()
	for i = 1, 2 do
		for j = 1, 12 do
			_G['CheckButton1' .. i .. "_"..j]:SetChecked(RHEL_Heals[i][j]);
		end
	end
	RHEL_MainFrame:Hide()
	print('RHEL loaded. Version '..version)
end

function RHEL_HealAnounce()
	local anounce = "HEALINGS: "
	for i = 1,2 do
		local message = "[" .. _G['HealerName'..i]:GetText() .. " -"

		if RHEL_Heals[i] then
			for j = 1, 8 do
				if RHEL_Heals[i][j] then
					if j < 9 then
						message = message .. " Group" .. j
					elseif j == 10 then
						message = message .. " MT"
					else j > 12 then
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
	local isChecked
--	isChecked = CheckButton11_1:GetChecked()
    isChecked=_G['CheckButton1' .. healer.. '_'..target]:GetChecked();
--	CheckButton11_1:SetChecked(not isChecked)
--	_G['CheckButton1' .. healer.. '_'..target]:SetChecked(not isChecked);
	RHEL_Heals[healer][target] = isChecked
	print(RHEL_Heals)
end

function HealerNameChange(healer)
-- for example
-- healer:GetName() get HealerName1
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
	local id = tonumber(string.sub(healer:GetName(),11))
	UpdateHealerClass(id);
	RHEL_Healer[id] = _G['HealerName'..id]:GetText()
end

-- TO DO
function UpdateHealerClass(icon)
	local englishClass = UnitClass(_G["HealerName"..icon]:GetText());
	if englishClass ~= nil then
		_G["HealerClass"..icon.."Texture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
		_G["HealerClass"..icon.."DragTexture"]:SetTexture("Interface\\Addons\\RHEL\\Icons\\"..englishClass);
	else
		_G["HealerClass"..icon.."Texture"]:SetTexture(nil);
		_G["HealerClass"..icon.."DragTexture"]:SetTexture(nil);
	end
end


function EditBox_OnEscapePressed()
	RHEL_MainFrame:Hide()
end
