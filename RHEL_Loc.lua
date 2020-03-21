-- LOCALIZATION FOR CHAT MESSAGES

-- Table to hold localization dictionary
RHEL_loc = {};

RHEL_loc.Languages = {
    "English",
    "Russian",
	"简体中文",
}
revLang = {};
for i,v in ipairs(RHEL_loc.Languages) do
	revLang[v] = i;
end

RHEL_loc.English = function()
	RHEL_loc["Main menu frame not ready"] = "Main menu frame not ready"
	RHEL_loc["Mini menu frame not ready"] = "Mini menu frame not ready"
	RHEL_loc["Invalid Command. Type '/rhel help'!"] = "Invalid Command. Type '/rhel help'!"
	RHEL_loc["LEGEND"] = "RaidHealersEasyLife loaded. Type /rhel to open. Version "
	RHEL_loc["Long message, total "] = "Long message, total "
	RHEL_loc[" symbols."] = " symbols."
	RHEL_loc['Wrong channel.'] = 'Wrong channel.'
	RHEL_loc["Groups: "] = "Groups-"
	RHEL_loc["All groups."] = "All groups."
	RHEL_loc["All groups or fallen"] = "All groups or fallen"
	RHEL_loc[": HEALINGS!"] = ": HEALINGS!"
	RHEL_loc[": BUFFS!"] = ": BUFFS!"
	RHEL_loc[": DISPELLS!"] = ": DISPELLS!"
	RHEL_loc[" in "] = " in "
	RHEL_loc[" on "] = " on "
	RHEL_loc["Heals:"] = "Heals:"
	RHEL_loc["Buffs:"] = "Buffs:"
	RHEL_loc["Dispells:"] = "Dispells:"
	RHEL_loc[" is not in your raid or party"] = " is not in your raid or party"
	RHEL_loc["Click on checkbox with unknown role"] = "Click on checkbox with unknown role"
	RHEL_loc["Wrong target or not friendly player"] = "Target not in your raid or not friendly player"
	RHEL_loc[" is dead."] = " is dead."
	RHEL_loc[" Heal "] = " Heal "
	RHEL_loc["Com Message too large for server"] = "Com Message too large for server"
	RHEL_loc["Prefix:"] = "Prefix:"
	RHEL_loc["Msg:"] = "Msg:"
	RHEL_loc["Announce banner not reсived by "] = "Announce banner not reсived by "
	
	-- Default tips for "Note"
	RHEL_loc.Razorgore = "Don't get aggro on adds. Use shields and downranked heals. Avoid Fireball Volley by hiding behind pillars."
	RHEL_loc.Vaelastrasz = "Equip Fire Resistance of full +Healing gear. When the MT is afflicted by Burning Adrenaline be ready to transition to the next tank while keeping the old one up. Use HN or PoH on group."
	RHEL_loc.Broodlord = "Pre-shield and HoT and follow up with high healing spells on tanks after Mortal Strike."
	RHEL_loc.Firemaw = "Stay, if possible, where you can heal and be out of LoS of Firemaw. Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. Equip Onyxia Scale Cloak!"
	RHEL_loc.Ebonroc = "Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. DPS should not take any damage. Heal tank through the Thrash. Take off Onyxia Scale Cloak."
	RHEL_loc.Flamegor = "Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. Heal tank through the Thrash. Care for hunters (they wont have time for themselves). Take off Onyxia Scale Cloak."
	RHEL_loc.Chromaggus = "Getting out of LoS for breathes. Heal tanks thrue Frenzy. Dispells must be prioritized. Black-curse, Blue-magic, Green-poison, Red-disease. NEVER LET SOMEONE GET ALL 5 BROOD AFFLICTIONS! Take off Onyxia Scale Cloak."
	RHEL_loc.Nefarian = "Priests must stop healing on their call and wait for it to end. Priests can still heal with Renew and PW:S. Use Stratholme Holy Water on phase 3. Equip Onyxia Scale Cloak!"
	
end

