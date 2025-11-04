--
-- ********************************
-- *** Bandits W1 The Ark       ***
-- ********************************
-- *** Coded by: Slayer         ***
-- ********************************
--

local TAFixIntake = require("Actions/TAFixIntake")

BWOAMenu = BWOAMenu or {}

BWOAMenu.blinking = {}

BWOAMenu.specialObjectsCanHighlight = {}

BWOAMenu.specialObjectsCanHighlight.Noah = function()
    return true
end

BWOAMenu.specialObjectsCanHighlight.Vent = function()
    -- return true
    return BWOAMissions.IsActive(3)
end

BWOAMenu.specialObjectsCanHighlight.Hatch = function()
    return true
end

BWOAMenu.specialObjectsAction = {}

BWOAMenu.specialObjectsAction.Noah = function(player, square)
    if luautils.walkAdj(player, square) then
        BWOANoah.Show()
    end    
end

BWOAMenu.specialObjectsAction.Vent = function(player, square)
    if luautils.walkAdj(player, square) then
        ISTimedActionQueue.add(TAFixIntake:new(player, square))
    end    
end

BWOAMenu.specialObjectsAction.Hatch = function(player, square)
    if luautils.walkAdj(player, square) then
        ISTimedActionQueue.add(TAOpenHatch:new(player, square))
    end    
end

BWOAMenu.specialObjectsHighlight = {
    ["Noah"] = {
        x = 9961, y = 12621, z = -4, spriteName = "theark_01_4", option = "Use Noah",
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Noah,
        actionFunc = BWOAMenu.specialObjectsAction.Noah,

    },
    ["Vent"] = {
        x = 9940, y = 12633, z = 0, spriteName = "theark_01_5", option = "Fix Vent", 
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Vent,
        actionFunc = BWOAMenu.specialObjectsAction.Vent
    }
}

function BWOAMenu.EventCracks(player)
    BWOASequence.Earthquake({intensity = 30, duration=20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4})
end

function BWOAMenu.MakeBasement(player, square)

    local basement = BWOABasements.Generic:new(square:getX(), square:getY())
    basement:build()

end

function BWOAMenu.Teleport(player)
    player:setX(9962)
    player:setY(12609)
    player:setZ(-4)
    player:setLastX(9962)
    player:setLastY(12609)
    player:setLastZ(-4)
end

function BWOAMenu.LoadHatches(player)
    BWOABuildings.LoadHatches()
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

local saveItems = function(square)

    local sx = square:getX()
    local sy = square:getY()
    local sz = square:getZ()
    
    local lines = {}

    local wobs = square:getWorldObjects()
    for i = 0, wobs:size()-1 do
        local o = wobs:get(i)
        local item = o:getItem()
        local itemType = item:getFullType()

        local x = o:getOffX()
        local y = o:getOffY()
        local z = o:getOffZ()
        local rx = item:getWorldXRotation()
        local ry = item:getWorldYRotation()
        local rz = item:getWorldZRotation()

        local line = ""
        line = line .. "BWOAPrepareTools.AddWorldItem(" .. tostring(sx) .. ", " .. tostring(sy) .. ", " .. tostring(sz) .. ", "
        line = line .. "\"" .. itemType .. "\", "
        line = line .. "{x=" .. string.format("%.2f", x) .. ", y=" .. string.format("%.2f", y) .. ", z=" .. string.format("%.2f", z) .. ", rx=" .. tostring(rx) ..", ry=" .. tostring(ry) .. ", rz=" .. tostring(rz) .. "})\n"
        table.insert(lines, line)
    end

    local fileWriter = getFileWriter("items-" .. sx .. "-" .. sy .. ".txt", true, true)
    table.insert(lines, "\n")

    local output = ""
    for k, v in pairs(lines) do
        output = output .. v
    end
    print (output)
    fileWriter:write(output)
    fileWriter:close()
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
            if sobject.highLightFunc() then
                context:addOption(sobject.option, player, sobject.actionFunc, square)
            end
        end
    end 

    if isDebugEnabled() then

        -- saveItems(square)        
        context:addOption("Teleport", player, BWOAMenu.Teleport)
        context:addOption("Spawn", player, BWOAMenu.Spawn, square)
        context:addOption("Make Basement", player, BWOAMenu.MakeBasement, square)
        context:addOption("Load Hatches", player, BWOAMenu.LoadHatches, square)
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

local updateHighlight = function()
    BWOAMenu.blinking = {}

    local cell = getCell()
    local playerList = BanditPlayer.GetPlayers()

    local specialObjectsHighlight = BWOAMenu.specialObjectsHighlight
    for sname, sobject in pairs(specialObjectsHighlight) do
        for i=0, playerList:size()-1 do
            local player = playerList:get(i)
            if player then
                local px, py, pz = player:getX(), player:getY(), player:getZ()
                if math.abs(px - sobject.x) < 6 and math.abs(py - sobject.y) < 6 then 
                    local square = cell:getGridSquare(sobject.x, sobject.y, sobject.z)
                    if square then
                        local objects = square:getObjects()
                        for i=objects:size()-1, 0, -1 do
                            local object = objects:get(i)
                            local sprite = object:getSprite()
                            if sprite then
                                spriteName = sprite:getName()
                                if spriteName == sobject.spriteName then
                                    if sobject.highLightFunc() then
                                        table.insert(BWOAMenu.blinking, object)
                                    end
                                    if sobject.highLightFunc() then
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
        end
    end
end

local blink = function(player)
    local blinking = BWOAMenu.blinking

    for _, object in ipairs(blinking) do
        object:setHighlighted(0, true)
        object:setHighlightColor(1, 0.5, 0, 1)
        object:setBlink(true)
    end
end

Events.OnPreFillWorldObjectContextMenu.Remove(onPreFillWorldObjectContextMenu)
Events.OnPreFillWorldObjectContextMenu.Add(onPreFillWorldObjectContextMenu)

Events.OnFillInventoryObjectContextMenu.Remove(onFillInventoryObjectContextMenu)
Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)

Events.EveryOneMinute.Remove(updateHighlight)
Events.EveryOneMinute.Add(updateHighlight)

Events.OnPlayerUpdate.Remove(blink)
Events.OnPlayerUpdate.Add(blink)