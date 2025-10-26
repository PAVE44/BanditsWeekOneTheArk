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

-- params: id, txt, anim
BWOAEvents.SayBandit = function(params)
    local player = getSpecificPlayer(0)
    local speaker = BanditZombie.GetInstanceById(params.id)
    if speaker then
        Bandit.ClearTasks(speaker)
        local task = {action="Talk", anim=params.anim, txt=params.txt, x=player:getX(), y=player:getY(), time=2000}
        Bandit.AddTask(speaker, task)
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
        if BWOARooms[params.roomName].SetAnims then
            BWOARooms[params.roomName].SetAnims()
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

BWOAEvents.SetRoomAnims = function(params)
    if params.roomName then
        BWOARooms[params.roomName].SetAnims()
    end
end

BWOAEvents.ClearBaseFromZombies = function(params)
    local zombieList = BanditZombie.CacheLightZ
    for id, z in pairs(zombieList) do
        if z.z < 0 then
            local zombie = BanditZombie.GetInstanceById(z.id)
            -- local id = BanditUtils.GetCharacterID(zombie)
            if zombie and zombie:isAlive() then
                -- fixme: zombie:canBeDeletedUnnoticed(float)
                zombie:removeFromSquare()
                zombie:removeFromWorld()
            end
        end
    end

    local cell = getCell()
    local zombieList = cell:getZombieList()
    local zombieListSize = zombieList:size()
    for i = 0, zombieListSize - 1 do
        local zombie = zombieList:get(i)
        if zombie and zombie:isAlive() then
            -- fixme: zombie:canBeDeletedUnnoticed(float)
            zombie:removeFromSquare()
            zombie:removeFromWorld()
        end
    end
end

BWOAEvents.PlayPlayer = function(params)
    BWOASound.PlayPlayer(params)
end

BWOAEvents.AlarmOn = function(params)
    BWOABaseAPI.AlarmOn()
end

BWOAEvents.WallCrack = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local world = getWorld()
    local cell = getCell()
    local volume = getSoundManager():getSoundVolume()

    local x1 = params.x - 8
    local x2 = params.x + 8
    local y1 = params.y - 8
    local y2 = params.y + 8
    local z = params.z

    local candidates = {}
    for x = x1, x2 do
        for y = y1, y2 do
            local square = cell:getGridSquare(x, y, z)
            if square then
                local wall = square:getWall(true) or square:getWall(false)

                if wall then
                    local sprite = wall:getSprite()
                    if  sprite then 
    
                        local spriteProps = sprite:getProperties()
                        if not spriteProps:Is(IsoFlagType.WallNTrans) and not spriteProps:Is(IsoFlagType.WallWTrans)
                           and not spriteProps:Is(IsoFlagType.WindowN) and not spriteProps:Is(IsoFlagType.WindowW) 
                           and not spriteProps:Is(IsoFlagType.DoorWallN) and not spriteProps:Is(IsoFlagType.DoorWallW)
                           and not spriteProps:Is(IsoFlagType.WallSE) then 

                            table.insert(candidates, wall)
                        end
                    end
                end
            end
        end
    end

    if #candidates > 0 then
        local wall = candidates[1 + ZombRand(#candidates)]

        if wall then
            local x, y, z = wall:getX(), wall:getY(), wall:getZ()
            local spriteName = "d_wallcracks_1_" .. tostring(1 + ZombRand(70))
            local list = ArrayList.new()
            local attachments = wall:getAttachedAnimSprite()
            if not attachments or attachments:size() == 0 then
                wall:setAttachedAnimSprite(ArrayList.new())
            end
            wall:getAttachedAnimSprite():add(getSprite(spriteName):newInstance())
            BWOASound.PlayLocation({x = x, y = y, z = z, sound="AmbientWallcrack"})

            local lightSwitch = BanditUtils.GetLightSwitch(x, y, z)
            if lightSwitch and lightSwitch:hasLightBulb() then
                lightSwitch:setActive(false, false, true)
                lightSwitch:removeLightBulb(cell:getFakeZombieForHit())
                local emitter = world:getFreeEmitter(x, y, z)
                if emitter then
                    local id = emitter:playSound("LightFlicker")
                    emitter:setVolume(id, volume)
                end
            end
        end
    end
end

BWOAEvents.SpawnGroup = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local args = params

    sendClientCommand(player, 'Spawner', 'Clan', args)
end

