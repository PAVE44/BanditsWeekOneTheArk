--
-- ********************************
-- *** Bandits W1 The Ark       ***
-- ********************************
-- *** Coded by: Slayer         ***
-- ********************************
--

local function predicateAll(item)
	return true
end

BWOAMenu = BWOAMenu or {}

BWOAMenu.version = "0.114"

BWOAMenu.blinking = {}

BWOAMenu.specialObjectsCanHighlight = {}

BWOAMenu.specialObjectsCanHighlight.Noah = function(player)
    return true
end

BWOAMenu.specialObjectsCanHighlight.Vent = function(player)
    return BWOAMissions.IsActive(3)
end

BWOAMenu.specialObjectsCanHighlight.Generator = function(player)
    return true
end

BWOAMenu.specialObjectsCanHighlight.NBCMixer = function(player)
    return true
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

BWOAMenu.specialObjectsCanHighlight.Wall = function(player)
    return true
end

BWOAMenu.specialObjectsCanHighlight.Hatch = function(player)
    return true
end

BWOAMenu.specialObjectsMenu = {}

BWOAMenu.specialObjectsMenu.Noah = function(context, square, player, sobject)
    local verifyFunc = function()
        return true, ""
    end

    local actionFunc = function()
        if luautils.walkAdj(player, square) then
            BWOANoah.Show()
        end
    end

    local option = context:addOption(getText("ContextMenu_UseNoah"), player, actionFunc, square)
    local texture = getTexture(sobject.spriteName)
    if texture then
        option.iconTexture = texture:splitIcon()
    end

    local allowed, reason = verifyFunc()
    if not allowed then
        local tooltip = ISToolTip:new()
        option.notAvailable = true
        tooltip.description = reason
        option.toolTip = tooltip
    end
end

BWOAMenu.specialObjectsMenu.Vent = function(context, square, player, sobject)
    local verifyFunc = function()
        local inventory = player:getInventory()
        local hasItem = inventory:containsTagRecurse(ItemTag.SCREWDRIVER)
        return hasItem, hasItem and "" or getText("ContextMenu_NeedScrewdriver")
    end

    local actionFunc = function()
        if luautils.walkAdj(player, square) then
            local inventory = player:getInventory()
            local item = inventory:getFirstTagRecurse(ItemTag.SCREWDRIVER)
            local transferAction = ISInventoryTransferUtil.newInventoryTransferAction(player, item, item:getContainer(), player:getInventory(), 100)
            ISTimedActionQueue.add(transferAction)
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 30, true))
            ISTimedActionQueue.add(TAFixIntake:new(player, square))
        end
    end

    local option = context:addOption(getText("ContextMenu_FixAirVent"), player, actionFunc, square)
    local texture = getTexture(sobject.spriteName)
    if texture then
        option.iconTexture = texture:splitIcon()
    end

    local allowed, reason = verifyFunc(player)
    if not allowed then
        local tooltip = ISToolTip:new()
        option.notAvailable = true
        tooltip.description = reason
        option.toolTip = tooltip
    end
end

