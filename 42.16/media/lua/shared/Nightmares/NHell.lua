BWOANightmares = BWOANightmares or {}

BWOANightmares.Hell = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.Hell.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    BWOAEventControl.Add("FadeOut", {time = 0}, 0)
    BWOAEventControl.Add("FadeIn", {time = 5}, 2700)
 
    BWOATex.tex = getTexture("media/textures/nightmare_mask3.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    player:setX(18009)
    player:setY(3848)
    player:setZ(-10)
    player:setLastX(18009)
    player:setLastY(3848)
    player:setLastZ(-10)
    getWorld():update()
end

BWOANightmares.Hell.onCycle = function(player)
    local player = getSpecificPlayer(0)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask3.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if cycle % 16 == 0 then
        local params = {
            cid = Bandit.clanMap.FinneganGeneric,
            x = 18000 + ZombRand(20),
            y = 3800 + ZombRand(50),
            z = -2,
            program = "Bandit",
            hostile = true,
            size = 1,
        }
        sendClientCommand(player, 'Spawner', 'Clan', params)
    end

    gmd.nightmares.cycle = cycle + 1
end

BWOANightmares.Hell.ShouldExit = function(player)

    if player:getX() > 18008 and player:getX() < 18012 and player:getY() < 3801 then
        return true
    end

    if player:getZ() >= 0 then
        return true
    end

    return false
end

BWOANightmares.Hell.onExit = function(player)
    local gmd = GetBWOAModData()
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.Hell.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil

    BWOATex.speed = 0.005
end
