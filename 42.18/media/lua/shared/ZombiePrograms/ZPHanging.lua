ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Hanging = {}
ZombiePrograms.Hanging.Stages = {}

ZombiePrograms.Hanging.Init = function(bandit)
end

ZombiePrograms.Hanging.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, true)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Hanging.Main = function(bandit)
    local tasks = {}

    local task = {action="Time", anim="Hanging1", time=200}
    table.insert(tasks, task)

    return {status=true, next="Main", tasks=tasks}
end

