ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Emma = {}

ZombiePrograms.name = "Emma Robinson"
ZombiePrograms.Emma.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Main = function(bandit)
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
            hourMax = 6,
            minuteMin = 0,
            minuteMax = 60
        }
    }

    local brain = BanditBrain.Get(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    if brain.bladder and brain.bladder > 20 then
        bandit:addLineChatElement("ACTIVITY: TOILET", 0, 0, 1)
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
            bandit:addLineChatElement("ACTIVITY: SHOWER", 0, 0, 1)
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
            bandit:addLineChatElement("ACTIVITY: SLEEP", 0, 0, 1)
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

    local config = {}
    config.mustSee = false
    config.hearDist = 50

    if not BWOAMissions.IsAccomplished(1) then
        local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit, config)

        if closestPlayer.x and closestPlayer.y and closestPlayer.z and closestPlayer.dist > 4 then
            Bandit.Say(bandit, "WAITTALK")
            BWOADialogues.Reveal(ZombiePrograms.name, "4")
            table.insert(tasks, BanditUtils.GetMoveTask(0, closestPlayer.x, closestPlayer.y, closestPlayer.z, "Run", closestPlayer.dist, false))
            return {status=true, next="Main", tasks=tasks}
        end
    end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Leisure = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.WaterHunt = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.FoodHunt = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Toilet = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end


