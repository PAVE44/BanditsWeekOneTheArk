BWOANightmares = BWOANightmares or {}

BWOANightmares.Fall = {}

local cycle = 1
local cycleNumber = 1000
local returnData = {}

BWOANightmares.Fall.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }
    
    local volume = getSoundManager():getSoundVolume()
    BWOAEventControl.Add("FadeIn", {time = 6, volume = volume}, 1)

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
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

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

    gmd.nightmares.cycle = cycle + 1
    print("Nightmare cycle: " .. player:getZ().. " " .. gmd.nightmares.cycle)
end

BWOANightmares.Fall.ShouldExit = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1
    if cycle > cycleNumber then
        return true
    end
    return false
end

BWOANightmares.Fall.onExit = function(player)
    local gmd = GetBWOAModData()
    player:setbClimbing(true)
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.Fall.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil

    BWOATex.speed = 0.005

    player:clearVariable("BumpFallType")
    player:setBumpType("stagger")
    player:setBumpFall(true)
    player:setBumpFallType("pushedBehind")
    player:setbClimbing(false)
end
