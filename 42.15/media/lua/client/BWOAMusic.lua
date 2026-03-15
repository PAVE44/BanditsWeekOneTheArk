BWOAMusic = BWOAMusic or {}
BWOAMusic.tick = 0
BWOAMusic.origReturnVolume = nil
BWOAMusic.customId = nil
BWOAMusic.customTargetVolume = 0
BWOAMusic.customCurrentVolume = 0
BWOAMusic.emitter = nil

BWOAMusic.OnMusicVolumeChange = function(volume)
    BWOAMusic.origReturnVolume = volume
end

BWOAMusic.Play = function(music, volumeTarget, volumeStart)
    if not volumeStart then volumeStart = 0 end
    if not volumeTarget then volumeTarget = 1 end
    -- if true then return end
    local emitter
    local player = getSpecificPlayer(0)
    if player then
        emitter = player:getEmitter()
    else
        emitter = getSoundManager():getUIEmitter()
        -- in main menu this is necessary to have stereo effect
        emitter:setPos(0, 0, 0)
    end
    BWOAMusic.emitter =  emitter

    -- stop previous custom music if there is one
    if BWOAMusic.customId then
        emitter:stopSound(BWOAMusic.customId)
        BWOAMusic.customId = nil
        BWOAMusic.customCurrentVolume = 0
    end

    -- start custom music
    local id = emitter:playSound(music)
    if id then
        emitter:setVolume(id, volumeStart)
        BWOAMusic.customId = id
        BWOAMusic.customCurrentVolume = volumeStart
        BWOAMusic.customTargetVolume = volumeTarget
        BWOAMusic.origReturnVolume = getSoundManager():getMusicVolume()
    end
end

BWOAMusic.Stop = function()
    if BWOAMusic.customId and BWOAMusic.emitter then
        BWOAMusic.emitter:stopSound(BWOAMusic.customId)
        BWOAMusic.customId = nil
        BWOAMusic.customCurrentVolume = 0
    end
end

BWOAMusic.IsPlaying = function()
    if BWOAMusic.customId then return true end
    --[[
    if BWOAMusic.customId and BWOAMusic.emitter then
        return BWOAMusic.emitter:isPlaying(BWOAMusic.customId)
    end]]
    return false
end

BWOAMusic.Process = function()
    
    if not BWOAMusic.emitter then return end

    local max = 160
    if isIngameState() then
        max = 30
    end

    if BWOAMusic.tick > 0 then
        BWOAMusic.tick = BWOAMusic.tick + 1
        if BWOAMusic.tick >= max then
            BWOAMusic.tick = 0
        end
        return
    end

    if getCore():getOptionUIRenderFPS() ~= 60 then
        getCore():setOptionUIRenderFPS(60)
    end

    if BWOAMusic.customId then
        -- fade out orig
        local sm = getSoundManager()
        local origVolume = sm:getMusicVolume()
        local newVolume = origVolume - 0.25
        if newVolume < 0 then newVolume = 0 end
        sm:setMusicVolume(newVolume)
        getCore():setOptionMusicVolume(newVolume * 10)

        -- fade in custom
        local emitter = BWOAMusic.emitter
        if emitter:isPlaying(BWOAMusic.customId) then
            local newVolume = BWOAMusic.customCurrentVolume + 0.1
            if newVolume > BWOAMusic.customTargetVolume then newVolume = BWOAMusic.customTargetVolume end
            BWOAMusic.customCurrentVolume = newVolume
            emitter:setVolume(BWOAMusic.customId, newVolume)
        else
            BWOAMusic.customId = nil
            BWOAMusic.customCurrentVolume = 0
        end
    else
        -- fade in orig
        local sm = getSoundManager()
        local origVolume = sm:getMusicVolume()
        local newVolume = origVolume + 0.1
        if newVolume <= BWOAMusic.origReturnVolume then
            sm:setMusicVolume(newVolume)
            getCore():setOptionMusicVolume(newVolume * 10)
        end
    end

    BWOAMusic.tick = 1
end

Events.OnPreUIDraw.Add(BWOAMusic.Process)
