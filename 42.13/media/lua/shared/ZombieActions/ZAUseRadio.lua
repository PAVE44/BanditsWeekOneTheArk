ZombieActions = ZombieActions or {}

ZombieActions.UseRadio = {}
ZombieActions.UseRadio.onStart = function(zombie, task)

    Bandit.Say(zombie, "RADIOCALL")

    return true
end

ZombieActions.UseRadio.onWorking = function(zombie, task)
    zombie:faceLocation(task.fx, task.fy)
    if task.time <= 0 then
       return true
    end
    return false
end

ZombieActions.UseRadio.onComplete = function(zombie, task)
    return true
end