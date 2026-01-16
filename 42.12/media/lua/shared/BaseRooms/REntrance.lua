BWOARooms = BWOARooms or {}

BWOARooms.Entrance = {}

BWOARooms.Entrance.Init = function ()
    BWOARooms.Entrance.name = "ENTRANCE"
    BWOARooms.Entrance.x1 = 9921
    BWOARooms.Entrance.x2 = 9943
    BWOARooms.Entrance.y1 = 12623
    BWOARooms.Entrance.y2 = 12627
    BWOARooms.Entrance.z = -4
    BWOARooms.Entrance.ambience = ""

    BWOARooms.Entrance.vents = {}

    BWOARooms.Entrance.els = {}
end

BWOARooms.Entrance.Build = function ()
    BWOARooms.Entrance.Init()

    BWOAPrepareTools.DarkenLight(9925, 12624, -4)

    BWOABuildTools.ELS(BWOARooms.Entrance.els)

    BWOABuildTools.LampOvalN(9938, 12624, -4)
    BWOABuildTools.LampOvalN(9928, 12624, -4)
end

BWOARooms.Entrance.SetEmitters = function ()
    BWOARooms.Entrance.Init()
end

BWOARooms.Entrance.SetFlickers = function ()
    BWOARooms.Entrance.Init()
    BWOALights.AddFlicker({x=9928, y=12624, z=-4})
end

BWOARooms.Entrance.Prepare = function ()
    BWOARooms.Entrance.Init()
end


