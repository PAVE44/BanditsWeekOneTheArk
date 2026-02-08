BWOASound = BWOASound or {}

BWOASound.global = {}
BWOASound.objects = {}
BWOASound.noah = {}
BWOASound.noahMax = 12
BWOASound.tick = 0
BWOASound.maxDist = 12
BWOASound.ambientArkSound = "AmbientArk"

BWOASound.megaphones = {}

BWOASound.megaphones.global = {
    {x=9966, y=12642, z=-4},
    {x=9966, y=12609, z=-4},
}

BWOASound.megaphones.noah = {
    {x=9966, y=12642, z=-4},
    {x=9966, y=12609, z=-4},
}

BWOASound.noahSounds = {
    ["ATTENTION"] = "NoahAttention",
    ["ERROR"] = "NoahError",
    ["POWERUP"] = "NoahPowerUp",
    ["POWERDOWN"] = "NoahPowerDown",
    ["BIO"] = "NoahBio",
    ["UNAUTHORIZED"] = "NoahUnauthorized",
    ["DECONTAMINATION"] = "NoahDecontamination",
    ["DECONTAMINATION_COMPLETE"] = "NoahDecontaminationComplete",
    ["GENERATORFAILURE"] = "NoahGeneratorFailure",
    ["GENERATORFUELLOW"] = "NoahGeneratorFuelLow",
    ["RADIATION"] = "NoahRadiation",
    ["CO2"] = "NoahCO2",
    ["STRUCTURAL"] = "NoahStructural",
    ["WATERFAILURE"] = "NoahWaterFailure",
    ["HEATINGFAILURE"] = "NoahHeatingFailure",
    ["FIRE"] = "NoahFire",
    ["AIRVENTROOM"] = "NoahAirVentRoom",
    ["ENTRANCE"] = "NoahMainEntrance",
    ["DECONTAMINATION_CHAMBER"] = "NoahDecontaminationChamber",
    ["ARMORY"] = "NoahArmory",
    ["BATHROOM"] = "NoahBathroom",
    ["BEDROOM"] = "NoahBedroom",
    ["CHAPEL"] = "NoahChapel",
    ["CONTROL_ROOM"] = "NoahControlRoom",
    ["GENERATOR_ROOM"] = "NoahGeneratorRoom",
    ["FOODGARDEN"] = "NoahFoodGarden",
    ["INCINERATOR_ROOM"] = "NoahIncineratorRoom",
    ["INFIRMARY"] = "NoahInfirmary",
    ["MEETING_ROOM"] = "NoahMeetingRoom",
    ["LABORATORY"] = "NoahLaboratory",
    ["LIBRARY"] = "NoahLibrary",
    ["MESSHALL"] = "NoahMesshall",
    ["LIVINGROOM"] = "NoahLivingRoom",
    ["STORAGEAREAONE"] = "NoahStorageAreaOne",
    ["STORAGEAREATWO"] = "NoahStorageAreaTwo",
    ["STORAGEAREATHREE"] = "NoahStorageAreaThree",
    ["STORAGEAREAFOUR"] = "NoahStorageAreaFour",
}

local function fixVolume(volume)
    local volumeMain = getSoundManager():getSoundVolume()
    local volumeZoom = 1

    local player = getSpecificPlayer(0)
    if player then
        local playerNum = player:getPlayerNum()
        local zoom = 1 / getCore():getZoom(playerNum)
        volumeZoom = BanditUtils.Lerp(zoom, 0.4, 4, 0.2, 1)
    end

    return volume * volumeMain * volumeZoom
end

BWOASound.PlayPlayer = function(tab)
    local player = getSpecificPlayer(0)
    player:playSound(tab.sound)
end

BWOASound.PlayCharacter = function(tab)
    local character = tab.character
    local emitter = character:getEmitter()
    local id = emitter:playSound(tab.sound)
    emitter:setVolume(id, fixVolume(1))
end

BWOASound.PlayLocation = function(tab)
    local square = getCell():getGridSquare(tab.x, tab.y, tab.z)
    if square then
        local emitter = getWorld():getFreeEmitter(tab.x, tab.y, tab.z)
        local id = emitter:playSound(tab.sound)
        emitter:setVolume(id, fixVolume(1))
    end
end

BWOASound.AddGlobal = function(tab)
    table.insert(BWOASound.global, tab)
end

BWOASound.RemoveGlobal = function(tab)
    for i, effect in ipairs(BWOASound.global) do
        if tab.sound == effect.sound then
            for _, megaphone in ipairs(BWOASound.megaphones.global) do
                megaphone.emitter:stopSoundByName(effect.sound)
                megaphone.emitter = nil
            end
            table.remove(BWOASound.global, i)
            break
        end
    end
