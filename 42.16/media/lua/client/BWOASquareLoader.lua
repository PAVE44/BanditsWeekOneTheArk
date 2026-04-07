BWOASquareLoader = BWOASquareLoader or {}

BWOASquareLoader.burnMap = {
    ["Base.CarLights"]        = "Base.CarNormalBurnt",
    ["Base.CarLuxury"]        = "Base.LuxuryCarBurnt",
    ["Base.NormalCarPolice"]  = "Base.NormalCarBurntPolice",
    ["Base.CarNormal"]        = "Base.CarNormalBurnt",
    ["Base.CarStationWagon"]  = "Base.CarNormalBurnt",
    ["Base.ModernCar"]        = "Base.ModernCar02Burnt",
    ["Base.ModernCar02"]      = "Base.SmallCar02Burnt",
    ["Base.SmallCar02"]       = "Base.SmallCar02Burnt",
    ["Base.CarSmall02"]       = "Base.SmallCar02Burnt",
    ["Base.SmallCar"]         = "Base.SmallCarBurnt",
    ["Base.CarSmall"]         = "Base.SmallCarBurnt",
    ["Base.SportsCar"]        = "Base.SportsCarBurnt",
    ["Base.OffRoad"]          = "Base.OffRoadBurnt",
    ["Base.LuxuryCar"]        = "Base.LuxuryCarBurnt",
    ["Base.SUV"]              = "Base.SUVBurnt",
    ["Base.Taxi"]             = "Base.TaxiBurnt",
    ["Base.CarTaxi"]          = "Base.TaxiBurnt",
    ["Base.CarTaxi2"]         = "Base.TaxiBurnt",
    ["Base.PickUpVanLights"]  = "Base.PickUpVanLightsBurnt",
    ["Base.PickUpVan"]        = "Base.PickUpVanBurnt",
    ["Base.VanAmbulance"]     = "Base.AmbulanceBurnt",
    ["Base.VanRadio"]         = "Base.VanRadioBurnt",
    ["Base.VanSeats"]         = "Base.VanSeatsBurnt",
    ["Base.Van"]              = "Base.VanBurnt",
    ["Base.StepVan"]          = "Base.VanBurnt",          -- has no better alternative
    ["Base.PickupSpecial"]    = "Base.PickupSpecialBurnt",
    ["Base.PickUpTruck"]      = "Base.PickupBurnt",
    ["Base.Pickup"]           = "Base.PickupBurnt",
}

local branches = {"d_generic_1_11", "d_generic_1_12", "d_generic_1_13", "d_generic_1_14", "d_generic_1_15", "d_generic_1_16", "d_generic_1_17", "d_generic_1_18"}

BWOASquareLoader.replacements = {
    ["vegetation_indoor_01_9"] = {"vegetation_indoor_01_25", "vegetation_indoor_01_33"},
    ["vegetation_indoor_01_10"] = {"vegetation_indoor_01_26", "vegetation_indoor_01_34"},
    ["vegetation_indoor_01_11"] = {"vegetation_indoor_01_27", "vegetation_indoor_01_35"},
    ["vegetation_indoor_01_12"] = {"vegetation_indoor_01_28", "vegetation_indoor_01_36"},
    ["vegetation_indoor_01_7"] = {"vegetation_indoor_01_29", "vegetation_indoor_01_37"},
    ["vegetation_ornamental_01"] = branches,
}

BWOASquareLoader.trashItems = {
    "Base.Plank",
    "Base.Plank",
    "Base.Plank",
    "Base.Plank",
    "Base.Plank",
    "Base.Plank",
    "Base.Plank",
    "Base.Plank_Broken",
    "Base.Plank_Broken",
    "Base.MetalPipe_Broken",
    "Base.ClayBrick",
    "Base.ClayBrick",
    "Base.RippedSheetsDirty",
    "Base.RippedSheetsDirty",
    "Base.Brochure",
    "Base.BrokenGlass",
    "Base.LongHandle_Broken",
    "Base.WoodenStick_Broken",
    "Base.Drawer",
    "Base.TableLeg_Broken",
    "Base.TableLeg",
    "Base.ChairLeg",
    "Base.TableLeg",
    "Base.Branch_Broken",
    "Base.LargeBranch",
    "Base.TreeBranch2",
    "Base.BeerEmpty",
    "Base.EmptyJar",
    "Base.Pop2Empty",
    "Base.Pop3Empty",
    "Base.PopEmpty",
    "Base.Bucket",
    "Base.BucketWood",
    "Base.UnusableWood",
    "Base.UnusableMetal",
    "Base.ScrapMetal",
    "Base.ScrapMetal",
    "Bandits.HumanBone",
    "Bandits.HumanBone",
    "Base.AnimalBone",
    "Base.AnimalBone",
    "Base.SheetPaper2",
    "Base.Sheet",
    "Base.Socks_Ankle",
}

