ZombieActions = ZombieActions or {}

local function predicateAll(item)

	return true
end

ZombieActions.TurnOven = {}
ZombieActions.TurnOven.onStart = function(zombie, task)
    task.anim = "Give"
    zombie:setBumpType(task.anim)

    return true
end

ZombieActions.TurnOven.onWorking = function(zombie, task)
    zombie:faceLocationF(task.obj.x, task.obj.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.TurnOven.onComplete = function(zombie, task)
    local oven = BWOABaseObjects.GetIsoObject(task.obj)
    if not oven then return true end

    oven:setActivated(task.active)

    return true
end

