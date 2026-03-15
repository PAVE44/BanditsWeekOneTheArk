require "BanditCustom"
require "BanditUtils"
require "BanditEventMarkerHandler"
require "BWOASequence"
require "BWOAEvents"
require "BWOAPlaceEvents"
require "BWOASound"

BWOAEventControl = BWOAEventControl or {}

-- table for enqueued events
BWOAEventControl.Events = {}

local schedule = {
    [0] = { -- D1 17.00
        [2] = {"Chapter", {tex = "chapter_1"}},
        [3] = {"SayPlayer", {txt = "What the hell?"}},
    },
    [1] = { -- D1 18.00
        [7] = {"Spooky", {cnt = 1}},
        [8] = {"SayPlayer", {txt = "Shit..."}},
    },
    [2] = { -- D1 19.00
        [17] = {"Spooky", {cnt = 5}},
        [18] = {"SayPlayer", {txt = "Damn..."}},
    },
    [4] = {
        [24] = {"ArkNetworkStatus", {arkId = 47}},
    },
    [22] = {
        [39] = {"Horde", {intensity = 12}},
    },
    [34] = {
        [39] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 4}},
    },
    [45] = {
        [17] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [55] = {
        [2] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [79] = {
        [14] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 7}},
    },
    [132] = {
        [30] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 1}},
        [31] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 2}},
        [32] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 3}},
        [35] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [135] = {
        [30] = {"Horde", {intensity = 40}},
    },
    [177] = {
        [30] = {"Assault", {cid = Bandit.clanMap.Surface3, intensity = 11}},
    },
    [184] = {
        [35] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4, fire = true}},
    },
    [190] = {
        [41] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 1}},
        [42] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 3}},
        [43] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 6}},
        [44] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 3}},
        [45] = {"Assault", {cid = Bandit.clanMap.Surface1, intensity = 2}},
    },
    [200] = {
        [30] = {"Horde", {intensity = 50}},
    },
    [242] = {
        [41] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 1}},
        [42] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 3}},
        [43] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 6}},
        [44] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 3}},
        [45] = {"Assault", {cid = Bandit.clanMap.Surface4, intensity = 2}},
    },
    [415] = {
        [50] = {"ArkNetworkStatus", {arkId = 50}},
    },
    [521] = {
        [26] = {"ArkNetworkStatus", {arkId = 49}},
        [31] = {"ArkNetworkStatus", {arkId = 53}},
    },
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

    print ("H: " .. hours .. " M: " .. minutes)

    -- time-fixed events
    if schedule[hours] and schedule[hours][minutes] then
        local event = schedule[hours][minutes]
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
        if not event.rendered then
            if not renderDist then
                event.renderDist = 50
            end
            if BanditUtils.DistTo(px, py, event.x, event.y) < event.renderDist then
                BWOAPlaceEvents.Render(event)

                if event.music then
                    BWOAMusic.Play(event.music, 0.6, 1)
                end

                if SandboxVars.BWOA.AngelProximity then
                    BWOASound.PlayPlayer({sound="AngelProximity"})

                    local icon = "media/ui/defend.png"
                    local color = {r=0.5, g=0.5, b=1}
                    local desc = "Point of Interest to Discover"
                    BanditEventMarkerHandler.set(getRandomUUID(), icon, 7200, event.x, event.y, color, desc)
                end
            end
        end
    end

    -- hostile ark raids
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
                            intensity = 6, 
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
    table.insert(BWOAEventControl.Events, event)
end

-- queue processor
function onTick()
    local player = getSpecificPlayer(0)
    if not player then return end

    local ct = BanditUtils.GetTime()
    for i, event in ipairs(BWOAEventControl.Events) do
        if event.start < ct then
            if BWOAEvents[event.name] then
                -- print ("EVENT:" .. event.name)
                BWOAEvents[event.name](event.params)
            end
            table.remove(BWOAEventControl.Events, i)
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