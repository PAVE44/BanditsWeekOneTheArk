--
-- ********************************
-- *** Bandits W1 The Ark       ***
-- ********************************
-- *** Coded by: Slayer         ***
-- ********************************
--

local TAFixIntake = require("Actions/TAFixIntake")

BWOAMenu = BWOAMenu or {}

BWOAMenu.version = "0.80"

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

function BWOAMenu.JukeboxOptions(player, square, option)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local jukebox = BWOAJukebox.Get(x, y, z)
    if jukebox then
        if option == "on" then
            BWOAJukebox.TurnOn(x, y, z)
        elseif option == "off" then
            BWOAJukebox.TurnOff(x, y, z)
        end
    end
end

local chapter = 1
function BWOAMenu.EventChapter(player)
    if chapter > 4 then chapter = 1 end
    BWOASequence.Chapter({tex = "chapter_" .. chapter})
    chapter = chapter + 1
end

function BWOAMenu.EventCracks(player)
    BWOASequence.Earthquake({intensity = 30, duration=20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4})
end

function BWOAMenu.EventFire(player)
    BWOASequence.Earthquake({intensity = 60, duration=20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4, fire = true})
end

function BWOAMenu.EventHorde(player)
    BWOASequence.Horde({intensity = 30})
end

function BWOAMenu.EventAssault(player)
    BWOASequence.Assault({intensity = 6})
end

