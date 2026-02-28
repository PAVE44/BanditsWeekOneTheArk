require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.BanditsCar = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.BanditsCar:placeObjects()
    BWOABuildTools.Generator(8340, 11610, 0, 50 + ZombRand(30), 18 + ZombRand(40), true, true)

    for x=8334, 8349 do
        for y=11609, 11616 do
            BWOABuildTools.RemoveObject(x, y, -2, "Bench")
        end
    end

    -- seating area
    BWOABuildTools.Generic(8335, 11610, -2, "floor_rugs_02_2")
    BWOABuildTools.Generic(8336, 11610, -2, "floor_rugs_02_2")
    BWOABuildTools.Generic(8335, 11611, -2, "floor_rugs_02_2")
    BWOABuildTools.Generic(8336, 11611, -2, "floor_rugs_02_2")
    BWOABuildTools.Generic(8334, 11609, -2, "carpentry_02_64")
    BWOABuildTools.Generic(8335, 11609, -2, "furniture_seating_indoor_01_17")
    BWOABuildTools.Generic(8336, 11609, -2, "furniture_seating_indoor_01_16")
    BWOABuildTools.Fireplace(8337, 11609, -2, "appliances_cooking_01_17")
    BWOABuildTools.Generic(8334, 11611, -2, "furniture_seating_indoor_01_8")
    BWOABuildTools.Generic(8334, 11612, -2, "carpentry_02_8")
    BWOABuildTools.Generic(8335, 11612, -2, "furniture_seating_indoor_01_20")
    BWOABuildTools.Generic(8336, 11612, -2, "furniture_seating_indoor_01_21")

    -- entertainment area
    BWOABuildTools.Generic(8335, 11614, -2, "recreational_01_2")
    BWOABuildTools.Generic(8336, 11614, -2, "recreational_01_3")
    BWOABuildTools.Generic(8334, 11616, -2, "recreational_01_0")
    BWOAJukebox.Add(8334, 11616, -2)
    BWOAJukebox.TurnOn(8334, 11616, -2)

    -- trash area
    BWOABuildTools.Generic(8338, 11616, -2, "trash_01_44")
    BWOABuildTools.Generic(8339, 11616, -2, "trash_containers_01_17")
    BWOABuildTools.Generic(8340, 11616, -2, "trash_01_52")
    BWOABuildTools.Generic(8340, 11615, -2, "trash_01_40")
    BWOABuildTools.Generic(8341, 11615, -2, "trash_01_48")
    BWOABuildTools.Generic(8341, 11614, -2, "trash_01_2")
    BWOABuildTools.Generic(8341, 11614, -2, "trash_01_2")
    BWOABuildTools.Generic(8341, 11616, -2, "trash_containers_01_27")
    BWOABuildTools.Generic(8342, 11616, -2, "trash_containers_01_26")
    BWOABuildTools.Generic(8343, 11616, -2, "trash_containers_01_26")

    -- dining area
    BWOABuildTools.Generic(8343, 11613, -2, "carpentry_01_28")
    BWOABuildTools.Generic(8344, 11613, -2, "carpentry_01_29")
    BWOABuildTools.Generic(8345, 11613, -2, "carpentry_01_61")
    BWOABuildTools.Generic(8343, 11612, -2, "carpentry_01_44")
    BWOABuildTools.Generic(8344, 11612, -2, "carpentry_01_44")
    BWOABuildTools.Generic(8345, 11612, -2, "carpentry_01_44")
    BWOABuildTools.Generic(8343, 11614, -2, "carpentry_01_46")
    BWOABuildTools.Generic(8344, 11614, -2, "carpentry_01_46")
    BWOABuildTools.Generic(8345, 11614, -2, "carpentry_01_46")
    BWOABuildTools.Generic(8342, 11613, -2, "carpentry_01_45")

    -- kitchen area
    BWOABuildTools.Generic(8338, 11609, -2, "camping_01_28")
    BWOABuildTools.Generic(8339, 11609, -2, "camping_01_29")
    BWOABuildTools.Generic(8341, 11609, -2, "location_business_office_generic_01_49")
    BWOABuildTools.Generic(8342, 11609, -2, "industry_01_23")
    BWOABuildTools.Generic(8343, 11609, -2, "fixtures_counters_01_13")
    BWOABuildTools.Generic(8343, 11609, -2, "fixtures_sinks_01_17")
    BWOABuildTools.Generic(8344, 11609, -2, "fixtures_counters_01_13")
    BWOABuildTools.Generic(8345, 11609, -2, "fixtures_counters_01_13")
    BWOABuildTools.Stove(8346, 11609, -2, "appliances_cooking_01_1")
    BWOABuildTools.Generic(8347, 11609, -2, "carpentry_01_19")
    BWOABuildTools.WasherDryer(8348, 11609, -2, "appliances_laundry_01_0", true)

    -- bathroom
    BWOABuildTools.RemoveObject(8355, 11611, -2, "Round Bin")
    BWOABuildTools.RemoveObject(8354, 11611, -2, "Conditioner")
    BWOABuildTools.Generic(8354, 11611, -2, "fixtures_bathroom_01_26")
    BWOABuildTools.Generic(8355, 11611, -2, "fixtures_bathroom_01_27")

