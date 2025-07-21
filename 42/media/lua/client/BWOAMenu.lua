--
-- ********************************
-- *** Bandits W1 The Ark       ***
-- ********************************
-- *** Coded by: Slayer         ***
-- ********************************
--

BWOAMenu = BWOAMenu or {}

function BWOAMenu.Teleport(player)
    player:setX(9962)
    player:setY(12609)
    player:setZ(-4)
    player:setLastX(9962)
    player:setLastY(12609)
    player:setLastZ(-4)
end

function BWOAMenu.TestEmmiter(player)
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].Init()
        BWOARooms[room].SetEmitters()
    end
end

function BWOAMenu.TestPrepare(player)
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].Init()
        BWOARooms[room].Prepare()
    end
end

function BWOAMenu.TestFlickers(player)
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].Init()

        if BWOARooms[room].SetFlickers then
            BWOARooms[room].SetFlickers()
        end
    end
end

function BWOAMenu.ArkAlarm(player, state)
    if state then
        BWOABaseAPI.AlarmOn()
    else
        BWOABaseAPI.AlarmOff()
    end
end

function BWOAMenu.ArkPower(player, state)
    if state then
        BWOABaseAPI.PowerOn()
    else
        BWOABaseAPI.PowerOff()
    end
end

function BWOAMenu.MakeRoom(player, roomName)
    BWOARooms[roomName].Init()
    BWOARooms[roomName].Build()
    BWOARooms[roomName].Prepare()
    BWOARooms[roomName].SetEmitters()

end

function BWOAMenu.AddOverlay(player, square)

    local objects = square:getObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        local sprite = object:getSprite()
        if sprite:getName() == "industry_02_163" then
            local test1 = object:getOnOverlay()
            local overlaySprite = getSprite("ark_01_0")
            local test2 = overlaySprite:getName()
            local spriteInstance = IsoSpriteInstance.get(overlaySprite)
            object:setOnOverlay(spriteInstance) 
            local test3 = object:getOnOverlay()
        end
    end
end

function BWOAMenu.NoahUI(player)
    BWOANoah.Show()
end

local function onPreFillWorldObjectContextMenu(playerID, context, worldobjects, test)
    local player = getSpecificPlayer(playerID)
    local square = BanditCompatibility.GetClickedSquare()

    -- Debug options
    if isDebugEnabled() then

        context:addOption("Noah", player, BWOAMenu.NoahUI)
        context:addOption("Teleport", player, BWOAMenu.Teleport)
        context:addOption("Test Emitter", player, BWOAMenu.TestEmmiter)
        context:addOption("Test Flickers", player, BWOAMenu.TestFlickers)
        context:addOption("Test Prepare", player, BWOAMenu.TestPrepare)
        context:addOption("Add Overlay", player, BWOAMenu.AddOverlay, square)

        context:addOption("Ark Alarm On", player, BWOAMenu.ArkAlarm, true)
        context:addOption("Ark Alarm Off", player, BWOAMenu.ArkAlarm, false)

        context:addOption("Ark Power On", player, BWOAMenu.ArkPower, true)
        context:addOption("Ark Power Off", player, BWOAMenu.ArkPower, false)

        local roomOption = context:addOption("Spawn Room")
        local roomMenu = context:getNew(context)
        context:addSubMenu(roomOption, roomMenu)

        local roomNames = {"BathroomFemale", "BathroomMale", "BedroomMale", "Control", "Farm", "Infirmary", "Library", "Lab", "Incinerator", "Generator"}

        for i=1, #roomNames do
            local roomName = roomNames[i]
            roomMenu:addOption(roomName, player, BWOAMenu.MakeRoom, roomName)
        end
    end
end

Events.OnPreFillWorldObjectContextMenu.Remove(onPreFillWorldObjectContextMenu)
Events.OnPreFillWorldObjectContextMenu.Add(onPreFillWorldObjectContextMenu)

