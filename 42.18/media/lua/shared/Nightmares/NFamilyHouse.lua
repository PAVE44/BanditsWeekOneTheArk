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

    BWOAEventControl.Add("FadeIn", {time = 5}, 1)
 
    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    BWOAEventControl.Add("Teleport", {x=18012, y=3414, z=-5}, 1)
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
    local x, y, z = gmd.nightmares.returnData.x, gmd.nightmares.returnData.y, gmd.nightmares.returnData.z
    BWOAEventControl.Add("Teleport", {x=x, y=y, z=z}, 1)
    -- getWorld():update()
end

BWOANightmares.FamilyHouse.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil

    BWOATex.speed = 0.005
end
