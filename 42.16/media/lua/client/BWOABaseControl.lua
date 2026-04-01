BWOABaseControl = {}

BWOABaseControl.power = false
BWOABaseControl.powerUsing = 0

BWOABaseControl.intrusion = false

local function onGameStart()
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].Init()
    end

    BWOABuildings.LoadHatches()

    local radio = getZomboidRadio()
    local rsm = radio:getScriptManager()
    rsm:RemoveChannel(93200)
    rsm:RemoveChannel(94200)
    rsm:RemoveChannel(98000)
    rsm:RemoveChannel(101200)
    rsm:RemoveChannel(89400)
    rsm:RemoveChannel(200)
    rsm:RemoveChannel(201)
    rsm:RemoveChannel(203)
    rsm:RemoveChannel(204)
    rsm:RemoveChannel(205)
    rsm:RemoveChannel(91200)
    rsm:RemoveChannel(107600)
    rsm:RemoveChannel(95000)
    rsm:RemoveChannel(206)
    rsm:RemoveChannel(207)
    rsm:RemoveChannel(208)
    rsm:RemoveChannel(209)
    rsm:RemoveChannel(210)
    rsm:reset()

    getSandboxOptions():set("ElecShut", 1)
    getSandboxOptions():set("ElecShutModifier", 0)
    if getWorld():isHydroPowerOn() then
        getWorld():setHydroPowerOn(false)
    end

    getCore():setOptionUIRenderFPS(60)

end

local function onPreMapLoad()
    getSoundManager():setMusicState("PauseMenu")
    BWOAMusic.Play("MusicEndure", 0.6, 1)
end


local function onCreatePlayer(playerNum, player)
    local hours = player:getHoursSurvived()
    if hours < 0.02 then
        BWOASequence.Start()
    else
        BWOASequence.Resume()
    end
end

local function manageIntrusion()

    if not BWOANoah.IsOn() then return end
    if BWOANoah.GetState() ~= "operational" then return end

    local gametime = getGameTime()
    local minute = gametime:getMinutes()
    if minute % 4 > 0 then return end

    BWOABaseControl.intrusion = false

    local zombieList = BanditZombie.CacheLightZ
    local roomNames = {}
    local alarmZombie = false
    for _, zombie in pairs(zombieList) do
        local room = BWOAUtils.GetRoom(zombie.x, zombie.y, zombie.z)
        if room then
            alarmZombie = true
            roomNames[room.name] = true
        end
    end

    if alarmZombie then
        BWOABaseAPI.AlarmOn()
        BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
        BWOASound.AddNoah({sound = BWOASound.noahSounds.BIO})
        for roomName, _ in pairs(roomNames) do
            BWOASound.AddNoah({sound = BWOASound.noahSounds[roomName]})
        end
        BWOABaseControl.intrusion = true
    end

    local banditList = BanditZombie.CacheLightB
    local roomNames = {}
    local alarmBandit = false
    for _, bandit in pairs(banditList) do
        if bandit.brain and bandit.brain.hostile then
            local room = BWOAUtils.GetRoom(bandit.x, bandit.y, bandit.z)
            if room then
                alarmBandit = true
                roomNames[room.name] = true
            end
        end
    end

    if alarmBandit then
        BWOABaseAPI.AlarmOn()
        BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
        BWOASound.AddNoah({sound = BWOASound.noahSounds.UNAUTHORIZED})
        for roomName, _ in pairs(roomNames) do
            BWOASound.AddNoah({sound = BWOASound.noahSounds[roomName]})
        end
        BWOABaseControl.intrusion = true
    end    
end

