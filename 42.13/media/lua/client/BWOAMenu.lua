--
-- ********************************
-- *** Bandits W1 The Ark       ***
-- ********************************
-- *** Coded by: Slayer         ***
-- ********************************
--

local TAFixIntake = require("Actions/TAFixIntake")

BWOAMenu = BWOAMenu or {}

BWOAMenu.version = "0.59"

BWOAMenu.blinking = {}

BWOAMenu.specialObjectsCanHighlight = {}

BWOAMenu.specialObjectsCanHighlight.Noah = function(player)
    return true
end

BWOAMenu.specialObjectsCanHighlight.Vent = function(player)
    return BWOAMissions.IsActive(3)
end

BWOAMenu.specialObjectsCanHighlight.FuelIntake = function(player)
    local cell = getCell()
    local sqs = {
        {x = 9925, y = 12616, z = 0},
        {x = 9926, y = 12616, z = 0},
        {x = 9927, y = 12616, z = 0},
        {x = 9928, y = 12616, z = 0},
        {x = 9925, y = 12615, z = 0},
        {x = 9926, y = 12615, z = 0},
        {x = 9927, y = 12615, z = 0},
        {x = 9928, y = 12616, z = 0},
    }

    for _, sq in pairs(sqs) do
        local square = cell:getGridSquare(sq.x, sq.y, sq.z)
        if square then
            local vehicle = square:getVehicleContainer()
            if vehicle then
                local md = vehicle:getModData()
                if md.BWOA and md.BWOA.fuel then
                    local fuel = md.BWOA.fuel
                    if fuel > 0 then
                        return true
                    end
                end
            end
        end
    end

    return false
end

BWOAMenu.specialObjectsCanHighlight.Wall = function()
    return true
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

BWOAMenu.specialObjectsAction.FuelIntake = function(player, square)
    if luautils.walkAdj(player, square) then
        ISTimedActionQueue.add(TAFuelIntake:new(player, square))
    end    
end

BWOAMenu.specialObjectsAction.Wall = function(player, square)
    if luautils.walkAdj(player, square) then
        local wall = square:getWall()
        if wall then
            ISTimedActionQueue.add(ISDestroyStuffAction:new(player, wall, false))
        end
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
    },
    ["Fuel1"] = {
        x = 9927, y = 12617, z = 0, spriteName = "theark_01_7", option = "Drain Fuel", 
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.FuelIntake,
        actionFunc = BWOAMenu.specialObjectsAction.FuelIntake
    },
    ["Wall"] = {
        x = 447, y = 9940, z = -1, spriteName = "walls_exterior_house_02_1", option = "Destroy", 
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Wall,
        actionFunc = BWOAMenu.specialObjectsAction.Wall,
        destroyable = true,
    },
}

function BWOAMenu.EventChapter(player)
    BWOASequence.Chapter({tex = "chapter_1"})
end

function BWOAMenu.EventCracks(player)
    BWOASequence.Earthquake({intensity = 30, duration=20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4})
end

function BWOAMenu.EventHorde(player)
    BWOASequence.Horde({intensity = 30})
end

function BWOAMenu.EventAssault(player)
    BWOASequence.Assault({intensity = 6})
end

function BWOAMenu.EventAbyss(player, square)
    local cell = getCell()
    local xmin = square:getX() - 5
    local xmax = square:getX() + 5
    local ymin = square:getY() - 5
    local ymax = square:getY() + 5
    local depth = 16

    for x=xmin, xmax do
        for y=ymin, ymax do
            --if x ~= xmax and y ~= ymax then
                local square = cell:getGridSquare(x, y, 0)
                if square then
                    local objects = square:getObjects()
                    for i=objects:size()-1, 0, -1 do
                        local object = objects:get(i)
                        square:transmitRemoveItemFromSquare(object)
                    end
                    square:setSquareChanged()
                end

                BWOABuildTools.Floor (x, y, -depth, "floors_exterior_street_01_0")
                BWOABuildTools.Generic (x, y, -depth, "boulders_" .. (1 + ZombRand(14)))
            --end

            if x == xmin then
                for z = -depth, -1 do
                    BWOABuildTools.Wall (x, y, z, "walls_logs_96")
                end
            end
            if x == xmax then
                for z = -depth, -1 do
                    BWOABuildTools.Wall (x, y, z, "theark_01_8")
                end
            end
            if y == ymin then
                for z = -depth, -1 do
                    BWOABuildTools.Wall (x, y, z, "walls_logs_97")
                end
            end
            if y == ymax then
                for z = -depth, -1 do
                    BWOABuildTools.Wall (x, y, z, "theark_01_9")
                end
            end
        end
    end

                -- NW: walls_logs_98
                -- N: walls_logs_97
                -- W: walls_logs_96

                -- floors_exterior_street_01_0

                -- boulders: boulders_3
                -- boulders: boulders_7
                -- boulders: boulders_8
                -- boulders: boulders_9
                -- boulders: boulders_14
                -- boulders: boulders_11

                -- boulders: boulders_33, boulders_32 (y+1)


end

