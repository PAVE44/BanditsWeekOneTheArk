BWOARooms = BWOARooms or {}

BWOARooms.ServiceTunnels = {}

BWOARooms.ServiceTunnels.Init = function ()
    BWOARooms.ServiceTunnels.name = "SERVICE_TUNNELS"
    BWOARooms.ServiceTunnels.x1 = 9944
    BWOARooms.ServiceTunnels.x2 = 9956
    BWOARooms.ServiceTunnels.y1 = 12615
    BWOARooms.ServiceTunnels.y2 = 12623
    BWOARooms.ServiceTunnels.z = -5
    BWOARooms.ServiceTunnels.ambience = ""

    BWOARooms.ServiceTunnels.els = {}
end

BWOARooms.ServiceTunnels.Build = function ()
    BWOARooms.ServiceTunnels.Init()

    -- under control room
    BWOABuildTools.LampBatteryWeak(9960, 12625, -5, "lighting_indoor_02_44")
    BWOABuildTools.Generic(9960, 12624, -5, "industry_02_171")
    BWOABuildTools.Generic(9960, 12623, -5, "industry_02_163")
    BWOABuildTools.Generic(9960, 12622, -5, "industry_02_174")
    BWOABuildTools.Generic(9961, 12622, -5, "industry_02_169")
    BWOABuildTools.Generic(9962, 12622, -5, "industry_02_165")

    -- under generator room
    -- BWOABuildTools.LampBatteryWeak(9953, 12620, -5, "lighting_indoor_02_46")
    -- BWOABuildTools.LampBatteryWeak(9954, 12620, -5, "lighting_indoor_02_46")
    BWOABuildTools.LampBatteryWeak(9953, 12615, -5, "lighting_indoor_02_45")
    -- BWOABuildTools.LampBatteryWeak(9954, 12615, -5, "lighting_indoor_02_45")
    
    -- corridors
    BWOABuildTools.LampBatteryWeak(9969, 12638, -5, "lighting_indoor_02_44")
    BWOABuildTools.LampBatteryWeak(9969, 12634, -5, "lighting_indoor_02_44")
    BWOABuildTools.LampBatteryWeak(9969, 12628, -5, "lighting_indoor_02_44")
    BWOABuildTools.LampBatteryWeak(9962, 12626, -5, "lighting_indoor_02_45")
    BWOABuildTools.LampBatteryWeak(9954, 12623, -5, "lighting_indoor_02_45")
    BWOABuildTools.LampBatteryWeak(9951, 12623, -5, "lighting_indoor_02_44")
    BWOABuildTools.LampBatteryWeak(9962, 12619, -5, "lighting_indoor_02_45")
    BWOABuildTools.LampBatteryWeak(9965, 12608, -5, "lighting_indoor_02_44")

    -- water tanks
    BWOABuildTools.LampBatteryWeak(9951, 12603, -5, "lighting_indoor_03_18")
    BWOABuildTools.LampBatteryWeak(9958, 12603, -5, "lighting_indoor_03_18")
    BWOABuildTools.LampBatteryWeak(9951, 12611, -5, "lighting_indoor_03_18")
    BWOABuildTools.LampBatteryWeak(9958, 12611, -5, "lighting_indoor_03_18")
    BWOABuildTools.LampBatteryWeak(9959, 12600, -7, "lighting_indoor_02_45")
    BWOABuildTools.LampBatteryWeak(9952, 12600, -7, "lighting_indoor_02_45")
    BWOABuildTools.LampBatteryWeak(9959, 12614, -7, "lighting_indoor_02_46")
    BWOABuildTools.LampBatteryWeak(9952, 12614, -7, "lighting_indoor_02_46")

    -- storage room
    BWOABuildTools.LampBatteryWeak(9957, 12617, -5, "lighting_indoor_02_44")

end

BWOARooms.ServiceTunnels.SetEmitters = function ()
    BWOARooms.ServiceTunnels.Init()
    BWOASound.AddToObject({x=9968, y=12631, z=-5, elec=true, sound="AmbientElectricity"})
    BWOASound.AddToObject({x=9956, y=12626, z=-5, elec=true, sound="AmbientElectricity"})
    BWOASound.AddToObject({x=9960, y=12623, z=-5, elec=true, sound="AmbientElectricity"})
end

BWOARooms.ServiceTunnels.SetFlickers = function ()
    BWOARooms.ServiceTunnels.Init()
    BWOALights.AddFlicker({x=9954, y=12615, z=-5})
    BWOALights.AddFlicker({x=9962, y=12626, z=-5})
end

BWOARooms.ServiceTunnels.Prepare = function ()
    BWOARooms.ServiceTunnels.Init()

    local tablets = {["Bandits.NBCTablets"] = 20}
    BWOAPrepareTools.AddItemsToContainer(9950, 12621, -5, tablets, "Locker")

    local generatorItems = {["Base.EngineMaul"] = 2, ["Base.EngineParts"] = 3, ["Bandits.EngineCoolant"] = 4, ["Bandits.EngineLubricant"] = 1}
    BWOAPrepareTools.AddItemsToContainer(9967, 12625, -5, generatorItems, "Locker")
end

