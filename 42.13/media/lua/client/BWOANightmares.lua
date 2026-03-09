BWOANightmares = BWOANightmares or {}

BWOANightmares.active = false
BWOANightmares.state = "enter"
BWOANightmares.cycle = 1
BWOANightmares.cycleNumber = 1000
BWOANightmares.returnData = {}

BWOANightmares.Activate = function()
    BWOANightmares.active = true
end

local function onPlayerUpdate(player)
    if not player then return end

    if not BWOANightmares.active then return end

    local state = BWOANightmares.state
    if state == "enter" then
        local volume = getSoundManager():getSoundVolume()
        BWOAEventControl.Add("FadeIn", {time = 6, volume = volume}, 1)

        BWOANightmares.returnData = {x=player:getX(), y=player:getY(), z=player:getZ()}

        local test1 = BWOANightmares.returnData

        BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
        BWOATex.speed = 0.000001
        BWOATex.mode = "full"
        BWOATex.alpha = 1

        player:setbClimbing(false)
        player:setX(8000)
        player:setY(5000)
        player:setZ(20)
        player:setLastX(8000)
        player:setLastY(5000)
        player:setLastZ(20)

        BWOANightmares.state = "cycle"
        getWorld():update()
    end

    if state == "cycle" then
        if player:getZ() < 5 then
            player:setX(8000)
            player:setY(5000)
            player:setZ(30)
            player:setLastX(8000)
            player:setLastY(5000)
            player:setLastZ(30)
            local sound = player:getDescriptor():getVoicePrefix() .. "DeathFall"
            local emitter = player:getEmitter()
            if not emitter:isPlaying(sound) then
                emitter:playSound(sound)
            end
        end

        if BWOANightmares.cycle < BWOANightmares.cycleNumber - 10  then
            player:setbClimbing(false)
        else
            player:setbClimbing(true)
        end

         -- spawn some zombies for fun

        BWOANightmares.cycle = BWOANightmares.cycle + 1
        print("Nightmare cycle: " .. player:getZ().. " " .. BWOANightmares.cycle)
        if BWOANightmares.cycle > BWOANightmares.cycleNumber then
            BWOANightmares.state = "exit"
        end
    end

    if state == "exit" then
        local data = BWOANightmares.returnData

        player:setbClimbing(true)
        player:setX(data.x)
        player:setY(data.y)
        player:setZ(data.z)
        player:setLastX(data.x)
        player:setLastY(data.y)
        player:setLastZ(data.z)

        BWOANightmares.state = "post"
        getWorld():update()
    end

    if state == "post" then
        BWOATex.speed = 0.005

        player:clearVariable("BumpFallType")
        player:setBumpType("stagger")
        player:setBumpFall(true)
        player:setBumpFallType("pushedBehind")

        BWOANightmares.state = "enter"
        BWOANightmares.cycle = 1
        BWOANightmares.active = false
    end
end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)