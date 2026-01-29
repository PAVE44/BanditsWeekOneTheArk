BWOAEventControl = BWOAEventControl or {}

-- table for enqueued events
BWOAEventControl.Events = {}

local schedule = {
    -- 17.00

    [0] = {
        [2] = {"Chapter", {tex = "chapter_1"}},
        [3] = {"SayPlayer", {txt = "What the hell?"}},
    },
    [22] = {
        [39] = {"Horde", {intensity = 12}},
    },
    [34] = {
        [39] = {"Assault", {intensity = 3}},
    },
    [45] = {
        [17] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [55] = {
        [2] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [79] = {
        [14] = {"Assault", {intensity = 4}},
    },
    [132] = {
        [30] = {"Assault", {intensity = 2}},
        [31] = {"Assault", {intensity = 2}},
        [32] = {"Assault", {intensity = 2}},
        [35] = {"Earthquake", {intensity = 30, duration = 20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4}},
    },
    [135] = {
        [30] = {"Horde", {intensity = 40}},
    },
    [177] = {
        [30] = {"Assault", {intensity = 9}},
    },
    [200] = {
        [30] = {"Horde", {intensity = 50}},
    },
}

-- triggering scheduled events 
local function everyOneMinute()
    local player = getSpecificPlayer(0)
    if not player then return end

    -- time events
    local gt = getGameTime()
    local hours = math.floor(gt:getWorldAgeHours()) - 10
    local minutes = gt:getMinutes()

    print ("H: " .. hours .. " M: " .. minutes)

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
    local px, py = player:getX(), player:getY()
    local placeEvents = gmd.placeEvents
    for k, event in pairs(placeEvents) do
        if not event.rendered then
            if BanditUtils.DistTo(px, py, event.x, event.y) < 50 then
                BWOAPlaceEvents.Render(event)

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

Events.EveryOneMinute.Remove(everyOneMinute)
Events.EveryOneMinute.Add(everyOneMinute)

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)