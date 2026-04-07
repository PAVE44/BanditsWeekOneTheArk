BWOANightmares = BWOANightmares or {}

BWOANightmares.MirrorRoom = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.MirrorRoom.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    BWOAEventControl.Add("FadeIn", {time = 5}, 1)
 
    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    player:setX(18005.5)
    player:setY(3603.5)
    player:setZ(-3)
    player:setLastX(18005.5)
    player:setLastY(3603.5)
    player:setLastZ(-3)
    getWorld():update()
end

BWOANightmares.MirrorRoom.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if cycle > 600 and cycle % 8 == 0 then
        BanditUtils.ClearZombies(18000, 18010, 3600, 3610)
    end

    if not gmd.nightmares.flag then
        local px, py = player:getX(), player:getY()
        if px >= 18002 and px <= 18004 and py >= 3601 and py <= 3603 then
            gmd.nightmares.flag = true
            BWOASound.PlayPlayer({sound = "SpookyLaugh"})
        end
    end

    gmd.nightmares.cycle = cycle + 1
end

BWOANightmares.MirrorRoom.ShouldExit = function(player)

    if player:getX() >= 18003 and player:getY() >= 3605 then
        return true
    end

    if player:getZ() >= 0 then
        return true
    end

    return false
end

BWOANightmares.MirrorRoom.onExit = function(player)
    local gmd = GetBWOAModData()
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.MirrorRoom.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil
    gmd.nightmares.flag = nil

    BWOATex.speed = 0.005
end
