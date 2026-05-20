require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Farmer = BWOAScenes.Abstract:derive("BWOAScenes.Farmer")

function BWOAScenes.Farmer:placeObjects()
    local x, y, z = self.x, self.y, self.z

    -- bookshelf

end

function BWOAScenes.Farmer:placeItems()
    local x, y, z = self.x, self.y, self.z

    local notebook = BanditCompatibility.InstanceItem("Bandits.NoteBook")
    notebook:setCanBeWrite(false)
    notebook:setName(getText("IGUI_Artifact_FarmingDiary"))
    local md = notebook:getModData()
    md.printContent = "notebook_farmer"
    BWOAPrepareTools.AddWorldItemSpecial(8341, 11751, -1, notebook, {x=0.33, y=0.89, z=0, rx=0, ry=0, rz=270})
    BWOAPrepareTools.AddWorldItem(8341, 11751, -1, "Base.Pencil", {x=0.37, y=0.79, z=0, rx=0, ry=0, rz=40})

    local items
    items = {
        ["Base.BookFarming1"] = 12, ["Base.BookFarming2"] = 8, ["Base.BookFarming3"] = 1, ["Base.BookFarming4"] = 1,
        ["Base.BookFarming5"] = 1, ["Base.FarmingMag1"] = 1, ["Base.FarmingMag2"] = 1, ["Base.FarmingMag3"] = 1, ["Base.FarmingMag4"] = 1,
        ["Base.FarmingMag5"] = 1, ["Base.FarmingMag6"] = 1, ["Base.FarmingMag7"] = 1, ["Base.FarmingMag8"] = 1, ["Base.Book_Farming"] = 12, 
    }
    BWOAPrepareTools.AddItemsToContainer(8336, 11748, -1, items, "Locker")

    items = {
        ["Base.ZucchiniBagSeed"] = 1,
        ["Base.WheatBagSeed"] = 1,
        ["Base.WatermelonBagSeed"] = 1,
        ["Base.TurnipBagSeed"] = 1,
        ["Base.TomatoBagSeed"] = 1,
        ["Base.CarrotBagSeed2"] = 1,
        ["Base.CauliflowerBagSeed"] = 1,
        ["Base.SweetPotatoBagSeed"] = 1,
        ["Base.SugarBeetBagSeed"] = 1,
        ["Base.SpinachBagSeed"] = 1,
        ["Base.SoybeansBagSeed"] = 1,
        ["Base.RyeBagSeed"] = 1,
        ["Base.RedRadishBagSeed"] = 1,
        ["Base.PoppyBagSeed"] = 1,
        ["Base.HopsBagSeed"] = 1,
        ["Base.JalapenoBagSeed"] = 1,
        ["Base.KaleBagSeed"] = 1,
        ["Base.LavenderBagSeed"] = 1,
        ["Base.LeekBagSeed"] = 1,
        ["Base.LemonGrassBagSeed"] = 1,
        ["Base.LettuceBagSeed"] = 1,
        ["Base.MarigoldBagSeed"] = 1,
        ["Base.MintBagSeed"] = 1,
        ["Base.OnionBagSeed"] = 1,
        ["Base.OreganoBagSeed"] = 1,
        ["Base.ParsleyBagSeed"] = 1,
        ["Base.PotatoBagSeed2"] = 1,
        ["Base.PumpkinBagSeed"] = 1,
        ["Base.HempBagSeed"] = 1,
    }
    BWOAPrepareTools.AddItemsToContainer(8336, 11747, -1, items, "Shelves")
end

function BWOAScenes.Farmer:placeCorpses()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Farmer:placeVehicles()
    
end

function BWOAScenes.Farmer:populate()
    local player = getSpecificPlayer(0)
end