function BWOAMenu.SceneToolbag(player , square)
    local x = 10033
    local y = 12733
    local z = 0
    local scene = BWOAScenes.Toolbag:new(x, y, z)
    scene:build()
end

function BWOAMenu.SceneCinema(player , square)
    local x = 10185
    local y = 12635
    local z = 0
    local scene = BWOAScenes.Cinema:new(x, y, z)
    scene:build()
end



function BWOAMenu.SceneFuelTank(player , square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local scene = BWOAScenes.FuelTruck:new(x, y, z)
    scene:build()
end

function BWOAMenu.SceneDave(player , square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local scene = BWOAScenes.Dave:new(x, y, z)
    scene:build()
end

function BWOAMenu.SceneBanditsCar(player , square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local scene = BWOAScenes.BanditsCar:new(x, y, z)
    scene:build()
end

function BWOAMenu.SceneFallasChurch(player , square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local scene = BWOAScenes.FallasChurch:new(x, y, z)
    scene:build()
end

function BWOAMenu.SceneEkronChurch(player , square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local scene = BWOAScenes.EkronChurch:new(x, y, z)
    scene:build()
end

function BWOAMenu.SceneExcavation(player , square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local scene = BWOAScenes.Excavation:new(x, y, z)
    scene:build()
end

function BWOAMenu.EmmaCry(player)
    local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma"})
    BWOAChat.ChangeBrainParam({param="sadness", value=100, target = target})
end

function BWOAMenu.MakeBasement(player, square)

    local basement = BWOABasements.Generic:new(square:getX(), square:getY(), square:getRoom(), "family")
    basement:build()

end

function BWOAMenu.LavaLake(player, square)

    local effect = {}
    effect.x = square:getX()
    effect.y = square:getY()
    effect.z = 0
    effect.size = 1312
    effect.name = "lava"
    effect.frameCnt = 1
    effect.frameRnd = false
    effect.repCnt = 80
    effect.alpha = 1
    effect.colors = {r=1.0, g=0.0, b=0.0, a=1}
    BWOAEventControl.Add("Effect", effect, 1)
end

function BWOAMenu.Teleport(player)
    --local x, y, z = 9962, 12609, -4
    local x, y, z = 9961, 12622, -4
    
    player:setX(x)
    player:setY(y)
    player:setZ(z)
    player:setLastX(x)
    player:setLastY(y)
    player:setLastZ(z)
end

function BWOAMenu.LoadHatches(player)
    BWOABuildings.LoadHatches()
end

function BWOAMenu.Transform(player, zombie)
    Bandit.AddTask(zombie, {
        action="Transform", 
        anim="BandageUpperBody",
        bid = Bandit.banditMap.Emma.Hazmat,
        cid = Bandit.clanMap.Emma
    })
end

function BWOAMenu.Spawn(player, square, program, cid)
    local args = {}
    args.cid = cid
    args.x = square:getX()
    args.y = square:getY()
    args.z = square:getZ()
    args.program = program
    args.size = 1
    -- args.permanent = true
    sendClientCommand(player, 'Spawner', 'Clan', args)
end

function BWOAMenu.TestItem(player, square, artifact)
    local leaflet = BanditCompatibility.InstanceItem("Bandits.Note")
    leaflet:setCanBeWrite(false)
    leaflet:setName("Test Note")
    local md = leaflet:getModData()
    md.printContent = artifact
    BWOAPrepareTools.AddWorldItemSpecial(square:getX(), square:getY(), square:getZ(), leaflet, {x=0.5, y=0.5, z=0})
end

function BWOAMenu.HangingBody(player, square, artifact)
    local args = {}
    args.cid = "0b0c0c24-a9f7-4b04-a3e2-72f33b3d82ce"
    args.x = square:getX()
    args.y = square:getY()
    args.z = square:getZ()
    args.program = "Hanging"
    args.size = 1
    -- args.permanent = true
    sendClientCommand(player, 'Spawner', 'Clan', args)
end

function BWOAMenu.SetDream(player)
    BWOAPlayer.dream = 1
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
    local cell = square:getCell()
    local sx, sy, sz = square:getX(), square:getY(), square:getZ()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local room = square:getRoom()

    -- print ("FREE: " .. tostring(square:isFree(false)))
    -- Debug options

    local specialObjectsHighlight = BWOAMenu.specialObjectsHighlight
    local i = 0
    for sname, sobject in pairs(specialObjectsHighlight) do
        i = i + 1
        if sobject.x == sx and sobject.y == sy and sobject.z == sz then
            if sobject.highLightFunc(player) then
                context:addOption(sobject.option, player, sobject.actionFunc, square)
            end
        end
    end 
    print ("Hatch count: " .. tostring(i - 4))

    if isDebugEnabled() then

        print (SandboxVars.Basement.SpawnFrequency)
        local test = SandboxVars
        local vehicle = square:getVehicleContainer()

        local building = square:getBuilding()
        if building then
            def = building:getDef()
            print ("BID: " .. def:getX() .. "-" .. def:getY())
        end

        saveItems(square)

        context:addOption("Quick Teleport", player, BWOAMenu.Teleport)
        

        local spawnOption = context:addOption("Character Spawn")
        local spawnMenu = context:getNew(context)
        context:addSubMenu(spawnOption, spawnMenu)
        spawnMenu:addOption("Emma", player, BWOAMenu.Spawn, square, "Emma", Bandit.clanMap.Emma)
        spawnMenu:addOption("James", player, BWOAMenu.Spawn, square, "James", Bandit.clanMap.James)

        context:addOption("Hanging Body", player, BWOAMenu.HangingBody, square)
        context:addOption("Make Basement", player, BWOAMenu.MakeBasement, square)
        context:addOption("Lava Lake", player, BWOAMenu.LavaLake, square)

        local eventsOption = context:addOption("Events")
        local eventsMenu = context:getNew(context)
        context:addSubMenu(eventsOption, eventsMenu)
        eventsMenu:addOption("Event Chapter", player, BWOAMenu.EventChapter)
        eventsMenu:addOption("Event Earthquake", player, BWOAMenu.EventCracks)
        eventsMenu:addOption("Event Horde", player, BWOAMenu.EventHorde)
        eventsMenu:addOption("Event Assault", player, BWOAMenu.EventAssault)
        eventsMenu:addOption("Event Abyss", player, BWOAMenu.EventAbyss, square)

        local scenesOption = context:addOption("Scenes")
        local scenesMenu = context:getNew(context)
        context:addSubMenu(scenesOption, scenesMenu)

        scenesMenu:addOption("Scene Cinema", player, BWOAMenu.SceneCinema, square)
        scenesMenu:addOption("Scene Toolbag", player, BWOAMenu.SceneToolbag, square)
        scenesMenu:addOption("Scene Fuel Tank", player, BWOAMenu.SceneFuelTank, square)
        scenesMenu:addOption("Scene Dave", player, BWOAMenu.SceneDave, square)
        scenesMenu:addOption("Scene Bandits Car", player, BWOAMenu.SceneBanditsCar, square)
        scenesMenu:addOption("Scene Fallas Church", player, BWOAMenu.SceneFallasChurch, square)
        scenesMenu:addOption("Scene Ekron Church", player, BWOAMenu.SceneEkronChurch, square)
        -- scenesMenu:addOption("Scene Excavation", player, BWOAMenu.SceneExcavation, square)

        
        local artifactsOption = context:addOption("Artifacts")
        local artifactsMenu = context:getNew(context)
        context:addSubMenu(artifactsOption, artifactsMenu)

        local artifacts = {
            "confidential_medical_observation",
            "emergency_medical_report",
            "doc_note",
            "sacred_incense",
            "cold_passage",
            "early_mortuary_practice",
            "paleolithic_survey_group",
            "supplementary_excavation_log",
            "diary_kowalska",
            "7Q17",
            "medical",
            "health_effects_radiation",
            "book_dacr_research",
            "book_nuclear_winter",
        }
        for _, artifact in pairs(artifacts) do
            artifactsMenu:addOption(artifact, player, BWOAMenu.TestItem, square, artifact)
        end

        -- context:addOption("Set Dream", player, BWOAMenu.SetDream)
        -- context:addOption("Load Hatches", player, BWOAMenu.LoadHatches, square)
        -- eventsMenu:addOption("Emma Cry", player, BWOAMenu.EmmaCry)

    end
end

local function onFillInventoryObjectContextMenu(playerNum, context, items)
    -- print ("test")
end

local updateHighlight = function()
    BWOAMenu.blinking = {}

    local cell = getCell()
    local playerList = BanditPlayer.GetPlayers()
    local dist = 6

    local specialObjectsHighlight = BWOAMenu.specialObjectsHighlight
    for sname, sobject in pairs(specialObjectsHighlight) do
        for i=0, playerList:size()-1 do
            local player = playerList:get(i)
            if player then
                local px, py = player:getX(), player:getY()
                if math.abs(px - sobject.x) < dist and math.abs(py - sobject.y) < dist then 
                    local square = cell:getGridSquare(sobject.x, sobject.y, sobject.z)
                    if square then
                        local objects = square:getObjects()
                        local found = false
                        for i=objects:size()-1, 0, -1 do
                            local object = objects:get(i)
                            local sprite = object:getSprite()
                            if sprite then
                                spriteName = sprite:getName()
                                if spriteName == sobject.spriteName then
                                    if sobject.highLightFunc(player) then
                                        table.insert(BWOAMenu.blinking, object)
                                        object:setHighlighted(0, true)
                                        object:setHighlightColor(1, 0.5, 0, 1)
                                        object:setBlink(true)
                                    end
                                    found = true
                                    break
                                end
                            end
                        end

                        if not found and not sobject.destroyable then
                            BWOABuildTools.Generic (sobject.x, sobject.y, sobject.z, sobject.spriteName)
                        end
                    end
                elseif math.abs(px - sobject.x) < 50 and math.abs(py - sobject.y) < 50 then 
                    print ("Hatch close at " .. tostring(sobject.x) .. ", " .. tostring(sobject.y))
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