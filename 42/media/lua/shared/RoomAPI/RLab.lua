BWOARooms = BWOARooms or {}

BWOARooms.Lab = {}

BWOARooms.Lab.Init = function ()
    BWOARooms.Lab.name = "LABORATORY"
    BWOARooms.Lab.x1 = 9962
    BWOARooms.Lab.x2 = 9973
    BWOARooms.Lab.y1 = 12643
    BWOARooms.Lab.y2 = 12651
    BWOARooms.Lab.z = -4
    BWOARooms.Lab.ambience = ""

    BWOARooms.Lab.els = {}
    for x=BWOARooms.Lab.x1, BWOARooms.Lab.x2 - 1 do
        if x ~= BWOARooms.Lab.x1 + 6 then
            table.insert(BWOARooms.Lab.els, {dir="N", x=x, y=BWOARooms.Lab.y1, z=-4})
        end
        table.insert(BWOARooms.Lab.els, {dir="S", x=x, y=BWOARooms.Lab.y2, z=-4})
    end

    for y=BWOARooms.Lab.y1, BWOARooms.Lab.y2 - 1 do
        table.insert(BWOARooms.Lab.els, {dir="W", x=BWOARooms.Lab.x1, y=y, z=-4})
        table.insert(BWOARooms.Lab.els, {dir="E", x=BWOARooms.Lab.x2, y=y, z=-4})
    end
end

BWOARooms.Lab.Build = function ()

    BWOARooms.Lab.Init()

    -- floors, walls, door
    local z = BWOARooms.Lab.z
    for x = BWOARooms.Lab.x1, BWOARooms.Lab.x2 do
        for y = BWOARooms.Lab.y1, BWOARooms.Lab.y2 do
            BWOABuildTools.FloorConcrete(x, y, z)

            if x == BWOARooms.Lab.x1 or x == BWOARooms.Lab.x2 then
                BWOABuildTools.WallWConcrete(x, y, z)
            end

            if y == BWOARooms.Lab.y2 then 
                BWOABuildTools.WallNConcrete(x, y, z)
            end
        end
    end

    BWOABuildTools.DoorNConcrete(9968, 12643, z)

    BWOABuildTools.ELS(BWOARooms.Lab.els)

    -- room lamps
    BWOABuildTools.LampOvalN(9964, 12643, -4)
    BWOABuildTools.LampOvalN(9970, 12643, -4)
    BWOABuildTools.LampOvalS(9959, 12650, -4)
    BWOABuildTools.LampOvalS(9970, 12650, -4)

    -- BWOABuildTools.Skeleton(9970, 12643, -4)

    -- closets
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1, BWOARooms.Lab.z, "location_community_medical_01_153")
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 1, BWOARooms.Lab.z, "location_community_medical_01_152")
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 2, BWOARooms.Lab.z, "location_community_medical_01_103")
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 3, BWOARooms.Lab.z, "location_community_medical_01_103")
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "location_community_medical_01_103")
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "location_community_medical_01_103")
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 6, BWOARooms.Lab.z, "location_community_medical_01_153")
    BWOABuildTools.Generic(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 7, BWOARooms.Lab.z, "location_community_medical_01_152")

    -- desk
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1, BWOARooms.Lab.z, "location_community_medical_01_107")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1, BWOARooms.Lab.z, "location_community_medical_01_108")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1, BWOARooms.Lab.z, "location_community_medical_01_108")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1, BWOARooms.Lab.z, "location_community_medical_01_109")

    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1, BWOARooms.Lab.z, "location_community_medical_01_11") -- poster

    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1, BWOARooms.Lab.z, "location_community_medical_01_136") -- microscope
    BWOABuildTools.LampDeskYellowN(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1, BWOARooms.Lab.z)
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1, BWOARooms.Lab.z, "appliances_com_01_72") -- computer

    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 1, BWOARooms.Lab.z, "furniture_seating_indoor_01_51") -- chair

    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 3, BWOARooms.Lab.z, "location_community_medical_01_10") -- chair

    -- desk
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "location_community_medical_01_107")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "location_community_medical_01_108")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "location_community_medical_01_108")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "location_community_medical_01_109")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 6, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "location_community_medical_01_50")

    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "fixtures_sinks_01_19") -- sink
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 4, BWOARooms.Lab.z, "location_community_medical_01_139") -- microscope

    -- desk
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "location_community_medical_01_107")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "location_community_medical_01_108")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "location_community_medical_01_108")
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "location_community_medical_01_109")

    BWOABuildTools.LampDeskYellowN(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z)
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "fixtures_sinks_01_17") -- sink
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "location_community_medical_01_136")

    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 6, BWOARooms.Lab.z, "location_community_medical_01_10") -- chair

    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 9, BWOARooms.Lab.y1 + 5, BWOARooms.Lab.z, "location_community_medical_01_79") -- processing table
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 9, BWOARooms.Lab.y1 + 6, BWOARooms.Lab.z, "location_community_medical_01_78") -- processing table
    
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 9 , BWOARooms.Lab.y1, BWOARooms.Lab.z, "furniture_tables_high_01_56") -- plastic table
    BWOABuildTools.Generic(BWOARooms.Lab.x1 + 10, BWOARooms.Lab.y1, BWOARooms.Lab.z, "furniture_tables_high_01_57") -- plastic table

    BWOABuildTools.VentW(BWOARooms.Lab.x1 + 9 , BWOARooms.Lab.y1, BWOARooms.Lab.z) --vent

    return true
end

BWOARooms.Lab.SetEmitters = function ()
    BWOARooms.Lab.Init()
    BWOASound.AddToObject({x=BWOARooms.Lab.x1 + 9.5, y=BWOARooms.Lab.y1 + 0.5, z=-4, elec=true, sound="AmbientVent"})
end

BWOARooms.Lab.Prepare = function ()
    BWOARooms.Lab.Init()
end


