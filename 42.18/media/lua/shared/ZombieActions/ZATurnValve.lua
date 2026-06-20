ZombieActions = ZombieActions or {}

ZombieActions.TurnValve = {}
ZombieActions.TurnValve.onStart = function(zombie, task)
    local valve = WPVirtual.ValveGet(task.obj.x, task.obj.y, task.obj.z)
    if not valve then return {} end

    if valve.c ~= task.close then
        task.anim = "LootLow"
        zombie:setBumpType(task.anim)
        task.sound = zombie:playSound("RepairWithWrench")
    end

    return true
end

ZombieActions.TurnValve.onWorking = function(zombie, task)
    zombie:faceLocationF(task.obj.x, task.obj.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.TurnValve.onComplete = function(zombie, task)
    local emitter = zombie:getEmitter()
    emitter:stopSoundByName("RepairWithWrench")

    local valve = WPVirtual.ValveGet(task.obj.x, task.obj.y, task.obj.z)
    if not valve then return true end

    if valve.c ~= task.close then
        WPVirtual.ValveSwitch(task.obj.x, task.obj.y, task.obj.z, task.close)
    end

    return true
end

