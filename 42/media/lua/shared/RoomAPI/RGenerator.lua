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

end

BWOARooms.Generator.Build = function ()
    BWOABuildTools.LampOvalN(9948, 12615, -4)
    BWOABuildTools.LampOvalS(9948, 12621, -4)

    BWOABuildTools.Generic(9944, 12618, -4, "theark_01_0")
    BWOABuildTools.Generic(9950, 12623, -4, "theark_01_0")
    BWOABuildTools.Generic(9950, 12622, -4, "theark_01_1")
end

BWOARooms.Generator.SetEmitters = function ()
    -- BWOASound.AddToObject({x=9945, y=12620, z=-4, sound="AmbientGenerator"})
    -- BWOASound.AddToObject({x=9944, y=12618, z=-4, sound="AmbientElectricity"})
    -- BWOASound.AddToObject({x=9950, y=12622, z=-4, sound="AmbientElectricity"})
end

BWOARooms.Generator.Prepare = function ()
    BWOAPrepareTools.DarkenLight(9956, 12623, -4)
end

BWOARooms.Generator.LightToggle = function ()
end

