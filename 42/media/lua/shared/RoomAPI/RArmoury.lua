BWOARooms = BWOARooms or {}

BWOARooms.Armoury = {}

BWOARooms.Armoury.Init = function ()
    BWOARooms.Armoury.name = "Armoury"
    BWOARooms.Armoury.x1 = 9973
    BWOARooms.Armoury.x2 = 9978
    BWOARooms.Armoury.y1 = 12614
    BWOARooms.Armoury.y2 = 12617
    BWOARooms.Armoury.z = -4
    BWOARooms.Armoury.ambience = ""

    BWOARooms.Armoury.vents = {
        {x=9973, y=12616.5, z=-4},
    }

    BWOARooms.Armoury.els = {}
    for x=BWOARooms.Armoury.x1, BWOARooms.Armoury.x2 do
        table.insert(BWOARooms.Armoury.els, {dir="N", x=x, y=BWOARooms.Armoury.y1, z=-4})
        table.insert(BWOARooms.Armoury.els, {dir="S", x=x, y=BWOARooms.Armoury.y2, z=-4})
    end

    for y=BWOARooms.Armoury.y1, BWOARooms.Armoury.y2 do
        if y ~= 12615 then
            table.insert(BWOARooms.Armoury.els, {dir="W", x=BWOARooms.Armoury.x1, y=y, z=-4})
        end
        table.insert(BWOARooms.Armoury.els, {dir="E", x=BWOARooms.Armoury.x2, y=y, z=-4})
    end
    
end

BWOARooms.Armoury.Build = function ()
    BWOARooms.Armoury.Init()
    BWOAPrepareTools.DarkenLight(9973, 12614, -4)

    BWOABuildTools.ELS(BWOARooms.Armoury.els)

    BWOABuildTools.EmergencyExitW(9973, 12615, -4)

    BWOABuildTools.LampOvalN(9976, 12614, -4)
    BWOABuildTools.LampOvalS(9976, 12617, -4)

end

BWOARooms.Armoury.SetEmitters = function ()
    BWOARooms.Armoury.Init()
end

BWOARooms.Armoury.SetFlickers = function ()
    BWOARooms.Armoury.Init()

    BWOALights.AddFlicker({x=9976, y=12614, z=-4})
    BWOALights.AddFlicker({x=9976, y=12617, z=-4})
end

BWOARooms.Armoury.Prepare = function ()
    BWOARooms.Armoury.Init()

end