BWOASquareLoader.trashObjects = {
    "boulders_0",
    "boulders_1",
    "boulders_2",
    "boulders_3",
    "boulders_4",
    "boulders_5",
    "boulders_6",
    "boulders_7",
    "boulders_8",
    "boulders_9",
    "boulders_10",
    "boulders_11",
    "boulders_12",
    "boulders_13",
    "boulders_14",
    "boulders_15",
    "furniture_seating_02_4",
    "furniture_seating_02_5",
    "furniture_seating_02_6",
    "furniture_seating_02_7",
    "fencing_damaged_01_137",
    "fencing_damaged_01_138",
    "fencing_damaged_01_139",
    "brokenglass_1_0",
    "brokenglass_1_1",
    "brokenglass_1_2",
    "brokenglass_1_3",
    "carpentry_01_44",
    "carpentry_01_45",
    "carpentry_01_46",
    "carpentry_01_47",
    "damaged_objects_01_12",
    "damaged_objects_01_13",
    "damaged_objects_01_14",
}

BWOASquareLoader.burnExclusion = {
    ["Base.PickUpTruckLightsFossoil"] = true
}

BWOASquareLoader.dirtyMap = {
    "floors_rugs_01",
    "recreational_01",
    "industry_02",
}

BWOASquareLoader.scrapChancePercent = {
    [1] = 8,
    [2] = 15,
    [3] = 23,
    [4] = 31,
    [5] = 39,
}

BWOASquareLoader.materialToItems = {
    ["Wood"] = {cnt = 2, items = {"Base.UnusableWood", "Base.UnusableWood", "Base.Plank"}},
    ["MetalPlates"] = {cnt = 1, items = {"Base.UnusableMetal", "Base.UnusableMetal", "Base.SheetMetal"}},
    ["SmallMetalPlates"] = {cnt = 1, items = {"Base.UnusableMetal", "Base.UnusableMetal", "Base.SmallSheetMetal"}},
    ["MetalScrap"] = {cnt = 1, items = {"Base.UnusableMetal", "Base.UnusableMetal", "Base.ScrapMetal"}},
    ["Nails"] = {cnt = 2, items = {"Base.Nails"}},
    ["Screws"] = {cnt = 2, items = {"Base.Screws"}},
    ["Fabric"] = {cnt = 2, items = {"Base.RippedSheetsDirty", "Base.RippedSheetsDirty", "Base.Sheet"}},
    -- ["Brick"] = {cnt = 3, items = {"Base.ClayBrick"}}, -- spams too much
    ["Electric"] = {cnt = 1, items = {"Base.Screws", "Base.Screws", "Base.ElectronicsScrap"}},
    ["Pipes"] = {cnt = 1, items = {"Base.MetalPipe_Broken", "Base.MetalPipe_Broken", "Base.MetalPipe"}},
}

BWOASquareLoader.lavaEpicenters = {
    {x=9950, y=11300, r=700},
    {x=11940, y=7010, r=140},
    {x=13830, y=1715, r=200},
}

local hasMaterial = function(props, material)
    local material1 = props:get("Material")
    local material2 = props:get("Material2")
    local material3 = props:get("Material3")
    if material1 == material or material2 == material or material3 == material then
        return true
    end
    return false
end

local makeDirty = function(str)
    local pos = str:find("%d")
    if pos then
        return str:sub(1, pos - 1) .. "burnt_" .. str:sub(pos)
    end
    return str
end

local burnVehicle = function(vehicle)
    local burnMap = BWOASquareLoader.burnMap
    local scriptName = vehicle:getScriptName()
    if scriptName:embodies("Burnt") then return end

    for k, v in pairs(burnMap) do
        if scriptName:embodies(k) then
            local ax = vehicle:getAngleX()
            local ay = vehicle:getAngleY()
            local az = vehicle:getAngleZ()
            vehicle:permanentlyRemove()

            local vehicleBurnt = BanditUtils.AddVehicle(v, IsoDirections.S, vehicle:getSquare())
            if vehicleBurnt then
                for i = 0, vehicleBurnt:getPartCount() - 1 do
                    local container = vehicleBurnt:getPartByIndex(i):getItemContainer()
                    if container then
                        container:removeAllItems()
                    end
                end
                vehicleBurnt:getModData().BWO = {}
                vehicleBurnt:getModData().BWO.wasRepaired = true
                vehicleBurnt:setAngles(ax, ay, az)
            end
            break
        end
    end
end

local bxor =function(a, b)
    local result = 0
    local bitval = 1
    while a > 0 or b > 0 do
        local abit, bbit = a % 2, b % 2
        if abit ~= bbit then
            result = result + bitval
        end
        a = math.floor(a / 2)
        b = math.floor(b / 2)
        bitval = bitval * 2
    end
    return result
