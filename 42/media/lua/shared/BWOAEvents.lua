BWOAEvents = BWOAEvents or {}

BWOAEvents.FadeOut = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            local playerNum = player:getPlayerNum()
            player:setBlockMovement(true)
            player:setBannedAttacking(true)
            UIManager.setFadeBeforeUI(playerNum, false)
            UIManager.FadeOut(playerNum, params.time)
        end
    end
end

BWOAEvents.FadeIn = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            local playerNum = player:getPlayerNum()
            player:setBlockMovement(false)
            player:setBannedAttacking(false)
            UIManager.FadeIn(playerNum, params.time)
            UIManager.setFadeBeforeUI(playerNum, false)
        end
    end
end

BWOAEvents.Teleport = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            player:setX(params.x + i)
            player:setY(params.y + i)
            player:setZ(params.z)
            player:setLastX(params.x + i)
            player:setLastY(params.y + i)
            player:setLastZ(params.z)
        end
    end
    getWorld():update()
end

-- base api proxy
BWOAEvents.EmergencyLights = function(params)
    if params.roomName and params.active then
        BWOABaseAPI.EmergencyLights(params.roomName, params.active)
    end
end
