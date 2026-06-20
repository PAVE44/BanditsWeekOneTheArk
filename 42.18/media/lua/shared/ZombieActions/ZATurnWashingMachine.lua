ZombieActions = ZombieActions or {}

local function predicateAll(item)

	return true
end

ZombieActions.TurnWashingMachine = {}
ZombieActions.TurnWashingMachine.onStart = function(zombie, task)
    local washingMachine = BWOABaseObjects.GetIsoObject(task.obj)
    if not washingMachine then return true end

    if washingMachine:isActivated() ~= task.active then
        task.anim = "Give"
        zombie:setBumpType(task.anim)
    end

    return true
end

ZombieActions.TurnWashingMachine.onWorking = function(zombie, task)
    zombie:faceLocationF(task.obj.x, task.obj.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.TurnWashingMachine.onComplete = function(zombie, task)
    local washingMachine = BWOABaseObjects.GetIsoObject(task.obj)
    if not washingMachine then return true end

    if washingMachine:isActivated() ~= task.active then
        washingMachine:setActivated(task.active)
    end

    return true
end

