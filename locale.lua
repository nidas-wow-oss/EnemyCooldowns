local _, engine = ...

local L = {}
engine.L = L

L["ADDON_LOADED"]       = "|cff4fc3f7[Enemy Cooldowns]|r Loaded! Use /ecd"
L["ADDON_ENABLED"]      = "|cff4fc3f7[Enemy Cooldowns]|r Enabled"
L["ADDON_DISABLED"]     = "|cff4fc3f7[Enemy Cooldowns]|r Disabled"
L["FRAME_LOCKED"]       = "|cff4fc3f7[Enemy Cooldowns]|r Frame locked"
L["FRAME_UNLOCKED"]     = "|cff4fc3f7[Enemy Cooldowns]|r Frame unlocked - Drag to reposition"
L["POSITION_RESET"]     = "|cff4fc3f7[Enemy Cooldowns]|r Position reset"

L["CMD_HEADER"]         = "|cff4fc3f7[Enemy Cooldowns]|r Commands:"
L["CMD_CONFIG"]         = "  /ecd config - Open configuration menu"
L["CMD_LOCK"]           = "  /ecd lock - Lock frame position"
L["CMD_UNLOCK"]         = "  /ecd unlock - Unlock frame position"
L["CMD_RESET"]          = "  /ecd reset - Reset position"
L["CMD_TEST"]           = "  /ecd test - Toggle test mode (30 fake cooldowns)"
L["TEST_MODE_BTN"]      = "Test Mode"
L["FIXED_GROUPS"]       = "Fixed positions"
L["FIXED_GROUPS_TIP"]   = "Keeps each enemy's cooldown group in place when you change target (no reordering)."
L["TEST_ON"]            = "|cff4fc3f7[Enemy Cooldowns]|r Test mode ON"
L["TEST_OFF"]           = "|cff4fc3f7[Enemy Cooldowns]|r Test mode OFF"

L["CONFIG_TITLE"]       = "Enemy Cooldowns"
L["SECTION_POSITION"]   = "Frame Position"
L["SECTION_LAYOUT"]     = "Layout"
L["SECTION_PLAYER_NAME"]= "Player Name Font"
L["SECTION_TIMER"]      = "Timer Settings"
L["SECTION_ZONES"]      = "Enable In:"

L["LOCK_FRAME"]         = "Lock Frame"
L["UNLOCK_FRAME"]       = "Unlock Frame"
L["RESET_POSITION"]     = "Reset Position"
L["RESET_ALL"]          = "Reset All"
L["ALL_RESET"]          = "All settings reset to defaults"
L["CMD_RESETALL"]       = "  /ecd resetall - Reset all settings to defaults"

L["SHOW_ENEMY_NAMES"]   = "Show enemy names"
L["COLOR_BY_TIME"]      = "Color by remaining time"
L["SHOW_CD_SWIPE"]      = "Show cooldown clock overlay"

L["FONT"]               = "Font:"
L["STYLE"]              = "Style:"
L["CD_SORT_ORDER"]      = "Sort Order:"

L["ICONS_PER_COLUMN"]   = "Icons / Column"
L["ICON_SPACING"]       = "Y Spacing"
L["COLUMN_SPACING"]     = "X Spacing"
L["GROUP_SPACING"]      = "Group Gap"
L["SCALE"]              = "Scale"
L["FONT_SIZE"]          = "Font Size"

L["COLOR_NORMAL"]       = "Normal (>10s):"
L["COLOR_WARNING"]      = "Warning (<=10s):"
L["COLOR_URGENT"]       = "Urgent (<=3s):"

L["ZONE_ARENA"]         = "Arena"
L["ZONE_BATTLEGROUND"]  = "Battleground"
L["ZONE_WORLD"]         = "World"

L["SORT_CAST"]          = "Cast order (recent first)"
L["SORT_REMAIN_ASC"]    = "Remaining (low to high)"
L["SORT_REMAIN_DESC"]   = "Remaining (high to low)"

L["ANCHOR_LABEL"]       = "Enemy Cooldowns"

L["UNKNOWN"]            = "Unknown"

L["EDIT_MODE_BTN"]      = "Edit Mode"
L["SPELL_LIST_BTN"]     = "Spell list..."
L["SPELL_LIST_TITLE"]   = "Tracked spells"
L["SPELL_LIST_NOTE"]    = "Unchecked spells are ignored: no icon and no cooldown tracked."
L["SPELL_ALL_ON"]       = "All on"
L["SPELL_ALL_OFF"]      = "All off"
L["ZONE_DUEL"]          = "Duel"
L["SPELL_GROUP_UNKNOWN"] = "NOT IN THIS CLIENT"
L["SPELL_RANKS_TIP"]    = "%d ranks, all together."