local function managePower()

    local cm = getClimateManager()
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    local gmd = GetBWOAModData()

    -- no Noah leads to generator shutdown
    if not BWOANoah.IsOn() or BWOANoah.GetState() ~= "operational" then
        for gtype, gen in pairs(gmd.generators) do
            gen.active = false
        end
    end

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
    local newPower
    if genCnt > 0 then
        -- ensure presence of fake generators
        BWOABaseAPI.GeneratorsUpdate()
        newPower = true
    else
        newPower = false
    end

    if newPower ~= BWOABaseControl.power then
        BWOABaseControl.power = newPower
        BWOASound.ClearNoah()
        if BWOABaseControl.power then
            BWOABaseAPI.GeneratorsOn()
            BWOASequence.EmergencyLights({active=false})
            BWOASound.AddNoah({sound = BWOASound.noahSounds.POWERUP})
        else
            BWOABaseAPI.GeneratorsOff()
            if BWOANoah.IsOn() and BWOANoah.GetState() == "operational" then
                BWOASequence.EmergencyLights({active=true})
            end

            -- force shutdown of other systems using power here:
            BWOABaseAPI.AlarmOff()

            gmd.ventilation.active = false
            gmd.waterpump.active = false
            BWOASound.AddNoah({sound = BWOASound.noahSounds.POWERDOWN})
        end
    end

    -- generator fuel usage
    if genCnt > 0 then
        local gridPowerUsing = BWOABaseAPI.GetGeneratorPowerUsing()
        -- print ("GRID-POWER" .. gridPowerUsing)

        local ventPowerUsing = 0
        if gmd.ventilation.active then
            ventPowerUsing = 0.01 -- mechanical ventilation cost
            if gmd.ventilation.heating then
                -- heating cost

                local diff = gmd.ventilation.tempTarget - BWOAClimate.temp
                if diff > 0 then

                    if diff > 80 then
                        diff = 80
                    end

                    -- Quadratic growth: (diff / 80)^2 scaled to max 0.1
                    local normalized = diff / 80.0
                    local cost = (normalized ^ 2) * 0.1

                    if gmd.ventilation.open then
                        cost = cost * 1.4
                    end

                    ventPowerUsing = ventPowerUsing + cost
                end
            end
            ventPowerUsing = ventPowerUsing / genCnt
        end

        BWOABaseControl.gridPowerUsing = 0
        for gtype, gen in pairs(gmd.generators) do
            if gen.active then

                -- in case physical generators are unreachable, use last know value
                local powerUsing
                if not gridPowerUsing then
                    powerUsing = gen.powerUsing
                else
                    powerUsing = gridPowerUsing / genCnt
                end
                gen.powerUsing = powerUsing

                local totalPowerUsing = powerUsing + ventPowerUsing
                BWOABaseControl.gridPowerUsing = BWOABaseControl.gridPowerUsing + totalPowerUsing

                local fuelUsing = totalPowerUsing * 0.1
                gen.fuel = gen.fuel - fuelUsing
                if gen.fuel <= 0 then gen.fuel = 0 end
                
                local condDrop = 0.001
                if not gen.lubricant then gen.lubricant = 100 end
                gen.lubricant = gen.lubricant - 0.005
                if gen.lubricant < 75 then
                    condDrop = condDrop + (100 - gen.lubricant) * 0.0004
                end

                -- emergency stop due to overheat and missing coolant
                if not gen.coolant then gen.coolant = 100 end
                gen.coolant = gen.coolant - 0.002
                if gen.coolant < 50 then
                    local rnd = ZombRand(100)
                    if rnd < (50 - gen.coolant) * 2 then
                        condDrop = condDrop + 1
                        gen.active = false
                        break
                    end
                end
                gen.condition = gen.condition - condDrop

                -- emergency stop - out of fuel
                if gen.fuel == 0 then
                    gen.active = false
                    break
                end

                -- emergency stop - low general condition
                if gen.condition < 10 then
                    -- low condition random stop
                    if ZombRand(math.floor(gen.condition) * 10 + 1) == 0 then
                        gen.active = false
                        break
                    end
                end

                -- alerting
                if minute % 10 == 1 then
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

                -- print ("GEN: type: " .. gtype .. " F: " .. gen.fuel .. " C: " .. gen.condition .. " P: " .. gen.powerUsing .. " VP: " .. ventPowerUsing)
            end
        end
    end
end

