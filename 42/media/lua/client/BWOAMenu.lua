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

function BWOAMenu.PrintMedia(player)
    local ui = UIPrintMedia:new("book_dacr_research", getSpecificPlayer(0))
    ui:initialise()
    ui:addToUIManager()
end

function BWOAMenu.Spawn(player, square)
    local args = {}
    args.cid = "0b0c0c24-a9f7-4b04-a3e2-72f33b3d82ce"
    args.x = square:getX()
    args.y = square:getY()
    args.z = square:getZ()
    args.program = "Emma"
    args.size = 1
    -- args.permanent = true
    sendClientCommand(player, 'Spawner', 'Clan', args)
end

function BWOAMenu.ArkAlarm(player, state)
    if state then
        BWOABaseAPI.AlarmOn()
    else
        BWOABaseAPI.AlarmOff()
        BWOARooms.MainStorage.Prepare()
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

function BWOAMenu.NoahUI(player)
    BWOANoah.Show()
end

local function onPreFillWorldObjectContextMenu(playerID, context, worldobjects, test)
    local player = getSpecificPlayer(playerID)
    local square = BanditCompatibility.GetClickedSquare()
    -- print ("FREE: " .. tostring(square:isFree(false)))
    -- Debug options
    if isDebugEnabled() then

        context:addOption("Noah", player, BWOAMenu.NoahUI)
        context:addOption("Teleport", player, BWOAMenu.Teleport)
        context:addOption("Spawn", player, BWOAMenu.Spawn, square)
        context:addOption("Print Media", player, BWOAMenu.PrintMedia, square)

        context:addOption("Ark Alarm On", player, BWOAMenu.ArkAlarm, true)
        context:addOption("Ark Alarm Off", player, BWOAMenu.ArkAlarm, false)

        local roomOption = context:addOption("Spawn Room")
        local roomMenu = context:getNew(context)
        context:addSubMenu(roomOption, roomMenu)

        local roomNames = {"AirIntake", "BathroomFemale", "BathroomMale", "BedroomMale", "Control", "Corridor", "Chapel", "Hydroponics", "Infirmary", "InterrogationRoom", "Library", "Lab", "Incinerator", "Generator", "MainStorage", "Messhall"}

        for i=1, #roomNames do
            local roomName = roomNames[i]
            roomMenu:addOption(roomName, player, BWOAMenu.MakeRoom, roomName)
        end
    end
end

Events.OnPreFillWorldObjectContextMenu.Remove(onPreFillWorldObjectContextMenu)
Events.OnPreFillWorldObjectContextMenu.Add(onPreFillWorldObjectContextMenu)

local function onFillInventoryObjectContextMenu(playerNum, context, items)
    print ("test")
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)