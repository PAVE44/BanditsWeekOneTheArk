BWOARooms = BWOARooms or {}

BWOARooms.BedroomMale = {}

BWOARooms.BedroomMale.Init = function ()
    BWOARooms.BedroomMale.name = "BEDROOM_ONE"
    BWOARooms.BedroomMale.x1 = 9944
    BWOARooms.BedroomMale.x2 = 9956
    BWOARooms.BedroomMale.y1 = 12636
    BWOARooms.BedroomMale.y2 = 12642
    BWOARooms.BedroomMale.z = -4
    BWOARooms.BedroomMale.ambience = ""

    BWOARooms.BedroomMale.vents = {
        {x=9944, y=12636.5, z=-4},
    }

    BWOARooms.BedroomMale.els = {}
    for x=9944, 9956 do
        table.insert(BWOARooms.BedroomMale.els, {dir="S", x=x, y=12642, z=-4})
        table.insert(BWOARooms.BedroomMale.els, {dir="N", x=x, y=12636, z=-4})
    end

    for y=12636, 12642 do
        table.insert(BWOARooms.BedroomMale.els, {dir="W", x=9944, y=y, z=-4})
        if y ~= 12639 then
            table.insert(BWOARooms.BedroomMale.els, {dir="E", x=9956, y=y, z=-4})
        end
    end
end

BWOARooms.BedroomMale.Build = function ()

    BWOARooms.BedroomMale.Init()

    BWOAPrepareTools.DarkenLight(9956, 12640, -4)

    BWOABuildTools.ELS(BWOARooms.BedroomMale.els)

    BWOABuildTools.LampOvalN(9945, 12636, -4)
    BWOABuildTools.LampOvalN(9952, 12636, -4)
    BWOABuildTools.LampOvalS(9945, 12642, -4)
    BWOABuildTools.LampOvalS(9952, 12642, -4)

    for x=BWOARooms.BedroomMale.x1, BWOARooms.BedroomMale.x2 do
        for y=BWOARooms.BedroomMale.y1, BWOARooms.BedroomMale.y2 do
            BWOABuildTools.RemoveObject(x, y, -4, "Beds")
        end
    end

    BWOABuildTools.VentN(9944, 12636, -4)

    for x = 9947, 9955, 2 do
        BWOABuildTools.Generic(x, 12636, -4, "furniture_bedding_01_1")
        BWOABuildTools.Generic(x, 12637, -4, "furniture_bedding_01_0")

        BWOABuildTools.Generic(x, 12641, -4, "furniture_bedding_01_69")
        BWOABuildTools.Generic(x, 12642, -4, "furniture_bedding_01_68")
    end

    for x = 9948, 9956, 2 do
        BWOABuildTools.Generic(x, 12636, -4, "furniture_storage_01_33")
        BWOABuildTools.Generic(x, 12642, -4, "furniture_storage_01_35")
    end
    BWOABuildTools.Generic(9956, 12636, -4, "vegetation_indoor_01_1")

    BWOABuildTools.Generic(9946, 12636, -4, "walls_decoration_02_23")
    BWOABuildTools.Generic(9948, 12636, -4, "walls_decoration_02_70")
    BWOABuildTools.Generic(9950, 12636, -4, "walls_decoration_02_67")
    BWOABuildTools.Generic(9954, 12636, -4, "walls_decoration_02_86")
    BWOABuildTools.Generic(9956, 12636, -4, "walls_decoration_01_48")

end

BWOARooms.BedroomMale.SetEmitters = function ()
    BWOARooms.BedroomMale.Init()
    -- BWOASound.AddToObject({x=9948, y=12605, z=-4, sound="AmbientWaterDrops"})
end

BWOARooms.BedroomMale.SetFlickers = function ()
    BWOARooms.BedroomMale.Init()
    BWOALights.AddFlicker({x=9945, y=12636, z=-4})
end