BWOAMenu.specialObjectsMenu.Generator = function(context, square, player, sobject)
    local findGen = function(square)
        local gmd = GetBWOAModData()
        local generators = gmd.generators
        for k, gen in pairs(generators) do
            if gen.x == square:getX() and gen.y == square:getY() and gen.z == square:getZ() then
                return gen
            end
        end
        return nil
    end

    local verifyCollantFunc = function()
        local item = BWOAItems.GetFirstItemTypeWithFluid("EngineCoolant")
        if not item then
            return false, getText("ContextMenu_NeedCoolant")
        end

        local gen = findGen(square)
        -- if not gen.coolant then gen.coolant = 0 end
        if gen and gen.coolant > 99 then
            return false, getText("ContextMenu_GeneratorCoolantFull")
        end

        return true
    end
    local verifyLubricantFunc = function()
        local item = BWOAItems.GetFirstItemTypeWithFluid("EngineLubricant")
        if not item then
            return false, getText("ContextMenu_NeedEngineLubricant")
        end

        local gen = findGen(square)
        -- if not gen.lubricant then gen.lubricant = 0 end
        if gen and gen.lubricant > 99 then
            return false, getText("ContextMenu_GeneratorLubricantFull")
        end

        if gen.active then
            return false, getText("ContextMenu_GeneratorMustBeShutDown")
        end
        return true
    end

    local actionCoolantFunc = function()
        if luautils.walkAdj(player, square) then
            local item = BWOAItems.GetFirstItemTypeWithFluid("EngineCoolant")
            if item then
                local transferAction = ISInventoryTransferUtil.newInventoryTransferAction(player, item, item:getContainer(), player:getInventory(), 100)
                ISTimedActionQueue.add(transferAction)
                ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 30, true))
                ISTimedActionQueue.add(TAFixGX9:new(player, square, "addCoolant"))
            end
        end
    end

    local actionLubricantFunc = function()
        if luautils.walkAdj(player, square) then
            local item = BWOAItems.GetFirstItemTypeWithFluid("EngineLubricant")
            if item then
                local transferAction = ISInventoryTransferUtil.newInventoryTransferAction(player, item, item:getContainer(), player:getInventory(), 100)
                ISTimedActionQueue.add(transferAction)
                ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 30, true))
                ISTimedActionQueue.add(TAFixGX9:new(player, square, "addLubricant"))
            end
        end
    end

    local genOption = context:addOption("GX-9")
    local texture = getTexture(sobject.spriteName)
    if texture then
        genOption.iconTexture = texture:splitIcon()
    end

    local genMenu = context:getNew(context)
    context:addSubMenu(genOption, genMenu)

    local optionCoolant = genMenu:addOption(getText("ContextMenu_AddCoolant"), player, actionCoolantFunc, square)
    local allowed, reason = verifyCollantFunc(player)
    if not allowed then
        local tooltip = ISToolTip:new()
        optionCoolant.notAvailable = true
        tooltip.description = reason
        optionCoolant.toolTip = tooltip
    end

    local optionLubricant = genMenu:addOption(getText("ContextMenu_AddLubricant"), player, actionLubricantFunc, square)
    local allowed, reason = verifyLubricantFunc(player)
    if not allowed then
        local tooltip = ISToolTip:new()
        optionLubricant.notAvailable = true
        tooltip.description = reason
        optionLubricant.toolTip = tooltip
    end
end

BWOAMenu.specialObjectsMenu.NBCMixer = function(context, square, player, sobject)
    local findDecontaminator = function(square)
        local gmd = GetBWOAModData()
        local decontaminator = gmd.decontaminator
        if decontaminator.x == square:getX() and decontaminator.y == square:getY() and decontaminator.z == square:getZ() then
            return decontaminator
        end

        return nil
    end

    local verifyFunc = function()
        local inventory = player:getInventory()
        local hasItem = inventory:containsTypeRecurse("Bandits.NBCTablets")
        return hasItem, hasItem and "" or getText("ContextMenu_NeedNBCTablets")
    end

    local actionFunc = function()
        if luautils.walkAdj(player, square) then
            local inventory = player:getInventory()
            local item = inventory:getFirstTypeRecurse("Bandits.NBCTablets")
            local transferAction = ISInventoryTransferUtil.newInventoryTransferAction(player, item, item:getContainer(), player:getInventory(), 100)
            ISTimedActionQueue.add(transferAction)
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 30, true))
            ISTimedActionQueue.add(TAAddNBCMixer:new(player, square))
        end
    end

    local option = context:addOption(getText("ContextMenu_AddNBCTablets"), player, actionFunc, square)
    local texture = getTexture(sobject.spriteName)
    if texture then
        option.iconTexture = texture:splitIcon()
    end
    local allowed, reason = verifyFunc(player)
    if not allowed then
        local tooltip = ISToolTip:new()
        option.notAvailable = true
        tooltip.description = reason
        option.toolTip = tooltip
    end
