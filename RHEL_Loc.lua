-- LOCALIZATION FOR CHAT MESSAGES

-- Table to hold localization dictionary
RHEL_loc = {};

RHEL_loc.Languages = {
    "English",
    "Russian"
}

RHEL_loc.English = function()
	RHEL_loc["Main menu frame not ready"] = "Main menu frame not ready"
	RHEL_loc["Mini menu frame not ready"] = "Mini menu frame not ready"
	RHEL_loc["Invalid Command. Type '/rhel help'!"] = "Invalid Command. Type '/rhel help'!"
	RHEL_loc["LEGEND"] = "RaidHealersEasyLife loaded. Type /rhel to open. Version "
	RHEL_loc["Long message, total "] = "Long message, total "
	RHEL_loc[" symbols."] = " symbols."
	RHEL_loc['Wrong channel.'] = 'Wrong channel.'
	RHEL_loc["Groups: "] = "Groups: "
	RHEL_loc["All groups."] = "All groups."
	RHEL_loc["All groups or fallen"] = "All groups or fallen"
	RHEL_loc[": HEALINGS!"] = ": HEALINGS!"
	RHEL_loc[": BUFFS!"] = ": BUFFS!"
	RHEL_loc[": DISPELLS!"] = ": DISPELLS!"
	RHEL_loc[" in "] = " in "
	RHEL_loc[" on "] = " on "
	RHEL_loc["[Heals-"] = "[Heals-"
	RHEL_loc["[Buffs-"] = "[Buffs-"
	RHEL_loc["[Dispells-"] = "[Dispells-"
	RHEL_loc[" is not in your raid or party"] = " is not in your raid or party"
	RHEL_loc["Click on checkbox with unknown role"] = "Click on checkbox with unknown role"
	RHEL_loc["Wrong target or not friendly player"] = "Wrong target or not friendly player"
	RHEL_loc[" is dead."] = " is dead."
	RHEL_loc[" Heal "] = " Heal "
	RHEL_loc["Com Message too large for server"] = "Com Message too large for server"
	RHEL_loc["Prefix:"] = "Prefix:"
	RHEL_loc["Msg:"] = "Msg:"
	
	-- Default tips for "Note"
	RHEL_loc.Razorgore = "Don't get aggro on adds. Use shields and downranked heals. Avoid Fireball Volley by hiding behind pillars."
	RHEL_loc.Vaelastrasz = "Equip Fire Resistance of full +Healing gear. When the MT is afflicted by Burning Adrenaline be ready to transition to the next tank while keeping the old one up. Use HN or PoH on group."
	RHEL_loc.Broodlord = "Pre-shield and HoT and follow up with high healing spells on tanks after Mortal Strike."
	RHEL_loc.Firemaw = "Stay, if possible, where you can heal and be out of LoS of Firemaw. Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. Equip Onyxia Scale Cloak!"
	RHEL_loc.Ebonroc = "Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. DPS should not take any damage. Heal tank through the Thrash. Equip Onyxia Scale Cloak!"
	RHEL_loc.Flamegor = "Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. Heal tank through the Thrash. Care for hunters (they wont have time for themselves). Equip Onyxia Scale Cloak!"
	RHEL_loc.Chromaggus = "Getting out of LoS for breathes. Heal tanks thrue Frenzy. Dispells must be prioritized. Black-curse, Blue-magic, Green-poison, Red-disease. NEVER LET SOMEONE GET ALL 5 BROOD AFFLICTIONS! Take off Onyxia Scale Cloak."
	RHEL_loc.Nefarian = "Priests must stop healing on their call and wait for it to end. Priests can still heal with Renew and PW:S. Use Stratholme Holy Water on phase 3. Equip Onyxia Scale Cloak!"
	
end


