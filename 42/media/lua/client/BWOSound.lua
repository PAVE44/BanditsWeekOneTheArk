BWOASound = BWOASound or {}

BWOASound.global = {}
BWOASound.objects = {}
BWOASound.noah = {}
BWOASound.tick = 0
BWOASound.maxDist = 50
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
    ["FIRE"] = "NoahFire",
    ["BATHROOM_ONE"] = "NoahBathroomOne",
    ["BATHROOM_TWO"] = "NoahBathroomTwo",
    ["CONTROL_ROOM"] = "NoahControlRoom",
    ["GENERATOR_ROOM"] = "NoahGeneratorRoom",
    ["INCINERATOR_ROOM"] = "NoahIncineratorRoom",
    ["LABORATORY"] = "NoahLaboratory",
    ["LIBRARY"] = "NoahLibrary",
}

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
    if tab.sound then
        table.insert(BWOASound.objects, tab)
    end
end

BWOASound.RemoveFromObject = function(tab)
    for i, effect in ipairs(BWOASound.objects) do
        if effect.x == tab.x and effect.y == tab.y and effect.z == tab.z and (tab.sound == effect.sound or not tab.sound) then
            effect.emitter:stopAll()
            table.remove(BWOASound.objects, i)
            break
        end
    end
end

BWOASound.AddNoah = function(tab)
    if tab.sound then
        table.insert(BWOASound.noah, tab)
    end
end

local function onTick()
    if isServer() then return end

    local player = getSpecificPlayer(0)
    local pemitter = player:getEmitter()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local maxDist = BWOASound.maxDist
    local volume = getSoundManager():getSoundVolume()

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
                megaphone.emitter = getWorld():getFreeEmitter(megaphone.x, megaphone.y, megaphone.z)
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

                megaphone.emitter = getWorld():getFreeEmitter(megaphone.x, megaphone.y, megaphone.z)

                print ("start: " .. event.sound)
                megaphone.emitter:playSound(event.sound)
                megaphone.emitter:setVolumeAll(volume / 1.5)
                megaphone.emitter:tick()

            end
        else
            local allFinished = true
            for _, megaphone in ipairs(BWOASound.megaphones.noah) do
                if megaphone.emitter:isPlaying(event.sound) then
                    allFinished = false
                else
                    megaphone.emitter:stopAll()
                    megaphone.emitter = nil
                end
            end
            if allFinished then
                table.remove(BWOASound.noah, 1)
                print ("stop: " .. event.sound)
            end
        end
    end

    -- object looped emitters
    for _, effect in ipairs(BWOASound.objects) do
        if effect.x and effect.y and effect.z then

            if math.abs(effect.x - px) < maxDist and math.abs(effect.y - py) < maxDist and math.abs(effect.z - pz) < 1 then

                if not effect.emitter then
                    effect.emitter = getWorld():getFreeEmitter(effect.x, effect.y, effect.z)
                end

                effect.emitter:setVolumeAll(volume)

                if not effect.emitter:isPlaying(effect.sound) then
                    effect.emitter:playAmbientLoopedImpl(effect.sound)
                    effect.emitter:tick()
                end
            end
        end
    end
end

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)
