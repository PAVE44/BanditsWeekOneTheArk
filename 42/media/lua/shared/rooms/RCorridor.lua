BWOARooms = BWOARooms or {}

BWOARooms.Corridor = {}

BWOARooms.Corridor.Init = function ()
end

BWOARooms.Corridor.Build = function ()
    return true
end

BWOARooms.Corridor.SetEmitters = function ()
    BWOASound.AddToObject({x=9957, y=12648.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9957, y=12640.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9954.5, y=12623, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9957, y=12610.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9957, y=12602.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9962.5, y=12640, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9968.5, y=12640, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9971, y=12634.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9971, y=12629.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9971, y=12623.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9971, y=12614.5, z=-4, sound="AmbientVent"})
    BWOASound.AddToObject({x=9957, y=12644.5, z=-4, sound="AmbientPlumbing"})
    BWOASound.AddToObject({x=9957, y=12621.5, z=-4, sound="AmbientPlumbing"})
    BWOASound.AddToObject({x=9971.5, y=12608, z=-4, sound="AmbientPlumbing"})
end

BWOARooms.Corridor.Prepare = function ()
end

BWOARooms.Corridor.LightToggle = function ()
end

