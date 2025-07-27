BWOARooms = BWOARooms or {}

BWOARooms.Lab = {}

BWOARooms.Lab.Init = function ()
    BWOARooms.Lab.name = "LABORATORY"
    BWOARooms.Lab.x1 = 9959
    BWOARooms.Lab.x2 = 9965
    BWOARooms.Lab.y1 = 12636
    BWOARooms.Lab.y2 = 12640
    BWOARooms.Lab.z = -4
    BWOARooms.Lab.ambience = ""

    BWOARooms.Lab.vents = {
        {x=9963, y=12636.5, z=-4},
    }

    BWOARooms.Lab.els = {}
    for x=BWOARooms.Lab.x1, BWOARooms.Lab.x2 - 1 do
        table.insert(BWOARooms.Lab.els, {dir="N", x=x, y=BWOARooms.Lab.y1, z=-4})
        if x ~= 9962 then
            table.insert(BWOARooms.Lab.els, {dir="S", x=x, y=BWOARooms.Lab.y2, z=-4})
        end
    end

    for y=BWOARooms.Lab.y1, BWOARooms.Lab.y2 - 1 do
        table.insert(BWOARooms.Lab.els, {dir="W", x=BWOARooms.Lab.x1, y=y, z=-4})
        table.insert(BWOARooms.Lab.els, {dir="E", x=BWOARooms.Lab.x2, y=y, z=-4})
    end
end

BWOARooms.Lab.Build = function ()

    BWOARooms.Lab.Init()

    BWOAPrepareTools.DarkenLight(9963, 12640, -4)

    BWOABuildTools.ELS(BWOARooms.Lab.els)

    BWOABuildTools.LampOvalN(9960, 12636, -4)
    BWOABuildTools.LampOvalN(9964, 12636, -4)

    BWOABuildTools.RemoveObject(9959, 12637, -4, "Contraption")
    BWOABuildTools.RemoveObject(9960, 12637, -4, "Contraption")
    BWOABuildTools.RemoveObject(9959, 12639, -4, "Contraption")
    BWOABuildTools.RemoveObject(9960, 12639, -4, "Contraption")
    BWOABuildTools.RemoveObject(9962, 12638, -4, "Mat")
    BWOABuildTools.RemoveObject(9962, 12639, -4, "Mat")
    BWOABuildTools.RemoveObject(9962, 12636, -4, "Sink")
    BWOABuildTools.RemoveObject(9964, 12636, -4, "Hamster Wheel")
    BWOABuildTools.RemoveObject(9965, 12636, -4, "Hamster Wheel")
    BWOABuildTools.RemoveObject(9964, 12638, -4, "Hamster Wheel")
    BWOABuildTools.RemoveObject(9965, 12638, -4, "Hamster Wheel")
    BWOABuildTools.RemoveObject(9964, 12640, -4, "Hamster Wheel")
    BWOABuildTools.RemoveObject(9965, 12640, -4, "Hamster Wheel")

    -- room lamps
    BWOABuildTools.LampOvalN(9964, 12643, -4)
    BWOABuildTools.LampOvalN(9970, 12643, -4)
    BWOABuildTools.LampOvalS(9959, 12650, -4)
    BWOABuildTools.LampOvalS(9970, 12650, -4)

    -- BWOABuildTools.Skeleton(9970, 12643, -4)

    -- closets
    BWOABuildTools.Generic(9959, 12636, -4, "location_community_medical_01_153")
    BWOABuildTools.Generic(9959, 12637, -4, "location_community_medical_01_152")
    BWOABuildTools.Generic(9959, 12638, -4, "location_community_medical_01_103")
    BWOABuildTools.Generic(9959, 12639, -4, "location_community_medical_01_103")
    BWOABuildTools.Generic(9959, 12640, -4,  "location_community_medical_01_103")


    -- desk
    BWOABuildTools.Generic(9961, 12636, -4, "location_community_medical_01_107")
    BWOABuildTools.Generic(9962, 12636, -4, "location_community_medical_01_108")
    BWOABuildTools.Generic(9963, 12636, -4, "location_community_medical_01_108")
    BWOABuildTools.Generic(9964, 12636, -4, "location_community_medical_01_109")

    BWOABuildTools.Generic(9961, 12636, -4, "location_community_medical_01_11") -- poster
    BWOABuildTools.Generic(9961, 12636, -4, "location_community_medical_01_136") -- microscope
    BWOABuildTools.LampDeskYellowN(9962, 12643, -4)
    BWOABuildTools.Generic(9963, 12636, -4, "appliances_com_01_72") -- computer
    BWOABuildTools.Generic(9963, 12637, -4, "furniture_seating_indoor_01_51") -- chair

    -- desk 2
    BWOABuildTools.Generic(9963, 12639, -4, "location_community_medical_01_107")
    BWOABuildTools.Generic(9964, 12639, -4, "location_community_medical_01_108")
    BWOABuildTools.Generic(9965, 12639, -4, "location_community_medical_01_109")
    BWOABuildTools.LampDeskYellowN(9963, 12639, -4)
    BWOABuildTools.Generic(9964, 12639, -4, "location_community_medical_01_136") -- microscope
    BWOABuildTools.Generic(9965, 12639, -4, "fixtures_sinks_01_17")
    BWOABuildTools.Generic(9964, 12640, -4, "location_community_medical_01_10") -- processing table


    BWOABuildTools.Generic(9961, 12639, -4, "location_community_medical_01_78") -- processing table
    BWOABuildTools.Generic(9961, 12638, -4, "location_community_medical_01_79") -- processing table
    
    BWOABuildTools.VentW(9963, 12636, -4) --vent
end

BWOARooms.Lab.SetEmitters = function ()
    BWOARooms.Lab.Init()
end

BWOARooms.Lab.Prepare = function ()
    BWOARooms.Lab.Init()
end


