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

    player:setX(18051)
    player:setY(3254)
    player:setZ(-3)
    player:setLastX(18051)
    player:setLastY(3254)
    player:setLastZ(-3)
    getWorld():update()
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
    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
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
