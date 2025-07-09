BWOARooms = BWOARooms or {}

BWOARooms.BathroomFemale = {}

BWOARooms.BathroomFemale.Init = function ()
    BWOARooms.BathroomFemale.x1 = 9948
    BWOARooms.BathroomFemale.x2 = 9956
    BWOARooms.BathroomFemale.y1 = 12600
    BWOARooms.BathroomFemale.y2 = 12608
    BWOARooms.BathroomFemale.z = -4
    BWOARooms.BathroomFemale.ambience = ""
end

BWOARooms.BathroomFemale.Build = function ()
    return true
end

BWOARooms.BathroomFemale.SetEmitters = function ()
    BWOASound.AddToObject({x=9945, y=12620, z=-4, sound="AmbientWaterDrops"})
end

BWOARooms.BathroomFemale.Prepare = function ()
end

BWOARooms.BathroomFemale.LightToggle = function ()
end

