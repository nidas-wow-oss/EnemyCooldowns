local ADDON_NAME, engine = ...

local configFrame
local isDragging = false
local anchorFrame
local L

-- Widget references for in-place reset
local W = {}

-- Theme
local THEME_BLUE = {r = 0.30, g = 0.65, b = 1.0}
local THEME_CYAN = {r = 0.40, g = 0.85, b = 1.0}
local THEME_LINE = {r = 0.20, g = 0.50, b = 0.80}
local THEME_BG   = {r = 0.05, g = 0.10, b = 0.18}

local MEDIA = "Interface\\AddOns\\EnemyCooldowns\\Media\\Fonts\\"

-- Font list (only 2 custom + 4 default)
local fontList = {
    {name = "Friz Quadrata",     path = "Fonts\\FRIZQT__.TTF"},
    {name = "Arial",             path = "Fonts\\ARIALN.TTF"},
    {name = "Morpheus",          path = "Fonts\\MORPHEUS.TTF"},
    {name = "Skurri",            path = "Fonts\\skurri.TTF"},
    {name = "ContinuumMedium",   path = MEDIA .. "ContinuumMedium.ttf"},
    {name = "DomyoujiRegular",   path = MEDIA .. "DomyoujiRegular.ttf"},
}

local outlineList = {
    {name = "None",          value = ""},
    {name = "Outline",       value = "OUTLINE"},
    {name = "Thick Outline", value = "THICKOUTLINE"},
}

-- Defaults
local defaults = {
    position = { point = "CENTER", x = 0, y = 200 },
    locked = true,
    showEnemyNames = true,
    sortMode = "cast",
    iconsPerColumn = 6,
    groupsOffset = 22,
    columnSpacing = 25,
    scale = 1.0,
    iconSpacing = 6,
    enabledZones = { arena = true, battleground = false, world = false },
    timerSettings = {
        font = "Fonts\\FRIZQT__.TTF", fontSize = 14, fontOutline = "",
        useColorByTime = true,
        colorNormal = {r = 1, g = 1, b = 1},
        color10s    = {r = 1, g = 1, b = 0.3},
        color3s     = {r = 1, g = 0.3, b = 0.3},
    },
    playerNameSettings = {
        font = "Fonts\\FRIZQT__.TTF", fontSize = 12, fontOutline = "OUTLINE",
    },
    showCooldownSwipe = true,
}

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------
local function DeepCopy(src)
    if type(src) ~= "table" then return src end
    local dst = {}
    for k, v in pairs(src) do dst[k] = DeepCopy(v) end
    return dst
end

local function FillDefaults(db, def)
    for k, v in pairs(def) do
        if db[k] == nil then
            db[k] = DeepCopy(v)
        elseif type(v) == "table" and type(db[k]) == "table" then
            FillDefaults(db[k], v)
        end
    end
end

local function FontPathToName(path)
    for _, f in ipairs(fontList) do if f.path == path then return f.name end end
    return "Friz Quadrata"
end

local function OutlineToName(val)
    for _, o in ipairs(outlineList) do if o.value == val then return o.name end end
    return "None"
end