local function manageVentilation()
    local gmd = GetBWOAModData()
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local ventilation = gmd.ventilation
    if ventilation.active and ventilation.heating then
        if ventilation.temp < ventilation.tempTarget then
            if ventilation.open then
                ventilation.temp = ventilation.temp + 0.1
            else
                ventilation.temp = ventilation.temp + 0.3
            end
        else
            if ventilation.open then
                ventilation.temp = ventilation.temp - 0.1
            else
                ventilation.temp = ventilation.temp - 0.025
            end
        end
    else
        if ventilation.temp > BWOAClimate.temp then
            if ventilation.open then
                ventilation.temp = ventilation.temp - 0.1
            else
                ventilation.temp = ventilation.temp - 0.025
            end
        end
    end
    BWOABaseAPI.HeatingUpdate(ventilation.active, ventilation.temp)

    local airintakes = gmd.airintakes
    local co2Reduction = 0
    if ventilation.active then

        for _, airintake in pairs(airintakes) do
            if not airintake.broken then
                if ventilation.open then
                    co2Reduction = co2Reduction + 6
                else
                    co2Reduction = co2Reduction + 5
                end
            end
        end
    end

    local co2BuildUp = 19

    ventilation.co2 = ventilation.co2 + co2BuildUp - co2Reduction

    if  co2BuildUp > co2Reduction then
        BWOADialogues.Reveal("Emma_Robinson", "1000.5")
    else
        BWOADialogues.Hide("Emma_Robinson", "1000.5")
    end

    if ventilation.co2 < 400 then ventilation.co2 = 400 end
    if ventilation.co2 > 100000 then ventilation.co2 = 100000 end

    BWOABaseAPI.AirIntakeUpdate(ventilation.active, airintakes)

    -- alerting
    if BWOANoah.IsOn() and BWOANoah.GetState() == "operational" then
        if minute % 30 == 2 then
            if ventilation.co2 > 6000 then
                BWOASound.ClearNoah()
                BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
                BWOASound.AddNoah({sound = BWOASound.noahSounds.CO2})

                if ventilation.co2 > 60000 then
                    BWOABaseAPI.AlarmOn()
                end
            end
        end
    end
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

local function manageRoomLogic()
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].Init()
        if BWOARooms[room].Logic then
            BWOARooms[room].Logic()
        end
    end
end

local function manageNoah()
    BWOABaseAPI.NoahUpdate() 
end

local function manageFire(fire)
    local x, y, z = fire:getX(), fire:getY(), fire:getZ()

    -- alerting
    if BWOANoah.IsOn() and BWOANoah.GetState() == "operational" then
        local room = BWOAUtils.GetRoom(x, y, z)
        if room then
            BWOABaseAPI.AlarmOn()
            BWOASound.ClearNoah()
            BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
            BWOASound.AddNoah({sound = BWOASound.noahSounds.FIRE})
            BWOASound.AddNoah({sound = BWOASound.noahSounds[room.name]})
        end
    end
end

Events.OnGameStart.Remove(onGameStart)
Events.OnGameStart.Add(onGameStart)

Events.OnPreMapLoad.Remove(onPreMapLoad)
Events.OnPreMapLoad.Add(onPreMapLoad)

Events.OnCreatePlayer.Remove(onCreatePlayer)
Events.OnCreatePlayer.Add(onCreatePlayer)

Events.EveryOneMinute.Remove(manageIntrusion)
Events.EveryOneMinute.Add(manageIntrusion)

Events.EveryOneMinute.Remove(manageNoah)
Events.EveryOneMinute.Add(manageNoah)

Events.EveryOneMinute.Remove(managePower)
Events.EveryOneMinute.Add(managePower)

Events.EveryOneMinute.Remove(manageVentilation)
Events.EveryOneMinute.Add(manageVentilation)

Events.EveryOneMinute.Remove(manageRoomLogic)
Events.EveryOneMinute.Add(manageRoomLogic)

Events.OnNewFire.Remove(manageFire)
Events.OnNewFire.Add(manageFire)