BWOARooms.BedroomMale.Prepare = function ()
    BWOARooms.BedroomMale.Init()

    -- lockers
    local items

    items = {["Base.Boilersuit_Flying"] = 1, ["Base.Briefs_White"] = 6, ["Base.Vest_DefaultTEXTURE"] = 4, ["Base.Tshirt_WhiteTINT"] = 5, ["Base.Shoes_Black"] = 1}
    BWOAPrepareTools.AddItemsToContainer(9944, 12637, -4, items, "Locker")

    items = {["Base.Boilersuit_Flying"] = 1, ["Base.Briefs_White"] = 6, ["Base.Vest_DefaultTEXTURE"] = 4, ["Base.Tshirt_WhiteTINT"] = 5, ["Base.Shoes_Black"] = 1}
    BWOAPrepareTools.AddItemsToContainer(9944, 12638, -4, items, "Locker")

    items = {["Base.Underpants_White"] = 6, ["Base.Vest_DefaultTEXTURE"] = 4, ["Base.Tshirt_WhiteTINT"] = 4, ["Base.Shoes_Black"] = 1}
    BWOAPrepareTools.AddItemsToContainer(9944, 12639, -4, items, "Locker")

    items = {["Base.Boilersuit_Flying"] = 1, ["Base.Briefs_White"] = 6, ["Base.Vest_DefaultTEXTURE"] = 3, ["Base.Tshirt_WhiteTINT"] = 2, ["Base.Shoes_Black"] = 1}
    BWOAPrepareTools.AddItemsToContainer(9944, 12640, -4, items, "Locker")

    items = {["Base.Boilersuit_Flying"] = 1, ["Base.Briefs_White"] = 6, ["Base.Vest_DefaultTEXTURE"] = 2, ["Base.Tshirt_WhiteTINT"] = 4, ["Base.Shoes_Black"] = 1}
    BWOAPrepareTools.AddItemsToContainer(9944, 12641, -4, items, "Locker")

    -- pillows
    for _, y in pairs({12636, 12642}) do
        for _, x in pairs({9947, 9949, 9951, 9952, 9955}) do 
            BWOAPrepareTools.AddWorldItem(x, y, -4, "Base.Pillow", {x=0.5, y=0.5, z=0.3})
        end
    end

    -- bed magazines
    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.MagazineWordsearch", {x=0.5, y=0.5, z=0.3})
    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.Pencil", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.SheetPaper2", {x=0.5, y=0.5, z=0.3})
    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.Crayons", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9951, 12637, -4, "Base.HottieZ_New", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9951, 12637, -4, "Base.Notebook", {x=0.5, y=0.5, z=0.3})
    BWOAPrepareTools.AddWorldItem(9951, 12637, -4, "Base.Pencil", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9955, 12637, -4, "Base.Magazine", {x=0.5, y=0.5, z=0.3})
    BWOAPrepareTools.AddWorldItem(9955, 12637, -4, "Base.Magazine", {x=0.5, y=0.5, z=0.3})

    -- table items
    BWOAPrepareTools.AddWorldItem(9948, 12636, -4, "Base.MugWhite", {x=0.4, y=0.7, z=0.36})
    BWOAPrepareTools.AddWorldItem(9948, 12636, -4, "Base.CaseyPic", {x=0.5, y=0.4, z=0.36, rz=0})

    BWOAPrepareTools.AddWorldItem(9950, 12636, -4, "Base.ChessWhite", {x=0.4, y=0.4, z=0.36})
    BWOAPrepareTools.AddWorldItem(9950, 12636, -4, "Base.ChessBlack", {x=0.6, y=0.6, z=0.36})

    BWOAPrepareTools.AddWorldItem(9952, 12636, -4, "Base.Book", {x=0.5, y=0.6, z=0.36})

    BWOAPrepareTools.AddWorldItem(9954, 12636, -4, "Base.MugWhite", {x=0.4, y=0.4, z=0.36})
    BWOAPrepareTools.AddWorldItem(9954, 12636, -4, "Base.Pen", {x=0.6, y=0.6, z=0.36})
    BWOAPrepareTools.AddWorldItem(9954, 12636, -4, "Base.MagazineWordsearch", {x=0.5, y=0.5, z=0.36})

    BWOAPrepareTools.AddWorldItem(9956, 12636, -4, "Base.Cube", {x=0.62, y=0.55, z=0.36})
    BWOAPrepareTools.AddWorldItem(9956, 12636, -4, "Base.Cube", {x=0.74, y=0.59, z=0.36})
    BWOAPrepareTools.AddWorldItem(9956, 12636, -4, "Base.Pills", {x=0.66, y=0.64, z=0.36})

    
    BWOAPrepareTools.AddWorldItem(9948, 12642, -4, "Base.MugWhite", {x=0.4, y=0.7, z=0.36})
    BWOAPrepareTools.AddWorldItem(9948, 12642, -4, "Base.PillsSleepingTablets", {x=0.5, y=0.4, z=0.36, rz=0})

    BWOAPrepareTools.AddWorldItem(9950, 12642, -4, "Base.Glasses_Normal", {x=0.4, y=0.4, z=0.36})
    BWOAPrepareTools.AddWorldItem(9950, 12642, -4, "Base.Book", {x=0.6, y=0.6, z=0.36})

    BWOAPrepareTools.AddWorldItem(9952, 12642, -4, "Base.ToyCar", {x=0.4, y=0.5, z=0.36, rz = 60})
    BWOAPrepareTools.AddWorldItem(9952, 12642, -4, "Base.ToyCar", {x=0.5, y=0.5, z=0.36, rz = 60})
    BWOAPrepareTools.AddWorldItem(9952, 12642, -4, "Base.ToyCar", {x=0.6, y=0.5, z=0.36, rz = 60})

    BWOAPrepareTools.AddWorldItem(9954, 12642, -4, "Base.Pencil", {x=0.4, y=0.4, z=0.36})
    BWOAPrepareTools.AddWorldItem(9954, 12642, -4, "Base.MagazineWordsearch", {x=0.6, y=0.6, z=0.36})
    BWOAPrepareTools.AddWorldItem(9954, 12642, -4, "Base.MagazineWordsearch", {x=0.5, y=0.5, z=0.36})

    BWOAPrepareTools.AddWorldItem(9956, 12642, -4, "Base.Pencil", {x=0.62, y=0.55, z=0.3})
    BWOAPrepareTools.AddWorldItem(9956, 12642, -4, "Base.TissueBox", {x=0.74, y=0.59, z=0.3})
    BWOAPrepareTools.AddWorldItem(9956, 12642, -4, "Base.Pills", {x=0.66, y=0.64, z=0.3})

    -- drawers

    local healthEffectsRadiation = BanditCompatibility.InstanceItem("Base.Book")
    healthEffectsRadiation:setCanBeWrite(false)
    healthEffectsRadiation:setName("Summary of Health Effects of Ionizing Radiation by ATSDR")
    local md = healthEffectsRadiation:getModData()
    md.printContent = "health_effects_radiation"
    local x = BanditUtils.Choice({9948, 9950, 9952, 9954, 9956})
    local y = BanditUtils.Choice({12642, 12636})
    BWOAPrepareTools.AddItemsToContainer(9948, 12642, -4, {healthEffectsRadiation}, "Drawers")

    -- others
    BWOAPrepareTools.AddWorldItem(9945, 12636, -4, "Base.GuitarAcoustic", {x=0.5, y=0.27, z=0.18, rx=0, ry=295, rz=90})

end


