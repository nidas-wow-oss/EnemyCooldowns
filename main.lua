local ADDON_NAME, engine = ...

local COMBATLOG_OBJECT_REACTION_NEUTRAL = COMBATLOG_OBJECT_REACTION_NEUTRAL
local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE
local COMBATLOG_OBJECT_REACTION_MASK = COMBATLOG_OBJECT_REACTION_MASK

local CLASS2HEXCOLOR = {}
local SPELLS, RESETTERS = engine.SPELLS, engine.RESETTERS
local table = engine.table
local bit = bit
local next = next
local GetTime = GetTime

-- Exported layout values (overridden by SavedVariables in InitConfig)
engine.ICONS_AT_COLUMN = 6
engine.ICON_SPACING = 6
engine.ICON_OFFSET_X = 25

local eventFrame = CreateFrame("Frame")
local trackers, unusedTrackers = {}, {}
local trackersOrder = {}
local cooldownInfo, GUID2name = {}, {}
local addonEnabled = false
local targetGUID

-- Memory cleanup state
local lastSeenGUID = {}
local lastCleanupTime = 0
local CLEANUP_INTERVAL = 30   -- seconds between cleanup passes
local GUID_TIMEOUT = 300      -- remove GUIDs inactive for 5 minutes

-- Expose for other files
engine.trackers = trackers
engine.addonEnabled = addonEnabled

------------------------------------------------------------------------
-- Helper: get a config value with a fallback default
------------------------------------------------------------------------
function engine:GetConfigValue(key, subkey, default)
    if not EnemyCooldownsDB then return default end

    if subkey then
        local parent = EnemyCooldownsDB[key]
        if parent and parent[subkey] ~= nil then
            return parent[subkey]
        end
        return default
    else
        if EnemyCooldownsDB[key] ~= nil then
            return EnemyCooldownsDB[key]
        end
        return default
    end
end

------------------------------------------------------------------------
-- Class colors
------------------------------------------------------------------------
do
    local function RGBPercToHex(r, g, b)
        r = (r >= 0 and r <= 1) and r or 0
        g = (g >= 0 and g <= 1) and g or 0
        b = (b >= 0 and b <= 1) and b or 0
        return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
    end

    CLASS2HEXCOLOR["none"] = RGBPercToHex(0.4, 0.4, 0.4)
    for class, c in pairs(RAID_CLASS_COLORS) do
        CLASS2HEXCOLOR[class] = RGBPercToHex(
            math.min(c.r * 1.25, 1),
            math.min(c.g * 1.25, 1),
            math.min(c.b * 1.25, 1)
        )
    end
end

------------------------------------------------------------------------
-- Sanitize RESETTERS: remove entries that aren't valid tables
------------------------------------------------------------------------
for k, v in pairs(RESETTERS) do
    if type(v) ~= "table" then
        RESETTERS[k] = nil
    end
end

------------------------------------------------------------------------
-- Zone detection and addon toggle
------------------------------------------------------------------------
function engine:GetCurrentZoneType()
    local inInstance, instanceType = IsInInstance()
    if inInstance then
        if instanceType == "arena" then
            return "arena"
        elseif instanceType == "pvp" then
            return "battleground"
        end
    end
    return "world"
end

function engine:ShouldBeEnabled()
    if not EnemyCooldownsDB or not EnemyCooldownsDB.enabledZones then
        return true
    end
    return EnemyCooldownsDB.enabledZones[self:GetCurrentZoneType()] == true
end

function engine:EnableAddon()
    if addonEnabled then return end
    addonEnabled = true
    engine.addonEnabled = true

    eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

    local L = engine.L
    if L then print(L["ADDON_ENABLED"]) end
end

function engine:DisableAddon()
    if not addonEnabled then return end
    addonEnabled = false
    engine.addonEnabled = false

    eventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    eventFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")

    self:ReleaseAllTrackers()
    self:ResetCooldownInfo()

    local L = engine.L
    if L then print(L["ADDON_DISABLED"]) end
end

function engine:CheckZoneAndToggle()
    if self:ShouldBeEnabled() then
        self:EnableAddon()
    else
        self:DisableAddon()
    end
