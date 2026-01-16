require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Dave = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

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
    bag:getModData().BWOA.accomplishMissionId = 8

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
        ["MaskEyes"] = "Base.Hat_GasMask",
        ["Scarf"] = "Base.Scarf_White",
        ["Boilersuit"] = "Base.HazmatSuitCamo",
        ["Torso1Legs1"] = "Base.LongJohns",
        ["TankTop"] = "Base.Vest_DefaultTEXTURE_TINT",
        ["Tshirt"] = "Base.Tshirt_WhiteLongSleeve",
        ["Shirt"] = "Base.Shirt_Denim",
        ["Hands"] = "Base.Gloves_LeatherGlovesBlack",
        ["BeltExtra"] = "Base.HolsterSimple_Brown",
        ["Socks"] = "Base.Socks_Long_Black",
        ["Shoes"] = "Base.Shoes_ArmyBoots",
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
        ["MaskEyes"] = "Base.Hat_GasMask",
        ["Scarf"] = "Base.Scarf_White",
        ["Boilersuit"] = "Base.HazmatSuitCamo",
        ["Torso1Legs1"] = "Base.LongJohns",
        ["TankTop"] = "Base.Vest_DefaultTEXTURE_TINT",
        ["Tshirt"] = "Base.Tshirt_WhiteLongSleeve",
        ["Shirt"] = "Base.Shirt_Denim",
        ["Hands"] = "Base.Gloves_LeatherGlovesBlack",
        ["BeltExtra"] = "Base.HolsterSimple_Brown",
        ["Socks"] = "Base.Socks_Long_Black",
        ["Shoes"] = "Base.Shoes_ArmyBoots",
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
