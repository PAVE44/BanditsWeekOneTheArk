BWOARooms = BWOARooms or {}

BWOARooms.Generator = {}

BWOARooms.Generator.Init = function ()
    BWOARooms.Generator.name = "GENERATOR_ROOM"
    BWOARooms.Generator.x1 = 9944
    BWOARooms.Generator.x2 = 9956
    BWOARooms.Generator.y1 = 12615
    BWOARooms.Generator.y2 = 12623
    BWOARooms.Generator.z = -4
    BWOARooms.Generator.ambience = ""

    BWOARooms.Generator.vents = {
        {x=9948, y=12621, z=-4},
    }

    BWOARooms.Generator.els = {}
    for x=9944, 9956 do
        table.insert(BWOARooms.Generator.els, {dir="N", x=x, y=12615, z=-4})
    end

    for x=9944, 9949 do
        table.insert(BWOARooms.Generator.els, {dir="S", x=x, y=12621, z=-4})
    end

    for x=9950, 9954 do
        table.insert(BWOARooms.Generator.els, {dir="S", x=x, y=12623, z=-4})
    end

    table.insert(BWOARooms.Generator.els, {dir="S", x=9956, y=12623, z=-4})

    for y=12615, 12618 do
        table.insert(BWOARooms.Generator.els, {dir="W", x=9944, y=y, z=-4})
    end

    table.insert(BWOARooms.Generator.els, {dir="W", x=9950, y=12622, z=-4})
    table.insert(BWOARooms.Generator.els, {dir="W", x=9950, y=12623, z=-4})

    for y=12615, 12623 do
        table.insert(BWOARooms.Generator.els, {dir="E", x=9956, y=y, z=-4})
    end

    table.insert(BWOARooms.Generator.els, {dir="N", x=9951, y=12619, z=-4})
    table.insert(BWOARooms.Generator.els, {dir="N", x=9952, y=12619, z=-4})
    table.insert(BWOARooms.Generator.els, {dir="S", x=9951, y=12617, z=-4})
    table.insert(BWOARooms.Generator.els, {dir="S", x=9952, y=12617, z=-4})
    table.insert(BWOARooms.Generator.els, {dir="W", x=9953, y=12618, z=-4})
    table.insert(BWOARooms.Generator.els, {dir="E", x=9950, y=12618, z=-4})
end

BWOARooms.Generator.Build = function ()
    BWOARooms.Generator.Init()

    BWOAPrepareTools.DarkenLight(9956, 12623, -4)

    BWOABuildTools.ELS(BWOARooms.Generator.els)

    BWOABuildTools.LampOvalN(9948, 12615, -4)
    BWOABuildTools.LampOvalS(9948, 12621, -4)

    BWOABuildTools.Generic(9944, 12618, -4, "theark_01_0")
    BWOABuildTools.Generic(9950, 12623, -4, "theark_01_0")
    BWOABuildTools.Generic(9950, 12622, -4, "theark_01_1")

    BWOABuildTools.WaterPump(9949, 12615, -4)
end

BWOARooms.Generator.SetEmitters = function ()
    BWOARooms.Generator.Init()
    -- BWOASound.AddToObject({x=9945, y=12620, z=-4, elec=true, sound="AmbientGenerator"})
    BWOASound.AddToObject({x=9944, y=12618, z=-4, elec=true, sound="AmbientElectricity"})
    BWOASound.AddToObject({x=9950, y=12622, z=-4, elec=true, sound="AmbientElectricity"})
end

BWOARooms.Generator.Prepare = function ()
    BWOARooms.Generator.Init()
end

