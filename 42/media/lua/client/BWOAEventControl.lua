BWOAEventControl = BWOAEventControl or {}

-- table for enqueued events
BWOAEventControl.Events = {}

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

Events.OnTick.Add(onTick)