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

    BWOARooms.Control.noah = {x=9961, y=12620, z=-4}

    BWOARooms.Control.vents = {
        {x=9959, y=12626.5, z=-4},
    }

    BWOARooms.Control.els ={
        {dir="W", x=9959, y=12622, z=-4},
        {dir="W", x=9959, y=12623, z=-4},
        {dir="W", x=9959, y=12624, z=-4},
        {dir="XW", x=9959, y=12625, z=-4},
        {dir="W", x=9959, y=12626, z=-4},
        {dir="W", x=9959, y=12629, z=-4},
        {dir="S", x=9961, y=12630, z=-4},
        {dir="S", x=9962, y=12630, z=-4},
        {dir="E", x=9964, y=12629, z=-4},
        {dir="E", x=9964, y=12628, z=-4},
        {dir="E", x=9964, y=12627, z=-4},
        {dir="E", x=9964, y=12624, z=-4},
        {dir="E", x=9964, y=12623, z=-4},
        {dir="E", x=9964, y=12622, z=-4},
        {dir="E", x=9964, y=12621, z=-4},
    }
end

BWOARooms.Control.Build = function ()

    BWOARooms.Control.Init()

    BWOAPrepareTools.DarkenLight(9959, 12624, -4)

    BWOABuildTools.ELS(BWOARooms.Control.els)

    BWOABuildTools.LampOvalW(9959, 12624, -4)
    BWOABuildTools.LampOvalE(9964, 12622, -4)

    BWOABuildTools.LampDeskYellowS(9960, 12630, -4)
    BWOABuildTools.LampDeskYellowS(9964, 12630, -4)
    BWOABuildTools.LampDeskYellowN(9963, 12626, -4)
    BWOABuildTools.LampDeskYellowS(9964, 12625, -4)

    BWOABuildTools.Generic(9960, 12621, -4, "theark_01_2")
    BWOABuildTools.Generic(9961, 12621, -4, "theark_01_4")
    BWOABuildTools.Generic(9962, 12621, -4, "theark_01_3")
    BWOABuildTools.Generic(9963, 12621, -4, "theark_01_2")
    BWOABuildTools.Generic(9964, 12621, -4, "theark_01_3")
end

BWOARooms.Control.SetEmitters = function ()
    BWOARooms.Control.Init()
    BWOASound.AddToObject({x=9959.5, y=12621, z=-4, elec=true, sound="AmbientElectricity"})
    BWOASound.AddToObject({x=9961.5, y=12620, z=-4, elec=true, sound="AmbientComputer"})
    BWOASound.AddToObject({x=9963.5, y=12621, z=-4, elec=true, sound="AmbientElectricity"})
end

BWOARooms.Control.SetFlickers = function ()
    BWOARooms.Control.Init()
end

BWOARooms.Control.Prepare = function ()
    BWOARooms.Control.Init()
end


