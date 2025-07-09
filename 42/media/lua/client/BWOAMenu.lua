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

function BWOAMenu.TestEmmiter(player, square)
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].SetEmitters()
    end
end

function BWOAMenu.Farm(player)
    BWOARooms.Greenhouse.Init()
    BWOARooms.Greenhouse.Build()
end

function BWOAMenu.Library(player)
    BWOARooms.Library.Init()
    BWOARooms.Library.Build()
end

function BWOAMenu.WorldContextMenuPre(playerID, context, worldobjects, test)
    local player = getSpecificPlayer(playerID)
    local square = BanditCompatibility.GetClickedSquare()

    -- Debug options
    if isDebugEnabled() then

        context:addOption("Teleport", player, BWOAMenu.Teleport)
        context:addOption("Test Emitter", player, BWOAMenu.TestEmmiter, square)

        local objectOption = context:addOption("Spawn Object")
        local objectMenu = context:getNew(context)
        context:addSubMenu(objectOption, objectMenu)

        local objects = {"Farm", "Library"}

        for i=1, #objects do
            local objectName = objects[i]
            objectMenu:addOption(objectName, player, BWOAMenu[objectName], square, objectName)
        end
    end
end

Events.OnPreFillWorldObjectContextMenu.Add(BWOAMenu.WorldContextMenuPre)