function BWOAMenu.EventRainbow(player)
    BWOAMusic.Play("MusicFinale", 1, 1)
    BWOATex.tex = getTexture("media/textures/rainbow.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 0.3
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

function BWOAMenu.Scene(player, placeEvent)
    local x, y, z = placeEvent.x, placeEvent.y, placeEvent.z
    local scene = BWOAScenes[placeEvent.scene]:new(x, y, z)
    scene:build()
end

function BWOAMenu.EmmaCry(player)
    local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma"})
    BWOAChat.ChangeBrainParam({param="sadness", value=100, target = target})
end

function BWOAMenu.MakeBasement(player, square)

    local basement = BWOABasements.Generic:new(square:getX(), square:getY(), square:getRoom(), "generic")
    basement:build()

end

function BWOAMenu.EmmaAction(player, bandit, action)
    if action == "GiveCarrot" then
        local item = BanditCompatibility.InstanceItem("Base.Carrots")
        BWOAPermaInv.Add(bandit, item)
    elseif action == "GetInventory" then
        local permaInv = BWOAPermaInv.GetAll(bandit)
    end
end

function BWOAMenu.LocateBasement(player)
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    BWOABuildings.LoadHatches()
    local specialObjectsHighlight = BWOAMenu.specialObjectsHighlight
    local distMax = math.huge
    local dx, dy
    
    for sname, sobject in pairs(specialObjectsHighlight) do
        local dist = BanditUtils.DistTo(px, py, sobject.x, sobject.y)
        if dist < distMax then
            distMax = dist
            dx = sobject.x
            dy = sobject.y
        end
    end


    if dx and dy then
        local icon = "media/ui/defend.png"
        local color = {r=0.5, g=0.5, b=0.5}
        local desc = "Closest Hatch"
        BanditEventMarkerHandler.set(getRandomUUID(), icon, 7200, dx, dy, color, desc)
    end
end

function BWOAMenu.LavaLake(player, square)
    local cell = getCell()
    local sx, sy, sz = square:getX(), square:getY(), square:getZ()
    local r = 10

    BWOABuildTools.Generator(sx, sy, sz - 3, 100, 100, true, true)

    for x = sx - r, sx + r do
        for y = sy - r, sy + r do
            if BWOAUtils.IsInCircle(x, y, sx, sy, r) then
                BWOABuildTools.Generic (x, y, sz, "theark_02_0")
                -- if x % 2 == 0 and y % 2 == 0 then
                    local heatsource = IsoHeatSource.new(x, y, sz, 7, 200)
                    cell:addHeatSource(heatsource)
                -- end
            end
        end
    end

    
end

function BWOAMenu.Teleport(player)
    --local x, y, z = 9962, 12609, -4
    local x, y, z = 9961, 12622, -4 -- ark
    -- local x, y, z = 5574, 12492, -13 -- secre t base
    
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

function BWOAMenu.Spooky(player)
    BWOASequence.Spooky({cnt = 5})
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
    local zombie = square:getZombie()
    local body = square:getDeadBody()

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
    
    local isoJukebox = BWOABaseObjects.GetIsoObject({x = sx, y = sy, z = sz, cn = "Jukebox"})
    if isoJukebox then
        local jukebox = BWOAJukebox.Get(sx, sy, sz)
        if not jukebox then
            jukebox = BWOAJukebox.Add(sx, sy, sz)
        end
        if jukebox.on then
            context:addOption("Stop Music", player, BWOAMenu.JukeboxOptions, square, "off")
        else
            context:addOption("Play Music", player, BWOAMenu.JukeboxOptions, square, "on")
        end
    end

    if isDebugEnabled() or isAdmin() then


        if body then
            body:setZ(body:getZ() + 0.05)
            body:setForwardDirectionAngle(-2)
            local angle = body:getAngle()
        end
        -- BWOADialogues.Reveal("Emma_Robinson", "2000.6")

        -- BWOARooms.Infirmary.SetFlickers()

        --[[
        BWOAAnims.Add({
            x = 9966, 
            y = 12638, 
            z = -4, 
            objName = "Incinerator",
            frameList = {
                "theark_01_9",
                "theark_01_10",
                "theark_01_11",
                "theark_01_12",
            }
        })
            ]]

        --[[
        for x = px - 40, px + 40 do
            for y = py - 40, py + 40 do
                local square = getCell():getGridSquare(x, y, pz)
                if square then
                    local wobs = square:getWorldObjects()
                    for i = 0, wobs:size()-1 do
                        local o = wobs:get(i)
                        local item = o:getItem()
                        local ftype = item:getFullType() 
                        if ftype == "Base.Bag_Military" then
                            print ("bag found")
                        end
                    end
                end
            end
        end]]

        --[[
        local doors = {
            {x = 9926, y = 12626, z = 0},
            {x = 9924, y = 12626, z = -4},
        }

        for _, doorConf in ipairs(doors) do
            local square = cell:getGridSquare(doorConf.x, doorConf.y, doorConf.z)
            if square then
                local objects = square:getObjects()
                if objects:size() > 1 then
                    local object = objects:get(1)
                    if instanceof(object, "IsoDoor") and not object:IsOpen() then
                        IsoDoor.toggleGarageDoor(object, true)
                    end
                end
            end
        end]]

        if zombie then
            local brain = BanditBrain.Get(zombie)
            if brain and brain.program and brain.program.name == "Emma" then
                local emmaOption = context:addOption("Emma Robinson")
                local emmaMenu = context:getNew(context)
                context:addSubMenu(emmaOption, emmaMenu)
                emmaMenu:addOption("Give Carrot", player, BWOAMenu.EmmaAction, zombie, "GiveCarrot")
                emmaMenu:addOption("Get Inventory", player, BWOAMenu.EmmaAction, zombie, "GetInventory")
            end
        end


        local building = square:getBuilding()
        if building then
            def = building:getDef()
            print ("BID: " .. def:getX() .. "-" .. def:getY())
        end

        Bandit.EnsureWhitelistedBandits()
        -- saveItems(square)

        context:addOption("Quick Teleport", player, BWOAMenu.Teleport)
        

        local spawnOption = context:addOption("Character Spawn")
        local spawnMenu = context:getNew(context)
        context:addSubMenu(spawnOption, spawnMenu)
        spawnMenu:addOption("Emma", player, BWOAMenu.Spawn, square, "Emma", Bandit.clanMap.Emma)
        spawnMenu:addOption("James", player, BWOAMenu.Spawn, square, "James", Bandit.clanMap.James)

        context:addOption("Hanging Body", player, BWOAMenu.HangingBody, square)
        context:addOption("Make Basement", player, BWOAMenu.MakeBasement, square)
        context:addOption("Locate Nearest Hatch", player, BWOAMenu.LocateBasement, player)
        context:addOption("Lava Lake", player, BWOAMenu.LavaLake, square)

        local eventsOption = context:addOption("Events")
        local eventsMenu = context:getNew(context)
        context:addSubMenu(eventsOption, eventsMenu)
        eventsMenu:addOption("Event Chapter", player, BWOAMenu.EventChapter)
        eventsMenu:addOption("Event Earthquake", player, BWOAMenu.EventCracks)
        eventsMenu:addOption("Event Earthquake + Fire", player, BWOAMenu.EventFire)
        eventsMenu:addOption("Event Horde", player, BWOAMenu.EventHorde)
        eventsMenu:addOption("Event Assault", player, BWOAMenu.EventAssault)
        eventsMenu:addOption("Event Abyss", player, BWOAMenu.EventAbyss, square)
        eventsMenu:addOption("Event Rainbow", player, BWOAMenu.EventRainbow)
        

        local scenesOption = context:addOption("Scenes")
        local scenesMenu = context:getNew(context)
        context:addSubMenu(scenesOption, scenesMenu)

        for _, placeEvent in pairs(BWOAPlaceEvents.events) do
            scenesMenu:addOption("Scene " .. placeEvent.scene, player, BWOAMenu.Scene, placeEvent)
        end
        
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
        context:addOption("Load Hatches", player, BWOAMenu.LoadHatches, square)
        context:addOption("Spooky", player, BWOAMenu.Spooky)
        context:addOption("Emma Cry", player, BWOAMenu.EmmaCry)
        

    end
end

local function onFillInventoryObjectContextMenu(playerNum, context, items)
    -- print ("test")
end

BWOAMenu.tick = 0
BWOAMenu.highlightClusters = nil

local updateHighlight = function()

    if BWOAMenu.tick >= 16 then
        BWOAMenu.tick = 0
    end

    local specialObjectsHighlight = BWOAMenu.specialObjectsHighlight
    if not BWOAMenu.highlightClusters then
        BWOAMenu.highlightClusters = {}
        BWOABuildings.LoadHatches()
        for sname, sobject in pairs(specialObjectsHighlight) do
            local cluster = (sobject.x + sobject.y) % 16
            if not BWOAMenu.highlightClusters[cluster] then
                BWOAMenu.highlightClusters[cluster] = {}
            end
            table.insert(BWOAMenu.highlightClusters[cluster], sobject)
        end
    end
    

    local cell = getCell()
    local playerList = BanditPlayer.GetPlayers()

    local specialObjectsHighlightCluster = BWOAMenu.highlightClusters[BWOAMenu.tick]
    if specialObjectsHighlightCluster then
        local ts = getTimestampMs()
        local i = 0
        for _, sobject in ipairs(specialObjectsHighlightCluster) do
            i = i + 1
            local dist = sobject.dist and sobject.dist or 5
            local id = sobject.x .. "-" .. sobject.y
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
                                            BWOAMenu.blinking[id] = object
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
                    else
                        BWOAMenu.blinking[id] = nil
                    end
                end
            end
        end
        -- print ("update highlight time: " .. (getTimestampMs() - ts) .. " iters: " .. i)
    end

    local blinking = BWOAMenu.blinking
    for _, object in pairs(blinking) do
        object:setHighlighted(0, true)
        object:setHighlightColor(1, 0.5, 0, 1)
        object:setBlink(true)
    end

    -- tick update
    BWOAMenu.tick = BWOAMenu.tick + 1
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

Events.OnPlayerUpdate.Remove(updateHighlight)
Events.OnPlayerUpdate.Add(updateHighlight)

-- Events.OnPlayerUpdate.Remove(blink)
-- Events.OnPlayerUpdate.Add(blink)