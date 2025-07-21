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

BWOAEvents.PlayerSetup = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            local gown = BanditCompatibility.InstanceItem("Base.HospitalGown")
            local gownLocation = gown:getBodyLocation()
            local inv = player:getInventory()
            local wornItems = player:getWornItems()
            inv:clear()
            wornItems:clear()
            inv:AddItem(gown)
            wornItems:setItem(gownLocation, gown)
            player:setWornItems(wornItems)

            local humanVisual = player:getHumanVisual()
            humanVisual:setHairModel("Bald")
            if not player:isFemale() then
                humanVisual:setBeardModel("None")
            end

            local bodyDamage = player:getBodyDamage()
            local head = bodyDamage:getBodyPart(BodyPartType.Head)
            head:setAdditionalPain(90)
            head:setBandaged(true, 1)
            player:resetModel()
        end
    end
end

BWOAEvents.ElecShut = function(params)
    getSandboxOptions():set("ElecShut", 1)
    getSandboxOptions():set("ElecShutModifier", 0)
    if getWorld():isHydroPowerOn() then
        getWorld():setHydroPowerOn(false)
    end
end

-- proxy
BWOAEvents.EmergencyLights = function(params)
    if params.roomName and params.active ~= nil then
        BWOABaseAPI.EmergencyLights(params.roomName, params.active)
    end
end

BWOAEvents.BuildRoom = function(params)
    if params.roomName then
        BWOARooms[params.roomName].Build()
    end
end

BWOAEvents.PrepareRoom = function(params)
    if params.roomName then
        BWOARooms[params.roomName].Prepare()
        if BWOARooms[params.roomName].SetEmitters then
            BWOARooms[params.roomName].SetEmitters()
        end
        if BWOARooms[params.roomName].SetFlickers then
            BWOARooms[params.roomName].SetFlickers()
        end
    end
end

BWOAEvents.SetRoomEmitters = function(params)
    if params.roomName then
        BWOARooms[params.roomName].SetEmitters()
    end
end

BWOAEvents.SetRoomFlickers = function(params)
    if params.roomName then
        BWOARooms[params.roomName].SetFlickers()
    end
end