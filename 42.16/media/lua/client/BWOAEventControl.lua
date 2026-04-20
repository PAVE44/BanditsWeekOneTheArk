require "BanditCustom"
require "BanditUtils"
require "BanditEventMarkerHandler"
require "BWOASequence"
require "BWOAEvents"
require "BWOAPlaceEvents"
require "BWOASound"

BWOAEventControl = BWOAEventControl or {}

-- table for enqueued events
BWOAEventControl.events = {}

-- HOURS MUST BE MULTIPLIERS OF 4 TO ENABLE PROPER TIME STRETCHING
BWOAEventControl.schedule = {
    [0] = { -- D1 17.00
        [3] = {"SayPlayer", {txt = getText("IGUI_SayPlayer_Start")}},
        [4] = {"Chapter", {tex = "chapter_1"}},
    },
    [4] = { -- D1 18.00
        [7] = {"Spooky", {cnt = 1}},
        [8] = {"SayPlayer", {txt = getText("IGUI_SayPlayer_Shock1")}},
    },
    [8] = { -- D1 19.00
        [17] = {"Spooky", {cnt = 5}},
        [18] = {"SayPlayer", {txt = getText("IGUI_SayPlayer_Shock2")}},
    },
    [12] = {
        [24] = {"ArkNetworkStatus", {arkId = 47}},
    },
    [24] = {
        [39] = {"Horde", {intensity = 8}},
    },
    [56] = {
        [39] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 4}},
    },
    [68] = {
        [17] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [92] = {
        [2] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [120] = {
        [14] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 7}},
    },
    [172] = {
        [30] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 1}},
        [31] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 2}},
        [32] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 3}},
        [35] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [180] = {
        [30] = {"Horde", {intensity = 30}},
    },
    [192] = {
        [30] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 11}},
    },
    [216] = {
        [35] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4, fire = true}},
    },
    [268] = {
        [41] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 1}},
        [42] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 3}},
        [43] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 6}},
        [44] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 3}},
        [45] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 2}},
    },
    [272] = {
        [30] = {"Horde", {intensity = 50}},
        [35] = {"BreakNoah", {}},
    },
    [276] = {
        [41] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 1}},
        [42] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 3}},
        [43] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 6}},
        [44] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 3}},
        [45] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 2}},
    },
    [336] = {
        [30] = {"Horde", {intensity = 60}},
    },
    [352] = {
        [35] = {"BreakNoah", {}},
    },
    [356] = {
        [15] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 7}},
        [16] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 7}},
    },
    [416] = {
        [50] = {"ArkNetworkStatus", {arkId = 50}},
    },
    [444] = {
        [33] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [34] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [36] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [37] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [45] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
    },
    [492] = {
        [33] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [34] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [36] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [37] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
        [45] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 4}},
    },
    [516] = {
        [30] = {"Horde", {intensity = 60}},
    },
    [544] = {
        [26] = {"ArkNetworkStatus", {arkId = 49}},
        [31] = {"ArkNetworkStatus", {arkId = 53}},
    },
    [592] = {
        [30] = {"Horde", {intensity = 60}},
    },
    [672] = {
        [30] = {"Horde", {intensity = 70}},
    },
    [744] = {}
}

-- disable non whitelisted W1ARK bandits spawn 
local function onGameStart()
    Bandit.EnsureWhitelistedBandits()
end

-- triggering scheduled events 
local function everyOneMinute()
    local player = getSpecificPlayer(0)
    if not player then return end

    -- time events
    local gt = getGameTime()
    local hours = math.floor(gt:getWorldAgeHours()) - 10
    local minutes = gt:getMinutes()
    -- print ("H: " .. hours .. " M: " .. minutes)

    local multipliers = {
        [1] = 0.25,
        [2] = 0.5,
        [3] = 1,
        [4] = 3,
        [5] = 6,
        [6] = 12
    }
    local multiplier = multipliers[SandboxVars.BWOA.FalloutEnds]

    local schedule = BWOAEventControl.schedule
    local scheduleScaled = {}
    for h, tab in pairs(schedule) do
        local newh = math.floor(h * multiplier)
        scheduleScaled[newh] = tab
    end

    -- time-fixed events
    if scheduleScaled[hours] and scheduleScaled[hours][minutes] then
        local event = scheduleScaled[hours][minutes]
        if event and event[1] and event[2] then
            local eventName = event[1]
            local eventParams = event[2]
            if BWOASequence[eventName] then
                BWOASequence[eventName](eventParams)
            else
                BWOAEventControl.Add(eventName, eventParams, 1)
            end
        end
    end

    -- place events
    local gmd = GetBWOAModData()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local placeEvents = gmd.placeEvents
    for k, event in pairs(placeEvents) do
        if not event.rendered and not event.hidden then
            if not renderDist then
                event.renderDist = 50
            end
            if BanditUtils.DistTo(px, py, event.x, event.y) < event.renderDist then
                BWOAEventControl.Add("PlaceEvent", event, 250)
            end
        end
    end

    -- hostile ark raids
    local hostileGroupSize = SandboxVars.BWOA.HostileGroupSize or 3
    local hostileGroupSizes = {
        [1] = 2,
        [2] = 4,
        [3] = 6,
        [4] = 9,
        [5] = 13,
        [6] = 24,
    }
    local intensity = math.ceil(hostileGroupSizes[hostileGroupSize])

    local arkDeclared = BWOABaseAPI.IsNetworkPlayerArkDeclared()
    if arkDeclared then
        if pz == -4 then
            local dist = BanditUtils.DistTo(px, py, Bandit.playerStart.x, Bandit.playerStart.y)
            if dist < 80 then

                local arks = BWOABaseAPI.GetHostileNetworkArks(hours)
                for _, ark in ipairs(arks) do
                    local rnd = ZombRand(1000)
                    if rnd == 0 then
                        BWOASequence.Assault({
                            cid = Bandit.clanMap.Surface2,
                            intensity = intensity, 
                            vtype = "Base.VanSeats_Mural"
                        })
                        ark.status = 2
                    end
                end
            end
        end
    end
end

-- queue adder
function BWOAEventControl.Add(name, params, delay)
    event = {}
    event.start = BanditUtils.GetTime() + delay
    event.name = name
    event.params = params
    table.insert(BWOAEventControl.events, event)
end

-- queue processor
function onTick()
    local player = getSpecificPlayer(0)
    if not player then return end

    local ct = BanditUtils.GetTime()
    for i, event in ipairs(BWOAEventControl.events) do
        if event.start < ct then
            if BWOAEvents[event.name] then
                -- print ("EVENT:" .. event.name)
                BWOAEvents[event.name](event.params)
            end
            table.remove(BWOAEventControl.events, i)
            break
        end
    end
end

Events.OnGameStart.Remove(onGameStart)
Events.OnGameStart.Add(onGameStart)

Events.EveryOneMinute.Remove(everyOneMinute)
Events.EveryOneMinute.Add(everyOneMinute)

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)