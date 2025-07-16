BWOABaseAPI = BWOABaseAPI or {}

BWOABaseAPI.power = true
BWOABaseAPI.alarm = false

BWOABaseAPI.generators = {
    {x=9950, y=12600, z=-6},
    {x=9950, y=12625, z=-6},
    {x=9950, y=12650, z=-6},
    {x=9975, y=12600, z=-6},
    {x=9975, y=12625, z=-6},
    {x=9975, y=12650, z=-6},
}

BWOABaseAPI.heatsources = {}

BWOABaseAPI.GeneratorsUpdate = function()

    local cell = getCell()

    -- ensure fake generator presence
    for _, coords in pairs(BWOABaseAPI.generators) do
        local square = cell:getGridSquare(coords.x, coords.y, coords.z)
        if square then
            local generator = square:getGenerator()
            if not generator then
                local genItem = BanditCompatibility.InstanceItem("Base.Generator")
                local generator = IsoGenerator.new(genItem, cell, square)
                generator:setSprite(nil)
                generator:transmitCompleteItemToClients()
                generator:setCondition(100)
                generator:setFuel(100)
                generator:setConnected(true)
                cell:addToProcessIsoObjectRemove(generator)
            else
                generator:setCondition(100)
                generator:setFuel(100)
            end
        else
            cell:getOrCreateGridSquare(coords.x, coords.y, coords.z)
        end
    end
end

BWOABaseAPI.GeneratorsOn = function()
    for _, coords in pairs(BWOABaseAPI.generators) do
        local square = getCell():getGridSquare(coords.x, coords.y, coords.z)
        if square then
            local generator = square:getGenerator()
            if generator then
                if generator:getFuel() > 0 and not generator:isActivated() then
                    generator:setActivated(true)
                end
            end
        end
    end
end

BWOABaseAPI.GeneratorsOff = function()
    for _, coords in pairs(BWOABaseAPI.generators) do
        local square = getCell():getGridSquare(coords.x, coords.y, coords.z)
        if square then
            local generator = square:getGenerator()
            if generator then
                if generator:isActivated() then
                    generator:setActivated(false)
                end
            end
        end
    end
end

BWOABaseAPI.EmergencyLights = function(roomName, active)
    local cell = getCell()
    for _, el in pairs(BWOARooms[roomName].els) do
        local square = cell:getGridSquare(el.x, el.y, el.z)
        if square then
            local objects = square:getObjects()
            for i=0, objects:size()-1 do
                local object = objects:get(i)
                if instanceof(object, "IsoLightSwitch") then
                    object:setActive(active)
                end
            end
        end 
    end
end

BWOABaseAPI.GetGeneratorPowerUsing = function()
    local powerUsing = 0
    for _, coords in pairs(BWOABaseAPI.generators) do
        local square = getCell():getGridSquare(coords.x, coords.y, coords.z)
        if square then
            local generator = square:getGenerator()
            if generator then
                if generator:isActivated() then
                    powerUsing = powerUsing + generator:getTotalPowerUsing()
                end
            end
        else
            return nil
        end
    end
    return powerUsing
end

BWOABaseAPI.IsNoahPowered = function()
    local cell = getCell()
    local square = cell:getGridSquare(BWOARooms.Control.noah.x, BWOARooms.Control.noah.y, BWOARooms.Control.noah.z)
    if square then
        return square:haveElectricity()
    end
end

BWOABaseAPI.AlarmOn = function()
    if BWOABaseAPI.IsNoahPowered() and not BWOABaseAPI.alarm then
        BWOABaseAPI.alarm = true
        BWOASound.AddGlobal({sound="AmbientAlarmGlobal"})
        BWOASound.AddToObject({x=9961, y=12622, z=-4, sound="AmbientAlarmLocal"})
    end
end

BWOABaseAPI.AlarmOff = function()
    BWOASound.RemoveGlobal({sound="AmbientAlarmGlobal"})
    BWOASound.RemoveFromObject({x=9961, y=12622, z=-4, sound="AmbientAlarmLocal"})
    BWOABaseAPI.alarm = false
end

BWOABaseAPI.VentilationOn = function(temp)
    local r = 1000
    local correction = 7
    local cell = getCell()
    for roomName, _ in pairs(BWOARooms) do
        if BWOARooms[roomName].vents then 
            for _, coords in pairs(BWOARooms[roomName].vents) do
                local square = getCell():getGridSquare(coords.x, coords.y, coords.z)
                if square then
                    local hid = coords.x .. "." .. coords.y  .. "." .. coords.z
                    if BWOABaseAPI.heatsources[hid] then
                        BWOABaseAPI.heatsources[hid]:setTemperature(temp + correction)
                        BWOASound.AddToObject({x=coords.x, y=coords.y, z=coords.z, sound="AmbientVent"})
                    else
                        local x, y, z = math.floor(coords.x), math.floor(coords.y), math.floor(coords.z)
                        BWOABaseAPI.heatsources[hid] = IsoHeatSource.new(x, y, z, r, temp + correction)
                        cell:addHeatSource(BWOABaseAPI.heatsources[hid])
                    end
                end
            end
        end
    end
end

BWOABaseAPI.VentilationOff = function()
    local cell = getCell()
    for roomName, _ in pairs(BWOARooms) do
        if BWOARooms[roomName].vents then 
            for _, coords in pairs(BWOARooms[roomName].vents) do
                local square = getCell():getGridSquare(coords.x, coords.y, coords.z)
                if square then
                    local hid = coords.x .. "." .. coords.y  .. "." .. coords.z
                    if BWOABaseAPI.heatsources[hid] then
                        cell:removeHeatSource(BWOABaseAPI.heatsources[hid])
                        BWOASound.RemoveFromObject({x=coords.x, y=coords.y, z=coords.z, sound="AmbientVent"})
                    end
                end
            end
        end
    end
end

BWOABaseAPI.WaterOn = function()

end

BWOABaseAPI.WaterOff = function()

end


BWOABaseAPI.ExitProcedure = function()
    -- open interior gate
    -- if player is inside
    -- check if hazmat suit is worn
    -- close interior door
end

BWOABaseAPI.EnterProcedure = function()
end