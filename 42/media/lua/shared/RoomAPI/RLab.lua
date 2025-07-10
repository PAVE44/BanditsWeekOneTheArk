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
end

BWOARooms.Lab.Build = function ()
    local cell = getCell()

    -- floors, walls, door
    local z = BWOARooms.Lab.z
    for x = BWOARooms.Lab.x1, BWOARooms.Lab.x2 do
        for y = BWOARooms.Lab.y1, BWOARooms.Lab.y2 do
            local square = cell:getOrCreateGridSquare(x, y, z)
            BWOABuildTools.FloorConcrete(square)

            if x == BWOARooms.Lab.x1 or x == BWOARooms.Lab.x2 then
                BWOABuildTools.WallWConcrete(square)
            end

            if y == BWOARooms.Lab.y2 then 
                BWOABuildTools.WallNConcrete(square)
            end
        end
    end

    BWOABuildTools.DoorNConcrete(cell:getGridSquare(9968, 12643, z))

    -- closets
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1, -4), "location_community_medical_01_153")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 1, -4), "location_community_medical_01_152")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 2, -4), "location_community_medical_01_103")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 3, -4), "location_community_medical_01_103")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 4, -4), "location_community_medical_01_103")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 5, -4), "location_community_medical_01_103")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 6, -4), "location_community_medical_01_153")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1, BWOARooms.Lab.y1 + 7, -4), "location_community_medical_01_152")

    -- desk
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1, -4), "location_community_medical_01_107")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1, -4), "location_community_medical_01_108")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1, -4), "location_community_medical_01_108")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1, -4), "location_community_medical_01_109")

    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1, -4), "location_community_medical_01_11") -- poster

    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1, -4), "location_community_medical_01_136") -- microscope
    BWOABuildTools.Lamp(cell:getGridSquare(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1, -4), "lighting_indoor_02_2") -- lamp
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1, -4), "appliances_com_01_72") -- computer

    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 1, -4), "furniture_seating_indoor_01_51") -- chair

    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 3, -4), "location_community_medical_01_10") -- chair

    -- desk
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 4, -4), "location_community_medical_01_107")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1 + 4, -4), "location_community_medical_01_108")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 4, -4), "location_community_medical_01_108")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 4, -4), "location_community_medical_01_109")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 6, BWOARooms.Lab.y1 + 4, -4), "location_community_medical_01_50")

    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 4, -4), "fixtures_sinks_01_19") -- sink
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 4, -4), "location_community_medical_01_139") -- microscope

    -- desk
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 5, -4), "location_community_medical_01_107")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 3, BWOARooms.Lab.y1 + 5, -4), "location_community_medical_01_108")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 5, -4), "location_community_medical_01_108")
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 5, -4), "location_community_medical_01_109")

    BWOABuildTools.Lamp(cell:getGridSquare(BWOARooms.Lab.x1 + 2, BWOARooms.Lab.y1 + 5, -4), "lighting_indoor_02_2") -- lamp
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 5, -4), "fixtures_sinks_01_17") -- sink
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 5, BWOARooms.Lab.y1 + 5, -4), "location_community_medical_01_136")

    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 4, BWOARooms.Lab.y1 + 6, -4), "location_community_medical_01_10") -- chair

    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 9, BWOARooms.Lab.y1 + 5, -4), "location_community_medical_01_79") -- processing table
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 9, BWOARooms.Lab.y1 + 6, -4), "location_community_medical_01_78") -- processing table
    
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 9 , BWOARooms.Lab.y1, -4), "furniture_tables_high_01_56") -- plastic table
    BWOABuildTools.Generic(cell:getGridSquare(BWOARooms.Lab.x1 + 10, BWOARooms.Lab.y1, -4), "furniture_tables_high_01_57") -- plastic table

    BWOABuildTools.VentW(cell:getGridSquare(BWOARooms.Lab.x1 + 9 , BWOARooms.Lab.y1, -4)) --vent

    return true
end

BWOARooms.Lab.SetEmitters = function ()
    BWOASound.AddToObject({x=BWOARooms.Lab.x1 + 9.5, y=BWOARooms.Lab.y1 + 0.5, z=-4, sound="AmbientVent"})
end

BWOARooms.Lab.GetLights = function ()
    local lights = {}
    local z = -4
    for _, x in pairs({9964, 9966, 9968, 9970, 9972}) do
        for y = BWOARooms.Lab.y1 + 3, BWOARooms.Lab.y2 - 2 do
            table.insert(lights, {x=x, y=y, z=z})
        end
    end
    return lights
end

BWOARooms.Lab.Prepare = function ()
end

BWOARooms.Lab.LightToggle = function ()
end

