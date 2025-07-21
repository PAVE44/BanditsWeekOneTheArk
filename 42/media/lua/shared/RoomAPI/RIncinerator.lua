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

    BWOARooms.Incinerator.els = {}
    for x=BWOARooms.Incinerator.x1, BWOARooms.Incinerator.x2 do
        table.insert(BWOARooms.Incinerator.els, {dir="S", x=x, y=BWOARooms.Incinerator.y1, z=-4})
        table.insert(BWOARooms.Incinerator.els, {dir="N", x=x, y=BWOARooms.Incinerator.y2, z=-4})
    end

    for y=BWOARooms.Incinerator.y1, BWOARooms.Incinerator.y2 do
        table.insert(BWOARooms.Incinerator.els, {dir="W", x=BWOARooms.Incinerator.x1, y=y, z=-4})
        if y ~= BWOARooms.Incinerator.y1 + 4 then
            table.insert(BWOARooms.Incinerator.els, {dir="E", x=BWOARooms.Incinerator.x2, y=y, z=-4})
        end
    end
end

BWOARooms.Incinerator.Build = function ()
    BWOARooms.Incinerator.Init()

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
    BWOARooms.Incinerator.Init()
    BWOASound.AddToObject({x=BWOARooms.Incinerator.x1, y=BWOARooms.Incinerator.y1 + 5.5, z=-4, elec=true, sound="AmbientVent"})
end

BWOARooms.Incinerator.Prepare = function ()
    BWOARooms.Incinerator.Init()
end


