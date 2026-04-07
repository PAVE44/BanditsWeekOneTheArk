BWOANightmares = BWOANightmares or {}

BWOANightmares.Finnegan = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.Finnegan.onEnter = function(player)
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

    player:setX(18054)
    player:setY(4011)
    player:setZ(-6)
    player:setLastX(18054)
    player:setLastY(4011)
    player:setLastZ(-6)
    getWorld():update()
end

BWOANightmares.Finnegan.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    if cycle > 600 and cycle % 8 == 0 then
        BanditUtils.ClearZombies(18000, 18059, 4000, 4031)
    end

    BWOATex.tex = getTexture("media/textures/nightmare_mask3.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    gmd.nightmares.cycle = cycle + 1
end

BWOANightmares.Finnegan.ShouldExit = function(player)
    if player:getZ() > -0.5 then
        return true
    end

    return false
end

BWOANightmares.Finnegan.onExit = function(player)
    local gmd = GetBWOAModData()
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.Finnegan.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = nil
    gmd.nightmares.cycle = 1
    BWOATex.speed = 0.005
end
