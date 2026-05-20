BWOANightmares = BWOANightmares or {}

BWOANightmares.Island = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.Island.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = math.floor(player:getX()),
        y = math.floor(player:getY()),
        z = math.floor(player:getZ())
    }

    BWOAEventControl.Add("FadeIn", {time = 8}, 1)

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    BWOAEventControl.Add("Teleport", {x=1700, y=12300, z=0}, 1)
end

BWOANightmares.Island.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    gmd.nightmares.cycle = cycle + 1
    -- print("Nightmare cycle: " .. gmd.nightmares.cycle)
end

BWOANightmares.Island.ShouldExit = function(player)
    local gmd = GetBWOAModData()
    if gmd.nightmares.cycle > 500 and player:getY() > 12342 then
        return true
    end

    return false
end

BWOANightmares.Island.onExit = function(player)
    local gmd = GetBWOAModData()
    local x, y, z = gmd.nightmares.returnData.x, gmd.nightmares.returnData.y, gmd.nightmares.returnData.z
    BWOAEventControl.Add("Teleport", {x=x, y=y, z=z}, 1)
end

BWOANightmares.Island.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = nil
    gmd.nightmares.cycle = 1
    BWOATex.speed = 0.005
end
