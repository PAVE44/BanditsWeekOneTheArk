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
    return true
end

BWOARooms.Generator.SetEmitters = function ()
    BWOASound.AddToObject({x=9945, y=12620, z=-4, sound="AmbientGenerator"})
    BWOASound.AddToObject({x=9944, y=12618, z=-4, sound="AmbientElectricity"})
    BWOASound.AddToObject({x=9950, y=12622, z=-4, sound="AmbientElectricity"})
end

BWOARooms.Generator.Prepare = function ()
end

BWOARooms.Generator.LightToggle = function ()
end