------------------------------------------------------------------------
-- Update all widgets in-place (for Reset All)
------------------------------------------------------------------------
local function UpdateAllWidgets()
    if not configFrame then return end
    local db = EnemyCooldownsDB

    if W.lockBtn then
        W.lockBtn:SetText(db.locked and (L["UNLOCK_FRAME"] or "Unlock Frame") or (L["LOCK_FRAME"] or "Lock Frame"))
    end

    -- Checkboxes
    if W.namesCheck then W.namesCheck:SetChecked(db.showEnemyNames ~= false) end
    if W.colorCheck then W.colorCheck:SetChecked(db.timerSettings.useColorByTime) end
    if W.swipeCheck then W.swipeCheck:SetChecked(db.showCooldownSwipe ~= false) end
    if W.arenaCheck then W.arenaCheck:SetChecked(db.enabledZones.arena) end
    if W.bgCheck    then W.bgCheck:SetChecked(db.enabledZones.battleground) end
    if W.worldCheck then W.worldCheck:SetChecked(db.enabledZones.world) end

    -- Sliders
    if W.iconsCol  then W.iconsCol:SetValue(db.iconsPerColumn) end
    if W.ySpace    then W.ySpace:SetValue(db.iconSpacing) end
    if W.xSpace    then W.xSpace:SetValue(db.columnSpacing) end
    if W.groupGap  then W.groupGap:SetValue(db.groupsOffset) end
    if W.scale     then W.scale:SetValue(db.scale) end
    if W.pNameSize then W.pNameSize:SetValue(db.playerNameSettings.fontSize) end
    if W.timerSize then W.timerSize:SetValue(db.timerSettings.fontSize) end

    -- Dropdowns: just update displayed text; checkmarks update dynamically on open
    if W.sortDD       then UIDropDownMenu_SetText(W.sortDD, ({cast = L["SORT_CAST"] or "Cast order (recent first)", remain_asc = L["SORT_REMAIN_ASC"] or "Remaining (low to high)", remain_desc = L["SORT_REMAIN_DESC"] or "Remaining (high to low)"})[db.sortMode] or "") end
    if W.pNameFontDD  then UIDropDownMenu_SetText(W.pNameFontDD, FontPathToName(db.playerNameSettings.font)) end
    if W.pNameStyleDD then UIDropDownMenu_SetText(W.pNameStyleDD, OutlineToName(db.playerNameSettings.fontOutline)) end
    if W.timerFontDD  then UIDropDownMenu_SetText(W.timerFontDD, FontPathToName(db.timerSettings.font)) end
    if W.timerStyleDD then UIDropDownMenu_SetText(W.timerStyleDD, OutlineToName(db.timerSettings.fontOutline)) end

    -- Color swatches
    for _, key in ipairs({"colorNormal", "color10s", "color3s"}) do
        if W[key] then
            local c = db.timerSettings[key]
            W[key]:SetTexture(c.r, c.g, c.b)
        end
    end
end

------------------------------------------------------------------------
-- InitConfig
------------------------------------------------------------------------
function engine:InitConfig()
    if not EnemyCooldownsDB then EnemyCooldownsDB = {} end
    FillDefaults(EnemyCooldownsDB, defaults)

    engine.ICONS_AT_COLUMN = EnemyCooldownsDB.iconsPerColumn
    engine.ICON_SPACING    = EnemyCooldownsDB.iconSpacing
    engine.ICON_OFFSET_X   = EnemyCooldownsDB.columnSpacing

    L = engine.L or {}
    self:CreateAnchorFrame()
end

------------------------------------------------------------------------
-- Reset All (no reload)
------------------------------------------------------------------------
function engine:ResetAllDefaults()
    EnemyCooldownsDB = DeepCopy(defaults)

    engine.ICONS_AT_COLUMN = defaults.iconsPerColumn
    engine.ICON_SPACING    = defaults.iconSpacing
    engine.ICON_OFFSET_X   = defaults.columnSpacing

    if anchorFrame then
        anchorFrame:ClearAllPoints()
        anchorFrame:SetPoint(defaults.position.point, UIParent, defaults.position.point, defaults.position.x, defaults.position.y)
        anchorFrame:EnableMouse(false)
        anchorFrame.bg:Hide()
        anchorFrame.text:Hide()
    end

    self:ApplyScaleToAll()
    self:ApplyNameVisibilityToAll()
    self:UpdateAllIconFonts()
    self:UpdateAllPlayerNameFonts()
    self:UpdateAllCooldownSwipes()
    self:RefreshAllTrackers()
    self:CheckZoneAndToggle()

    UpdateAllWidgets()

    print("|cff00ff00[Enemy Cooldowns]|r " .. (L["ALL_RESET"] or "All settings reset to defaults"))
end

