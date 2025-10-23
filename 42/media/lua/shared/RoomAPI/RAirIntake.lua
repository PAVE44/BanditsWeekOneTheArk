BWOARooms = BWOARooms or {}

BWOARooms.AirIntake = {}

BWOARooms.AirIntake.Init = function ()
    BWOARooms.AirIntake.name = "AIRINTAKE"
    BWOARooms.AirIntake.x1 = 9940
    BWOARooms.AirIntake.x2 = 9941
    BWOARooms.AirIntake.y1 = 12633
    BWOARooms.AirIntake.y2 = 12634
    BWOARooms.AirIntake.z = 0
    BWOARooms.AirIntake.ambience = ""
end

BWOARooms.AirIntake.Build = function ()
    BWOARooms.AirIntake.Init()
    BWOABuildTools.Generic(9940, 12633, 0, "theark_01_5")
    BWOABuildTools.Generic(9940, 12634, 0, "theark_01_6")
    BWOABuildTools.Generic(9941, 12633, 0, "theark_01_5")
    BWOABuildTools.Generic(9941, 12634, 0, "theark_01_6")
end

BWOARooms.AirIntake.SetEmitters = function ()
    BWOARooms.AirIntake.Init()
end

BWOARooms.AirIntake.SetAnims = function ()
    BWOARooms.AirIntake.Init()

    

end

BWOARooms.AirIntake.SetFlickers = function ()
    BWOARooms.AirIntake.Init()
end

BWOARooms.AirIntake.Prepare = function ()
    BWOARooms.AirIntake.Init()
end


