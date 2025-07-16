BWOARooms = BWOARooms or {}

BWOARooms.Incinerator = {}

BWOARooms.Incinerator.Init = function ()
    BWOARooms.Incinerator.name = "INCINERATOR_ROOM"
    BWOARooms.Incinerator.x1 = 9973
    BWOARooms.Incinerator.x2 = 9979
    BWOARooms.Incinerator.y1 = 12637
    BWOARooms.Incinerator.y2 = 12643
    BWOARooms.Incinerator.z = -4
    BWOARooms.Incinerator.ambience = ""
end

BWOARooms.Incinerator.Build = function ()
    -- floors, walls, door
    local z = BWOARooms.Incinerator.z
    for x = BWOARooms.Incinerator.x1, BWOARooms.Incinerator.x2 do
        for y = BWOARooms.Incinerator.y1, BWOARooms.Incinerator.y2 do
            BWOABuildTools.FloorConcrete(x, y, z)

            if x == BWOARooms.Incinerator.x2 then
                BWOABuildTools.WallWConcrete(x, y, z)
            end

            if y == BWOARooms.Incinerator.y2 then 
                BWOABuildTools.WallNConcrete(x, y, z)
            end
        end
    end

    BWOABuildTools.DoorWConcrete(BWOARooms.Incinerator.x1, BWOARooms.Incinerator.y1 + 4, BWOARooms.Incinerator.z)
    BWOABuildTools.VentN(BWOARooms.Incinerator.x1, BWOARooms.Incinerator.y1 + 5, BWOARooms.Incinerator.z)

    -- incinerator
    BWOABuildTools.Generic(BWOARooms.Incinerator.x1, BWOARooms.Incinerator.y1 + 4, BWOARooms.Incinerator.z, "industry_02_56")
    BWOABuildTools.Generic(BWOARooms.Incinerator.x1 + 1, BWOARooms.Incinerator.y1 + 4, BWOARooms.Incinerator.z, "industry_02_55")
    BWOABuildTools.Generic(BWOARooms.Incinerator.x1 + 2, BWOARooms.Incinerator.y1 + 4, BWOARooms.Incinerator.z, "industry_02_56")
    BWOABuildTools.Generic(BWOARooms.Incinerator.x1 + 3, BWOARooms.Incinerator.y1 + 4, BWOARooms.Incinerator.z, "industry_02_238")

    return true
end

BWOARooms.Incinerator.SetEmitters = function ()
    BWOASound.AddToObject({x=BWOARooms.Incinerator.x1, y=BWOARooms.Incinerator.y1 + 5.5, z=-4, sound="AmbientVent"})
end

BWOARooms.Incinerator.Prepare = function ()
end

BWOARooms.Incinerator.LightToggle = function ()
end

