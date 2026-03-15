ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Angel = {}
ZombiePrograms.Angel.Stages = {}

ZombiePrograms.Angel.Init = function(bandit)
end

ZombiePrograms.Angel.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, true)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Angel.Main = function(bandit)
    local tasks = {}
    local player = getSpecificPlayer(0)

    local task = {action="FaceLocation", anim="IdleFemale", x = player:getX(), y = player:getY(), time=200}
    table.insert(tasks, task)

    return {status=true, next="Main", tasks=tasks}
end