end

BWOAMenu.specialObjectsMenu.FuelIntake = function(context, square, player, sobject)
    local verifyFunc = function()
        return true, ""
    end

    local actionFunc = function()
        if luautils.walkAdj(player, square) then
            ISTimedActionQueue.add(TAFuelIntake:new(player, square))
        end
    end

    local option = context:addOption("Drain Fuel", player, actionFunc, square)
    local texture = getTexture(sobject.spriteName)
    if texture then
        option.iconTexture = texture:splitIcon()
    end
    local allowed, reason = verifyFunc(player)
    if not allowed then
        local tooltip = ISToolTip:new()
        option.notAvailable = true
        tooltip.description = reason
        option.toolTip = tooltip
    end
end

BWOAMenu.specialObjectsMenu.Wall = function(context, square, player, sobject)
    local verifyFunc = function()
        local inventory = player:getInventory()
        local hasItem = inventory:containsTagRecurse(ItemTag.SLEDGEHAMMER)
        return hasItem, hasItem and "" or getText("ContextMenu_NeedSledgehammer")
    end

    local actionFunc = function()
        if luautils.walkAdj(player, square) then
            local wall = square:getWall()
            if wall then
                local inventory = player:getInventory()
                local item = inventory:getFirstTagRecurse(ItemTag.SLEDGEHAMMER)
                local transferAction = ISInventoryTransferUtil.newInventoryTransferAction(player, item, item:getContainer(), player:getInventory(), 100)
                ISTimedActionQueue.add(transferAction)
                ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 30, true))
                ISTimedActionQueue.add(ISDestroyStuffAction:new(player, wall, false))
            end
        end    
    end

    local option = context:addOption(getText("ContextMenu_Destroy"), player, actionFunc, square)
    local allowed, reason = verifyFunc(player)
    if not allowed then
        local tooltip = ISToolTip:new()
        option.notAvailable = true
        tooltip.description = reason
        option.toolTip = tooltip
    end
end

BWOAMenu.specialObjectsMenu.Hatch = function(context, square, player, sobject)
    local verifyFunc = function()
        local inventory = player:getInventory()
        local hasItem = inventory:containsTagRecurse(ItemTag.CROWBAR)
        return hasItem, hasItem and "" or getText("ContextMenu_NeedCrowbar")
    end

    local actionFunc = function()
        if luautils.walkAdj(player, square) then
            local inventory = player:getInventory()
            local item = inventory:getFirstTagRecurse(ItemTag.CROWBAR)
            local transferAction = ISInventoryTransferUtil.newInventoryTransferAction(player, item, item:getContainer(), player:getInventory(), 100)
            ISTimedActionQueue.add(transferAction)
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 30, true))
            ISTimedActionQueue.add(TAOpenHatch:new(player, square))
        end
    end

    local option = context:addOption(getText("ContextMenu_OpenHatch"), player, actionFunc, square)
    local texture = getTexture(sobject.spriteName)
    if texture then
        option.iconTexture = texture:splitIcon()
    end
    local allowed, reason = verifyFunc(player)
    if not allowed then
        local tooltip = ISToolTip:new()
        option.notAvailable = true
        tooltip.description = reason
        option.toolTip = tooltip
    end
end

