require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Doc = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Doc:placeObjects()
    local x, y, z = self.x, self.y, self.z

    -- injection room
    BWOABuildTools.RemoveObject(10861, 10038, -1, "Table")
    BWOABuildTools.RemoveObject(10862, 10038, -1, "Table")
    BWOABuildTools.RemoveObject(10864, 10038, -1, "Drawers")
    BWOABuildTools.RemoveObject(10861, 10040, -1, "Bed")
    BWOABuildTools.RemoveObject(10864, 10041, -1, "Bed")
    BWOABuildTools.RemoveObject(10862, 10041, -1, "Table")

    BWOABuildTools.Generic(10862, 10039, -1, "location_community_medical_01_1") -- bed
    BWOABuildTools.Generic(10862, 10040, -1, "location_community_medical_01_0")
    BWOABuildTools.Generic(10861, 10041, -1, "location_community_medical_01_8") -- scale
    BWOABuildTools.Generic(10861, 10039, -1, "location_community_medical_01_26") -- drip
    BWOABuildTools.Generic(10863, 10039, -1, "location_community_medical_01_50") -- counter
    BWOABuildTools.Generic(10864, 10038, -1, "furniture_storage_02_0")

    -- storage room
    BWOABuildTools.RemoveObject(10865, 10045, -1, "Door")
    BWOABuildTools.RemoveObject(10865, 10044, -1, "Shelves")
    BWOABuildTools.RemoveObject(10866, 10044, -1, "Shelves")

    BWOABuildTools.Generic(10865, 10042, -1, "walls_exterior_wooden_01_24") -- WALL
    BWOABuildTools.Generic(10865, 10043, -1, "walls_exterior_wooden_01_24") -- WALL


    BWOABuildTools.Door (10865, 10045, -1, false, "fixtures_doors_01_32", true)
    BWOABuildTools.Fridge(10865, 10044, -1)
    BWOABuildTools.Fridge(10866, 10044, -1)
end

function BWOAScenes.Doc:placeItems()
    local x, y, z = self.x, self.y, self.z

    local items
    items = {
        ["Base.JacketLong_Doctor"] = 4, 
        ["Base.Gloves_Surgical"] = 33, 
        ["Base.Hat_SurgicalCap"] = 14, 
        ["Base.Hat_SurgicalMask"] = 35, 
    }
    BWOAPrepareTools.AddItemsToContainer(10864, 10038, -1, items, "Locker")


    -- main room
    items = {
        ["Base.Paperwork"] = 14, 
        ["Base.Paperback_Medical"] = 11,
    }
    BWOAPrepareTools.AddItemsToContainer(10868, 10036, -1, items, "Shelves")

    local note = BanditCompatibility.InstanceItem("Bandits.Note")
    note:setCanBeWrite(false)
    note:setName("Dr. Andrew Cortman's Note")
    local md = note:getModData()
    md.printContent = "doc_note"
    md.BWOA = {}
    md.BWOA.onTaken = {}
    md.BWOA.onTaken.revealDialogueId = "2000.6.4.1.1"
    md.BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"

    BWOAPrepareTools.AddItemsToContainer(10868, 10036, -1, {note}, "Shelves", true)

    local preserve = false
    for i=1, 6 do
        local syringe = BanditCompatibility.InstanceItem("Bandits.LabSyringe")
        local md = syringe:getModData()
        md.BWOA = {}
        md.BWOA.onTaken = {}
        md.BWOA.onTaken.accomplishMissionId = 111
        md.BWOA.onTaken.revealMissionId = 112
        md.BWOA.onTaken.revealDialogueId = "2000.6.4.1.2"
        md.BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"
        md.BWOA.onDropArea = {}
        md.BWOA.onDropArea.x1 = 9959
        md.BWOA.onDropArea.y1 = 12636
        md.BWOA.onDropArea.x2 = 9965
        md.BWOA.onDropArea.y2 = 12640
        md.BWOA.onDropArea.accomplishMissionId = 113

        BWOAPrepareTools.AddItemsToContainer(10865, 10044, -1, {syringe}, "Fridge", preserve)
        preserve = true
    end

    -- items = {["Bandits.LabSyringe"] = 5}
    -- BWOAPrepareTools.AddItemsToContainer(10866, 10044, -1, items, "Fridge")
end

function BWOAScenes.Doc:placeCorpses()
    local x, y, z = self.x, self.y, self.z

    local clothing = {
        {bl = ItemBodyLocation.PANTS, itemType = "Base.Trousers_Suit"},
        {bl = ItemBodyLocation.TANK_TOP, itemType = "Base.Vest_DefaultTEXTURE_TINT"},
        {bl = ItemBodyLocation.SHIRT, itemType = "Base.Shirt_FormalWhite"},
        {bl = ItemBodyLocation.SOCKS, itemType = "Base.Socks_Ankle"},
        {bl = ItemBodyLocation.SHOES, itemType = "Base.Shoes_Black"},
        {bl = ItemBodyLocation.JACKET_SUIT, itemType = "Base.JacketLong_Doctor"},
        
    }

    local inventory = {
        "Base.PillsAntiDep",
        "Base.PillsAntiDep",
        "Base.Revolver_Short",
        "Base.Bullets38",
        "Base.CigarettePack",
        "Base.Lighter",
    }

    BWOAPrepareTools.AddHumanCorpseDetail(10862, 10035, -1, false, clothing, inventory)
end

function BWOAScenes.Doc:placeVehicles()
    

end

function BWOAScenes.Doc:populate()
    local player = getSpecificPlayer(0)
end
