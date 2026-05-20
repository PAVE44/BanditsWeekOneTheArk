BWOANightmares = BWOANightmares or {}

BWOANightmares.Fall = {}

local cycle = 1
local cycleNumber = 800
local returnData = {}

BWOANightmares.Fall.onEnter = function(player)
    -- print ("[FALL] onEnter")
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
    BWOAEventControl.Add("Teleport", {x=8000, y=5000, z=20}, 1)
    player:setLastZ(20)
    -- getWorld():update()
end

BWOANightmares.Fall.onCycle = function(player)
    -- print ("[FALL] onCycle")
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if player:getZ() < 4 then
        -- print ("[FALL] onCycle, player z < 4 so teleporting to floor 31")
        player:teleportTo(8000, 5000, 31)
        local sound = player:getDescriptor():getVoicePrefix() .. "DeathFall"
        local emitter = player:getEmitter()
        if not emitter:isPlaying(sound) then
            emitter:playSound(sound)
        end
    end

    if cycle < cycleNumber - 10  then
        -- print ("[FALL] onCycle, climbing is false")
        player:setbClimbing(false)
    else
        -- print ("[FALL] onCycle, climbing is true")
        player:setbClimbing(true)
    end

    local inc = getGameTime():getGameWorldSecondsSinceLastUpdate() * 4
    -- print (inc)
    gmd.nightmares.cycle = cycle + inc
    -- print("Nightmare cycle: " .. player:getZ().. " " .. gmd.nightmares.cycle)
end

BWOANightmares.Fall.ShouldExit = function(player)
    -- print ("[FALL] shouldExit check")
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1
    if cycle > cycleNumber then
        -- print ("[FALL] shouldExit is now true")
        return true
    end
    return false
end

BWOANightmares.Fall.onExit = function(player)
    -- print ("[FALL] onExit")
    -- print ("[FALL] onExit player alive: " .. tostring(player:isAlive()))
    local gmd = GetBWOAModData()
    player:setbClimbing(true)
    -- print ("[FALL] onExit climbing set to true")
    -- print ("[FALL] onExit player alive: " .. tostring(player:isAlive()))
    local x, y, z = gmd.nightmares.returnData.x, gmd.nightmares.returnData.y, gmd.nightmares.returnData.z
    BWOAEventControl.Add("Teleport", {x=x, y=y, z=z}, 1)
    -- print ("[FALL] onExit position Z: " .. player:getZ())
    -- print ("[FALL] onExit player alive: " .. tostring(player:isAlive()))
    -- getWorld():update()
    -- print ("[FALL] onExit position Z after world update: " .. player:getZ())
    -- print ("[FALL] onExit player alive: " .. tostring(player:isAlive()))
end

BWOANightmares.Fall.onPost = function(player)
    -- print ("[FALL] onPost")
    -- print ("[FALL] onPost player alive: " .. tostring(player:isAlive()))
    -- print ("[FALL] onPost position Z: " .. player:getZ())
    
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil

    BWOATex.speed = 0.005

    -- print ("[FALL] onPost player alive: " .. tostring(player:isAlive()))
    player:clearVariable("BumpFallType")
    player:setBumpType("stagger")
    player:setBumpFall(true)
    player:setBumpFallType("pushedBehind")

    -- print ("[FALL] onPost player alive: " .. tostring(player:isAlive()))
    player:setbClimbing(false)
    -- print ("[FALL] onPost climbing is false ")
    -- print ("[FALL] onPost player alive: " .. tostring(player:isAlive()))
end
