BWOARooms = BWOARooms or {}

BWOARooms.Messhall = {}

BWOARooms.Messhall.Init = function ()
    BWOARooms.Messhall.name = "Messhall"
    BWOARooms.Messhall.x1 = 9959
    BWOARooms.Messhall.x2 = 9970
    BWOARooms.Messhall.y1 = 12610
    BWOARooms.Messhall.y2 = 12620
    BWOARooms.Messhall.z = -4
    BWOARooms.Messhall.ambience = ""

    BWOARooms.Messhall.vents = {
        {x=9959, y=12614.5, z=-4},
    }

    BWOARooms.Messhall.els = {}
    for x=BWOARooms.Messhall.x1, BWOARooms.Messhall.x2 do
        table.insert(BWOARooms.Messhall.els, {dir="N", x=x, y=BWOARooms.Messhall.y1, z=-4})
        table.insert(BWOARooms.Messhall.els, {dir="S", x=x, y=BWOARooms.Messhall.y2, z=-4})
    end

    for y=BWOARooms.Messhall.y1, BWOARooms.Messhall.y2 do
        if y ~= 12615 then
            table.insert(BWOARooms.Messhall.els, {dir="W", x=BWOARooms.Messhall.x1, y=y, z=-4})
            table.insert(BWOARooms.Messhall.els, {dir="E", x=BWOARooms.Messhall.x2, y=y, z=-4})
        end
    end

    -- pillar
    table.insert(BWOARooms.Messhall.els, {dir="N", x=9964, y=12616, z=-4})
    table.insert(BWOARooms.Messhall.els, {dir="N", x=9965, y=12616, z=-4})
    
    table.insert(BWOARooms.Messhall.els, {dir="S", x=9964, y=12614, z=-4})
    table.insert(BWOARooms.Messhall.els, {dir="S", x=9965, y=12614, z=-4})

    table.insert(BWOARooms.Messhall.els, {dir="W", x=9966, y=12615, z=-4})
    table.insert(BWOARooms.Messhall.els, {dir="E", x=9963, y=12615, z=-4})
end

BWOARooms.Messhall.Build = function ()
    BWOARooms.Messhall.Init()
    BWOAPrepareTools.DarkenLight(9959, 12616, -4)

    BWOABuildTools.ELS(BWOARooms.Messhall.els)

    BWOABuildTools.EmergencyExitW(9959, 12615, -4)

    -- BWOABuildTools.RemoveObject(9959, 12612, -4, "Clock")

    BWOABuildTools.LampOvalW(9959, 12613, -4)
    BWOABuildTools.LampOvalW(9959, 12617, -4)
    BWOABuildTools.LampOvalS(9962, 12620, -4)
    BWOABuildTools.LampOvalS(9967, 12620, -4)
    BWOABuildTools.LampOvalE(9970, 12613, -4)
    BWOABuildTools.LampOvalE(9970, 12617, -4)
    BWOABuildTools.LampOvalN(9962, 12610, -4)
    BWOABuildTools.LampOvalN(9967, 12610, -4)

    BWOABuildTools.LampOvalW(9966, 12615, -4)
    BWOABuildTools.LampOvalE(9963, 12615, -4)

    BWOABuildTools.RemoveObject(9961, 12610, -4, "Green Garbage Bin")
    BWOABuildTools.Fridge(9961, 12610, -4)
    BWOABuildTools.RemoveObject(9968, 12610, -4, "Green Garbage Bin")
    BWOABuildTools.Fridge(9968, 12610, -4)

end

BWOARooms.Messhall.SetEmitters = function ()
    BWOARooms.Messhall.Init()
end

BWOARooms.Messhall.SetFlickers = function ()
    BWOARooms.Messhall.Init()
end

BWOARooms.Messhall.Prepare = function ()
    BWOARooms.Messhall.Init()

end