end

------------------------------------------------------------------------
-- Memory cleanup: prune stale GUIDs periodically
------------------------------------------------------------------------
function engine:CleanupMemory()
    local now = GetTime()
    if now - lastCleanupTime < CLEANUP_INTERVAL then return end
    lastCleanupTime = now

    for guid, info in next, cooldownInfo do
        local lastSeen = lastSeenGUID[guid]
        if not next(info) or (lastSeen and (now - lastSeen) > GUID_TIMEOUT) then
            cooldownInfo[guid] = table.del(info)
            GUID2name[guid] = nil
            lastSeenGUID[guid] = nil
        end
    end

    for guid in next, GUID2name do
        if not cooldownInfo[guid] then
            local lastSeen = lastSeenGUID[guid]
            if lastSeen and (now - lastSeen) > GUID_TIMEOUT then
                GUID2name[guid] = nil
                lastSeenGUID[guid] = nil
            end
        end
    end
end

------------------------------------------------------------------------
-- Cooldown data management
------------------------------------------------------------------------

-- Remove expired cooldowns for a given key
function engine:Cleanup(key)
    local info = cooldownInfo[key]
    if not info then return end

    local now = GetTime()
    for spellID, data in next, info do
        if now >= data.timeEnd then
            info[spellID] = nil
        end
    end

    if not next(info) then
        cooldownInfo[key] = table.del(info)
    end
end

function engine:GetCooldownInfo(key)
    self:Cleanup(key)
    return cooldownInfo[key]
end

function engine:AddCooldown(key, spellID, timeEnd, castTime)
    cooldownInfo[key] = cooldownInfo[key] or table.new()
    cooldownInfo[key][spellID] = {
        timeEnd = timeEnd,
        castTime = castTime,
    }
end

function engine:RemoveCooldown(key, spellIDList)
    local info = cooldownInfo[key]
    if not info then return end

    if type(spellIDList) == "table" then
        for i = 1, #spellIDList do
            info[spellIDList[i]] = nil
        end
    end

    if not next(info) then
        cooldownInfo[key] = table.del(info)
    end
end

function engine:ResetCooldownInfo()
    for k, v in next, cooldownInfo do
        cooldownInfo[k] = table.del(v)
    end
    table.wipe(GUID2name)
    table.wipe(lastSeenGUID)
end

------------------------------------------------------------------------
-- Tracker management
------------------------------------------------------------------------
function engine:GetTrackerKey(srcGUID)
    return srcGUID
end

function engine:GetDisplayName(key, srcGUID)
    local L = engine.L
    return GUID2name[srcGUID] or (L and L["UNKNOWN"] or "Unknown")
end

function engine:SpawnTracker(key, displayName)
    local tracker = table.remove(unusedTrackers) or self:CreateGroup()
    tracker:Initialize(key, displayName)
    trackers[key] = tracker

    if key == targetGUID then
        table.insert(trackersOrder, 1, key)
    else
        table.insert(trackersOrder, key)
    end

    self:UpdatePositions()
    return tracker
end

function engine:UpdateTracker(key, srcGUID)
    local info = self:GetCooldownInfo(key)
    if info then
        local name = self:GetDisplayName(key, srcGUID)
        local tracker = trackers[key] or self:SpawnTracker(key, name)

        tracker.name:SetText(name)
        tracker:Update(info)
    else
        self:ReleaseTracker(key)
    end
end

function engine:ReleaseTracker(key)
    if table.removeByValue(trackersOrder, key) then
        local tracker = trackers[key]
        tracker:Release()
        trackers[key] = nil
        table.insert(unusedTrackers, tracker)
        self:UpdatePositions()
    end
end

function engine:ReleaseAllTrackers()
    for i = #trackersOrder, 1, -1 do
        local key = trackersOrder[i]
        local tracker = trackers[key]
        tracker:Release()
        trackers[key] = nil
        trackersOrder[i] = nil
        table.insert(unusedTrackers, tracker)
    end
    table.wipe(trackersOrder)
end

