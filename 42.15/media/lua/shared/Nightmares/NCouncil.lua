BWOANightmares = BWOANightmares or {}

BWOANightmares.Council = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.Council.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    local volume = getSoundManager():getSoundVolume()
    -- BWOAEventControl.Add("FadeOut", {time = 0}, 0)
    BWOAEventControl.Add("FadeIn", {time = 5, volume = volume}, 2700)
 
    BWOATex.tex = getTexture("media/textures/nightmare_mask3.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    player:setX(18005)
    player:setY(3018)
    player:setZ(-3)
    player:setLastX(18005)
    player:setLastY(3018)
    player:setLastZ(-3)
    getWorld():update()
end

BWOANightmares.Council.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask3.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if cycle > 600 and cycle % 8 == 0 then
        BanditUtils.ClearZombies(18000, 18012, 3000, 3020)
    end

    gmd.nightmares.cycle = cycle + 1
end

BWOANightmares.Council.ShouldExit = function(player)

    if player:getX() > 18008.5 and player:getY() > 3015 then
        return true
    end

    return false
end

BWOANightmares.Council.onExit = function(player)
    local gmd = GetBWOAModData()
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.Council.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil

    BWOATex.speed = 0.005
end
