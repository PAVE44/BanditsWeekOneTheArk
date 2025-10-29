--
-- ********************************
-- *** Bandits W1 The Ark       ***
-- ********************************
-- *** Coded by: Slayer         ***
-- ********************************
--

BWOAMenu = BWOAMenu or {}

BWOAMenu.specialObjectsHighlight = {
    ["Noah"] = {
        x = 9961, y = 12621, z = -4, spriteName = "theark_01_4", option = "Use Noah"
    }
}

function BWOAMenu.EventCracks(player)
    BWOASequence.Earthquake({intensity = 30, duration=20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4})
end

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

function BWOAMenu.NoahUI(player, square)
    if luautils.walkAdj(player, square) then
        BWOANoah.Show()
    end    
end

local function onPreFillWorldObjectContextMenu(playerID, context, worldobjects, test)
    local player = getSpecificPlayer(playerID)
    local square = BanditCompatibility.GetClickedSquare()
    local sx, sy, sz = square:getX(), square:getY(), square:getZ()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    -- print ("FREE: " .. tostring(square:isFree(false)))
    -- Debug options

    local specialObjectsHighlight = BWOAMenu.specialObjectsHighlight
    for sname, sobject in pairs(specialObjectsHighlight) do
        if sobject.x == sx and sobject.y == sy and sobject.z == sz then
            context:addOption(sobject.option, player, BWOAMenu.NoahUI, square)
        end
    end 

    

    if isDebugEnabled() then
        
        context:addOption("Teleport", player, BWOAMenu.Teleport)
        context:addOption("Spawn", player, BWOAMenu.Spawn, square)
        context:addOption("Print Media", player, BWOAMenu.PrintMedia, square)

        context:addOption("Event Cracks", player, BWOAMenu.EventCracks)

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

local function onFillInventoryObjectContextMenu(playerNum, context, items)
    print ("test")
end

local onPlayerUpdate = function(player)
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local cell = getCell()
    local specialObjectsHighlight = BWOAMenu.specialObjectsHighlight
    for sname, sobject in pairs(specialObjectsHighlight) do
        local square = cell:getGridSquare(sobject.x, sobject.y, sobject.z)
        if square then
            if BanditUtils.DistToManhattan(px, py, sobject.x, sobject.y) < 3 then
                local objects = square:getObjects()
                for i=objects:size()-1, 0, -1 do
                    local object = objects:get(i)
                    local sprite = object:getSprite()
                    if sprite then
                        spriteName = sprite:getName()
                        if spriteName == sobject.spriteName then
                            object:setHighlighted(0, true)
                            object:setHighlightColor(1, 0.5, 0, 1)
                            object:setBlink(true)
                        end
                    end
                end
            end
        end
    end
end

Events.OnPreFillWorldObjectContextMenu.Remove(onPreFillWorldObjectContextMenu)
Events.OnPreFillWorldObjectContextMenu.Add(onPreFillWorldObjectContextMenu)

Events.OnFillInventoryObjectContextMenu.Remove(onFillInventoryObjectContextMenu)
Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)