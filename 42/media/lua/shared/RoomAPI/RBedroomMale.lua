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
end

BWOARooms.BedroomMale.Build = function ()
    BWOABuildTools.LampOvalN(9945, 12636, -4)
    BWOABuildTools.LampOvalN(9952, 12636, -4)
    BWOABuildTools.LampOvalS(9945, 12642, -4)
    BWOABuildTools.LampOvalS(9952, 12642, -4)

    BWOABuildTools.Generic(9946, 12636, -4, "walls_decoration_02_23")
    BWOABuildTools.Generic(9948, 12636, -4, "walls_decoration_02_70")
    BWOABuildTools.Generic(9950, 12636, -4, "walls_decoration_02_67")
    BWOABuildTools.Generic(9954, 12636, -4, "walls_decoration_02_86")
    BWOABuildTools.Generic(9956, 12636, -4, "walls_decoration_01_48")

    BWOABuildTools.SmallTableN(9948, 12636, -4, {})
    BWOABuildTools.SmallTableN(9950, 12636, -4, {})
    BWOABuildTools.SmallTableN(9952, 12636, -4, {})
    BWOABuildTools.SmallTableN(9954, 12636, -4, {})
    BWOABuildTools.SmallTableN(9956, 12636, -4, {})

    BWOABuildTools.SmallTableS(9948, 12642, -4, {})
    BWOABuildTools.SmallTableS(9950, 12642, -4, {})
    BWOABuildTools.SmallTableS(9952, 12642, -4, {})
    BWOABuildTools.SmallTableS(9954, 12642, -4, {})
    BWOABuildTools.SmallTableS(9956, 12642, -4, {})

end

BWOARooms.BedroomMale.SetEmitters = function ()
    -- BWOASound.AddToObject({x=9948, y=12605, z=-4, sound="AmbientWaterDrops"})
end

BWOARooms.BedroomMale.SetFlickers = function ()
    BWOALights.AddFlicker({x=9945, y=12636, z=-4})
end

BWOARooms.BedroomMale.Prepare = function ()
    BWOAPrepareTools.DarkenLight(9956, 12640, -4)

    -- pillows
    for _, y in pairs({12636, 12642}) do
        for _, x in pairs({9947, 9949, 9951, 9952, 9955}) do 
            BWOAPrepareTools.AddWorldItem(x, y, -4, "Base.Pillow", {x=0.5, y=0.5, z=0.3})
            BWOAPrepareTools.AddWorldItem(x, y, -4, "Base.Pillow", {x=0.5, y=0.5, z=0.8})
        end
    end

    -- bed magazines
    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.MagazineWordsearch", {x=0.5, y=0.5, z=0.3})
    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.Pencil", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.SheetPaper2", {x=0.5, y=0.5, z=0.8})
    BWOAPrepareTools.AddWorldItem(9947, 12637, -4, "Base.Crayons", {x=0.5, y=0.5, z=0.8})

    BWOAPrepareTools.AddWorldItem(9951, 12637, -4, "Base.HottieZ_New", {x=0.5, y=0.5, z=0.8})

    BWOAPrepareTools.AddWorldItem(9951, 12637, -4, "Base.Notebook", {x=0.5, y=0.5, z=0.3})
    BWOAPrepareTools.AddWorldItem(9951, 12637, -4, "Base.Pencil", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9955, 12637, -4, "Base.Magazine", {x=0.5, y=0.5, z=0.3})
    BWOAPrepareTools.AddWorldItem(9955, 12637, -4, "Base.Magazine", {x=0.5, y=0.5, z=0.3})

    -- table items
    BWOAPrepareTools.AddWorldItem(9948, 12636, -4, "Base.MugWhite", {x=0.4, y=0.7, z=0.24})
    BWOAPrepareTools.AddWorldItem(9948, 12636, -4, "Base.CaseyPic", {x=0.5, y=0.4, z=0.24, rz=0})

    BWOAPrepareTools.AddWorldItem(9950, 12636, -4, "Base.ChessWhite", {x=0.4, y=0.4, z=0.24})
    BWOAPrepareTools.AddWorldItem(9950, 12636, -4, "Base.ChessBlack", {x=0.6, y=0.6, z=0.24})

    BWOAPrepareTools.AddWorldItem(9952, 12636, -4, "Base.Book", {x=0.5, y=0.6, z=0.24})

    BWOAPrepareTools.AddWorldItem(9954, 12636, -4, "Base.MugWhite", {x=0.4, y=0.4, z=0.24})
    BWOAPrepareTools.AddWorldItem(9954, 12636, -4, "Base.Pen", {x=0.6, y=0.6, z=0.24})
    BWOAPrepareTools.AddWorldItem(9954, 12636, -4, "Base.MagazineWordsearch", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9956, 12636, -4, "Base.Cube", {x=0.62, y=0.55, z=0.3})
    BWOAPrepareTools.AddWorldItem(9956, 12636, -4, "Base.Cube", {x=0.74, y=0.59, z=0.3})
    BWOAPrepareTools.AddWorldItem(9956, 12636, -4, "Base.Pills", {x=0.66, y=0.64, z=0.3})

    
    BWOAPrepareTools.AddWorldItem(9948, 12642, -4, "Base.MugWhite", {x=0.4, y=0.7, z=0.24})
    BWOAPrepareTools.AddWorldItem(9948, 12642, -4, "Base.PillsSleepingTablets", {x=0.5, y=0.4, z=0.24, rz=0})

    BWOAPrepareTools.AddWorldItem(9950, 12642, -4, "Base.Glasses_Normal", {x=0.4, y=0.4, z=0.24})
    BWOAPrepareTools.AddWorldItem(9950, 12642, -4, "Base.Book", {x=0.6, y=0.6, z=0.24})

    BWOAPrepareTools.AddWorldItem(9952, 12642, -4, "Base.ToyCar", {x=0.4, y=0.5, z=0.24, rz = 60})
    BWOAPrepareTools.AddWorldItem(9952, 12642, -4, "Base.ToyCar", {x=0.5, y=0.5, z=0.24, rz = 60})
    BWOAPrepareTools.AddWorldItem(9952, 12642, -4, "Base.ToyCar", {x=0.6, y=0.5, z=0.24, rz = 60})

    BWOAPrepareTools.AddWorldItem(9954, 12642, -4, "Base.Pencil", {x=0.4, y=0.4, z=0.24})
    BWOAPrepareTools.AddWorldItem(9954, 12642, -4, "Base.MagazineWordsearch", {x=0.6, y=0.6, z=0.24})
    BWOAPrepareTools.AddWorldItem(9954, 12642, -4, "Base.MagazineWordsearch", {x=0.5, y=0.5, z=0.3})

    BWOAPrepareTools.AddWorldItem(9956, 12642, -4, "Base.Pencil", {x=0.62, y=0.55, z=0.3})
    BWOAPrepareTools.AddWorldItem(9956, 12642, -4, "Base.TissueBox", {x=0.74, y=0.59, z=0.3})
    BWOAPrepareTools.AddWorldItem(9956, 12642, -4, "Base.Pills", {x=0.66, y=0.64, z=0.3})

    -- others
    BWOAPrepareTools.AddWorldItem(9945, 12636, -4, "Base.GuitarAcoustic", {x=0.5, y=0.27, z=0.18, rx=0, ry=295, rz=90})

end

BWOARooms.BedroomMale.LightToggle = function ()
end

