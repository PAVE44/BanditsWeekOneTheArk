BWOARooms = BWOARooms or {}

BWOARooms.Control = {}

BWOARooms.Control.Init = function ()
    BWOARooms.Control.name = "CONTROL_ROOM"
    BWOARooms.Control.x1 = 9948
    BWOARooms.Control.x2 = 9956
    BWOARooms.Control.y1 = 12600
    BWOARooms.Control.y2 = 12608
    BWOARooms.Control.z = -4
    BWOARooms.Control.ambience = ""
end

BWOARooms.Control.Build = function ()
    return true
end

BWOARooms.Control.SetEmitters = function ()
    BWOASound.AddToObject({x=9959.5, y=12621, z=-4, sound="AmbientElectricity"})
    BWOASound.AddToObject({x=9961.5, y=12620, z=-4, sound="AmbientComputer"})
    BWOASound.AddToObject({x=9963.5, y=12621, z=-4, sound="AmbientElectricity"})
end

BWOARooms.Control.Prepare = function ()
end

BWOARooms.Control.LightToggle = function ()
end