RHEL_loc.Russian = function()
    RHEL_loc["Main menu frame not ready"] = "Окно главного меню не готово"
	RHEL_loc["Mini menu frame not ready"] = "Окно мини меню не готово"
	RHEL_loc["Invalid Command. Type '/rhel help'!"] = "Не верная команда. Наберите '/rhel help'!"
	RHEL_loc["LEGEND"] = "RaidHealersEasyLife загружен. Набрите /rhel чтобы открыть. Версия "
	RHEL_loc["Long message, total "] = "Длинное сообщение, всего "
	RHEL_loc[" symbols."] = " символов."
	RHEL_loc['Wrong channel.'] = 'Не верный канал.'
	RHEL_loc["Groups: "] = "Группы: "
	RHEL_loc["All groups."] = "Все группы."
	RHEL_loc["All groups or fallen"] = "Все группы или павших"
	RHEL_loc[": HEALINGS!"] = ": ИСЦЕЛЕНИЕ!"
	RHEL_loc[": BUFFS!"] = ": УСИЛЕНИЕ!"
	RHEL_loc[": DISPELLS!"] = ": РАССЕИВАНИЕ!"
	RHEL_loc[" in "] = " в "
	RHEL_loc[" on "] = " на "
	RHEL_loc["[Heals-"] = "[Исцеление-"
	RHEL_loc["[Buffs-"] = "[Усиление-"
	RHEL_loc["[Dispells-"] = "[Рассеивание-"
	RHEL_loc[" is not in your raid or party"] = " не в вашем рейде или группе"
	RHEL_loc["Click on checkbox with unknown role"] = "Клик на чекбоксе с неизвестной ролью"
	RHEL_loc["Wrong target or not friendly player"] = "Не правильная цель или не дружественный игрок"
	RHEL_loc[" is dead."] = " погиб"
	RHEL_loc[" Heal "] = " Лечите " 
	RHEL_loc["Com Message too large for server"] = "Слишком длинное COM сообщение для сервера"
	RHEL_loc["Prefix:"] = "Префикс:"
	RHEL_loc["Msg:"] = "Сообщение:"
	
	
	-- Default tips for "Note"
	RHEL_loc.Razorgore = "Не рвите агро прислужников. Используйте щиты и низкоуровневые исцеления. Прячьтесь от Града огненных шаров за колоннами."
	RHEL_loc.Vaelastrasz = "Оденьте вещи на Сопротивление Огню или на бонус к Исцелению. Когда на MT Горящий адреналин готовьтесь перейти к следующему танку но не бросайте старого. Используйте Кольцо света или Молитву исцеления."
	RHEL_loc.Broodlord = "Используйте СС:Щ и HoT и продолжайте сильными исцеляющими заклинаниями на танке после Смертельного удара."
	RHEL_loc.Firemaw = "По возможности, стойте вне LoS босса. Теневое пламя наносит урон тьмой и не может быть уменьшен! Используйте СС:Щ и HoT перед Теневым пламенем. Одень Плащ из чешуи Ониксии!"
	RHEL_loc.Ebonroc = "Теневое пламя наносит урон тьмой и не может быть уменьшен! Используйте СС:Щ и HoT перед Теневым пламенем. DPS не должны получать урон. Отлечивайте танка после Взмаха. Одень Плащ из чешуи Ониксии!"
	RHEL_loc.Flamegor = "Теневое пламя наносит урон тьмой и не может быть уменьшен! Используйте СС:Щ и HoT перед Теневым пламенем. Отлечивайте танка после Взмаха. Приглядывайте за охотниками (у них нет времени на себя). Одень Плащ из чешуи Ониксии!"
	RHEL_loc.Chromaggus = "Не стойте в LoS при ослаблении. Ислечивате танков при Бешенстве. Рассеивание в приоритете. Черный-проклятие, Синий-магия, Зеленый-яд, Red-болезнь. Не допустите всех ослаблений! Одень обычный плащ."
	RHEL_loc.Nefarian = "Жрецы должны остановить исцеление на своем призыве. Жрецы могут лечить Обновлением и СС:Щ. Используйте Святую воду Статхольмы на фазе 3. Одень Плащ из чешуи Ониксии!"
	
end


