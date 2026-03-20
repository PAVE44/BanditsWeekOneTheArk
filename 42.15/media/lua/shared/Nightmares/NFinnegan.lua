BWOANightmares = BWOANightmares or {}

BWOANightmares.Finnegan = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.Finnegan.onEnter = function(player)
    local volume = getSoundManager():getSoundVolume()
    BWOAEventControl.Add("FadeOut", {time = 0}, 0)
    BWOAEventControl.Add("FadeIn", {time = 5, volume = volume}, 2700)

    returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }
   
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

    cycle = cycle + 1

    if cycle > 600 and cycle % 8 == 0 then
        BanditUtils.ClearZombies(18000, 18059, 4000, 4031)
    end

end

BWOANightmares.Finnegan.ShouldExit = function(player)
    if player:getZ() > -1 then
        return true
    end

    return false
end

BWOANightmares.Finnegan.onExit = function(player)
    player:setX(returnData.x)
    player:setY(returnData.y)
    player:setZ(returnData.z)
    player:setLastX(returnData.x)
    player:setLastY(returnData.y)
    player:setLastZ(returnData.z)

    getWorld():update()
end

BWOANightmares.Finnegan.onPost = function(player)
    BWOATex.speed = 0.005

    cycle = 1
end
