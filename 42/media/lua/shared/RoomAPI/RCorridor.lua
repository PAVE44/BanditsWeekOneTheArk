BWOARooms = BWOARooms or {}

BWOARooms.Corridor = {}

BWOARooms.Corridor.Init = function ()
    BWOARooms.Corridor.vents = {
        {x=9957, y=12648.5, z=-4},
        {x=9957, y=12640.5, z=-4},
        {x=9954.5, y=12623, z=-4},
        {x=9957, y=12610.5, z=-4},
        {x=9957, y=12602.5, z=-4},
        {x=9963.5, y=12641, z=-4},
        {x=9969.5, y=12641, z=-4},
        {x=9971, y=12634.5, z=-4},
        {x=9971, y=12629.5, z=-4},
        {x=9971, y=12623.5, z=-4},
        {x=9971, y=12614.5, z=-4},
    }
end

BWOARooms.Corridor.Build = function ()
    BWOARooms.Corridor.Init()
end

BWOARooms.Corridor.SetEmitters = function ()
    BWOARooms.Corridor.Init()

    for _, coords in pairs(BWOARooms.Corridor.vents) do 
        BWOASound.AddToObject({x=coords.x, y=coords.y, z=coords.z, elec=true, sound="AmbientVent"})
    end

    BWOASound.AddToObject({x=9957, y=12644.5, z=-4, sound="AmbientPlumbing"})
    BWOASound.AddToObject({x=9957, y=12621.5, z=-4, sound="AmbientPlumbing"})
    BWOASound.AddToObject({x=9971.5, y=12608, z=-4, sound="AmbientPlumbing"})
end

BWOARooms.Corridor.Prepare = function ()
    BWOARooms.Corridor.Init()
end


