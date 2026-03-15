BWOANightmares = BWOANightmares or {}

BWOANightmares.Fall = {}

local cycle = 1
local cycleNumber = 1000
local returnData = {}

BWOANightmares.Fall.onEnter = function(player)
    local volume = getSoundManager():getSoundVolume()
    BWOAEventControl.Add("FadeIn", {time = 6, volume = volume}, 1)

    returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    player:setbClimbing(false)
    player:setX(8000)
    player:setY(5000)
    player:setZ(20)
    player:setLastX(8000)
    player:setLastY(5000)
    player:setLastZ(20)

    getWorld():update()
end

BWOANightmares.Fall.onCycle = function(player)
    if player:getZ() < 5 then
        player:setX(8000)
        player:setY(5000)
        player:setZ(30)
        player:setLastX(8000)
        player:setLastY(5000)
        player:setLastZ(30)
        local sound = player:getDescriptor():getVoicePrefix() .. "DeathFall"
        local emitter = player:getEmitter()
        if not emitter:isPlaying(sound) then
            emitter:playSound(sound)
        end
    end

    if cycle < cycleNumber - 10  then
        player:setbClimbing(false)
    else
        player:setbClimbing(true)
    end

    cycle = cycle + 1
    print("Nightmare cycle: " .. player:getZ().. " " .. cycle)
end

BWOANightmares.Fall.ShouldExit = function(player)
    if cycle > cycleNumber then
        return true
    end
    return false
end

BWOANightmares.Fall.onExit = function(player)
    player:setbClimbing(true)
    player:setX(returnData.x)
    player:setY(returnData.y)
    player:setZ(returnData.z)
    player:setLastX(returnData.x)
    player:setLastY(returnData.y)
    player:setLastZ(returnData.z)

    getWorld():update()
end

BWOANightmares.Fall.onPost = function(player)
    BWOATex.speed = 0.005

    player:clearVariable("BumpFallType")
    player:setBumpType("stagger")
    player:setBumpFall(true)
    player:setBumpFallType("pushedBehind")
    player:setbClimbing(false)

    cycle = 1
end