BWOAMenu.specialObjectsHighlight = {
    ["Noah"] = {
        x = 9964, y = 12627, z = -4, spriteName = "theark_01_20",
        menuFunc = BWOAMenu.specialObjectsMenu.Noah,
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Noah,
        destroyable = true,
    },
    ["Vent"] = {
        x = 9940, y = 12633, z = 0, spriteName = "theark_01_5", 
        menuFunc = BWOAMenu.specialObjectsMenu.Vent,
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Vent,
    },
    ["Generator1"] = {
        x = 9947, y = 12621, z = -4, spriteName = "industry_02_67", 
        menuFunc = BWOAMenu.specialObjectsMenu.Generator,
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Generator,
    },
    ["Generator2"] = {
        x = 9947, y = 12616, z = -4, spriteName = "industry_02_67",
        menuFunc = BWOAMenu.specialObjectsMenu.Generator,
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Generator,
    },
    ["NBCMixer"] = {
        x = 9948, y = 12622, z = -5, spriteName = "rooftop_furniture_1",
        menuFunc = BWOAMenu.specialObjectsMenu.NBCMixer,
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.NBCMixer,
    },
    ["Fuel1"] = {
        x = 9927, y = 12617, z = 0, spriteName = "theark_01_7",
        menuFunc = BWOAMenu.specialObjectsMenu.FuelIntake,
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.FuelIntake,
    },
    ["Wall"] = {
        x = 447, y = 9940, z = -1, spriteName = "walls_exterior_house_02_1",
        menuFunc = BWOAMenu.specialObjectsMenu.Wall,
        highLightFunc = BWOAMenu.specialObjectsCanHighlight.Wall,
        destroyable = true,
    },
}

function BWOAMenu.JukeboxOptions(player, square, option)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    if luautils.walkAdj(player, square) then
        ISTimedActionQueue.add(TAJukebox:new(player, square, option))
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
    BWOASequence.Assault({intensity = 6, cid = Bandit.clanMap.Surface2})
end

function BWOAMenu.EventRainbow(player)
    BWOASequence.Finale()
end

function BWOAMenu.EventNightmare(player, variant)
    BWOANightmares.Activate(variant)
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

function BWOAMenu.MakeLakeData(player, square)
    local cell = getCell()
    local sx, sy, sz = square:getX(), square:getY(), square:getZ()

    local map = {
        ["blends_natural_02_0"] = "theark_02_0",
        ["blends_natural_02_1"] = "theark_02_1",
        ["blends_natural_02_2"] = "theark_02_2",
        ["blends_natural_02_3"] = "theark_02_3",
        ["blends_natural_02_4"] = "theark_02_4",
        ["blends_natural_02_5"] = "theark_02_0",
        ["blends_natural_02_6"] = "theark_02_0",
        ["blends_natural_02_7"] = "theark_02_0",
        ["blends_natural_02_8"] = "theark_02_8",
        ["blends_natural_02_9"] = "theark_02_9",
        ["blends_natural_02_10"] = "theark_02_10",
        ["blends_natural_02_11"] = "theark_02_11",
    }

    local fileWriter = getFileWriter("lake-" .. sx .. "-" .. sy .. ".txt", true, true)

    local lines = {}
    table.insert(lines, "local map = {\n")
    for x = sx-120, sx + 120 do
        for y = sy-120, sy + 120 do
            local square = cell:getGridSquare(x, y, sz)
            if square then
                local objects = square:getObjects()
                for i=objects:size()-1, 0, -1 do
                    local object = objects:get(i)
                    local sprite = object:getSprite()
                    local spriteName = sprite:getName()
                    if map[spriteName] then
                        table.insert(lines, "    {x = " .. (x - sx) .. ", y = " .. (y - sy) .. ", sprite = \"" .. map[spriteName] .. "\"},\n")
                        -- table.insert(lines, "BWOABuildTools.Generic(x + " .. tostring(x - sx) .. ", y + " .. tostring(y - sy) .. ", " .. tostring(sz) .. ", \"" .. map[spriteName] .. "\")\n")
                    end 
                end
            end
        end
    end
    table.insert(lines, "}\n")
    table.insert(lines, "return map\n")

    local output = ""
    for k, v in pairs(lines) do
        output = output .. v
    end
    print (output)
    fileWriter:write(output)
    fileWriter:close()
end

