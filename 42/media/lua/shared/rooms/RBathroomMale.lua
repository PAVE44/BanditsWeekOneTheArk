BWOARooms = BWOARooms or {}

BWOARooms.BathroomMale = {}

BWOARooms.BathroomMale.Init = function ()
    BWOARooms.BathroomMale.x1 = 9948
    BWOARooms.BathroomMale.x2 = 9956
    BWOARooms.BathroomMale.y1 = 12643
    BWOARooms.BathroomMale.y2 = 12650
    BWOARooms.BathroomMale.z = -4
    BWOARooms.BathroomMale.ambience = ""
end

BWOARooms.BathroomMale.Build = function ()
    return true
end

BWOARooms.BathroomMale.SetEmitters = function ()
    BWOASound.AddToObject({x=9948, y=12645, z=-4, sound="AmbientWaterDrops"})
end

BWOARooms.BathroomMale.Prepare = function ()
end

BWOARooms.BathroomMale.LightToggle = function ()
end

