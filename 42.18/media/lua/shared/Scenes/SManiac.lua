require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Maniac = BWOAScenes.Abstract:derive("BWOAScenes.Maniac")

function BWOAScenes.Maniac:placeObjects()
    -- BWOABuildTools.Generator(8340, 11610, 0, 50 + ZombRand(30), 18 + ZombRand(40), true, true)
end

function BWOAScenes.Maniac:placeItems()
    
    local items
    items = {
        ["Base.ShotgunShells"] = 6, ["Base.Dogfood"] = 7, ["Base.BandageDirty"] = 1, ["Base.RippedSheetsDirty"] = 3,
        ["Base.LargeKnife"] = 1, ["Base.Whetstone"] = 1, ["Base.HerbalistMag"] = 1, ["Base.Rope"] = 2, ["Bandits.HumanMeat"] = 2
    }
    BWOAPrepareTools.AddItemsToContainer(10110, 11185, -2, items, "Locker")
    
    BWOAPrepareTools.AddWorldItem(10110, 11183, -2, "Base.DoubleBarrelShotgun", {x=0.12, y=0.11, z=0.23, rx=180, ry=257, rz=0})
    BWOAPrepareTools.AddWorldItem(10111, 11185, -2, "Base.Shovel2", {x=0.52, y=0.30, z=0.23, rx=338, ry=306, rz=87})
    BWOAPrepareTools.AddWorldItem(10111, 11186, -2, "Base.ToiletPaper", {x=0.20, y=0.23, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(10117, 11183, -2, "Base.Bucket", {x=0.52, y=0.76, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(10117, 11186, -2, "Base.Bucket", {x=0.36, y=0.27, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(10111, 11182, -2, "Base.HottieZ_New", {x=0.41, y=0.74, z=0.25, rx=0, ry=0, rz=325})
    BWOAPrepareTools.AddWorldItem(10112, 11182, -2, "Base.Lantern_Hurricane", {x=0.65, y=0.66, z=0.38, rx=0, ry=0, rz=0})
end


function BWOAScenes.Maniac:placeCorpses()
    local clothing = {
        {bl = ItemBodyLocation.PANTS, itemType = "Base.Trousers_Denim"},
        {bl = ItemBodyLocation.TANK_TOP, itemType = "Base.Vest_DefaultTEXTURE_TINT"},
        {bl = ItemBodyLocation.TSHIRT, itemType = "Base.Tshirt_WhiteTINT"},
        {bl = ItemBodyLocation.SHIRT, itemType = "Base.Shirt_Denim"},
        {bl = ItemBodyLocation.SOCKS, itemType = "Base.Socks_Ankle"},
        {bl = ItemBodyLocation.SHOES, itemType = "Base.Shoes_TrainerTINT"},
    }

    local inventory = {}

    BWOAPrepareTools.AddHumanCorpseDetail(10117, 11183, -2, false, clothing, inventory)
end

function BWOAScenes.Maniac:placeVehicles()
end

function BWOAScenes.Maniac:populate()
    local player = getSpecificPlayer(0)

    BanditUtils.ClearZombies(10105, 10125, 11170, 11195)

    local params1 = {
        cid = Bandit.clanMap.BasementCannibals,
        x = 10111,
        y = 11183,
        z = -2,
        program = "Defend",
        size = 1,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params1)
end
