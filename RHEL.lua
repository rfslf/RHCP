-- Author      : Virgo
-- Create Date : 12/19/2019 7:43:57 PM

-- RHEL_Heals={}

SLASH_RHEL_SLASHCMD1 = '/RHEL'
SLASH_RHEL_SLASHCMD2 = '/rhel'
SlashCmdList["RHEL_SLASHCMD"] = function(msg)
--    RHEL_MainFrame:Show()
	print("Hi!")
end

function RHEL_OnMouseDown()
	RHEL_MainFrame:StartMoving()
end

function RHEL_OnMouseUp()
	RHEL_MainFrame:StopMovingOrSizing()
end

function RHEL_HealsOnLoad()
	print('Start')
	if RHEL_Heals == nil then
   		RHEL_Heals = {{true,false,false,false,false,false,false,false,false,false,false,false},{}}; -- This is the first time this addon is loaded; initialize heals to false.
  	end
--	CheckButton11_1:SetChecked(RHEL_Heals[1]);
	for i = 1, 2 do
		for j = 1, 12 do
			_G['CheckButton1' .. i .. "_"..j]:SetChecked(RHEL_Heals[i][j]);
		end
	end
	print('Finish')
end

function RHEL_HealAnounce()
	local anounce = "HEALING: "
	for i = 1,2 do
		local message
		if __G['HealerName'..i]:GetText() == nil
			break
		if message == "" then
			message = "[" .. __G['HealerName'..i]:GetText() .. " -"
		end
		if RHEL_Heals then
			for j = 1, 8 do
				if RHEL_Heals[j] then
					message = message .. " Group" .. j
				end
			end
			if RHEL_Heals[9] then
				message = message .. " MT"
			end
			for j = 10, 12 do
				if RHEL_Heals[j] then
					message = message .. " T" .. (j-8)
				end
			end
		end
		anounce = anounce .. message .. "]"
	end
	print(anounce)
end

function ClickOnHealCheckBox(healer,target)
	local isChecked
--	isChecked = CheckButton11_1:GetChecked()
    isChecked=_G['CheckButton1' .. healer.. '_'..number]:GetChecked()
--	CheckButton11_1:SetChecked(not isChecked)
	_G['CheckButton1' .. healer.. '_'..number]:SetChecked(not isChecked)
	RHEL_Heals[number] = not isChecked
end

function HealerNameChange(healer)
-- for example
-- healer:GetName() get HealerName1
-- string.sub(healer:GetName(),11) take from 11-th character inclusive and get '1'
-- tonumber turns variable to 1
	local id = tonumber(string.sub(healer:GetName(),11)) 
	UpdateHealerClass(id);
end

-- TO DO
function UpdateHealerClass(icon)
	local _,englishClass = UnitClass(_G["HealerName"..icon]:GetText());
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
