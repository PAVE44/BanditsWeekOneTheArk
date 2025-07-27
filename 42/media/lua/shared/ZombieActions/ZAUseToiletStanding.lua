ZombieActions = ZombieActions or {}

ZombieActions.UseToiletStanding = {}
ZombieActions.UseToiletStanding.onStart = function(zombie, task)
    task.anim = "washFace"
    zombie:setBumpType(task.anim)
    return true
end

ZombieActions.UseToiletStanding.onWorking = function(zombie, task)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.UseToiletStanding.onComplete = function(zombie, task)
    local brain = BanditBrain.Get(zombie)
    brain.bladder = 0
    return true
end