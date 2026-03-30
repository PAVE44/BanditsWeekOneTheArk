BWOANightmares = BWOANightmares or {}

BWOANightmares.FamilyHouse = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.FamilyHouse.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    local volume = getSoundManager():getSoundVolume()
    BWOAEventControl.Add("FadeIn", {time = 5, volume = volume}, 1)
 
    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    player:setX(18012)
    player:setY(3414)
    player:setZ(-5)
    player:setLastX(18012)
    player:setLastY(3414)
    player:setLastZ(-5)
    getWorld():update()
end

BWOANightmares.FamilyHouse.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if cycle > 600 and cycle % 8 == 0 then
        BanditUtils.ClearZombies(18000, 18060, 3200, 3260)
    end

    gmd.nightmares.cycle = cycle + 1
end

BWOANightmares.FamilyHouse.ShouldExit = function(player)

    if player:getX() < 18002 and player:getY() < 3403 then
        return true
    end

    if player:getZ() >= 0 then
        return true
    end

    return false
end

BWOANightmares.FamilyHouse.onExit = function(player)
    local gmd = GetBWOAModData()
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.FamilyHouse.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil

    BWOATex.speed = 0.005
end