RHEL_loc.Russian = function()
    RHEL_loc["Main menu frame not ready"] = "Окно главного меню не готово"
	RHEL_loc["Mini menu frame not ready"] = "Окно мини меню не готово"
	RHEL_loc["Invalid Command. Type '/rhel help'!"] = "Не верная команда. Наберите '/rhel help'!"
	RHEL_loc["LEGEND"] = "RaidHealersEasyLife загружен. Набрите /rhel чтобы открыть меню. Версия "
	RHEL_loc["Long message, total "] = "Длинное сообщение, всего "
	RHEL_loc[" symbols."] = " символов."
	RHEL_loc['Wrong channel.'] = 'Не верный канал.'
	RHEL_loc["Groups: "] = "Группы-"
	RHEL_loc["All groups."] = "Все группы."
	RHEL_loc["All groups or fallen"] = "Все группы или павших"
	RHEL_loc[": HEALINGS!"] = ": ИСЦЕЛЕНИЕ!"
	RHEL_loc[": BUFFS!"] = ": УСИЛЕНИЕ!"
	RHEL_loc[": DISPELLS!"] = ": РАССЕИВАНИЕ!"
	RHEL_loc[" in "] = " в "
	RHEL_loc[" on "] = " на "
	RHEL_loc["Heals:"] = "Исцеление:"
	RHEL_loc["Buffs:"] = "Усиление:"
	RHEL_loc["Dispells:"] = "Рассеивание:"
	RHEL_loc[" is not in your raid or party"] = " не в вашем рейде или группе"
	RHEL_loc["Click on checkbox with unknown role"] = "Клик на чекбоксе с неизвестной ролью"
	RHEL_loc["Wrong target or not friendly player"] = "Цель не в вашем рейде или не дружественный игрок"
	RHEL_loc[" is dead."] = " погиб"
	RHEL_loc[" Heal "] = " Лечите " 
	RHEL_loc["Com Message too large for server"] = "Слишком длинное COM сообщение для сервера"
	RHEL_loc["Prefix:"] = "Префикс:"
	RHEL_loc["Msg:"] = "Сообщение:"
	RHEL_loc["Announce banner not reсived by "] = "Баннер с анонсом не получен "
	
	-- Default tips for "Note"
	RHEL_loc.Razorgore = "Не рвите агро прислужников. Используйте щиты и низкоуровневые исцеления. Прячьтесь от Града огненных шаров за колоннами."
	RHEL_loc.Vaelastrasz = "Оденьте вещи на Сопротивление Огню или на бонус к Исцелению. Когда на MT Горящий адреналин готовьтесь перейти к следующему танку но не бросайте старого. Используйте Кольцо света или Молитву исцеления."
	RHEL_loc.Broodlord = "Используйте СС:Щ и HoT и продолжайте сильными исцеляющими заклинаниями на танке после Смертельного удара."
	RHEL_loc.Firemaw = "По возможности, стойте вне LoS босса. Теневое пламя наносит урон тьмой и не может быть уменьшен! Используйте СС:Щ и HoT перед Теневым пламенем. Одень Плащ из чешуи Ониксии!"
	RHEL_loc.Ebonroc = "Теневое пламя наносит урон тьмой и не может быть уменьшен! Используйте СС:Щ и HoT перед Теневым пламенем. DPS не должны получать урон. Отлечивайте танка после Взмаха. Одень обычный плащ."
	RHEL_loc.Flamegor = "Теневое пламя наносит урон тьмой и не может быть уменьшен! Используйте СС:Щ и HoT перед Теневым пламенем. Отлечивайте танка после Взмаха. Приглядывайте за охотниками (у них нет времени на себя). Одень обычный плащ."
	RHEL_loc.Chromaggus = "Не стойте в LoS при ослаблении. Ислечивате танков при Бешенстве. Рассеивание в приоритете. Черный-проклятие, Синий-магия, Зеленый-яд, Red-болезнь. Не допустите всех ослаблений! Одень обычный плащ."
	RHEL_loc.Nefarian = "Жрецы должны остановить исцеление на своем призыве. Жрецы могут лечить Обновлением и СС:Щ. Используйте Святую воду Статхольмы на фазе 3. Одень Плащ из чешуи Ониксии!"
	
end

