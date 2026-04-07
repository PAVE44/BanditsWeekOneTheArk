require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Dave = BWOAScenes.Abstract:derive("BWOAScenes.Dave")

function BWOAScenes.Dave:placeObjects()
    local x, y, z = self.x, self.y, self.z
   
    local campfireCoords = {x = x, y = y + 1, z = z}
    BWOABuildTools.Generic(campfireCoords.x, campfireCoords.y, campfireCoords.z, "camping_01_6")
end

function BWOAScenes.Dave:placeItems()
    local x, y, z = self.x, self.y, self.z
    
    local seedsCoords = {x = x, y = y - 1, z = z}

    local seedsItems = {
        "Base.BasilBagSeed",
        "Base.BellPepperBagSeed",
        "Base.BarleyBagSeed",
        "Base.BroccoliBagSeed2",
        "Base.CabbageBagSeed2",
        "Base.CarrotBagSeed2",
        "Base.CauliflowerBagSeed",
        "Base.CilantroBagSeed",
        "Base.CornBagSeed",
        "Base.CucumberBagSeed",
        "Base.FlaxBagSeed",
        "Base.GarlicBagSeed",
        "Base.GreenpeasBagSeed",
        "Base.HabaneroBagSeed",
        "Base.HopsBagSeed",
        "Base.JalapenoBagSeed",
        "Base.KaleBagSeed",
        "Base.LavenderBagSeed",
        "Base.LeekBagSeed",
        "Base.LemonGrassBagSeed",
        "Base.LettuceBagSeed",
        "Base.MarigoldBagSeed",
        "Base.MintBagSeed",
        "Base.OnionBagSeed",
        "Base.OreganoBagSeed",
        "Base.ParsleyBagSeed",
        "Base.PoppyBagSeed",
        "Base.PotatoBagSeed2",
        "Base.PumpkinBagSeed",
    }

    local bag = BanditCompatibility.InstanceItem("Base.Bag_ProtectiveCase")
    bag:getModData().BWOA = {}
    bag:getModData().BWOA.onTaken = {}
    bag:getModData().BWOA.onTaken.accomplishMissionId = 8

    local container = bag:getItemContainer()
    for _, itemType in ipairs(seedsItems) do
        local item = BanditCompatibility.InstanceItem(itemType)
        container:AddItem(item)
    end
    BWOAPrepareTools.AddWorldItemSpecial(seedsCoords.x, seedsCoords.y, seedsCoords.z, bag)

end

function BWOAScenes.Dave:placeCorpses()
    local x, y, z = self.x, self.y, self.z
    
    local daveCoords = {x = x, y = y, z = z}

    local daveClothing = {
        {bl = ItemBodyLocation.MASK_EYES, itemType = "Base.Hat_GasMask"},
        {bl = ItemBodyLocation.SCARF, itemType = "Base.Scarf_White"},
        {bl = ItemBodyLocation.BOILERSUIT, itemType = "Base.HazmatSuitCamo"},
        {bl = ItemBodyLocation.TORSO1LEGS1, itemType = "Base.LongJohns"},
        {bl = ItemBodyLocation.TANK_TOP, itemType = "Base.Vest_DefaultTEXTURE_TINT"},
        {bl = ItemBodyLocation.TSHIRT, itemType = "Base.Tshirt_WhiteLongSleeve"},
        {bl = ItemBodyLocation.SHIRT, itemType = "Base.Shirt_Denim"},
        {bl = ItemBodyLocation.HANDS, itemType = "Base.Gloves_LeatherGlovesBlack"},
        {bl = ItemBodyLocation.BELT_EXTRA, itemType = "Base.HolsterSimple_Brown"},
        {bl = ItemBodyLocation.SOCKS, itemType = "Base.Socks_Long_Black"},
        {bl = ItemBodyLocation.SHOES, itemType = "Base.Shoes_ArmyBoots"},
    }

    local daveInventory = {
        "Base.Crowbar",
        "Base.Pistol",
        "Base.9mmClip",
        "Base.9mmClip",
        "Base.9mmClip",
        "Base.GasmaskFilter",
        "Base.GasmaskFilter",
    }

    BWOAPrepareTools.AddHumanCorpseDetail(daveCoords.x, daveCoords.y, daveCoords.z, false, daveClothing, daveInventory)

    local marthaCoords = {x = x + 1, y = y, z = z}

    local mathaClothing = {
        {bl = ItemBodyLocation.MASK_EYES, itemType = "Base.Hat_GasMask"},
        {bl = ItemBodyLocation.SCARF, itemType = "Base.Scarf_White"},
        {bl = ItemBodyLocation.BOILERSUIT, itemType = "Base.HazmatSuitCamo"},
        {bl = ItemBodyLocation.TORSO1LEGS1, itemType = "Base.LongJohns"},
        {bl = ItemBodyLocation.TANK_TOP, itemType = "Base.Vest_DefaultTEXTURE_TINT"},
        {bl = ItemBodyLocation.TSHIRT, itemType = "Base.Tshirt_WhiteLongSleeve"},
        {bl = ItemBodyLocation.SHIRT, itemType = "Base.Shirt_Denim"},
        {bl = ItemBodyLocation.HANDS, itemType = "Base.Gloves_LeatherGlovesBlack"},
        {bl = ItemBodyLocation.BELT_EXTRA, itemType = "Base.HolsterSimple_Brown"},
        {bl = ItemBodyLocation.SOCKS, itemType = "Base.Socks_Long_Black"},
        {bl = ItemBodyLocation.SHOES, itemType = "Base.Shoes_ArmyBoots"},
    }

    local mathaInventory = {
        "Base.Pistol",
        "Base.9mmClip",
        "Base.9mmClip",
        "Base.GasmaskFilter",
        "Base.HandShovel",
    }

    BWOAPrepareTools.AddHumanCorpseDetail(marthaCoords.x, marthaCoords.y, marthaCoords.z, true, mathaClothing, mathaInventory)
end

function BWOAScenes.Dave:placeVehicles()
    
end

function BWOAScenes.Dave:populate()

end
