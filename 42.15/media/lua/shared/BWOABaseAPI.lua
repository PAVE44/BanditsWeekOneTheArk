BWOABaseAPI = BWOABaseAPI or {}

BWOABaseAPI.power = true
BWOABaseAPI.alarm = false

BWOABaseAPI.generators = {
    {x=9950, y=12599, z=-6},
    {x=9950, y=12625, z=-6},
    {x=9950, y=12650, z=-6},
    {x=9975, y=12599, z=-6},
    {x=9975, y=12625, z=-6},
    {x=9975, y=12650, z=-6},
}

BWOABaseAPI.heatsources = {}

BWOABaseAPI.GeneratorsUpdate = function()
    local cell = getCell()

    -- ensure fake generator presence
    for _, coords in pairs(BWOABaseAPI.generators) do
        local square = cell:getOrCreateGridSquare(coords.x, coords.y, coords.z)
        if square and square:getChunk() then
            local generator = square:getGenerator()
            if not generator then
                local genItem = BanditCompatibility.InstanceItem("Base.Generator_Old")
                local generator = IsoGenerator.new(genItem, cell, square)
                generator:transmitCompleteItemToClients()
                generator:setCondition(100)
                generator:setFuel(100)
                generator:setConnected(true)

                local props = generator:getProperties()
                props:set("GeneratorSound", "silenced")

                cell:addToProcessIsoObjectRemove(generator)
                square:setSquareChanged()
                

            else
                generator:setCondition(100)
                generator:setFuel(100)
                local props = generator:getProperties()
                props:set("GeneratorSound", "silenced")


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
                    local sprite = object:getSprite()
                    if sprite then
                        local props = sprite:getProperties()
                        if not props or not props:has("CustomName") or props:get("CustomName") ~= "Noah" then
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
        if square and square:getChunk() then
            local generator = square:getGenerator()
            if generator then
                if generator:isActivated() then
                    generator:update()
                    powerUsing = powerUsing + generator:getTotalPowerUsing()
                    --[[
                    print (powerUsing)
                    local items = generator:getItemsPowered()
                    for i=0,items:size()-1 do
                        print(items:get(i))
                    end]]

                end
            end
        else
            return nil
        end
    end
    return powerUsing
end

BWOABaseAPI.AlarmOn = function()
    if not BWOABaseAPI.alarm then
        BWOABaseAPI.alarm = true
        BWOASound.AddGlobal({sound="AmbientAlarmGlobal"})
        BWOASound.AddToObject({x=BWOARooms.Control.noah.x, y=BWOARooms.Control.noah.y, z=BWOARooms.Control.noah.z, sound="AmbientAlarmLocal"})
        BanditPlayer.WakeEveryone()
    end
end

BWOABaseAPI.AlarmOff = function()
    BWOASound.RemoveGlobal({sound="AmbientAlarmGlobal"})
    BWOASound.RemoveFromObject({x=BWOARooms.Control.noah.x, y=BWOARooms.Control.noah.y, z=BWOARooms.Control.noah.z, sound="AmbientAlarmLocal"})
    BWOABaseAPI.alarm = false
end

BWOABaseAPI.NoahUpdate = function()
    local square = getCell():getGridSquare(BWOARooms.Control.noah.x, BWOARooms.Control.noah.y, BWOARooms.Control.noah.z)
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            if instanceof(object, "IsoLightSwitch") then
                local sprite = object:getSprite()
                if sprite then
                    local props = sprite:getProperties()
                    if props:has("CustomName") then
                        local customName = props:get("CustomName")
                        if customName and customName == "Noah" then
                            if object:isActivated() then
                                if not BWOANoah.IsOn() then
                                    BWOANoah.screen = "Main"
                                end
                                BWOANoah.SetOn(true)
                                BWOASound.AddToObject({x=9963.5, y=12627, z=-4, sound="AmbientComputer"})
                            else
                                BWOANoah.SetOn(false)
                                BWOASound.RemoveFromObject({x=9963.5, y=12627, z=-4, sound="AmbientComputer"})
                            end
                        end
                    end
                end
            end
        end
    end
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

BWOABaseAPI.IsNetworkPlayerArkDeclared = function()
    local gmd = GetBWOAModData()
    local network = gmd.arkNetwork
    for _, ark in ipairs(network) do
        if ark.player and ark.status == 1 then
            return true
        end
    end

    return false
end

BWOABaseAPI.GetHostileNetworkArks = function(hours)
    local gmd = GetBWOAModData()
    local network = gmd.arkNetwork
    local hostile = {}
    for _, ark in ipairs(network) do
        if ark.status == 1 and not ark.player and ark.raidAgeStart and hours > ark.raidAgeStart and ark.raidAgeEnd and hours < ark.raidAgeEnd then
            table.insert(hostile, ark)
        end
    end

    return hostile
end

BWOABaseAPI.GetNetworkPlayerArk = function()
    local gmd = GetBWOAModData()
    local network = gmd.arkNetwork
    for _, ark in ipairs(network) do
        if ark.player then
            return ark
        end
    end

    return nil
end

BWOABaseAPI.SwitchNetworkPlayerArkConcealment = function()
    local gmd = GetBWOAModData()
    local network = gmd.arkNetwork
    for _, ark in ipairs(network) do
        if ark.player then
            BWOASound.ClearNoah()
            BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
            if ark.status == 0 then
                ark.status = 1
                BWOASound.AddNoah({sound = BWOASound.noahSounds.ARKDECLARED})
            else
                ark.status = 0
                BWOASound.AddNoah({sound = BWOASound.noahSounds.ARKCONCEALED})
            end
            break
        end
    end
end

BWOABaseAPI.NetworkArkReveal = function(arkId)
    local gmd = GetBWOAModData()
    local wa = getGameTime():getWorldAgeHours() - 10
    local network = gmd.arkNetwork

    local playerDeclared = false
    for _, ark in ipairs(network) do
        if ark.player then
            if ark.status == 1 then
                playerDeclared = true
                break
            end
        end
    end

    for _, ark in ipairs(network) do
        if ark.id == arkId then
            ark.status = 1
            ark.raidAgeStart = wa + 5
            ark.raidAgeEnd = 4000

            if playerDeclared then
                BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
                BWOASound.AddNoah({sound = BWOASound.noahSounds.ARKREVEALED})
            end
            break
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