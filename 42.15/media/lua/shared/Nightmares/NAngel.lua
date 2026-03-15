BWOANightmares = BWOANightmares or {}

BWOANightmares.Angel = {}

local cycle = 1
local cycleNumber = 1000
local returnData = {}

BWOANightmares.Angel.onEnter = function(player)
    local volume = getSoundManager():getSoundVolume()
    BWOAEventControl.Add("FadeIn", {time = 6, volume = volume}, 1)

    returnData = {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }

    BWOAClimate.Disable()
    getWorld():getClimateManager():stopWeatherAndThunder()

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    player:setX(3238)
    player:setY(5710)
    player:setZ(0)
    player:setLastX(3238)
    player:setLastY(5710)
    player:setLastZ(0)

    getWorld():update()
end

BWOANightmares.Angel.onCycle = function(player)
    print("Nightmare cycle: " .. player:getZ().. " " .. cycle)

    local angelCoors = {
        x = 3236,
        y = 5710,
        z = 0
    }
    
    if cycle == 1 then
        local ls = IsoLightSource.new(angelCoors.x, angelCoors.y, angelCoors.z, 1, 1, 1, 12, 7000)
        getCell():addLamppost(ls)
    elseif cycle == 2 then
        local params1 = {
            cid = Bandit.clanMap.Angel,
            x = angelCoors.x,
            y = angelCoors.y,
            z = angelCoors.z,
            program = "Angel",
            size = 1,
        }
        sendClientCommand(player, 'Spawner', 'Clan', params1)
    end

    cycle = cycle + 1
    
end

BWOANightmares.Angel.ShouldExit = function(player)
    if cycle > cycleNumber then
        return true
    end
    return false
end

BWOANightmares.Angel.onExit = function(player)
    player:setX(returnData.x)
    player:setY(returnData.y)
    player:setZ(returnData.z)
    player:setLastX(returnData.x)
    player:setLastY(returnData.y)
    player:setLastZ(returnData.z)

    getWorld():update()
end

BWOANightmares.Angel.onPost = function(player)
    BWOATex.speed = 0.005

    cycle = 1
end
