local _, engine = ...

-- Localization: English defaults are defined here.
-- Locale-specific files (e.g. esES.lua) override keys after this loads.

local L = {}
engine.L = L

-- Addon messages
L["ADDON_LOADED"]       = "|cff00ff00[Enemy Cooldowns]|r Loaded! Use /ecd"
L["ADDON_ENABLED"]      = "|cff00ff00[Enemy Cooldowns]|r Enabled"
L["ADDON_DISABLED"]     = "|cff00ff00[Enemy Cooldowns]|r Disabled"
L["FRAME_LOCKED"]       = "|cff00ff00[Enemy Cooldowns]|r Frame locked"
L["FRAME_UNLOCKED"]     = "|cff00ff00[Enemy Cooldowns]|r Frame unlocked - Drag to reposition"
L["POSITION_RESET"]     = "|cff00ff00[Enemy Cooldowns]|r Position reset"

-- Slash commands help
L["CMD_HEADER"]         = "|cff00ff00[Enemy Cooldowns]|r Commands:"
L["CMD_CONFIG"]         = "  /ecd config - Open configuration menu"
L["CMD_LOCK"]           = "  /ecd lock - Lock frame position"
L["CMD_UNLOCK"]         = "  /ecd unlock - Unlock frame position"
L["CMD_RESET"]          = "  /ecd reset - Reset position"

-- Config panel: section titles (color applied by config.lua, so no color codes here)
L["CONFIG_TITLE"]       = "Enemy Cooldowns"
L["SECTION_POSITION"]   = "Frame Position"
L["SECTION_LAYOUT"]     = "Layout"
L["SECTION_PLAYER_NAME"]= "Player Name Font"
L["SECTION_TIMER"]      = "Timer Settings"
L["SECTION_ZONES"]      = "Enable In:"

-- Config panel: buttons
L["LOCK_FRAME"]         = "Lock Frame"
L["UNLOCK_FRAME"]       = "Unlock Frame"
L["RESET_POSITION"]     = "Reset Position"
L["RESET_ALL"]          = "Reset All"
L["ALL_RESET"]          = "All settings reset to defaults"
L["CMD_RESETALL"]       = "  /ecd resetall - Reset all settings to defaults"

-- Config panel: checkboxes
L["SHOW_ENEMY_NAMES"]   = "Show enemy names"
L["COLOR_BY_TIME"]      = "Color by remaining time"
L["SHOW_CD_SWIPE"]      = "Show cooldown clock overlay"

-- Config panel: labels
L["FONT"]               = "Font:"
L["STYLE"]              = "Style:"
L["CD_SORT_ORDER"]      = "Sort Order:"

-- Config panel: sliders (NUF-style: centered title, value shown separately below)
L["ICONS_PER_COLUMN"]   = "Icons / Column"
L["ICON_SPACING"]       = "Y Spacing"
L["COLUMN_SPACING"]     = "X Spacing"
L["GROUP_SPACING"]      = "Group Gap"
L["SCALE"]              = "Scale"
L["FONT_SIZE"]          = "Font Size"

-- Config panel: color pickers
L["COLOR_NORMAL"]       = "Normal (>10s):"
L["COLOR_WARNING"]      = "Warning (<=10s):"
L["COLOR_URGENT"]       = "Urgent (<=3s):"

-- Config panel: zones
L["ZONE_ARENA"]         = "Arena"
L["ZONE_BATTLEGROUND"]  = "Battleground"
L["ZONE_WORLD"]         = "World"

-- Sort modes
L["SORT_CAST"]          = "Cast order (recent first)"
L["SORT_REMAIN_ASC"]    = "Remaining (low to high)"
L["SORT_REMAIN_DESC"]   = "Remaining (high to low)"

-- Anchor
L["ANCHOR_LABEL"]       = "Enemy Cooldowns"

-- Misc
L["UNKNOWN"]            = "Unknown"