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
    local room = BWOARooms[roomName]
    local change = false
    for _, el in pairs(room.els) do
        local square = cell:getGridSquare(el.x, el.y, el.z)
        if square then
            local objects = square:getObjects()
            for i=0, objects:size()-1 do
                local object = objects:get(i)
                if instanceof(object, "IsoLightSwitch") and object:getUseBattery() and object:getHasBattery() then
                    if object:isActivated() ~= active then
                        object:setActive(active)
                        if active then
                            change = true
                        end
                    end
                end
            end
        end 
    end

    if change then
        if room.x1 and room.x2 and room.y1 and room.y2 then
            local sound = {}
            sound.x = math.floor(((room.x1 + room.x2) / 2) + 0.5)
            sound.y = math.floor(((room.y1 + room.y2) / 2) + 0.5)
            sound.z = room.z
            sound.sound = "AmbientELS"
            BWOASound.PlayLocation(sound)
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
                    local items = generator:getItemsPowered()
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

BWOABaseAPI.HeatingUpdate = function(active, temp)
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

                        if active then
                            BWOASound.AddToObject({x=coords.x, y=coords.y, z=coords.z, sound="AmbientVent"})
                        else
                            BWOASound.RemoveFromObject({x=coords.x, y=coords.y, z=coords.z, sound="AmbientVent"})
                        end
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

BWOABaseAPI.AirIntakeUpdate = function(active, airintakes)
    for _, airintake in pairs(airintakes) do
        if active and not airintake.broken then
            BWOAAnims.Add({
                x = airintake.x, 
                y = airintake.y, 
                z = airintake.z, 
                objName = "AirVent",
                frameList = {
                    "theark_01_5",
                    "theark_01_6"
                }
            })
        else
            BWOAAnims.Remove({
                x = airintake.x, 
                y = airintake.y, 
                z = airintake.z, 
            })
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