RHEL_loc['简体中文'] = function()
	RHEL_loc["Main menu frame not ready"] = "主界面未就绪"
	RHEL_loc["Mini menu frame not ready"] = "迷你界面未就绪"
	RHEL_loc["Invalid Command. Type '/rhel help'!"] = "无效的命令。输入 '/rhel help'! 获取帮助信息"
	RHEL_loc["LEGEND"] = "RaidHealersEasyLife 已加载. 输入 /rhel 打开主界面。 Version "
	RHEL_loc["Long message, total "] = "消息过长，总计 "
	RHEL_loc[" symbols."] = " 字符。"
	RHEL_loc['Wrong channel.'] = '频道错误'
	RHEL_loc["Groups: "] = "队伍-"
	RHEL_loc["All groups."] = "全部队伍。"
	RHEL_loc["All groups or fallen"] = "所有或剩余未分配的队伍"
	RHEL_loc[": HEALINGS!"] = "：治疗任务分配！"
	RHEL_loc[": BUFFS!"] = "：职业增益任务分配！"
	RHEL_loc[": DISPELLS!"] = "：驱散任务分配！"
	RHEL_loc[" in "] = " 在副本 "
	RHEL_loc[" on "] = " 以下战斗 "
	RHEL_loc["Heals:"] = "治疗："
	RHEL_loc["Buffs:"] = "职业增益："
	RHEL_loc["Dispells:"] = "驱散："
	RHEL_loc[" is not in your raid or party"] = " 不在你的队伍或团队中"
	RHEL_loc["Click on checkbox with unknown role"] = "选中未知角色的复选框"
	RHEL_loc["Wrong target or not friendly player"] = "目标不在你的团队中或不是本阵营玩家"
	RHEL_loc[" is dead."] = " 已经死亡。"
	RHEL_loc[" Heal "] = " 治疗 "
	RHEL_loc["Com Message too large for server"] = "收到的消息超过服务器每条消息的最大限制字符数。"
	RHEL_loc["Prefix:"] = "信息前缀："
	RHEL_loc["Msg:"] = "信息："
	RHEL_loc["Announce banner not reсived by "] = "无法正确广播通知消息，来自于"

	-- Default tips for "Note"
	RHEL_loc.Razorgore = "Don't get aggro on adds. Use shields and downranked heals. Avoid Fireball Volley by hiding behind pillars."
	RHEL_loc.Vaelastrasz = "Equip Fire Resistance of full +Healing gear. When the MT is afflicted by Burning Adrenaline be ready to transition to the next tank while keeping the old one up. Use HN or PoH on group."
	RHEL_loc.Broodlord = "Pre-shield and HoT and follow up with high healing spells on tanks after Mortal Strike."
	RHEL_loc.Firemaw = "Stay, if possible, where you can heal and be out of LoS of Firemaw. Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. Equip Onyxia Scale Cloak!"
	RHEL_loc.Ebonroc = "Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. DPS should not take any damage. Heal tank through the Thrash. Take off Onyxia Scale Cloak."
	RHEL_loc.Flamegor = "Shadow Flame deals Shadow damage and cannot be mitigated or resisted! Pre-shield and HoT the tank right before a Shadow Flame. Heal tank through the Thrash. Care for hunters (they wont have time for themselves). Take off Onyxia Scale Cloak."
	RHEL_loc.Chromaggus = "Getting out of LoS for breathes. Heal tanks thrue Frenzy. Dispells must be prioritized. Black-curse, Blue-magic, Green-poison, Red-disease. NEVER LET SOMEONE GET ALL 5 BROOD AFFLICTIONS! Take off Onyxia Scale Cloak."
	RHEL_loc.Nefarian = "Priests must stop healing on their call and wait for it to end. Priests can still heal with Renew and PW:S. Use Stratholme Holy Water on phase 3. Equip Onyxia Scale Cloak!"
	-- Need correct Chinese font to display this
	--RHEL_loc.Razorgore = "不要吸引小怪的仇恨；使用真言术：盾并配合低等级法术进行治疗是个好办法；躲避在柱子后面避免火球齐射。"
	--RHEL_loc.Vaelastrasz = "穿戴拥有火焰抗性的治疗装备；当前坦克获得燃烧刺激效果时，在死亡前保持其HOT并准备切换治疗下一个坦克；使用神圣新星或者治疗祷言进行团补。"
	--RHEL_loc.Broodlord = "预先给盾并保持HOT；在坦克受到致死打击效果后使用最大等级治疗法术进行治疗。"
	--RHEL_loc.Firemaw = "请待在远离费尔默视线的地方原地进行治疗！首领暗影烈焰技能造成的伤害无法减轻或者抵抗！在受到技能伤害前预先给坦克上盾并保持HOT；记得装备好奥妮克希亚披风。"
	--RHEL_loc.Ebonroc = "首领暗影烈焰技能造成的伤害无法减轻或者抵抗！在受到技能伤害前预先给坦克上盾并保持HOT；由于DPS不会受到任何伤害，因此所有治疗师应专注于治疗坦克；记得脱掉奥妮克希亚披风。"
	--RHEL_loc.Flamegor = "首领暗影烈焰技能造成的伤害无法减轻或者抵抗！在受到技能伤害前预先给坦克上盾并保持HOT；治疗好猎人们（他们没有时间自我治疗）；记得脱掉奥妮克希亚披风。"
	--RHEL_loc.Chromaggus = "注意躲开吐息！在首领疯狂状态时加大坦克治疗；必须优先考虑驱散：黑色-点燃肉体，蓝色-霜冻，绿色-腐蚀性酸，红色-焚化，千万不要让任何人同时获得5种减益！记得脱掉奥妮克希亚披风。"
	--RHEL_loc.Nefarian = "首领点名牧师后，必须立即中断当前治疗法术直到点名结束！点名期间你仍然可以使用真言术：盾和恢复进行治疗！阶段3中你可以使用斯坦索姆圣水来帮助团队清理小怪；记得装备好奥妮克希亚披风。"
end