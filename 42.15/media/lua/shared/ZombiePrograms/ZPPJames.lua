ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.James = {}
ZombiePrograms.James.Stages = {}

ZombiePrograms.James.Init = function(bandit)
end

ZombiePrograms.James.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, true)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.James.Main = function(bandit)
    local tasks = {}

    local fx, fy = bandit:getX() + 2, bandit:getY() - 2
    bandit:faceLocation(fx, fy)
    local task = {action="Time", anim="Pray", time=200}
    table.insert(tasks, task)

    return {status=true, next="Main", tasks=tasks}
end

