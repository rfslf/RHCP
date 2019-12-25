-- Author      : Virgo
-- Create Date : 12/19/2019 7:43:57 PM

RHEL_Heals={}

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

function RHEL_OnLoad()
	print('Start')
	if RHEL_Heals == nil then
   		RHEL_Heals = {true,false,false,false,false,false,false,false,false,false,false,false}; -- This is the first time this addon is loaded; initialize heals to false.
  	end
	CheckButton11_1:SetChecked(RHEL_Heals[1]);
	CheckButton11_2:SetChecked(RHEL_Heals[2]);
	CheckButton11_3:SetChecked(RHEL_Heals[3]);
	CheckButton11_4:SetChecked(RHEL_Heals[4]);
	CheckButton11_5:SetChecked(RHEL_Heals[5]);
	CheckButton11_6:SetChecked(RHEL_Heals[6]);
	CheckButton11_7:SetChecked(RHEL_Heals[7]);
	CheckButton11_8:SetChecked(RHEL_Heals[8]);
	CheckButton11_9:SetChecked(RHEL_Heals[9]);
	CheckButton11_10:SetChecked(RHEL_Heals[10]);
	CheckButton11_11:SetChecked(RHEL_Heals[11]);
	CheckButton11_12:SetChecked(RHEL_Heals[12]);
--  _G['CheckButton11_'..number]:SetChecked(RHEL_Heals[number]);
	print('Finish')
end

function RHEL_HealAnounce()
	local message=""
	for i = 1, 12 do
		if RHEL_Heals[i] then
			if message == "" then
				message = "HEALING:" .. "Group " .. i
			else
				message = message .. ",Group " .. i
			end
		else
			message = "None"
		end
	print(message)
end

function ClickOnHealCheckBox(number)
	local isChecked
	isChecked = CheckButton11_1:GetChecked()
--  isChecked=_G['CheckButton11_'..number]:GetChecked()
	CheckButton11_1:SetChecked(not isChecked)
--	_G['CheckButton11_'..number]:SetChecked(not isChecked)
	RHEL_Heals[number] = not isChecked
end

function HealerNameChange(healer)
	local id = tonumber(string.sub(healer:GetName(),11))
	UpdateHealerClass(id);
end

function EditBox_OnEscapePressed()
	SurgeonGeneralConfigFrame:Hide()
end
