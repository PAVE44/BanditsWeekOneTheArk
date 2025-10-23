ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Emma = {}

ZombiePrograms.Emma.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Main = function(bandit)
    local tasks = {}
    local subTasks = BanditPrograms.Idle(bandit)
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


