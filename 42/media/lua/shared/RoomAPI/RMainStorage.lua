BWOARooms = BWOARooms or {}

BWOARooms.MainStorage = {}

BWOARooms.MainStorage.Init = function ()
    BWOARooms.MainStorage.name = "MainStorage"
    BWOARooms.MainStorage.x1 = 9944
    BWOARooms.MainStorage.x2 = 9956
    BWOARooms.MainStorage.y1 = 12627
    BWOARooms.MainStorage.y2 = 12635
    BWOARooms.MainStorage.z = -4
    BWOARooms.MainStorage.ambience = ""

    BWOARooms.MainStorage.vents = {
        {x=9954.5, y=12627, z=-4},
        {x=9950, y=12633.5, z=-4},
        {x=9944, y=12633.5, z=-4},
    }

    BWOARooms.MainStorage.els = {}
    for x=9944, 9949 do
        table.insert(BWOARooms.MainStorage.els, {dir="N", x=x, y=12629, z=-4})
        table.insert(BWOARooms.MainStorage.els, {dir="S", x=x, y=12635, z=-4})
    end

    for y=12629, 12635 do
        table.insert(BWOARooms.MainStorage.els, {dir="W", x=9944, y=y, z=-4})
        if y ~= 12634 then
            table.insert(BWOARooms.MainStorage.els, {dir="E", x=9949, y=y, z=-4})
        end
    end

    for x=9950, 9956 do
        if x ~= 9955 then
            table.insert(BWOARooms.MainStorage.els, {dir="N", x=x, y=12627, z=-4})
        end
        table.insert(BWOARooms.MainStorage.els, {dir="S", x=x, y=12635, z=-4})
    end

    for y=12627, 12635 do
        if y ~= 12634 then
            table.insert(BWOARooms.MainStorage.els, {dir="W", x=9950, y=y, z=-4})
        end
        table.insert(BWOARooms.MainStorage.els, {dir="E", x=9956, y=y, z=-4})
    end

    
end

BWOARooms.MainStorage.Build = function ()
    BWOARooms.MainStorage.Init()
    BWOAPrepareTools.DarkenLight(9956, 12627, -4)
    BWOAPrepareTools.DarkenLight(9949, 12633, -4)

    BWOABuildTools.ELS(BWOARooms.MainStorage.els)

    BWOABuildTools.EmergencyExitN(9955, 12627, -4)

    BWOABuildTools.VentN(9944, 12633, -4)

    BWOABuildTools.LampOvalN(9952, 12627, -4)
    BWOABuildTools.LampOvalS(9952, 12635, -4)
    BWOABuildTools.LampOvalS(9955, 12635, -4)

    BWOABuildTools.LampOvalW(9944, 12630, -4)
    BWOABuildTools.LampOvalW(9944, 12634, -4)
    BWOABuildTools.LampOvalE(9949, 12630, -4)

end

BWOARooms.MainStorage.SetEmitters = function ()
    BWOARooms.MainStorage.Init()
end

BWOARooms.MainStorage.SetFlickers = function ()
    BWOARooms.MainStorage.Init()
end

BWOARooms.MainStorage.Prepare = function ()
    BWOARooms.MainStorage.Init()

end


