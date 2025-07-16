BWOARooms = BWOARooms or {}

BWOARooms.Infirmary = {}

BWOARooms.Infirmary.Init = function ()
    BWOARooms.Infirmary.name = "INFIRMARY"
    BWOARooms.Infirmary.x1 = 9965
    BWOARooms.Infirmary.x2 = 9970
    BWOARooms.Infirmary.y1 = 12621
    BWOARooms.Infirmary.y2 = 12627
    BWOARooms.Infirmary.z = -4
    BWOARooms.Infirmary.ambience = ""

end

BWOARooms.Infirmary.Build = function ()
    BWOABuildTools.LampOvalW(9965, 12624, -4)
    BWOABuildTools.LampOvalW(9968, 12626, -4)

    BWOABuildTools.Generic(9965, 12623, -4, "location_community_medical_01_24")

    BWOABuildTools.LampDeskYellowS(9970, 12622, -4)
end

BWOARooms.Infirmary.SetEmitters = function ()
    -- BWOASound.AddToObject({x=9945, y=12620, z=-4, sound="AmbientInfirmary"})
    -- BWOASound.AddToObject({x=9944, y=12618, z=-4, sound="AmbientElectricity"})
    -- BWOASound.AddToObject({x=9950, y=12622, z=-4, sound="AmbientElectricity"})
end

BWOARooms.Infirmary.SetFlickers = function ()
    BWOALights.AddFlicker({x=9965, y=12624, z=-4})
end

BWOARooms.Infirmary.Prepare = function ()
    BWOAPrepareTools.DarkenLight(9970, 12625, -4)
    BWOAPrepareTools.DarkenLight(9969, 12627, -4)

    BWOAPrepareTools.AddWorldItem(9969, 12622, -4, "Base.Paperwork", {x=0.5, y=0.5, z=0.35})
    BWOAPrepareTools.AddWorldItem(9969, 12622, -4, "Base.BluePen", {x=0.4, y=0.5, z=0.35})
end

BWOARooms.Infirmary.LightToggle = function ()
end