function BWOAMenu.LavaLake(player, square)
    local cell = getCell()
    local sx, sy, sz = square:getX(), square:getY(), square:getZ()
    local r = 10

    local blueprint = BWOALakes.Island()
    BWOABuildTools.LavaLake(sx, sy, blueprint)
   
end

function BWOAMenu.Teleport(player)
    --local x, y, z = 9962, 12609, -4
    local x, y, z = 9961, 12622, -4 -- ark
    -- local x, y, z = 18005, 3603, -3 -- family house
    -- local x, y, z = 5574, 12492, -13 -- secre t base
    
    player:setX(x)
    player:setY(y)
    player:setZ(z)
    player:setLastX(x)
    player:setLastY(y)
    player:setLastZ(z)
end

function BWOAMenu.EmmaTeleport(player)
    BWOANPC.Teleport("Emma", player:getX(), player:getY(), player:getZ())
end

function BWOAMenu.BreakNoah(player)
    BWOANoah.ChangeState("error")
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
    args.occupation = {
        face = "N",
        action = "Making"
    }
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
            if sobject.menuFunc then
                sobject.menuFunc(context, square, player, sobject)
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
            context:addOption(getText("ContextMenu_StopMusic"), player, BWOAMenu.JukeboxOptions, square, "off")
        else
            context:addOption(getText("ContextMenu_PlayMusic"), player, BWOAMenu.JukeboxOptions, square, "on")
        end
    end

    if isDebugEnabled() or isAdmin() then

        print ("ISNOTBLOCKED:" .. tostring(square:isNotBlocked(false)))

        -- BWOABuildTools.Fridge(9961, 12610, -4)
        -- square:removeGrime()
        --player:setZ(-1)


        -- BWOABuildTools.ClearAll(sx, sy, sz)
        --BWOABuildTools.LampCustom(18003, 3000, -1, "lighting_indoor_02_57")

        --[[
        local test = forageSystem.forageDefinitions
        if body then
            body:setZ(body:getZ() + 0.05)
            body:setForwardDirectionAngle(-2)
            local angle = body:getAngle()
        end
        ]]

        
        BWOADialogues.MarkAsked("Emma_Robinson", "2000.6.4.1.2")
        BWOADialogues.Reveal("Emma_Robinson", "2000.7")
        BWOADialogues.Reveal("Emma_Robinson", "2000.9")

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

        -- GameSounds.fix3DListenerPosition(true)

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
        saveItems(square)

        context:addOption("Quick Teleport", player, BWOAMenu.Teleport)
        context:addOption("Emma Teleport", player, BWOAMenu.EmmaTeleport)
        context:addOption("Break Noah", player, BWOAMenu.BreakNoah)
        

        local spawnOption = context:addOption("Character Spawn")
        local spawnMenu = context:getNew(context)
        context:addSubMenu(spawnOption, spawnMenu)
        spawnMenu:addOption("Emma", player, BWOAMenu.Spawn, square, "Emma", Bandit.clanMap.Emma)
        spawnMenu:addOption("James", player, BWOAMenu.Spawn, square, "James", Bandit.clanMap.James)
        spawnMenu:addOption("Angel", player, BWOAMenu.Spawn, square, "Angel", Bandit.clanMap.Angel)
        spawnMenu:addOption("Finnegan Employee", player, BWOAMenu.Spawn, square, "Finnegan", Bandit.clanMap.FinneganGeneric)

        -- context:addOption("Hanging Body", player, BWOAMenu.HangingBody, square)
        -- context:addOption("Make Basement", player, BWOAMenu.MakeBasement, square)
        context:addOption("Locate Nearest Hatch", player, BWOAMenu.LocateBasement)
        -- context:addOption("Save Lake Blueprint", player, BWOAMenu.MakeLakeData, square)
        -- context:addOption("Lava Lake", player, BWOAMenu.LavaLake, square)

        local eventsOption = context:addOption("Events")
        local eventsMenu = context:getNew(context)
        context:addSubMenu(eventsOption, eventsMenu)
        eventsMenu:addOption("Event Chapter", player, BWOAMenu.EventChapter)
        eventsMenu:addOption("Event Earthquake", player, BWOAMenu.EventCracks)
        eventsMenu:addOption("Event Earthquake + Fire", player, BWOAMenu.EventFire)
        eventsMenu:addOption("Event Horde", player, BWOAMenu.EventHorde)
        eventsMenu:addOption("Event Assault", player, BWOAMenu.EventAssault)
        eventsMenu:addOption("Event Rainbow", player, BWOAMenu.EventRainbow)

        local nightmaresOption = context:addOption("Nightmares")
        local nightmaresMenu = context:getNew(context)
        context:addSubMenu(nightmaresOption, nightmaresMenu)
        nightmaresMenu:addOption("The Fall", player, BWOAMenu.EventNightmare, "Fall")
        nightmaresMenu:addOption("Angel", player, BWOAMenu.EventNightmare, "Angel")
        nightmaresMenu:addOption("Island", player, BWOAMenu.EventNightmare, "Island")
        nightmaresMenu:addOption("Finnegan", player, BWOAMenu.EventNightmare, "Finnegan")
        nightmaresMenu:addOption("Council", player, BWOAMenu.EventNightmare, "Council")
        nightmaresMenu:addOption("Maze", player, BWOAMenu.EventNightmare, "Maze")
        nightmaresMenu:addOption("Mirror Room", player, BWOAMenu.EventNightmare, "MirrorRoom")
        nightmaresMenu:addOption("Family House", player, BWOAMenu.EventNightmare, "FamilyHouse")

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
        -- context:addOption("Emma Cry", player, BWOAMenu.EmmaCry)
        
    end
