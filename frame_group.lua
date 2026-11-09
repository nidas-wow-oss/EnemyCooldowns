local engine = select(2, ...)

local ICONS_SIZE = 28
local ICONS_MAX = 20
local math = math
local table = engine.table
local next = next
local CreateFrame = CreateFrame
local setmetatable = setmetatable

local prototype = setmetatable({}, getmetatable(UIParent))
local MT = {__index = prototype}

local function SortCooldowns(a, b)
    local mode = (EnemyCooldownsDB and EnemyCooldownsDB.sortMode) or "cast"

    if mode == "remain_asc" then
        if a.timeEnd ~= b.timeEnd then
            return a.timeEnd < b.timeEnd
        end
        return a.castTime > b.castTime

    elseif mode == "remain_desc" then
        if a.timeEnd ~= b.timeEnd then
            return a.timeEnd > b.timeEnd
        end
        return a.castTime > b.castTime

    else
        if a.castTime ~= b.castTime then
            return a.castTime > b.castTime
        end
        return a.timeEnd > b.timeEnd
    end
end

function prototype:Update(cooldownInfo)
    if not cooldownInfo then
        engine:ReleaseTracker(self.GUID)
        return
    end

    local ICONS_AT_COLUMN = engine.ICONS_AT_COLUMN or 6
    local OFFSET_Y = engine.ICON_SPACING or 6
    local OFFSET_X = engine.ICON_OFFSET_X or 25

    local cdList = table.new()
    local n = 0
    for spellID, data in next, cooldownInfo do
        local t = table.new()
        t.spellID = spellID
        t.timeEnd = data.timeEnd
        t.castTime = data.castTime
        n = n + 1
        cdList[n] = t
    end

    table.sort(cdList, SortCooldowns)

    local iconsBySpell = self.iconsBySpell
    if not iconsBySpell then
        iconsBySpell = {}
        self.iconsBySpell = iconsBySpell
    end

    local used = table.new()
    local shownN = math.min(n, ICONS_MAX)

    for i = 1, shownN do
        local cd = cdList[i]
        local spellID = cd.spellID

        local icon = iconsBySpell[spellID]
        if not icon then
            icon = engine:CreateIcon(self)
            iconsBySpell[spellID] = icon
        end

        used[spellID] = true
        icon:SetSize(ICONS_SIZE, ICONS_SIZE)
        icon:ClearAllPoints()

        local col = math.floor((i - 1) / ICONS_AT_COLUMN)
        local row = (i - 1) % ICONS_AT_COLUMN
        icon:SetPoint(
            "TOPLEFT", self, "TOPLEFT",
            col * (ICONS_SIZE + OFFSET_X),
            -row * (ICONS_SIZE + OFFSET_Y)
        )

        icon:SetSpell(spellID)
        icon:SetCooldown(cd.timeEnd, spellID)
    end

    for spid, iconFrame in next, iconsBySpell do
        if iconFrame:IsShown() and not used[spid] then
            iconFrame:Hide()
            iconFrame:SetScript("OnUpdate", nil)
        end
    end

    for i = 1, n do
        cdList[i] = table.del(cdList[i])
    end
    table.del(cdList)
    table.del(used)

    local numColumns = math.ceil(shownN / ICONS_AT_COLUMN)
    if numColumns < 1 then numColumns = 1 end
    self:SetWidth(numColumns * (ICONS_SIZE + OFFSET_X))

    local numRows = math.min(shownN, ICONS_AT_COLUMN)
    self:SetHeight(math.max(numRows * (ICONS_SIZE + OFFSET_Y), 1))
end

function prototype:HideIcons()
    if not self.iconsBySpell then return end
    for _, icon in next, self.iconsBySpell do
        if icon:IsShown() then
            icon:Hide()
            icon:SetScript("OnUpdate", nil)
        end
    end
end

function prototype:UpdateNameFont()
    local db = EnemyCooldownsDB
    if not db or not db.playerNameSettings then
        self.name:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
        return
    end

    local s = db.playerNameSettings
    self.name:SetFont(
        s.font or "Fonts\\FRIZQT__.TTF",
        s.fontSize or 12,
        s.fontOutline or "OUTLINE"
    )
end

function prototype:Initialize(GUID, unitName)
    self.name:SetText(unitName)
    self.GUID = GUID

    local scale = EnemyCooldownsDB and EnemyCooldownsDB.scale or 1.0
    self:SetScale(scale)

    local show = true
    if EnemyCooldownsDB and EnemyCooldownsDB.showEnemyNames ~= nil then
        show = EnemyCooldownsDB.showEnemyNames
    end
    if show then self.name:Show() else self.name:Hide() end

    self:UpdateNameFont()
    self:Show()
end

function prototype:Release()
    self:HideIcons()
    self.GUID = nil
    self:Hide()
end

function engine:CreateGroup()
    local frame = setmetatable(CreateFrame("Frame", nil, UIParent), MT)
    frame:SetHeight(1)

    local name = frame:CreateFontString(nil, "BORDER", "GameFontNormal")
    name:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    name:SetPoint("BOTTOM", frame, "TOP", 0, 2)

    frame.name = name
    frame.iconsBySpell = {}

    return frame
end

function engine:UpdateAllPlayerNameFonts()
    for _, tracker in pairs(self.trackers or {}) do
        if tracker and tracker.UpdateNameFont then
            tracker:UpdateNameFont()
        end
    end
end