function engine:UpdatePositions()
    if #trackersOrder == 0 then return end

    local anchor = self:GetAnchorFrame()
    if not anchor then return end

    local offset = EnemyCooldownsDB and EnemyCooldownsDB.groupsOffset or 22

    trackers[trackersOrder[1]]:SetPoint("TOPLEFT", anchor, "TOPLEFT", 0, 0)
    for i = 2, #trackersOrder do
        trackers[trackersOrder[i]]:SetPoint(
            "TOPLEFT",
            trackers[trackersOrder[i - 1]],
            "TOPRIGHT",
            offset,
            0
        )
    end
end

------------------------------------------------------------------------
-- Combat log event handler
------------------------------------------------------------------------
function engine:COMBAT_LOG_EVENT_UNFILTERED(_, subEvent, ...)
    if not addonEnabled then return end

    if subEvent == "SPELL_CAST_SUCCESS" then
        local srcGUID, srcName, srcFlags, _, _, _, spellID = ...

        local reaction = bit.band(srcFlags, COMBATLOG_OBJECT_REACTION_MASK)
        if reaction ~= COMBATLOG_OBJECT_REACTION_HOSTILE
        and reaction ~= COMBATLOG_OBJECT_REACTION_NEUTRAL then
            return
        end

        lastSeenGUID[srcGUID] = GetTime()

        -- Cache colored display name (strip realm from "Name-Realm")
        if not GUID2name[srcGUID] then
            local _, class = GetPlayerInfoByGUID(srcGUID)
            local color = CLASS2HEXCOLOR[class or "none"]
            GUID2name[srcGUID] = color .. (srcName or ""):gsub("-.*$", "")
        end

        local key = self:GetTrackerKey(srcGUID)
        local now = GetTime()
        local updated = false

        -- Check if this spell resets other cooldowns
        local resetList = RESETTERS[spellID]
        if resetList and #resetList > 0 then
            self:RemoveCooldown(key, resetList)
            updated = true
        end

        -- Check if this spell itself has a tracked cooldown
        local duration = SPELLS[spellID]
        if duration then
            self:AddCooldown(key, spellID, now + duration, now)
            updated = true
        end

        if updated then
            self:UpdateTracker(key, srcGUID)
        end
    end
end

------------------------------------------------------------------------
-- Target changed: promote current target's tracker to first position
------------------------------------------------------------------------
function engine:PLAYER_TARGET_CHANGED()
    if not addonEnabled then return end

    -- BUG FIX: simplified — just set the new target directly
    targetGUID = UnitGUID("target")

    if targetGUID and trackers[targetGUID] then
        table.removeByValue(trackersOrder, targetGUID)
        table.insert(trackersOrder, 1, targetGUID)
        self:UpdatePositions()
    end
end

------------------------------------------------------------------------
-- Zone change: wipe state and re-evaluate whether the addon should run
------------------------------------------------------------------------
function engine:PLAYER_ENTERING_WORLD()
    self:ReleaseAllTrackers()
    self:ResetCooldownInfo()
    self:CheckZoneAndToggle()
end

------------------------------------------------------------------------
-- Addon loaded: initialize config and start cleanup timer
------------------------------------------------------------------------
function engine:ADDON_LOADED(addonName)
    if addonName ~= ADDON_NAME then return end

    self:InitConfig()
    self:CheckZoneAndToggle()

    -- Periodic memory cleanup (WotLK compatible, no C_Timer)
    local cleanupFrame = CreateFrame("Frame")
    local elapsed = 0
    cleanupFrame:SetScript("OnUpdate", function(_, dt)
        elapsed = elapsed + dt
        if elapsed >= CLEANUP_INTERVAL then
            elapsed = 0
            engine:CleanupMemory()
        end
    end)

    local L = engine.L
    if L then print(L["ADDON_LOADED"]) end
end

------------------------------------------------------------------------
-- Event dispatcher
------------------------------------------------------------------------
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(_, event, ...)
    engine[event](engine, ...)
end)

-- Keep the combat log buffer indefinitely so we don't miss events
CombatLogSetRetentionTime(-1)