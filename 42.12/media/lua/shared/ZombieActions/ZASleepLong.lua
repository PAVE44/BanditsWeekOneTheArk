ZombieActions = ZombieActions or {}

ZombieActions.SleepLong = {}
ZombieActions.SleepLong.onStart = function(zombie, task)
    return true
end

ZombieActions.SleepLong.onWorking = function(zombie, task)
    local dx = 0.5
    local dy = 0.5
    local fx = 0 
    local fy = 0
    
    if not task.stage then task.stage = 1 end

    if task.facing == "S" then
        fy = 20
        dy = dy - 0.8
    elseif task.facing == "N" then
        fy = -20
        dy = dy + 0.8
    elseif task.facing == "E" then
        fx = 20
        dx = dx - 0.8
    elseif task.facing == "W" then
        fx = -20 
        dx = dx + 0.8   
    end

    if not zombie:isBumped() then
        if task.stage == 1 then
            zombie:setBumpType("SleepGetInBed")
            task.stage = 2

        elseif task.stage == 2 then
            zombie:setBumpType("SleepAwakeToAsleep")

            task.stage = 3
        elseif task.stage == 3 then
            zombie:setBumpType("SleepSleep")

            local gameTime = getGameTime()
            local hour = gameTime:getHour()
            local minute = gameTime:getMinutes()

            if hour == 6 then
                task.stage = 5
            end 
        elseif task.stage == 4 then
            zombie:setBumpType("SleepAsleepToAwake")

            task.stage = 5
        elseif task.stage == 5 then
            zombie:setBumpType("SleepGetOutBed")
            task.stage = 6
        elseif task.stage == 6 then
            return true
        end
    else
        if task.stage == 2 then
            if task.facing == "S" then
                fx = -20
                fy = 0
            elseif task.facing == "N" then
                fx = 20
                fy = 0
            elseif task.facing == "E" then
                fx = 0
                fy = 20
            elseif task.facing == "W" then
                fx = 0
                fy = -20
            end
            
        elseif task.stage == 6 then
            if task.facing == "S" then
                fx = 20
                fy = 0
                dy = 0.5
            elseif task.facing == "N" then
                fx = -20
                fy = 0
                dy = 0.5
            elseif task.facing == "E" then
                fx = 0
                fy = 20
                dx = 0.5
            elseif task.facing == "W" then
                fx = 0
                fy = -20
                dx = 0.5
            end
        end
    end

    

    zombie:setX(task.x + dx)
    zombie:setY(task.y + dy)
    zombie:setZ(task.z)
    zombie:faceLocationF(task.x + fx, task.y + fy)

    return false
end

ZombieActions.SleepLong.onComplete = function(zombie, task)
    return true
end