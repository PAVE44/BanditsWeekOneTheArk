require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.FamilyHouse = BWOAScenes.Abstract:derive("BWOAScenes.FamilyHouse")

function BWOAScenes.FamilyHouse:placeObjects()
    BWOABuildTools.Generator(18010, 3410, -6, 100, 100, true, true, true)

    local data = {r = 255, g = 80, b = 20, d=4}
    BWOABuildTools.LampCustom(18013, 3412, -5, "lighting_outdoor_01_26", data)
    BWOABuildTools.LampCustom(18009, 3413, -5, "lighting_indoor_01_58", data)
    BWOABuildTools.LampCustom(18012, 3406, -5, "lighting_indoor_01_17", data)
    BWOABuildTools.LampCustom(18006, 3407, -4, "lighting_indoor_01_16", data)
    BWOABuildTools.LampCustom(18010, 3406, -4, "lighting_indoor_01_12", data)
    BWOABuildTools.LampCustom(18006, 3410, -4, "lighting_indoor_01_11", data)
    BWOABuildTools.LampCustom(18012, 3406, -4, "lighting_indoor_02_19", data)

    BWOABuildTools.WasherDryer(18010, 3413, -4, "appliances_laundry_01_3", true)
    BWOABuildTools.TV(18010, 3413, -5, "appliances_television_01_6", {active=true})

end

function BWOAScenes.FamilyHouse:placeItems()
    -- BWOAPrepareTools.AddWorldItem(18005, 3203, -3, "Base.Roses", {x=0.61, y=0.14, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.BloodSplat(18011,3410,-4)
    BWOAPrepareTools.BloodSplat(18012,3410,-4)
    BWOAPrepareTools.BloodSplat(18012,3409,-4)
    BWOAPrepareTools.BloodSplat(18012,3408,-4)
end

function BWOAScenes.FamilyHouse:placeCorpses()
    -- RJ
    local clothing = {
        {bl = ItemBodyLocation.SHORTS_SHORT, itemType = "Base.Shorts_ShortSport"},
        {bl = ItemBodyLocation.TANK_TOP, itemType = "Base.Vest_DefaultTEXTURE_TINT"},
    }

    local inventory = {
        "Base.ToyPlane",
    }

    BWOAPrepareTools.AddHumanCorpseDetail(18012.6, 3410, -4, false, clothing, inventory)
end

function BWOAScenes.FamilyHouse:placeVehicles()
end

function BWOAScenes.FamilyHouse:populate()
    local player = getSpecificPlayer(0)
    BanditUtils.ClearZombies(18000, 18020, 3400, 3420)

    local params1 = {
        cid = Bandit.clanMap.Kate,
        x = 18009,
        y = 3412,
        z = -4,
        program = "Bandit",
        size = 1,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params1)

    local params2 = {
        cid = Bandit.clanMap.Murderers,
        x = 18009,
        y = 3408,
        z = -4,
        program = "Bandit",
        size = 4,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params2)
end