------------------------------------------------------------------------
-- Anchor frame
------------------------------------------------------------------------
function engine:CreateAnchorFrame()
    if anchorFrame then return end
    anchorFrame = CreateFrame("Frame", "EnemyCooldownsAnchor", UIParent)
    anchorFrame:SetSize(200, 40)
    anchorFrame:SetPoint(EnemyCooldownsDB.position.point, UIParent, EnemyCooldownsDB.position.point, EnemyCooldownsDB.position.x, EnemyCooldownsDB.position.y)

    local bg = anchorFrame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(); bg:SetTexture(0, 0, 0, 0.7); bg:Hide()
    anchorFrame.bg = bg

    local text = anchorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    text:SetPoint("CENTER"); text:SetText(L and L["ANCHOR_LABEL"] or "Enemy Cooldowns"); text:Hide()
    anchorFrame.text = text

    anchorFrame:SetMovable(true); anchorFrame:EnableMouse(false); anchorFrame:RegisterForDrag("LeftButton")
    anchorFrame:SetScript("OnDragStart", function(self) if not EnemyCooldownsDB.locked then self:StartMoving(); isDragging = true end end)
    anchorFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); isDragging = false; engine:SavePosition() end)
end

function engine:SavePosition()
    local point, _, _, x, y = anchorFrame:GetPoint()
    EnemyCooldownsDB.position.point = point
    EnemyCooldownsDB.position.x = x
    EnemyCooldownsDB.position.y = y
end

function engine:GetAnchorFrame() return anchorFrame end

------------------------------------------------------------------------
-- Lock / Unlock
------------------------------------------------------------------------
function engine:ToggleLock()
    EnemyCooldownsDB.locked = not EnemyCooldownsDB.locked
    if EnemyCooldownsDB.locked then
        anchorFrame:EnableMouse(false); anchorFrame.bg:Hide(); anchorFrame.text:Hide()
        print(L["FRAME_LOCKED"])
    else
        anchorFrame:EnableMouse(true); anchorFrame.bg:Show(); anchorFrame.text:Show()
        print(L["FRAME_UNLOCKED"])
    end
    if W.lockBtn then
        W.lockBtn:SetText(EnemyCooldownsDB.locked and (L["UNLOCK_FRAME"] or "Unlock Frame") or (L["LOCK_FRAME"] or "Lock Frame"))
    end
end

------------------------------------------------------------------------
-- Refresh helpers
------------------------------------------------------------------------
function engine:RefreshAllTrackers()
    for GUID, tracker in pairs(engine.trackers or {}) do
        local info = self:GetCooldownInfo(GUID)
        if info then tracker:Update(info) end
    end
    self:UpdatePositions()
end

function engine:ApplyScaleToAll()
    local scale = EnemyCooldownsDB.scale or 1.0
    for _, tracker in pairs(engine.trackers or {}) do
        if tracker and tracker.SetScale then tracker:SetScale(scale) end
    end
    self:UpdatePositions()
end

function engine:ApplyNameVisibilityToAll()
    local show = EnemyCooldownsDB.showEnemyNames ~= false
    for _, tracker in pairs(engine.trackers or {}) do
        if tracker and tracker.name then
            if show then tracker.name:Show() else tracker.name:Hide() end
        end
    end
end

------------------------------------------------------------------------
-- UI WIDGET BUILDERS
------------------------------------------------------------------------

local function CreateSeparator(parent, yOff)
    local line = parent:CreateTexture(nil, "ARTWORK")
    line:SetHeight(1)
    line:SetPoint("TOPLEFT", 4, yOff); line:SetPoint("TOPRIGHT", -4, yOff)
    line:SetTexture(THEME_LINE.r, THEME_LINE.g, THEME_LINE.b, 0.6)
    return yOff - 6
end

local function CreateSection(parent, text, yOff)
    yOff = CreateSeparator(parent, yOff)
    local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fs:SetPoint("TOP", 0, yOff)
    fs:SetTextColor(THEME_BLUE.r, THEME_BLUE.g, THEME_BLUE.b)
    fs:SetText(text)
    return yOff - 20
end

