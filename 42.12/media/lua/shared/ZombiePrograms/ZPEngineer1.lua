ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Engineer1 = {}

ZombiePrograms.Engineer1.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Engineer1.Main = function(bandit)
    local tasks = {}
    
    local schedule = {
        --[[
        shower = {
            hourMin = 16,
            hourMax = 16,
            minuteMin = 0,
            minuteMax = 40
        },
        sleep1 = {
            hourMin = 23,
            hourMax = 23,
            minuteMin = 20,
            minuteMax = 60
        },
        ]]
        sleep2 = {
            hourMin = 0,
            hourMax = 24,
            minuteMin = 0,
            minuteMax = 60
        }
    }

    local brain = BanditBrain.Get(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    if brain.bladder > 20 then
        local obj, dist = BWOABaseObjects.FindClosestObject({"Toilet"}, {x=bx, y=by})
        if obj then
            local task = {action="UseToiletStanding", time=300}
            local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
            if #subTasks > 0 then
                for _, subTask in pairs(subTasks) do
                    table.insert(tasks, subTask)
                end
                return {status=true, next="Main", tasks=tasks}
            end
        end
    end


    local activity = BanditUtils.GetScheduledActivity(schedule)
    if activity then
        if activity == "shower" then
            local obj, dist = BWOABaseObjects.FindClosestObject({"Shower"}, {x=bx, y=by})
            if obj then
                local task = {action="UseToiletStanding", time=300}
                local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                if #subTasks > 0 then
                    for _, subTask in pairs(subTasks) do
                        table.insert(tasks, subTask)
                    end
                    return {status=true, next="Main", tasks=tasks}
                end
            end
        elseif activity == "sleep1" or activity == "sleep2" then
            local obj, dist = BWOABaseObjects.FindClosestObject({"Beds", "Bed"}, {x=bx, y=by})
            if obj then
                local bed = BWOABaseObjects.GetIsoObject(obj)
                local facing = bed:getSprite():getProperties():Val("Facing")
                -- local eoffset = bed:getSprite():getProperties():Val("Eoffset")
                local task = {action="SleepLong", x=obj.x, y=obj.y, z=obj.z, facing=facing, time=3000}
                local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                if #subTasks > 0 then
                    for _, subTask in pairs(subTasks) do
                        table.insert(tasks, subTask)
                    end
                    return {status=true, next="Main", tasks=tasks}
                end
            end
        end
    end


    --[[
    local routine = "Leisure"
    if brain.thirst < 20 then 
        routine = "WaterHunt"
    elseif brain.hunger < 20 then
        routine = "FoodHunt"
    elseif brain.bladder < 20 then
        routine = "Toilet"
    end]]

    -- toilet if bladder
    -- water if thirsty (use sink them item)
    -- food if hungry
    
    -- wash if dirty

    -- time based:
    -- change to work
    -- breakfast
    -- work
    -- lunch
    -- work
    -- change to normal
    -- leisure
    -- dinner
    -- leisure
    -- change to wash
    -- wash
    -- change to sleep
    -- sleep


    


    local subTasks = BanditPrograms.Idle(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Engineer1.Leisure = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Engineer1.WaterHunt = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Engineer1.FoodHunt = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Engineer1.Toilet = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end