end

local hash = function(x, y, seed)
    return (bxor(x * 73856093, bxor(y * 19349663, seed * 83492791))) % 1000000
end

local shouldPlace = function(x, y, density, seed)
    local threshold = density * 1000000  -- Scale density to hash range
    return hash(x, y, seed) < threshold
end

local burnSquare = function(square)
    local x, y, z = square:getX(), square:getY(), square:getZ()

    local md = square:getModData()
    if not md.BWO then md.BWO = {} end
    md.BWO.burnt = true

    local replacements = BWOASquareLoader.replacements
    local dirtyMap = BWOASquareLoader.dirtyMap
    local residuleScrapChance = BWOASquareLoader.scrapChancePercent[SandboxVars.BWOA.ResidueScrap]
    local residuleMaterialToItems = BWOASquareLoader.materialToItems
    local addNavDestruction = false
    if BanditUtils.HasZoneType(x, y, z, "Nav") then
        addNavDestruction = true
    end

    local objects = square:getObjects()
    for i=objects:size()-1, 0, -1 do
        local object = objects:get(i)
        local sprite = object:getSprite()
        if sprite then
            local spriteName = sprite:getName()

            -- nav destroyer
            if addNavDestruction then
                if spriteName and spriteName:embodies("street") then
                    local rn = ZombRand(8)
                    local overlaySprite
                    if rn < 2  then
                        overlaySprite = "floors_overlay_street_01_" .. ZombRand(44)
                    elseif rn == 2 then
                        overlaySprite = "blends_streetoverlays_01_" .. ZombRand(32)
                    end
                    if overlaySprite then
                        local attachments = object:getAttachedAnimSprite()
                        if not attachments or attachments:size() == 0 then
                            object:setAttachedAnimSprite(ArrayList.new())
                        end
                        object:getAttachedAnimSprite():add(getSprite(overlaySprite):newInstance())
                    end
                end
            end

            -- object replacer
            for k, v in pairs(replacements) do
                if spriteName and spriteName:embodies(k) then
                    square:transmitRemoveItemFromSquare(object)
                    if #v > 0 then
                        local newSpriteName = BanditUtils.Choice(v)
                        if newSpriteName then
                            local newObject = IsoObject.new(square, newSpriteName, "")
                            square:AddSpecialObject(newObject)
                            newObject:transmitCompleteItemToClients()
                        end
                    end
                    break
                end
            end

            -- object dirtying
            for _, dirty in ipairs(dirtyMap) do
                if spriteName and spriteName:embodies(dirty) then
                    local dirtySpriteName = makeDirty(spriteName)
                    if dirtySpriteName then
                        object:setSprite(getSprite(dirtySpriteName))
                        object:transmitUpdatedSpriteToClients()
                    end
                    break
                end
            end

            -- object desstruction to materials
            local rnd = ZombRand(100)
            if rnd < residuleScrapChance then
                local props = sprite:getProperties()
                local cnt = 0
                local itemType

                for material, matData in pairs(residuleMaterialToItems) do
                    if hasMaterial(props, material) then
                        cnt = matData.cnt
                        itemTypes = matData.items
                        for i = 1, cnt do
                            local itemType = BanditUtils.Choice(itemTypes)
                            local ox, oy, oz, rz = ZombRandFloat(0.1, 0.9), ZombRandFloat(0.1, 0.9), 0, ZombRand(360)
                            local item = BanditCompatibility.InstanceItem(itemType)
                            if item then
                                local witem = square:AddWorldInventoryItem(item, ox, oy, oz)
                                if witem then
                                    witem:setWorldZRotation(rz)
                                end
                            end
                        end
                    end
                end
            end
        end
        if instanceof(object, "IsoLightSwitch") then
            square:transmitRemoveItemFromSquare(object)
        end
        if instanceof(object, "IsoCurtain") then
            square:transmitRemoveItemFromSquare(object)
        end
        if instanceof(object, "IsoWindow") then
            square:transmitRemoveItemFromSquare(object)
        end
    end

    square:BurnWalls(false, true)

    if BanditUtils.HasZoneType(x, y, z, "TownZone") then
        local rnd = ZombRand(100)
        if rnd < 10 then
            local rn = ZombRand(8)
            local obj = IsoObject.new(square, "floors_ash_01_" .. tostring(rn), "")
            if obj then
                square:AddSpecialObject(obj)
                obj:transmitCompleteItemToClients()
            end
        elseif rnd < 20 then
            local rn = ZombRand(54)
            local sprite = "trash_01_" .. tostring(rn)
            local obj = IsoObject.new(square, sprite, "")
            if obj then
                square:AddSpecialObject(obj)
                obj:transmitCompleteItemToClients()
            end
        elseif rnd < 24 then
            local rnd = ZombRand(100)
            if rnd < residuleScrapChance * 2 then
                local itemType = BanditUtils.Choice(BWOASquareLoader.trashItems)
                local ox, oy, oz, rz = ZombRandFloat(0.1, 0.9), ZombRandFloat(0.1, 0.9), 0, ZombRand(360)
                local item = BanditCompatibility.InstanceItem(itemType)
                if item then
                    local witem = square:AddWorldInventoryItem(item, ox, oy, oz)
                    if witem then
                        witem:setWorldZRotation(rz)
                    end
                end
            end
        elseif rnd < 25 then
            local sprite = BanditUtils.Choice(BWOASquareLoader.trashObjects)
            local obj = IsoObject.new(square, sprite, "")
            square:AddSpecialObject(obj)
            obj:transmitCompleteItemToClients()
        end
    end

    
