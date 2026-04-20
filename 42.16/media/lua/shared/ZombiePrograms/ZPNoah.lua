ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Noah = {}
ZombiePrograms.Noah.Stages = {}

ZombiePrograms.Noah.Init = function(bandit)
end

ZombiePrograms.Noah.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Noah.Main = function(bandit)
    local tasks = {}
    local player = getSpecificPlayer(0)

    --[[
    bandit:setX(18002)
    bandit:setY(4201)
    bandit:setZ(-3)
    ]]

    bandit:setBumpType("SitInChair1")

    local task = {action="SitInChair", anim="SitInChair1", looped=true, x=18001.8, y=4200.45, z=-3, facing="S", time=200}
    table.insert(tasks, task)
    
    return {status=true, next="Main", tasks=tasks}
end

