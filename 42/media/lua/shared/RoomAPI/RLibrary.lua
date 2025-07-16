BWOARooms = BWOARooms or {}

BWOARooms.Library = {}

BWOARooms.Library.Init = function ()
    BWOARooms.Library.name = "LIBRARY"
    BWOARooms.Library.x1 = 9973
    BWOARooms.Library.x2 = 9977
    BWOARooms.Library.y1 = 12608
    BWOARooms.Library.y2 = 12613
    BWOARooms.Library.z = -4
    BWOARooms.Library.ambience = ""
end

BWOARooms.Library.Build = function ()
    -- floors, walls, door
    local z = BWOARooms.Library.z
    for x = BWOARooms.Library.x1, BWOARooms.Library.x2 do
        for y = BWOARooms.Library.y1, BWOARooms.Library.y2 do
            BWOABuildTools.FloorConcrete(x, y, z)

            if x == BWOARooms.Library.x2 then
                BWOABuildTools.WallWConcrete(x, y, z)
                if y % 5 == 0 then
                    BWOABuildTools.VentN(x, y, z)
                end
            end

            if y == BWOARooms.Library.y1 then 
                BWOABuildTools.WallNConcrete(x, y, z)
            end
        end
    end

    BWOABuildTools.DoorWConcrete(9973, 12610, -4)

    -- equipment
    BWOABuildTools.BookshelfW(9973, 12608, -4)
    BWOABuildTools.BookshelfW(9974, 12608, -4)
    BWOABuildTools.BookshelfW(9975, 12608, -4)
    BWOABuildTools.BookshelfW(9976, 12608, -4)
    BWOABuildTools.BookshelfW(9977, 12608, -4)
    BWOABuildTools.Generic(9973, 12612, -4, "furniture_seating_indoor_03_5")
    BWOABuildTools.Generic(9974, 12613, -4, "furniture_seating_indoor_03_14")
    BWOABuildTools.Generic(9975, 12613, -4, "furniture_seating_indoor_03_15")
    BWOABuildTools.Generic(9973, 12613, -4, "furniture_tables_low_01_17")
    BWOABuildTools.Generic(9976, 12613, -4, "furniture_tables_low_01_17")

    -- lights
    BWOABuildTools.Lamp(9973, 12613, -4, "lighting_indoor_01_32")

    return true
end

BWOARooms.Library.SetEmitters = function ()
    BWOASound.AddToObject({x=9977.5, y=12610 + 0.5, z=-4, sound="AmbientVent"})
end

BWOARooms.Library.Prepare = function ()
end

BWOARooms.Library.LightToggle = function ()
end

