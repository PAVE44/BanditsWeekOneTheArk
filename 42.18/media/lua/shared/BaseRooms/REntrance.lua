BWOARooms = BWOARooms or {}

BWOARooms.Entrance = {}

BWOARooms.Entrance.Init = function ()
    BWOARooms.Entrance.name = "ENTRANCE"
    BWOARooms.Entrance.x1 = 9918
    BWOARooms.Entrance.x2 = 9943
    BWOARooms.Entrance.y1 = 12623
    BWOARooms.Entrance.y2 = 12627
    BWOARooms.Entrance.z = -4
    BWOARooms.Entrance.ambience = ""

    BWOARooms.Entrance.vents = {}

    BWOARooms.Entrance.els = {}

    BWOARooms.Entrance.doors = {
        -- {x = 9926, y = 12625, z = 0},
        {
            x = 9924, 
            y = 12625, 
            z = -4,
            panels = {
                {x = 9924, y = 12624, z = -4}
            }
        },
        {
            x = 9934, 
            y = 12625, 
            z = -4,
            panels = {
                {x = 9933, y = 12624, z = -4},
                {x = 9934, y = 12624, z = -4},
            }
        },
        {
            x = 9944, 
            y = 12625, 
            z = -4,
            panels = {
                {x = 9943, y = 12624, z = -4},
            }
        },
    }
end

BWOARooms.Entrance.Build = function ()
    BWOARooms.Entrance.Init()

    BWOAPrepareTools.DarkenLight(9925, 12624, -4)

    BWOABuildTools.ELS(BWOARooms.Entrance.els)

    BWOABuildTools.LampOvalN(9938, 12624, -4)
    BWOABuildTools.LampOvalN(9928, 12624, -4)

    -- door panels
    for _, doorConf in ipairs(BWOARooms.Entrance.doors) do
        for _, panel in ipairs(doorConf.panels) do
            BWOABuildTools.WallPanel(panel.x, panel.y, panel.z)
        end
    end

    BWOABuildTools.RemoveObject(9925, 12624, -4, "walls_garage_01_37")
    BWOABuildTools.WindowFrame(9925, 12624, -4, "theark_01_25", true)
    BWOABuildTools.Window(9925, 12624, -4, "theark_01_26", true)

    BWOABuildTools.RemoveObject(9932, 12624, -4, "walls_garage_01_37")
    BWOABuildTools.WindowFrame(9932, 12624, -4, "theark_01_25", true)
    BWOABuildTools.Window(9932, 12624, -4, "theark_01_26", true)

    BWOABuildTools.RemoveObject(9935, 12624, -4, "walls_garage_01_37")
    BWOABuildTools.WindowFrame(9935, 12624, -4, "theark_01_25", true)
    BWOABuildTools.Window(9935, 12624, -4, "theark_01_26", true)

    BWOABuildTools.RemoveObject(9941, 12624, -4, "walls_garage_01_37")
    BWOABuildTools.WindowFrame(9941, 12624, -4, "theark_01_25", true)
    BWOABuildTools.Window(9941, 12624, -4, "theark_01_26", true)

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

BWOARooms.Entrance.Logic = function ()
    BWOARooms.Entrance.Init()

    local emergency = false
    if not BWOABaseControl.power then emergency = true end
    if not BWOANoah.IsOn() then emergency = true end
    if BWOANoah.GetState() ~= "operational" then emergency = true end

    local gmd = GetBWOAModData()
    local forceopen = false
    local ventilation = gmd.ventilation
    if ventilation.co2 > 30000 then
        emergency = true
        forceopen = true
    end

    local player = getSpecificPlayer(0)
    local banditList = BanditZombie.CacheLightB
    for _, doorConf in ipairs(BWOARooms.Entrance.doors) do
        local square = getCell():getGridSquare(doorConf.x, doorConf.y, doorConf.z)
        if square then
            local objects = square:getObjects()
            if objects:size() > 1 then
                local object = objects:get(1)
                if instanceof(object, "IsoDoor") then
                    local present = false
                    for _, bandit in pairs(banditList) do
                        if bandit.brain and not bandit.brain.hostile then
                            if bandit.z == doorConf.z then
                                local dist = BanditUtils.DistTo(bandit.x, bandit.y, doorConf.x, doorConf.y)
                                if dist < 4 then
                                    present = true
                                    break
                                end
                            end
                        end
                    end
                    if player:getZ() == doorConf.z then
                        local dist = BanditUtils.DistTo(player:getX(), player:getY(), doorConf.x, doorConf.y)
                        if dist < 4 then
                            present = true
                        end
                    end

                    local md = object:getModData()
                    if present or emergency then
                        -- IsoDoor.toggleGarageDoor(object, true)
                        if md.CustomLock then
                            print ("unlocking door at " .. doorConf.x .. ", " .. doorConf.y)
                            if not object:IsOpen() then
                                local garageDoorObjects = buildUtil.getGarageDoorObjects(object)
                                for i=1, #garageDoorObjects do
                                    local obj = garageDoorObjects[i]
                                    obj:getModData().CustomLock = false
                                    BWOABuildTools.RemoveObject(obj:getX(), obj:getY(), obj:getZ(), "location_entertainment_theatre_01_136")
                                    BWOABuildTools.DoorLightOn(obj:getX(), obj:getY(), obj:getZ())
                                end
                                BWOASound.PlayLocation({sound="PneumaticLock", x=doorConf.x, y=doorConf.y, z=doorConf.z})
                                for _, panel in ipairs(doorConf.panels) do
                                    BWOABuildTools.RemoveObject(panel.x, panel.y, panel.z, "theark_01_14")
                                    BWOABuildTools.WallPanelOn(panel.x, panel.y, panel.z)
                                end
                            end
                        end

                        if emergency and forceopen and not object:IsOpen() then
                            print ("opening door at " .. doorConf.x .. ", " .. doorConf.y)
                            IsoDoor.toggleGarageDoor(object, false)
                            BWOASound.PlayLocation({sound="GarageDoorOpen", x=doorConf.x, y=doorConf.y, z=doorConf.z})
                        end

                    else
                        if object:IsOpen() then
                            print ("closing door at " .. doorConf.x .. ", " .. doorConf.y)
                            IsoDoor.toggleGarageDoor(object, false)
                            BWOASound.PlayLocation({sound="GarageDoorClose", x=doorConf.x, y=doorConf.y, z=doorConf.z})
                        end

                        if not md.CustomLock then
                            print ("locking door at " .. doorConf.x .. ", " .. doorConf.y)
                            BWOASound.PlayLocation({sound="PneumaticLockDelayed", x=doorConf.x, y=doorConf.y, z=doorConf.z})
                            local garageDoorObjects = buildUtil.getGarageDoorObjects(object)
                            for i=1, #garageDoorObjects do
                                local obj = garageDoorObjects[i]
                                obj:getModData().CustomLock = true
                                BWOABuildTools.RemoveObject(obj:getX(), obj:getY(), obj:getZ(), "location_entertainment_theatre_01_208")
                                BWOABuildTools.DoorLight(obj:getX(), obj:getY(), obj:getZ())
                            end
                            for _, panel in ipairs(doorConf.panels) do
                                BWOABuildTools.RemoveObject(panel.x, panel.y, panel.z, "theark_01_15")
                                BWOABuildTools.WallPanel(panel.x, panel.y, panel.z)
                            end
                        end
                    end
                end
            end
        end
    end
end
