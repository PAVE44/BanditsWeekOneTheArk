ZombieActions = ZombieActions or {}

ZombieActions.UseToiletStanding = {}
ZombieActions.UseToiletStanding.onStart = function(zombie, task)
    return true
end

ZombieActions.UseToiletStanding.onWorking = function(zombie, task)
    if task.ox then
        zombie:setX(task.ox)
    end
    if task.oy then
        zombie:setY(task.oy)
    end
    if task.oz then
        zombie:setZ(task.oz)
    end

    if task.f then
        local dx, dy = 0, 0
        if task.f == "E" then
            dx = 1
        elseif task.f == "W" then
            dx = -1
        elseif task.f == "N" then
            dy = -1
        elseif task.f == "S" then
            dy = 1
        end
        local doorSquare = getCell():getGridSquare(zombie:getX() + dx, zombie:getY() + dy, zombie:getZ())
        if doorSquare then
            local door = doorSquare:getIsoDoor()
            if door then
                if door:IsOpen() then
                    door:DirtySlice()
                    IsoGridSquare.RecalcLightTime = -1.0
                    doorSquare:InvalidateSpecialObjectPaths()
                    door:ToggleDoorSilent()
                    doorSquare:RecalcProperties()
                    door:syncIsoObject(false, 1, nil, nil)
                    local brain = BanditBrain.Get(zombie)
                    local tab = {}
                    tab.id = brain.id
                    tab.txt = "Occupied!"
                    tab.sound = "VoiceFemaleShoutHey"
                    BWOAEventControl.Add("SayBandit", tab, 250)
                end
            end
        end
    end
    

    -- zombie:addLineChatElement("x: " .. zombie:getX() .. ", y: " .. zombie:getY(), 1, 0, 1)

    if task.fx and task.fy then
        zombie:faceLocationF(task.fx, task.fy)
    end

    -- print (task.time)
    if zombie:getBumpType() ~= task.anim then
        if task.looped then
            zombie:setBumpType(task.anim)
        else
            return true 
        end
    end
    return false
end

ZombieActions.UseToiletStanding.onComplete = function(zombie, task)
    if task.item then
        if task.left then
            zombie:setSecondaryHandItem(nil)
        else
            zombie:setPrimaryHandItem(nil)
        end
    end

    if task.f then
        local dx, dy = 0, 0
        if task.f == "E" then
            dx = 1
        elseif task.f == "W" then
            dx = -1
        elseif task.f == "N" then
            dy = -1
        elseif task.f == "S" then
            dy = 1
        end

        local doorSquare = getCell():getGridSquare(zombie:getX() + dx, zombie:getY() + dy, zombie:getZ())
        if doorSquare then
            local door = doorSquare:getIsoDoor()
            if door then
                if not door:IsOpen() then
                    door:DirtySlice()
                    IsoGridSquare.RecalcLightTime = -1.0
                    doorSquare:InvalidateSpecialObjectPaths()
                    door:ToggleDoorSilent()
                    doorSquare:RecalcProperties()
                    door:syncIsoObject(false, 1, nil, nil)
                    local brain = BanditBrain.Get(zombie)
                    local tab = {}
                    tab.id = brain.id
                    tab.txt = "Occupied!"
                    tab.sound = "VoiceFemaleShoutHey"
                    BWOAEventControl.Add("SayBandit", tab, 250)
                end
            end
        end
    end

    local tab = {x = zombie:getX(), y = zombie:getY(), z = zombie:getZ(), sound = "ToiletFlush"}
    BWOASound.PlayLocation(tab)

    local brain = BanditBrain.Get(zombie)
    brain.bladder = 0
    return true
end