end

BWOASound.AddToObject = function(tab)
    if not tab.sound then return end

    local duplicate = false
    for i, effect in ipairs(BWOASound.objects) do
        if effect.x == tab.x and effect.y == tab.y and effect.z == tab.z and (tab.sound == effect.sound or not tab.sound) then
            duplicate = true
            break
        end
    end

    if not duplicate then
        table.insert(BWOASound.objects, tab)
    end
end

BWOASound.RemoveFromObject = function(tab)
    for i, effect in ipairs(BWOASound.objects) do
        if effect.x == tab.x and effect.y == tab.y and effect.z == tab.z and (tab.sound == effect.sound or not tab.sound) then
            if effect.emitter then
                effect.emitter:stopAll()
            end
            table.remove(BWOASound.objects, i)
            break
        end
    end
end

BWOASound.AddNoah = function(tab)
    if #BWOASound.noah > BWOASound.noahMax then return end
    if tab.sound then
        table.insert(BWOASound.noah, tab)
    end
end

BWOASound.ClearNoah = function(tab)
    for i = #BWOASound.noah, 2 do
        table.remove(BWOASound.noah, i)
    end
end

local function onTick()
    if isServer() then return end
    if not isIngameState() then return end

    local world = getWorld()
    local player = getSpecificPlayer(0)
    if not player then return end

    local pemitter = player:getEmitter()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local maxDist = BWOASound.maxDist
    
    local gmd = GetBWOAModData()
    local power = BWOABaseControl.power

    local volume = fixVolume(1)
    local volumeNoah = volume * 1.5

    -- ambient looped emitter

    if pz > -2 then
        if pemitter:isPlaying(BWOASound.ambientArkSound) then
            pemitter:stopSoundByName(BWOASound.ambientArkSound)
        end
    else
        if not pemitter:isPlaying(BWOASound.ambientArkSound) then
            local id = pemitter:playSound(BWOASound.ambientArkSound)
            pemitter:setVolume(id, volume)
        end
    end

    -- global looped emitters
    for _, effect in ipairs(BWOASound.global) do
        for _, megaphone in ipairs(BWOASound.megaphones.global) do
            if not megaphone.emitter then
                megaphone.emitter = world:getFreeEmitter(megaphone.x, megaphone.y, megaphone.z)
            end

            if not megaphone.emitter:isPlaying(effect.sound) then
                megaphone.emitter:playSound(effect.sound)
            end
            megaphone.emitter:setVolumeAll(volume)
        end
    end

    -- Noah voice (non-looped, one at a time)
    local event = BWOASound.noah[1]
    if event then
        if not event.started then
            event.started = true
            for _, megaphone in ipairs(BWOASound.megaphones.noah) do

                megaphone.emitter = world:getFreeEmitter(megaphone.x, megaphone.y, megaphone.z)

                print ("start: " .. event.sound)
                megaphone.emitter:playSound(event.sound)
                megaphone.emitter:setVolumeAll(volumeNoah)
                megaphone.emitter:tick()

            end
        else
            local allFinished = true
            for _, megaphone in ipairs(BWOASound.megaphones.noah) do
                if megaphone.emitter then
                    if megaphone.emitter:isPlaying(event.sound) then
                        allFinished = false
                    else
                        megaphone.emitter:stopAll()
                        megaphone.emitter = nil
                    end
                end
            end
            if allFinished then
                table.remove(BWOASound.noah, 1)
            end
        end
    end

    -- object looped emitters

    for _, effect in ipairs(BWOASound.objects) do
        if effect.x and effect.y and effect.z then

            if math.abs(effect.x - px) < maxDist and math.abs(effect.y - py) < maxDist and math.abs(effect.z - pz) < 1 then

                if not effect.emitter then
                    effect.emitter = world:getFreeEmitter(effect.x, effect.y, effect.z)
                end

                if effect.emitter then
                    effect.emitter:setPos(effect.x, effect.y, effect.z)
                    if not effect.emitter:isPlaying(effect.sound) then
                        local sid = effect.emitter:playSound(effect.sound)
                        effect.sid = sid
                        -- print (effect.sound .. " x: " .. effect.x .. " y: " .. effect.y .. " z: " .. effect.z)
                    end

                    if not effect.elec or power then
                        effect.emitter:setVolumeAll(volume)
                    else
                        effect.emitter:setVolumeAll(0)
                    end
                end
            else
                if effect.emitter then
                    effect.emitter:stopAll()
                    effect.emitter:tick()
                    effect.emitter = nil
                end
            end
        end
    end
end

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)
