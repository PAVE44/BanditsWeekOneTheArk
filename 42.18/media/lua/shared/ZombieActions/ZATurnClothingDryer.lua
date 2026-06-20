ZombieActions = ZombieActions or {}

local function predicateAll(item)

	return true
end

ZombieActions.TurnClothingDryer = {}
ZombieActions.TurnClothingDryer.onStart = function(zombie, task)
    local dryer = BWOABaseObjects.GetIsoObject(task.obj)
    if not dryer then return true end

    if dryer:isActivated() ~= task.active then
        task.anim = "Give"
        zombie:setBumpType(task.anim)
    end

    return true
end

ZombieActions.TurnClothingDryer.onWorking = function(zombie, task)
    zombie:faceLocationF(task.obj.x, task.obj.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.TurnClothingDryer.onComplete = function(zombie, task)
    local dryer = BWOABaseObjects.GetIsoObject(task.obj)
    if not dryer then return true end

    if dryer:isActivated() ~= task.active then
        dryer:setActivated(task.active)
    end

    return true
end