local function CreateNUFSlider(parent, name, x, y, width, minV, maxV, step, curVal, title, onChange)
    local tf = CreateFrame("Frame", nil, parent)
    tf:SetFrameLevel(parent:GetFrameLevel() + 5)
    tf:SetSize(width, 14); tf:SetPoint("TOPLEFT", x, y)
    local tfs = tf:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    tfs:SetPoint("TOP", tf, "TOP", 0, 0)
    tfs:SetTextColor(THEME_CYAN.r, THEME_CYAN.g, THEME_CYAN.b)
    tfs:SetText(title)

    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", x, y - 14)
    slider:SetMinMaxValues(minV, maxV); slider:SetValueStep(step)
    slider:SetWidth(width); slider:SetHeight(14); slider:SetValue(curVal)

    local low = _G[name .. "Low"]; low:ClearAllPoints()
    low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 2, -1)
    low:SetText(minV); low:SetFont(low:GetFont(), 9); low:SetTextColor(0.5, 0.5, 0.5)

    local high = _G[name .. "High"]; high:ClearAllPoints()
    high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -2, -1)
    high:SetText(maxV); high:SetFont(high:GetFont(), 9); high:SetTextColor(0.5, 0.5, 0.5)

    local val = _G[name .. "Text"]; val:ClearAllPoints()
    val:SetPoint("TOP", slider, "BOTTOM", 0, -1)
    val:SetFont(val:GetFont(), 11); val:SetTextColor(1, 1, 1)

    local function Upd(v)
        if step < 1 then val:SetText(string.format("%.2f", v))
        else val:SetText(tostring(math.floor(v + 0.5))) end
    end
    Upd(curVal)

    slider:SetScript("OnValueChanged", function(self, value)
        if step >= 1 then value = math.floor(value + 0.5)
        else value = math.floor(value * 100 + 0.5) / 100 end
        Upd(value)
        if onChange then onChange(value) end
    end)
    return slider
end

local function CreateCheck(parent, x, y, labelText, checked, onClick)
    local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    cb:SetPoint("TOPLEFT", x, y); cb:SetSize(22, 22); cb:SetChecked(checked)
    local t = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    t:SetPoint("LEFT", cb, "RIGHT", 2, 0); t:SetText(labelText); t:SetTextColor(0.9, 0.9, 0.9)
    cb:SetScript("OnClick", function(self) onClick(self:GetChecked() and true or false) end)
    return cb
end

