require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Hunter = BWOAScenes.Abstract:derive("BWOAScenes.Hunter")

function BWOAScenes.Hunter:placeObjects()
    local x, y, z = self.x, self.y, self.z

    BWOABuildTools.RemoveObject(9814, 12924, -1, "Freezer")
    BWOABuildTools.RemoveObject(9814, 12925, -1, "Freezer")
    BWOABuildTools.RemoveObject(9814, 12926, -1, "Freezer")
    BWOABuildTools.Generic(9816, 12926, -1, "furniture_storage_02_20")
    BWOABuildTools.Generic(9816, 12925, -1, "furniture_storage_02_21")
    BWOABuildTools.Generic(9815, 12926, -1, "furniture_storage_01_45")
    BWOABuildTools.Generic(9815, 12925, -1, "furniture_shelving_01_44")
    BWOABuildTools.Generic(9814, 12926, -1, "location_business_office_generic_01_13")
    BWOABuildTools.Generic(9814, 12925, -1, "location_business_office_generic_01_14")
    BWOABuildTools.Generic(9816, 12924, -1, "furniture_tables_high_01_27")
    BWOABuildTools.Generic(9815, 12924, -1, "furniture_tables_high_01_26")
    BWOABuildTools.Generic(9819, 12920, -1, "furniture_seating_indoor_02_24")
    BWOABuildTools.Generic(9820, 12920, -1, "furniture_seating_indoor_02_25")
    BWOABuildTools.Generic(9821, 12922, -1, "furniture_tables_high_01_55")
    BWOABuildTools.Generic(9821, 12923, -1, "furniture_tables_high_01_54")
    

    -- ammo locker
    -- bookshelf
    -- throfies
    -- placed traps
end

function BWOAScenes.Hunter:placeItems()
    local x, y, z = self.x, self.y, self.z

    BWOAPrepareTools.AddWorldItem(9818, 12922, -1, "Base.BucketEmpty", {x=0.75, y=0.72, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9821, 12922, -1, "Base.BookTrappingSet", {x=0.50, y=0.62, z=0.29, rx=0, ry=0, rz=95})
    BWOAPrepareTools.AddWorldItem(9820, 12920, -1, "Base.Sheet", {x=0.33, y=0.67, z=0.21, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9819, 12920, -1, "Base.Pillow", {x=0.48, y=0.68, z=0.21, rx=0, ry=0, rz=90})
    BWOAPrepareTools.AddWorldItem(9819, 12920, -1, "Base.Sheet", {x=0.90, y=0.70, z=0.21, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9819, 12921, -1, "Base.BookFancy_MilitaryHistory", {x=0.66, y=0.25, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9818, 12920, -1, "Base.BeerEmpty", {x=0.91, y=0.90, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9818, 12920, -1, "Base.BeerEmpty", {x=0.77, y=0.66, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9818, 12920, -1, "Base.BeerEmpty", {x=0.66, y=1.00, z=0.03, rx=96, ry=0, rz=123})
    BWOAPrepareTools.AddWorldItem(9818, 12920, -1, "Base.HuntingRifle", {x=0.45, y=0.25, z=0.19, rx=111, ry=0, rz=95})
    BWOAPrepareTools.AddWorldItem(9818, 12921, -1, "Base.Crowbar", {x=0.26, y=0.50, z=0.00, rx=0, ry=0, rz=350})
    BWOAPrepareTools.AddWorldItem(9817, 12921, -1, "Base.BeerEmpty", {x=0.62, y=0.26, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9817, 12921, -1, "Base.BeerEmpty", {x=0.38, y=0.25, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9821, 12923, -1, "Base.SurvivalSchematic", {x=0.38, y=0.37, z=0.29, rx=0, ry=0, rz=85})
    BWOAPrepareTools.AddWorldItem(9821, 12923, -1, "Base.SurvivalSchematic", {x=0.45, y=0.45, z=0.29, rx=0, ry=0, rz=300})
    BWOAPrepareTools.AddWorldItem(9821, 12921, -1, "Base.HuntingMag4", {x=0.49, y=0.29, z=0.29, rx=0, ry=0, rz=345})
    BWOAPrepareTools.AddWorldItem(9821, 12921, -1, "Base.BookForaging3", {x=0.59, y=0.31, z=0.29, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9821, 12921, -1, "Base.BookForaging4", {x=0.41, y=0.31, z=0.29, rx=0, ry=0, rz=325})
    BWOAPrepareTools.AddWorldItem(9821, 12921, -1, "Base.BookForaging5", {x=0.70, y=0.30, z=0.29, rx=0, ry=0, rz=20})

    local items = {["Base.JarLid"] = 33, ["Base.EmptyJar"] = 33}
    BWOAPrepareTools.AddItemsToContainer(9815, 12920, -1, items, "Shelves")

    items = {["Base.JarLid"] = 13, ["Base.EmptyJar"] = 17}
    BWOAPrepareTools.AddItemsToContainer(9816, 12920, -1, items, "Shelves")

    items = {["Base.PopEmpty"] = 12, ["Base.PopEmpty2"] = 12, ["Base.PopEmpty3"] = 12}
    BWOAPrepareTools.AddItemsToContainer(9817, 12920, -1, items, "Green Garbage Bin")

    local mediaRecorder = ZomboidRadio.getInstance():getRecordedMedia()
    local item = BanditCompatibility.InstanceItem("Base.VHS_Retail")
    local mediaData = mediaRecorder:getMediaData("75928dcd-c613-4a1e-afb5-20c4c671b835") -- Exposure Survival E6)
    item:setRecordedMediaData(mediaData)
    BWOAPrepareTools.AddWorldItemSpecial(9821, 12923, -1, item, {x=0.40, y=0.05, z=0.29, rx=0, ry=0, rz=30})

    -- trapping books
    -- hunting mags
    -- tent
    -- hunting rifle and ammo
    -- traps as items
    -- exposure survival 6
    -- Base.SurvivalSchematic
    -- hunter note
end

function BWOAScenes.Hunter:placeCorpses()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Hunter:placeVehicles()
    
end

function BWOAScenes.Hunter:populate()
    local player = getSpecificPlayer(0)
end
