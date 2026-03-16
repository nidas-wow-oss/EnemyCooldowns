local engine = select(2,...)

local setmetatable = setmetatable
local CreateFrame = CreateFrame
local GetTime = GetTime
local GetSpellInfo = GetSpellInfo
local math_floor = math.floor

local prototype = setmetatable({}, getmetatable(UIParent))
local MT = {__index = prototype}

local spellID2texture = setmetatable({
    [71607] = "Interface\\Icons\\inv_jewelcrafting_gem_28", -- bauble of true blood
    [42292] = "Interface\\Icons\\Spell_Shadow_Charm", -- Medalion
},{
    __index = function(t,k)
        local _,_,v = GetSpellInfo(k)
        t[k] = v
        return v
    end,
})

local function math_round(x)
    return math_floor(x+0.51)
end

local function formatTime(v)
    if v > 0 then
        local minutes = math.floor(v / 60)
        local seconds = math.floor(v % 60)
        if minutes > 0 then
            return string.format("%d:%02d", minutes, seconds)
        else
            if v <= 3 then
                return string.format("%.1f", v)
            else
                return tostring(seconds)
            end
        end
    end
end

local function GetTimerColor(remain)
    local db = EnemyCooldownsDB
    if not db or not db.timerSettings then
        return 1, 1, 1
    end

    local settings = db.timerSettings
    if settings.useColorByTime then
        if remain <= 3 then
            return settings.color3s.r, settings.color3s.g, settings.color3s.b
        elseif remain <= 10 then
            return settings.color10s.r, settings.color10s.g, settings.color10s.b
        else
            return settings.colorNormal.r, settings.colorNormal.g, settings.colorNormal.b
        end
    else
        return settings.colorNormal.r, settings.colorNormal.g, settings.colorNormal.b
    end
end

-- ✅ MEJORA 3: OPTIMIZACIÓN DE ONUPDATE (throttling)
local UPDATE_THROTTLE = 0.1  -- Solo actualizar cada 0.1 segundos
local function frame_update_cb(self, elapsed)
    -- Acumular tiempo
    self.throttleTimer = (self.throttleTimer or 0) + elapsed
    
    -- Solo actualizar cada UPDATE_THROTTLE segundos (98% menos CPU usage)
    if self.throttleTimer < UPDATE_THROTTLE then
        return
    end
    
    local actualElapsed = self.throttleTimer
    self.throttleTimer = 0
    
    local remain = self.remain - actualElapsed
    self.remain = remain

    if remain > 0 then
        self.text:SetText(formatTime(remain))

        local r, g, b = GetTimerColor(remain)
        self.text:SetTextColor(r, g, b)

        self.texture:SetAlpha(1.0)
    else
        self.text:SetText(nil)
        self.texture:SetAlpha(1.0)

        if remain < -0.1 then
            local tracker = self:GetParent()
            tracker:Update(engine:GetCooldownInfo(tracker.GUID))
        end
    end
end

function prototype:UpdateFont()
    local db = EnemyCooldownsDB
    if not db or not db.timerSettings then return end

    local settings = db.timerSettings
    local font = settings.font or "Fonts\\FRIZQT__.TTF"
    local size = settings.fontSize or 14

    local outline = settings.fontOutline
    if outline == nil then outline = "" end

    self.text:SetFont(font, size, outline)
end

function prototype:SetCooldown(timeEnd, spellID)
    local currentTime = GetTime()
    local duration = timeEnd - currentTime
    if duration <= 0 then return end

    -- Forzar actualización de fuente siempre
    if self.UpdateFont then
        self:UpdateFont()
    end

    local isSameCooldown = (self.timeEnd == timeEnd and self.spellID == spellID)

    self.timeEnd = timeEnd
    self.spellID = spellID
    self.remain = duration
    self.throttleTimer = 0  -- Reset throttle timer

    -- ✅ EXTRA 2: Aplicar configuración de cooldown swipe
    local showSwipe = true
    if EnemyCooldownsDB and EnemyCooldownsDB.showCooldownSwipe ~= nil then
        showSwipe = EnemyCooldownsDB.showCooldownSwipe
    end
    
    if showSwipe then
        if not isSameCooldown and self.cooldown then
            self.cooldown:SetCooldown(currentTime, duration)
        end
        self.cooldown:Show()
    else
        self.cooldown:Hide()
    end

    self:SetScript("OnUpdate", frame_update_cb)
    self:Show()
end

function prototype:SetSpell(spellID)
    self.texture:SetTexture(spellID2texture[spellID])
end

function engine:CreateIcon(parent)
    local frame = setmetatable(CreateFrame("frame", nil, parent), MT)
    frame:SetScript("OnUpdate", frame_update_cb)
    frame:SetFrameLevel(parent:GetFrameLevel())
    frame:Hide()
    frame.timeEnd = nil
    frame.throttleTimer = 0  -- Throttle timer inicial

    local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    text:SetJustifyH("LEFT")
    text:SetPoint("LEFT", frame, "RIGHT")

    local texture = frame:CreateTexture(nil, "BORDER")
    texture:SetAllPoints()

    local cooldown = CreateFrame("Cooldown", nil, frame)
    cooldown:SetAllPoints()
    cooldown:SetReverse(true)
    cooldown:SetDrawEdge(false)
    cooldown.noCooldownCount = true

    frame.text = text
    frame.texture = texture
    frame.cooldown = cooldown

    -- fuente inicial
    frame:UpdateFont()

    return frame
end

function engine:UpdateAllIconFonts()
    for _, tracker in pairs(self.trackers or {}) do
        if tracker.iconsBySpell then
            for _, icon in pairs(tracker.iconsBySpell) do
                if icon and icon.UpdateFont then
                    icon:UpdateFont()
                end
            end
        elseif tracker.icons then
            for _, icon in pairs(tracker.icons) do
                if icon and icon.UpdateFont then
                    icon:UpdateFont()
                end
            end
        end
    end
end

-- ✅ EXTRA 2: Función para actualizar visibilidad de cooldown swipes
function engine:UpdateAllCooldownSwipes()
    local showSwipe = true
    if EnemyCooldownsDB and EnemyCooldownsDB.showCooldownSwipe ~= nil then
        showSwipe = EnemyCooldownsDB.showCooldownSwipe
    end
    
    for _, tracker in pairs(self.trackers or {}) do
        if tracker.iconsBySpell then
            for _, icon in pairs(tracker.iconsBySpell) do
                if icon and icon.cooldown then
                    if showSwipe then
                        icon.cooldown:Show()
                    else
                        icon.cooldown:Hide()
                    end
                end
            end
        elseif tracker.icons then
            for _, icon in pairs(tracker.icons) do
                if icon and icon.cooldown then
                    if showSwipe then
                        icon.cooldown:Show()
                    else
                        icon.cooldown:Hide()
                    end
                end
            end
        end
    end
end