-- FIX #1 & #4: getSelected is a FUNCTION that reads from DB every time the dropdown opens
local function CreateDropdown(parent, name, x, y, width, labelText, items, getSelected, onSelect)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOPLEFT", x + 20, y)
    label:SetTextColor(THEME_CYAN.r, THEME_CYAN.g, THEME_CYAN.b)
    label:SetText(labelText)

    local dd = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
    dd:SetPoint("TOPLEFT", x, y - 14)
    UIDropDownMenu_SetWidth(dd, width)

    UIDropDownMenu_Initialize(dd, function()
        local currentValue = getSelected()  -- read LIVE from DB each time dropdown opens
        for _, item in ipairs(items) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.name
            info.func = function()
                UIDropDownMenu_SetText(dd, item.name)
                if onSelect then onSelect(item.value) end
            end
            info.checked = (item.value == currentValue)
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- Set initial display text
    local initVal = getSelected()
    for _, item in ipairs(items) do
        if item.value == initVal then UIDropDownMenu_SetText(dd, item.name); break end
    end
    return dd
end

local function CreateColorBtn(parent, labelText, x, y, colorKey)
    local t = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    t:SetPoint("TOPLEFT", x, y); t:SetText(labelText); t:SetTextColor(0.9, 0.9, 0.9)

    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(28, 16); btn:SetPoint("LEFT", t, "RIGHT", 8, 0)
    local border = btn:CreateTexture(nil, "ARTWORK")
    border:SetPoint("TOPLEFT", -1, 1); border:SetPoint("BOTTOMRIGHT", 1, -1); border:SetTexture(0.3, 0.3, 0.3)
    local tex = btn:CreateTexture(nil, "OVERLAY"); tex:SetAllPoints()
    W[colorKey] = tex

    local function Refresh() local c = EnemyCooldownsDB.timerSettings[colorKey]; tex:SetTexture(c.r, c.g, c.b) end
    Refresh()

    btn:SetScript("OnClick", function()
        local c = EnemyCooldownsDB.timerSettings[colorKey]
        local pR, pG, pB = c.r, c.g, c.b
        ColorPickerFrame.func = function() c.r, c.g, c.b = ColorPickerFrame:GetColorRGB(); Refresh(); engine:RefreshAllTrackers() end
        ColorPickerFrame.cancelFunc = function() c.r, c.g, c.b = pR, pG, pB; Refresh(); engine:RefreshAllTrackers() end
        ColorPickerFrame.previousValues = {pR, pG, pB}
        ColorPickerFrame:SetColorRGB(c.r, c.g, c.b); ColorPickerFrame:Show()
    end)
    return btn
end

------------------------------------------------------------------------
-- Confirmation popup
------------------------------------------------------------------------
StaticPopupDialogs["ECD_CONFIRM_RESET_ALL"] = {
    text = "Reset ALL Enemy Cooldowns settings to defaults?",
    button1 = "Yes", button2 = "Cancel",
    OnAccept = function() engine:ResetAllDefaults() end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

------------------------------------------------------------------------
-- CREATE CONFIG MENU
------------------------------------------------------------------------
function engine:CreateConfigMenu()
    if configFrame then configFrame:Show(); return end
    L = engine.L or {}

    configFrame = CreateFrame("Frame", "EnemyCooldownsConfig", UIParent)
    configFrame:SetSize(480, 620); configFrame:SetPoint("CENTER")
    configFrame:SetMovable(true); configFrame:EnableMouse(true)
    configFrame:RegisterForDrag("LeftButton")
    configFrame:SetScript("OnDragStart", configFrame.StartMoving)
    configFrame:SetScript("OnDragStop", configFrame.StopMovingOrSizing)
    configFrame:SetFrameStrata("DIALOG")
    configFrame:SetBackdrop({
        bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = {left = 5, right = 5, top = 5, bottom = 5},
    })
    configFrame:SetBackdropColor(0.028, 0.048, 0.095, 0.97)
    configFrame:SetBackdropBorderColor(0.22, 0.52, 0.92, 0.95)
    table.insert(UISpecialFrames, "EnemyCooldownsConfig")

    -- titleBox: narrow, centered, protrudes above the frame top (NUF style)
    local titleBox = CreateFrame("Frame", nil, configFrame)
    titleBox:SetWidth(260)
    titleBox:SetHeight(36)
    titleBox:SetPoint("BOTTOM", configFrame, "TOP", 0, -20)
    titleBox:SetFrameLevel(configFrame:GetFrameLevel() + 2)
    titleBox:SetBackdrop({
        bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
    })
    titleBox:SetBackdropColor(0.035, 0.065, 0.140, 1.0)
    titleBox:SetBackdropBorderColor(0.28, 0.68, 1.0, 1.0)

    configFrame.title = titleBox:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    configFrame.title:SetPoint("CENTER", titleBox, "CENTER", 0, 0)
    configFrame.title:SetTextColor(1.0, 0.82, 0.0)   -- gold/yellow like NUF
    configFrame.title:SetText("Enemy Cooldowns")

    -- Subtitle sits below the titleBox, on the main frame (outside the box)
    local sub = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    sub:SetPoint("TOP", configFrame, "TOP", 0, -20)
    sub:SetTextColor(0.45, 0.55, 0.65)
    sub:SetText("Cooldown Tracker & PvP Tools")

    local closeBtn = CreateFrame("Button", nil, configFrame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function() configFrame:Hide() end)

    local sf = CreateFrame("ScrollFrame", "ECDConfigScroll", configFrame, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", 10, -38); sf:SetPoint("BOTTOMRIGHT", -28, 10)
    local sc = CreateFrame("Frame"); sc:SetSize(430, 1400); sf:SetScrollChild(sc)

    local y = -4
    local LEFT, RIGHT, HW = 12, 225, 195

    local fontItems, outlineItems = {}, {}
    for _, f in ipairs(fontList) do fontItems[#fontItems + 1] = {name = f.name, value = f.path} end
    for _, o in ipairs(outlineList) do outlineItems[#outlineItems + 1] = {name = o.name, value = o.value} end

    -- ==================== FRAME POSITION ====================
    y = CreateSection(sc, L["SECTION_POSITION"] or "Frame Position", y)

    W.lockBtn = CreateFrame("Button", nil, sc, "GameMenuButtonTemplate")
    W.lockBtn:SetSize(125, 24); W.lockBtn:SetPoint("TOPLEFT", LEFT, y)
    W.lockBtn:SetText(EnemyCooldownsDB.locked and (L["UNLOCK_FRAME"] or "Unlock Frame") or (L["LOCK_FRAME"] or "Lock Frame"))
    W.lockBtn:SetScript("OnClick", function() engine:ToggleLock() end)

    local resetBtn = CreateFrame("Button", nil, sc, "GameMenuButtonTemplate")
    resetBtn:SetSize(125, 24); resetBtn:SetPoint("LEFT", W.lockBtn, "RIGHT", 6, 0)
    resetBtn:SetText(L["RESET_POSITION"] or "Reset Position")
    resetBtn:SetScript("OnClick", function()
        EnemyCooldownsDB.position = DeepCopy(defaults.position)
        anchorFrame:ClearAllPoints()
        anchorFrame:SetPoint(defaults.position.point, UIParent, defaults.position.point, defaults.position.x, defaults.position.y)
        engine:UpdatePositions()
    end)

    local resetAllBtn = CreateFrame("Button", nil, sc, "GameMenuButtonTemplate")
    resetAllBtn:SetSize(125, 24); resetAllBtn:SetPoint("LEFT", resetBtn, "RIGHT", 6, 0)
    resetAllBtn:SetText(L["RESET_ALL"] or "Reset All")
    resetAllBtn:GetFontString():SetTextColor(1, 0.4, 0.4)
    resetAllBtn:SetScript("OnClick", function() StaticPopup_Show("ECD_CONFIRM_RESET_ALL") end)

    y = y - 30

    -- ==================== LAYOUT ====================
    y = CreateSection(sc, L["SECTION_LAYOUT"] or "Layout", y)

    local sortModes = {
        {name = L["SORT_CAST"]        or "Cast order (recent first)", value = "cast"},
        {name = L["SORT_REMAIN_ASC"]  or "Remaining (low to high)",   value = "remain_asc"},
        {name = L["SORT_REMAIN_DESC"] or "Remaining (high to low)",   value = "remain_desc"},
    }

    -- FIX #4: getter function reads live from DB
    W.sortDD = CreateDropdown(sc, "ECDSortDD", LEFT - 10, y, 200,
        L["CD_SORT_ORDER"] or "Sort Order:", sortModes,
        function() return EnemyCooldownsDB.sortMode or "cast" end,
        function(v) EnemyCooldownsDB.sortMode = v; engine:RefreshAllTrackers() end)
    y = y - 54

    W.iconsCol = CreateNUFSlider(sc, "ECDIconsCol", LEFT, y, HW, 3, 10, 1,
        EnemyCooldownsDB.iconsPerColumn or 6, L["ICONS_PER_COLUMN"] or "Icons / Column",
        function(v) EnemyCooldownsDB.iconsPerColumn = v; engine.ICONS_AT_COLUMN = v; engine:RefreshAllTrackers() end)

    W.ySpace = CreateNUFSlider(sc, "ECDYSpace", RIGHT, y, HW, 0, 20, 1,
        EnemyCooldownsDB.iconSpacing or 6, L["ICON_SPACING"] or "Y Spacing",
        function(v) EnemyCooldownsDB.iconSpacing = v; engine.ICON_SPACING = v; engine:RefreshAllTrackers() end)
    y = y - 48

    W.xSpace = CreateNUFSlider(sc, "ECDXSpace", LEFT, y, HW, 0, 80, 1,
        EnemyCooldownsDB.columnSpacing or 25, L["COLUMN_SPACING"] or "X Spacing",
        function(v) EnemyCooldownsDB.columnSpacing = v; engine.ICON_OFFSET_X = v; engine:RefreshAllTrackers() end)

    W.groupGap = CreateNUFSlider(sc, "ECDGroupGap", RIGHT, y, HW, 5, 80, 1,
        EnemyCooldownsDB.groupsOffset or 22, L["GROUP_SPACING"] or "Group Gap",
        function(v) EnemyCooldownsDB.groupsOffset = v; engine:UpdatePositions() end)
    y = y - 48

    W.scale = CreateNUFSlider(sc, "ECDScale", LEFT, y, HW, 0.5, 2.0, 0.05,
        EnemyCooldownsDB.scale or 1.0, L["SCALE"] or "Scale",
        function(v) EnemyCooldownsDB.scale = v; engine:ApplyScaleToAll() end)
    y = y - 52

    -- ==================== PLAYER NAME FONT ====================
    y = CreateSection(sc, L["SECTION_PLAYER_NAME"] or "Player Name Font", y)

    -- FIX #1: getter functions read live from DB
    W.pNameFontDD = CreateDropdown(sc, "ECDPNameFont", LEFT - 10, y, 160,
        L["FONT"] or "Font:", fontItems,
        function() return EnemyCooldownsDB.playerNameSettings.font end,
        function(v) EnemyCooldownsDB.playerNameSettings.font = v; engine:UpdateAllPlayerNameFonts() end)

    W.pNameStyleDD = CreateDropdown(sc, "ECDPNameStyle", RIGHT - 10, y, 160,
        L["STYLE"] or "Style:", outlineItems,
        function() return EnemyCooldownsDB.playerNameSettings.fontOutline end,
        function(v) EnemyCooldownsDB.playerNameSettings.fontOutline = v; engine:UpdateAllPlayerNameFonts() end)
    y = y - 54

    -- FIX #3: max 19 for player name font size
    W.pNameSize = CreateNUFSlider(sc, "ECDPNameSize", LEFT, y, HW, 8, 19, 1,
        EnemyCooldownsDB.playerNameSettings.fontSize or 12, L["FONT_SIZE"] or "Font Size",
        function(v) EnemyCooldownsDB.playerNameSettings.fontSize = v; engine:UpdateAllPlayerNameFonts() end)
    y = y - 52

    -- ==================== TIMER SETTINGS ====================
    y = CreateSection(sc, L["SECTION_TIMER"] or "Timer Settings", y)

    W.timerFontDD = CreateDropdown(sc, "ECDTimerFont", LEFT - 10, y, 160,
        L["FONT"] or "Font:", fontItems,
        function() return EnemyCooldownsDB.timerSettings.font end,
        function(v) EnemyCooldownsDB.timerSettings.font = v; engine:UpdateAllIconFonts(); engine:RefreshAllTrackers() end)

    W.timerStyleDD = CreateDropdown(sc, "ECDTimerStyle", RIGHT - 10, y, 160,
        L["STYLE"] or "Style:", outlineItems,
        function() return EnemyCooldownsDB.timerSettings.fontOutline end,
        function(v) EnemyCooldownsDB.timerSettings.fontOutline = v; engine:UpdateAllIconFonts(); engine:RefreshAllTrackers() end)
    y = y - 54

    -- FIX #3: max 19 for timer font size
    W.timerSize = CreateNUFSlider(sc, "ECDTimerSize", LEFT, y, HW, 8, 19, 1,
        EnemyCooldownsDB.timerSettings.fontSize or 14, L["FONT_SIZE"] or "Font Size",
        function(v) EnemyCooldownsDB.timerSettings.fontSize = v; engine:UpdateAllIconFonts(); engine:RefreshAllTrackers() end)
    y = y - 48

    W.colorCheck = CreateCheck(sc, LEFT, y, L["COLOR_BY_TIME"] or "Color by remaining time",
        EnemyCooldownsDB.timerSettings.useColorByTime,
        function(v) EnemyCooldownsDB.timerSettings.useColorByTime = v; engine:RefreshAllTrackers() end)
    y = y - 26

    W.swipeCheck = CreateCheck(sc, LEFT, y, L["SHOW_CD_SWIPE"] or "Show cooldown clock overlay",
        EnemyCooldownsDB.showCooldownSwipe ~= false,
        function(v) EnemyCooldownsDB.showCooldownSwipe = v; engine:UpdateAllCooldownSwipes() end)
    y = y - 32

    CreateColorBtn(sc, L["COLOR_NORMAL"]  or "Normal (>10s):",   LEFT, y, "colorNormal"); y = y - 22
    CreateColorBtn(sc, L["COLOR_WARNING"] or "Warning (<=10s):", LEFT, y, "color10s"); y = y - 22
    CreateColorBtn(sc, L["COLOR_URGENT"]  or "Urgent (<=3s):",   LEFT, y, "color3s"); y = y - 34

    -- ==================== ZONES ====================
    y = CreateSection(sc, L["SECTION_ZONES"] or "Enable In:", y)

    W.arenaCheck = CreateCheck(sc, LEFT, y, L["ZONE_ARENA"] or "Arena",
        EnemyCooldownsDB.enabledZones.arena,
        function(v) EnemyCooldownsDB.enabledZones.arena = v; engine:CheckZoneAndToggle() end)

    W.bgCheck = CreateCheck(sc, LEFT + 130, y, L["ZONE_BATTLEGROUND"] or "Battleground",
        EnemyCooldownsDB.enabledZones.battleground,
        function(v) EnemyCooldownsDB.enabledZones.battleground = v; engine:CheckZoneAndToggle() end)

    W.worldCheck = CreateCheck(sc, LEFT + 290, y, L["ZONE_WORLD"] or "World",
        EnemyCooldownsDB.enabledZones.world,
        function(v) EnemyCooldownsDB.enabledZones.world = v; engine:CheckZoneAndToggle() end)

    y = y - 30
    sc:SetHeight(math.abs(y) + 20)
    configFrame:Hide()
end

------------------------------------------------------------------------
-- Slash commands
------------------------------------------------------------------------
SLASH_ENEMYCOOLDOWNS1 = "/ecd"
SLASH_ENEMYCOOLDOWNS2 = "/enemycooldowns"

SlashCmdList["ENEMYCOOLDOWNS"] = function(msg)
    msg = msg:lower():trim()
    L = engine.L or {}

    if msg == "config" or msg == "" then
        engine:CreateConfigMenu(); configFrame:Show()
    elseif msg == "lock" then
        EnemyCooldownsDB.locked = true
        anchorFrame:EnableMouse(false); anchorFrame.bg:Hide(); anchorFrame.text:Hide()
        print(L["FRAME_LOCKED"])
    elseif msg == "unlock" then
        EnemyCooldownsDB.locked = false
        anchorFrame:EnableMouse(true); anchorFrame.bg:Show(); anchorFrame.text:Show()
        print(L["FRAME_UNLOCKED"])
    elseif msg == "reset" then
        EnemyCooldownsDB.position = DeepCopy(defaults.position)
        anchorFrame:ClearAllPoints()
        anchorFrame:SetPoint(defaults.position.point, UIParent, defaults.position.point, defaults.position.x, defaults.position.y)
        engine:UpdatePositions()
        print(L["POSITION_RESET"])
    elseif msg == "resetall" then
        StaticPopup_Show("ECD_CONFIRM_RESET_ALL")
    else
        print(L["CMD_HEADER"]); print(L["CMD_CONFIG"]); print(L["CMD_LOCK"])
        print(L["CMD_UNLOCK"]); print(L["CMD_RESET"])
        print(L["CMD_RESETALL"] or "  /ecd resetall - Reset all settings to defaults")
    end
end
