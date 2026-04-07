BWOANightmares = BWOANightmares or {}

BWOANightmares.Island = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.Island.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    BWOAEventControl.Add("FadeIn", {time = 8}, 1)

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    player:setX(1700)
    player:setY(12300)
    player:setZ(0)
    player:setLastX(1700)
    player:setLastY(12300)
    player:setLastZ(0)
    getWorld():update()
end

BWOANightmares.Island.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if cycle == 40 then
        local blueprint = BWOALakes.Island()
        BWOABuildTools.LavaLake(1720, 12300, blueprint)
    end
    if cycle == 25 then
        local params1 = {
            cid = Bandit.clanMap.Demon,
            x = 1720,
            y = 12300,
            z = 0,
            program = "Assault",
            size = 3,
        }
        sendClientCommand(player, 'Spawner', 'Clan', params1)
    end

    gmd.nightmares.cycle = cycle + 1
    print("Nightmare cycle: " .. gmd.nightmares.cycle)
end

BWOANightmares.Island.ShouldExit = function(player)
    if player:getY() > 12342 then
        return true
    end

    return false
end

BWOANightmares.Island.onExit = function(player)
    local gmd = GetBWOAModData()
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.Island.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = nil
    gmd.nightmares.cycle = 1
    BWOATex.speed = 0.005
end
