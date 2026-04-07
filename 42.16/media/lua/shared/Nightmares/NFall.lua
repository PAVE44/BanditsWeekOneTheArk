BWOANightmares = BWOANightmares or {}

BWOANightmares.Fall = {}

local cycle = 1
local cycleNumber = 1000
local returnData = {}

BWOANightmares.Fall.onEnter = function(player)
    print ("[FALL] onEnter")
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }
    
    BWOAEventControl.Add("FadeIn", {time = 6}, 1)

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
    print ("[FALL] onCycle")
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if player:getZ() < 7 then
        print ("[FALL] onCycle, player z < 7 so teleporting to floor 31")
        player:setX(8000)
        player:setY(5000)
        player:setZ(30)
        player:setLastX(8000)
        player:setLastY(5000)
        player:setLastZ(31)
        local sound = player:getDescriptor():getVoicePrefix() .. "DeathFall"
        local emitter = player:getEmitter()
        if not emitter:isPlaying(sound) then
            emitter:playSound(sound)
        end
    end

    if cycle < cycleNumber - 10  then
        print ("[FALL] onCycle, climbing is false")
        player:setbClimbing(false)
    else
        print ("[FALL] onCycle, climbing is true")
        player:setbClimbing(true)
    end

    gmd.nightmares.cycle = cycle + 1
    print("Nightmare cycle: " .. player:getZ().. " " .. gmd.nightmares.cycle)
end

BWOANightmares.Fall.ShouldExit = function(player)
    print ("[FALL] shouldExit check")
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1
    if cycle > cycleNumber then
        print ("[FALL] shouldExit is now true")
        return true
    end
    return false
end

BWOANightmares.Fall.onExit = function(player)
    print ("[FALL] onExit")
    local gmd = GetBWOAModData()
    player:setbClimbing(true)
    print ("[FALL] onExit climbing set to true")
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.Fall.onPost = function(player)
    print ("[FALL] onPost")
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