end

local skeletonPlacer = function(square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    
    if square:getDeadBody() then return end
    if z <= -2 then return end

    local seed = 12346
    local density = 0.016
    local zone = square:getZone()
    local multiplier = 0
    if zone then
        local zoneType = zone:getType()
        if zoneType then
            if zoneType == "TownZone" or zoneType == "TrailerPark" then
                multiplier = 1
            elseif zoneType == "Farm" or zoneType == "Ranch" then
                multiplier = 0.6
            elseif zoneType == "Nav" then
                multiplier = 0.3
            elseif zoneType == "Vegitation" then
                multiplier = 0.1
            end
        end
    end
    density = density * multiplier

    if not square:isOutside() then density = density * 5 end

    if density > 0 and shouldPlace(x, y, density, seed) then
        -- local age = getGameTime():getWorldAgeHours() - 10
        local fakeItem = BanditCompatibility.InstanceItem("Base.Axe")
        local fakeZombie = getCell():getFakeZombieForHit()

        local zombieList = BanditCompatibility.AddZombiesInOutfit(x, y, z, "Naked", 0, false, false, false, false, false, false, 2)
        for i=0, zombieList:size()-1 do
            -- print ("place body at x:" .. x .. " y:" .. y)
            local zombie = zombieList:get(i)
            zombie:setSkeleton(true)

            local banditVisuals = zombie:getHumanVisual()
            banditVisuals:setHairModel("Bald")
            banditVisuals:setBeardModel("")

            zombie:resetModelNextFrame()
            zombie:resetModel()


            -- zombie:setForceFakeDead(true)
            BanditCompatibility.Splash(zombie, fakeItem, fakeZombie)
            zombie:Hit(fakeItem, fakeZombie, 50, false, 1, false)
            zombie:setHealth(0)
        end
    end
end

local lavaPlacer = function(square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    
    if z ~= 0 then return end

    local isInEpicenter = false
    local lavaEpicenters = BWOASquareLoader.lavaEpicenters
    for _, epicenter in ipairs(lavaEpicenters) do
        if BWOAUtils.IsInCircle(x, y, epicenter.x, epicenter.y, epicenter.r) then
            isInEpicenter = true
            break
        end
    end
    if not isInEpicenter then return end

    local seed = 12346
    local density = 0.0005

    if density > 0 and shouldPlace(x, y, density, seed) then
        BWOAEventControl.Add("LavaLake", {x = x, y = y}, 2000)
    end
end

local isExcluded = function(square)
    local x, y, z = square:getX(), square:getY(), square:getZ()

    if z < 0 then return true end

    -- ARK exclusion
    if x >= 9910 and y >= 12611 and x <= 9942 and y <= 12645 then return true end

    -- Fallas Lake exclusion
    if x >= 7050 and y >= 8154 and x <= 7880 and y <= 8560 then return true end

    return false
end

local processSquare = function(square)
    local md = square:getModData()
    if not md.BWO then md.BWO = {} end

    -- if true then return end

    -- post nuke world destroyer
    if not md.BWO.processed and not isExcluded(square) then
        burnSquare(square)
        local vehicle = square:getVehicleContainer()
        if vehicle and not BWOASquareLoader.burnExclusion[vehicle:getScriptName()] then
            burnVehicle(vehicle)
        end

        skeletonPlacer(square)

        lavaPlacer(square)

        md.BWO.processed = true
    end
end

local function as(vehicle)
    if not BWOASquareLoader.burnExclusion[vehicle:getScriptName()] then
        burnVehicle(vehicle)
    end
end

Events.OnSpawnVehicleEnd.Remove(onSpawnVehicleEnd)
Events.OnSpawnVehicleEnd.Add(onSpawnVehicleEnd)

Events.LoadGridsquare.Remove(processSquare)
Events.LoadGridsquare.Add(processSquare)