end

function BWOAScenes.BanditsCar:placeItems()
    
    local items
    items = {
        ["Base.HottieZ"] = 12, ["Base.ComicBook"] = 8, ["Base.HempMag1"] = 1, ["Base.CookingMag1"] = 1,
        ["Base.TrickMag1"] = 1, ["Base.TrickMag2"] = 1, ["Base.MechanicMag1"] = 1, ["Base.MechanicMag2"] = 1, ["Base.MechanicMag2"] = 1,
        ["Base.KeyMag1"] = 1, ["Base.HuntingMag1"] = 1, 
    }
    BWOAPrepareTools.AddItemsToContainer(8334, 11609, -2, items, "Shelves")
    
    items = {
        ["Base.Wrench"] = 1, ["Base.BallPeenHammer"] = 1, ["Base.BoltCutters"] = 1, ["Base.CarpentryChisel"] = 1,
        ["Base.HandSaw"] = 1, ["Base.Hatchet"] = 1, ["Base.MetalPipe"] = 1, ["Base.Shovel"] = 1,
        ["Base.File"] = 1, ["Base.Axe"] = 1, ["Base.HandAxe"] = 1, ["Base.PipeWrench"] = 1, ["Base.Screwdriver"] = 1,
        ["Base.SheepShears"] = 1, ["Base.Brush"] = 1, ["Base.StoneChisel"] = 1, ["Base.ViseGrips"] = 1
    }
    BWOAPrepareTools.AddItemsToContainer(8349, 11604, -1, items, "Shelves")

    items = {
        ["Base.WeldingMask"] = 1, ["Base.BlowTorch"] = 1, ["Base.Tongs"] = 1, ["Base.Paintbrush"] = 2,
        ["Base.MetalworkingPliers"] = 1, ["Base.MeasuringTape"] = 1, ["Base.Loupe"] = 1, ["Base.PlasterTrowel"] = 1,
        ["Base.RubberHose"] = 2, ["Base.HandDrill"] = 1, ["Base.Saw"] = 1, ["Base.Funnel"] = 1,
        ["Base.Calipers"] = 2, ["Base.Awl"] = 1, ["Base.Saw"] = 1, ["Base.Funnel"] = 1,
    }
    BWOAPrepareTools.AddItemsToContainer(8349, 11603, -1, items, "Shelves")

    items = {
        ["Base.CandleBox"] = 1, ["Base.HandTorch"] = 2, ["Base.BatteryBox"] = 2, ["Base.Generator"] = 1,
        ["Base.ElectronicsScrap"] = 13, ["Base.DuctTapeBox"] = 1
    }
    BWOAPrepareTools.AddItemsToContainer(8347, 11604, -41, items, "Shelves")

    items = {
        ["Base.Soap"] = 10, ["Base.RippedSheets"] = 12, ["Base.Bleach"] = 3, ["Base.Sponge"] = 3,
    }
    BWOAPrepareTools.AddItemsToContainer(8347, 11603, -1, items, "Shelves")

    items = {
        ["Base.ScrewsBox"] = 3, ["Base.NailsBox"] = 5, ["Base.Epoxy"] = 2, ["Base.Glue"] = 3, ["Base.Rope"] = 2,
    }
    BWOAPrepareTools.AddItemsToContainer(8345, 11603, -1, items, "Shelves")

    items = {
        ["Base.PropaneTank"] = 3,
    }
    BWOAPrepareTools.AddItemsToContainer(8345, 11604, -1, items, "Shelves")

    items = {
        ["Base.SheetMetal"] = 4, ["Base.SmallSheetMetal"] = 5, ["Base.ScrapMetal"] = 13,
    }
    BWOAPrepareTools.AddItemsToContainer(8345, 11605, -1, items, "Shelves")

    items = {
        ["Base.PetrolCan"] = 5
    }
    BWOAPrepareTools.AddItemsToContainer(8345, 11606, -1, items, "Shelves")

    items = {
        ["Base.CannedBolognese"] = 5, ["Base.TinnedBeans"] = 4, ["Base.CannedCorn"] = 6,
        ["Base.CannedMushroomSoup"] = 7, ["Base.TinnedSoup"] = 5,
        ["Base.CannedCornedBeef"] = 6, ["Base.CannedChili"] = 3,
        ["Base.TunaTin"] = 5, ["Base.CannedSardines"] = 8,
        ["Base.CannedPineapple"] = 2, ["Base.CannedFruitCocktail"] = 4,
        ["Base.CannedPotato2"] = 11, ["Base.CannedCarrots2"] = 6,
     }
    BWOAPrepareTools.AddItemsToContainer(8352, 11603, -2, items, "Shelves")

    items = {
        ["Base.OatsRaw"] = 3, ["Base.Cereal"] = 4,
        ["Base.JamFruit"] = 12, ["Base.JamMarmalade"] = 6,
    }
    BWOAPrepareTools.AddItemsToContainer(8353, 11603, -2, items, "Shelves")

    items = {
        ["Base.Vodka"] = 3, ["Base.WineScrewtop"] = 17,
    }
    BWOAPrepareTools.AddItemsToContainer(8354, 11603, -2, items, "Shelves")

    items = {
        ["Base.BeerCan"] = 17
    }
    BWOAPrepareTools.AddItemsToContainer(8355, 11603, -2, items, "Shelves")

    items = {
        ["Base.Bandage"] = 8, ["Base.AlcoholWipes"] = 2, ["Base.Antibiotics"] = 1,
        ["Base.Painkillers"] = 2, ["Base.Vitamins"] = 3, ["Base.SutureNeedle"] = 6,
        ["Base.SutureNeedleHolder"] = 1, ["Base.Scalpel"] = 1, ["Base.Stethoscope"] = 1,
        ["Base.RubberHose"] = 2, ["Base.Machete"] = 1, ["Base.GasmaskFilter"] = 11,
    }
    BWOAPrepareTools.AddItemsToContainer(8352, 11605, -2, items, "Shelves")

    items = {
        ["Base.WaterBottle"] = 30,
    }
    BWOAPrepareTools.AddItemsToContainer(8352, 11606, -2, items, "Shelves")

    items = {
        ["Base.AssaultRifle"] = 2, ["Base.556Clip"] = 6, ["Base.556Box"] = 17,
    }
    BWOAPrepareTools.AddItemsToContainer(8354, 11605, -2, items, "Shelves")

    items = {
        ["Base.Pistol"] = 2, ["Base.9mmClip"] = 4, ["Base.Bullets9mmBox"] = 19,
    }
    BWOAPrepareTools.AddItemsToContainer(8355, 11605, -2, items, "Shelves")

    items = {
        ["Base.EngineParts"] = 12, ["Base.LightBulbBox"] = 1, ["Base.TirePump"] = 1,
        ["Base.TireIron"] = 1, ["Base.Jack"] = 1, ["Base.OldTire2"] = 2,
    }
    BWOAPrepareTools.AddItemsToContainer(8354, 11607, -2, items, "Shelves")

    items = {
        ["Base.BookReloading3"] = 1, ["Base.BookReloading4"] = 1, ["Base.BookReloading5"] = 1,
        ["Base.BookAiming3"] = 1, ["Base.BookAiming4"] = 1, ["Base.BookAiming5"] = 1,
        ["Base.BookElectrical1"] = 1, ["Base.BookElectrical2"] = 1,
        ["Base.BookFirstAid1"] = 1, 
        ["Base.BookMaintenance1"] = 1,
        ["Base.BookMechanic1"] = 1, ["Base.BookMechanic2"] = 1
    }
    BWOAPrepareTools.AddItemsToContainer(8355, 11607, -2, items, "Shelves")

    BWOAPrepareTools.AddWorldItem(8338, 11612, -2, "Base.BarBell", {x=0.57, y=0.49, z=0.00, rx=0, ry=0, rz=32})
    BWOAPrepareTools.AddWorldItem(8338, 11613, -2, "Base.DumbBell", {x=0.37, y=0.22, z=0.00, rx=0, ry=0, rz=310})
    BWOAPrepareTools.AddWorldItem(8338, 11613, -2, "Base.DumbBell", {x=0.56, y=0.85, z=0.00, rx=0, ry=0, rz=95})

    BWOAPrepareTools.AddWorldItem(8334, 11612, -2, "Base.Whiskey", {x=0.63, y=0.40, z=0.23, rx=0, ry=0, rz=30})
    BWOAPrepareTools.AddWorldItem(8334, 11612, -2, "Base.HerbalistMag", {x=0.43, y=0.54, z=0.23, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8334, 11612, -2, "Base.MugWhite", {x=0.68, y=0.60, z=0.23, rx=0, ry=0, rz=215})
    BWOAPrepareTools.AddWorldItem(8335, 11610, -2, "Base.Whiskey", {x=0.34, y=0.16, z=0.00, rx=0, ry=0, rz=30})
    BWOAPrepareTools.AddWorldItem(8337, 11609, -2, "Base.MugWhite", {x=0.27, y=0.42, z=0.35, rx=0, ry=0, rz=215})
    BWOAPrepareTools.AddWorldItem(8340, 11610, -2, "Base.Magazine_Firearm_New", {x=0.45, y=0.80, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8340, 11611, -2, "Base.Magazine_Firearm_New", {x=0.65, y=0.13, z=0.00, rx=0, ry=0, rz=295})
    BWOAPrepareTools.AddWorldItem(8344, 11609, -2, "Base.CuttingBoardPlastic", {x=0.43, y=0.41, z=0.38, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8344, 11609, -2, "Base.KnifeFillet", {x=0.88, y=0.52, z=0.38, rx=0, ry=0, rz=290})
    BWOAPrepareTools.AddWorldItem(8344, 11609, -2, "Base.DeadRat", {x=0.38, y=0.41, z=0.38, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8344, 11609, -2, "Base.Smallanimalmeat", {x=0.55, y=0.54, z=0.38, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8345, 11609, -2, "Base.MeatCleaver", {x=0.05, y=0.59, z=0.38, rx=0, ry=0, rz=290})
    BWOAPrepareTools.AddWorldItem(8345, 11609, -2, "Base.Ladle", {x=0.95, y=0.54, z=0.38, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8346, 11609, -2, "Base.PotOfStew", {x=0.33, y=0.58, z=0.39, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8346, 11609, -2, "Base.Pan", {x=0.90, y=0.70, z=0.39, rx=0, ry=0, rz=220})
    BWOAPrepareTools.AddWorldItem(8343, 11613, -2, "Base.CannedPotatoOpen", {x=0.62, y=0.91, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8343, 11613, -2, "Base.TinOpener", {x=0.52, y=0.36, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8343, 11613, -2, "Base.CannedSardinesOpen", {x=0.80, y=0.30, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8343, 11613, -2, "Base.TunaTin", {x=0.80, y=0.48, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8343, 11613, -2, "Base.BeerBottle", {x=0.79, y=0.74, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8343, 11613, -2, "Base.PlasticFork", {x=0.78, y=0.91, z=0.35, rx=0, ry=0, rz=35})
    BWOAPrepareTools.AddWorldItem(8344, 11613, -2, "Base.CannedPeasOpen", {x=0.42, y=0.36, z=0.35, rx=0, ry=0, rz=100})
    BWOAPrepareTools.AddWorldItem(8344, 11613, -2, "Base.BeerEmpty", {x=0.38, y=0.52, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8344, 11613, -2, "Base.DogfoodOpen", {x=0.47, y=0.94, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8344, 11613, -2, "Base.TinCanEmpty", {x=0.64, y=0.86, z=0.35, rx=0, ry=0, rz=240})
    BWOAPrepareTools.AddWorldItem(8344, 11613, -2, "Base.BottleOpener", {x=0.38, y=0.65, z=0.35, rx=0, ry=0, rz=295})
    BWOAPrepareTools.AddWorldItem(8344, 11613, -2, "Base.BeerBottle", {x=0.74, y=0.76, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8344, 11613, -2, "Base.Fork", {x=0.63, y=0.95, z=0.35, rx=0, ry=0, rz=225})
    BWOAPrepareTools.AddWorldItem(8345, 11613, -2, "Base.DogfoodOpen", {x=0.34, y=0.38, z=0.33, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8345, 11613, -2, "Base.CigaretteSingle", {x=0.25, y=0.53, z=0.33, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8345, 11613, -2, "Base.TinCanEmpty", {x=0.54, y=0.43, z=0.33, rx=0, ry=0, rz=295})
    BWOAPrepareTools.AddWorldItem(8345, 11613, -2, "Base.TinCanEmpty", {x=0.55, y=0.60, z=0.33, rx=0, ry=0, rz=240})
    BWOAPrepareTools.AddWorldItem(8345, 11613, -2, "Base.Fork", {x=0.74, y=0.76, z=0.33, rx=0, ry=0, rz=290})
    BWOAPrepareTools.AddWorldItem(8345, 11613, -2, "Base.9mmClip", {x=0.36, y=0.77, z=0.33, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8346, 11613, -2, "Base.Bag_TrashBag", {x=0.30, y=0.70, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8346, 11613, -2, "Base.Bag_TrashBag", {x=0.48, y=0.48, z=0.00, rx=0, ry=0, rz=120})
    BWOAPrepareTools.AddWorldItem(8355, 11609, -2, "Base.ToiletPaper", {x=0.19, y=0.78, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(8355, 11609, -2, "Base.ToiletPaper", {x=0.35, y=0.90, z=0.00, rx=0, ry=0, rz=0})








end

function BWOAScenes.BanditsCar:placeCorpses()
    
end

function BWOAScenes.BanditsCar:placeVehicles()

    local vtype = "Base.SUV"

    local vehicle = addVehicle(vtype, 8318, 11636, 0)
    if not vehicle then return end

    vehicle:setGeneralPartCondition(0.8, 0)
    vehicle:setRust(100)

    for i = 0, vehicle:getPartCount() - 1 do
        local container = vehicle:getPartByIndex(i):getItemContainer()
        if container then
            container:removeAllItems()
        end
    end

    local container = vehicle:getTrunkPart():getItemContainer()
    if container then
        local item = container:AddItem("Base.PetrolCan")
        if item then
            container:addItemOnServer(item)
        end
    end

    local keySquare = getCell():getGridSquare(8337, 11610, -2)
    -- vehicle:addKeyToGloveBox()
    -- vehicle:addKeyToGloveBox()
    -- vehicle:putKeyToWorld(keySquare)

    local key = vehicle:createVehicleKey()
    key:getModData().BWOA = {}
    key:getModData().BWOA.onTaken = {}
    key:getModData().BWOA.onTaken.revealMissionId = 10
    BWOAPrepareTools.AddWorldItemSpecial(keySquare:getX(), keySquare:getY(), keySquare:getZ(), key, {x=0.5, y=0.5, z=0})

    local md = vehicle:getModData()
    md.BWOA = {}
    -- vehicle:putKeyInIgnition(vehicle:createVehicleKey())
end

function BWOAScenes.BanditsCar:populate()
    local player = getSpecificPlayer(0)

    BanditUtils.ClearZombies(8250, 8440, 11510, 11700)

    local params1 = {
        cid = Bandit.clanMap.Surface1,
        x = 8318,
        y = 11644,
        z = 0,
        program = "Roadblock",
        size = 4,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params1)

    local params2 = {
        cid = Bandit.clanMap.Surface1,
        x = 8353,
        y = 11606,
        z = -1,
        program = "Defend",
        size = 1,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params2)

    local params3 = {
        cid = Bandit.clanMap.Surface1,
        x = 8354,
        y = 11605,
        z = -1,
        program = "Defend",
        size = 1,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params3)

    local params4 = {
        cid = Bandit.clanMap.Surface1,
        x = 8341,
        y = 11610,
        z = -2,
        program = "Defend",
        size = 4,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params4)
end
