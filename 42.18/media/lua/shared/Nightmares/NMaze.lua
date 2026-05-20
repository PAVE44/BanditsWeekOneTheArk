BWOANightmares = BWOANightmares or {}

BWOANightmares.Maze = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

BWOANightmares.Maze.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    BWOAEventControl.Add("FadeOut", {time = 0}, 0)
    BWOAEventControl.Add("FadeIn", {time = 5}, 2700)
 
    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    BWOAEventControl.Add("Teleport", {x=18051, y=3254, z=-3}, 1)
end

BWOANightmares.Maze.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    if cycle > 600 and cycle % 8 == 0 then
        BanditUtils.ClearZombies(18000, 18060, 3200, 3260)
    end

    if cycle == 1700 then
        for i = 1, 2 + ZombRand(3) do
            local params1 = {
                cid = Bandit.clanMap.Fallen,
                x = 18003 + ZombRand(30),
                y = 3212 + ZombRand(20),
                z = -3,
                program = "Bandit",
                size = 1,
            }
            sendClientCommand(player, 'Spawner', 'Clan', params1)
        end
    end

    if not gmd.nightmares.flag then
        if player:getY() < 3207 and player:getX() > 18004 and player:getX() < 18011 then
            gmd.nightmares.flag = true
            BWOAMusic.Play("MusicMaze", 1, 1)
        end
    end

    if not gmd.nightmares.flagKate then
        if math.floor(player:getX()) == 18005 and math.floor(player:getY()) == 3203 then
            gmd.nightmares.flagKate = true
            BWOAEventControl.Add("SayPlayer", {txt = getText("IGUI_SayPlayer_Kate")}, 100)
        end
    end

    if not gmd.nightmares.flagSuzie then
        if math.floor(player:getX()) == 18007 and math.floor(player:getY()) == 3203 then
            gmd.nightmares.flagSuzie = true
            BWOAEventControl.Add("SayPlayer", {txt = getText("IGUI_SayPlayer_Suzie")}, 100)
        end
    end

    if not gmd.nightmares.flagRJ then
        if math.floor(player:getX()) == 18009 and math.floor(player:getY()) == 3203 then
            gmd.nightmares.flagRJ = true
            BWOAEventControl.Add("SayPlayer", {txt = getText("IGUI_SayPlayer_RJ")}, 100)
        end
    end


    gmd.nightmares.cycle = cycle + 1
end

BWOANightmares.Maze.ShouldExit = function(player)

    if player:getX() < 18002.5 and player:getY() < 3203 then
        return true
    end

    if player:getZ() >= 0 then
        return true
    end

    return false
end

BWOANightmares.Maze.onExit = function(player)
    local gmd = GetBWOAModData()
    local x, y, z = gmd.nightmares.returnData.x, gmd.nightmares.returnData.y, gmd.nightmares.returnData.z
    BWOAEventControl.Add("Teleport", {x=x, y=y, z=z}, 1)
end

BWOANightmares.Maze.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil
    gmd.nightmares.flag = nil
    gmd.nightmares.flagKate = nil
    gmd.nightmares.flagSuzie = nil
    gmd.nightmares.flagRJ = nil

    BWOATex.speed = 0.005
end
