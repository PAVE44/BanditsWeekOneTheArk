BWOABaseControl = {}

BWOABaseControl.power = false
BWOABaseControl.powerUsing = 0

local function onGameStart()
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].Init()
    end
end

local function onCreatePlayer(playerNum, player)
    local hours = player:getHoursSurvived()
    if hours < 0.1 then
        BWOASequence.Start()
    else
        BWOASequence.Resume()
    end
end

local function manageIntrusion()

    local gametime = getGameTime()
    local minute = gametime:getMinutes()
    if minute % 2 == 0 then return end

    local zombieList = BanditZombie.CacheLightZ
    local roomNames = {}
    local alarm = false
    for _, zombie in pairs(zombieList) do
        local room = BWOAUtils.GetRoom(zombie.x, zombie.y, zombie.z)
        if room then
            alarm = true
            roomNames[room.name] = true
        end
    end

    if alarm then
        BWOABaseAPI.AlarmOn()
        BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
        BWOASound.AddNoah({sound = BWOASound.noahSounds.BIO})
        for roomName, _ in pairs(roomNames) do
            BWOASound.AddNoah({sound = BWOASound.noahSounds[roomName]})
        end
    end
end

local function managePower()

    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    local gmd = GetBWOAModData()

    -- manage generators
    local genCnt = 0
    for gtype, gen in pairs(gmd.generators) do
        if gen.active then
            BWOASound.AddToObject({x=gen.x, y=gen.y, z=gen.z, elec=true, sound="AmbientGenerator"})
            genCnt = genCnt + 1
        else
            BWOASound.RemoveFromObject({x=gen.x, y=gen.y, z=gen.z, elec=true, sound="AmbientGenerator"})
        end
    end

    -- set global power var
    BWOABaseControl.powerUsing = 0
    if genCnt > 0 then
        BWOABaseControl.power = true
    else
        BWOABaseControl.power = false
    end

    -- ensure presence of fake generators
    if genCnt > 0 then
        BWOABaseAPI.GeneratorsUpdate()
    end

    -- generator fuel usage
    if genCnt > 0 then
        local powerUsing = BWOABaseAPI.GetGeneratorPowerUsing()

        for gtype, gen in pairs(gmd.generators) do
            if gen.active then

                -- in case physical generators are unreachable, use last know value
                if not powerUsing then
                    powerUsing = gen.powerUsing
                else
                    powerUsing = powerUsing / genCnt
                end

                ventPowerUsing = 0
                if gmd.ventilation.active then
                    ventPowerUsing = 2 -- mechanical ventilation cost
                    if gmd.ventilation.heating then
                        -- heating cost
                        local diff = gmd.ventilation.tempTarget - BWOAClimate.temp
                        if diff > 0 then
                            ventPowerUsing = ventPowerUsing + (diff * 0.1)
                        end
                    end
                    ventPowerUsing = ventPowerUsing / genCnt
                end

                local totalPowerUsing = powerUsing + ventPowerUsing
                BWOABaseControl.powerUsing = totalPowerUsing

                local fuelUsing = totalPowerUsing * 0.1
                gen.fuel = gen.fuel - fuelUsing
                gen.condition = gen.condition - 0.01
                gen.powerUsing = powerUsing

                if gen.fuel <= 0 then
                    gen.fuel = 0
                    gen.active = false
                    genCnt = genCnt - 1
                    BWOASound.PlayLocation({
                        sound = "AmbientPowerDown",
                        x = BWOARooms.Control.noah.x,
                        y = BWOARooms.Control.noah.y,
                        z = BWOARooms.Control.noah.z
                    })
                end
                if gen.condition < 10 then
                    -- low condition random stop
                    if ZombRand(math.floor(gen.condition) * 10 + 1) == 0 then
                        gen.active = false
                    end
                end

                -- alerting
                if minute % 5 == 0 then
                    local fuelAlert = false
                    local conditionAlert = false
                    if gen.fuel < gmd.alerting.generatorFuelAlert then
                        fuelAlert = true
                    end
                    if gen.condition < gmd.alerting.generatorConditionAlert then
                        conditionAlert = true
                    end

                    if fuelAlert or conditionAlert then

                        BWOASound.ClearNoah()
                        BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})

                        if fuelAlert then
                            BWOASound.AddNoah({sound = BWOASound.noahSounds.GENERATORFUELLOW})
                        end
                        if conditionAlert then
                            BWOASound.AddNoah({sound = BWOASound.noahSounds.GENERATORFAILURE})
                        end
                    end
                end

                print ("GEN: type: " .. gtype .. " F: " .. gen.fuel .. " C: " .. gen.condition .. " P: " .. gen.powerUsing .. " VP: " .. ventPowerUsing)
            end
        end
    end

    -- handle generator status
    if genCnt > 0 then
        BWOABaseAPI.GeneratorsOn()
        BWOASequence.EmergencyLights({active=false})
    else
        BWOABaseAPI.GeneratorsOff()

        BWOASequence.EmergencyLights({active=true})

        -- force shutdown of other systems using power here:
        BWOABaseAPI.AlarmOff()

        gmd.ventilation.active = false
        gmd.waterpump.active = false
    end
end

local function manageVentilation()
    local gmd = GetBWOAModData()
    local ventilation = gmd.ventilation
    if ventilation.active and ventilation.heating then
        if ventilation.temp < ventilation.tempTarget then
            ventilation.temp = ventilation.temp + 0.1
        end
    else
        if ventilation.temp > BWOAClimate.temp then
            ventilation.temp = ventilation.temp - 0.1
        end
    end
    BWOABaseAPI.VentilationUpdate(ventilation.active, ventilation.temp)
end

local function manageWater()
    getSandboxOptions():set("WaterShut", 1)
    getSandboxOptions():set("WaterShutModifier", 0)

    local gmd = GetBWOAModData()
    local waterpump = gmd.waterpump

    if water.active then
        BWOABaseAPI.WaterOn()
    else
        BWOABaseAPI.WaterOff()
    end
end

local function manageFire(fire)
    local x, y, z = fire:getX(), fire:getY(), fire:getZ()
    local room = BWOAUtils.GetRoom(x, y, z)
    if room then
        BWOABaseAPI.AlarmOn()
        BWOASound.ClearNoah()
        BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
        BWOASound.AddNoah({sound = BWOASound.noahSounds.FIRE})
        BWOASound.AddNoah({sound = BWOASound.noahSounds[room.name]})
    end
end

Events.OnGameStart.Remove(onGameStart)
Events.OnGameStart.Add(onGameStart)

Events.OnCreatePlayer.Remove(onCreatePlayer)
Events.OnCreatePlayer.Add(onCreatePlayer)

Events.EveryOneMinute.Remove(manageIntrusion)
Events.EveryOneMinute.Add(manageIntrusion)

Events.EveryOneMinute.Remove(managePower)
Events.EveryOneMinute.Add(managePower)

Events.EveryOneMinute.Remove(manageVentilation)
Events.EveryOneMinute.Add(manageVentilation)

Events.OnNewFire.Remove(manageWater)
Events.OnNewFire.Add(manageWater)

Events.OnNewFire.Remove(manageFire)
Events.OnNewFire.Add(manageFire)
