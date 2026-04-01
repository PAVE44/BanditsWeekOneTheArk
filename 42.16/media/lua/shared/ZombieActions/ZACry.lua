ZombieActions = ZombieActions or {}

ZombieActions.Cry = {}
ZombieActions.Cry.onStart = function(zombie, task)
    task.anim = "Cry" .. tostring(1 + ZombRand(3))
    zombie:setBumpType(task.anim)
    local emitter = zombie:getEmitter()
    if not emitter:isPlaying("EmmaCry") then
        emitter:playSound("EmmaCry")
    end

    Bandit.Say(zombie, "CRY")

    return true
end

ZombieActions.Cry.onWorking = function(zombie, task)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.Cry.onComplete = function(zombie, task)
    -- local emitter = zombie:getEmitter()
    -- emitter:stopSoundByName("EmmaCry")
    return true
end