end

local function onFillWorldObjectContextMenu(playerNum, context, worldObjects, test)
    context:removeOptionByName("AdvancedCybernetics Noah")
end

local function onFillInventoryObjectContextMenu(playerNum, context, items)
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

    local generalHLColor = getCore():getWorldItemHighlightColor()
    local specialObjectsHighlightCluster = BWOAMenu.highlightClusters[BWOAMenu.tick]
    if specialObjectsHighlightCluster then
        local ts = getTimestampMs()
        local i = 0
        for _, sobject in ipairs(specialObjectsHighlightCluster) do
            i = i + 1
            local dist = sobject.dist and sobject.dist or 3
            local id = sobject.x .. "-" .. sobject.y

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

                            for i=0, playerList:size()-1 do
                                local player = playerList:get(i)
                                if player then
                                    local playerNum = player:getPlayerNum()
                                    local px, py, pz = player:getX(), player:getY(), player:getZ()
                                    if pz == sobject.z and math.abs(px - sobject.x) < dist and math.abs(py - sobject.y) < dist then
                                        object:setOutlineHighlight(playerNum, true)
                                        object:setOutlineHighlightCol(playerNum, generalHLColor)
                                    else
                                        object:setOutlineHighlight(playerNum, false)
                                    end
                                end
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
        end
        -- print ("update highlight time: " .. (getTimestampMs() - ts) .. " iters: " .. i)
    end

    -- tick update
    BWOAMenu.tick = BWOAMenu.tick + 1
end



Events.OnPreFillWorldObjectContextMenu.Remove(onPreFillWorldObjectContextMenu)
Events.OnPreFillWorldObjectContextMenu.Add(onPreFillWorldObjectContextMenu)

Events.OnFillWorldObjectContextMenu.Remove(onFillWorldObjectContextMenu)
Events.OnFillWorldObjectContextMenu.Add(onFillWorldObjectContextMenu)

Events.OnFillInventoryObjectContextMenu.Remove(onFillInventoryObjectContextMenu)
Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)

Events.OnPlayerUpdate.Remove(updateHighlight)
Events.OnPlayerUpdate.Add(updateHighlight)
