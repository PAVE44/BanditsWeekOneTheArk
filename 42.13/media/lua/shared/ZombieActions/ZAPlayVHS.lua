ZombieActions = ZombieActions or {}

local function predicateAll(item)

	return true
end

ZombieActions.PlayVHS = {}
ZombieActions.PlayVHS.onStart = function(zombie, task)
    task.anim = "Give"
    zombie:setBumpType(task.anim)

    return true
end

ZombieActions.PlayVHS.onWorking = function(zombie, task)
    zombie:faceLocationF(task.obj.x, task.obj.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.PlayVHS.onComplete = function(zombie, task)
    local tv = BWOABaseObjects.GetIsoObject(task.obj)
    if not tv then return true end

    local dd = tv:getDeviceData()
    if not dd then return true end

    if not dd:getIsTurnedOn() then
        dd:setIsTurnedOn(true)
    end

    if dd:hasMedia() and not dd:isPlayingMedia()then
        dd:StartPlayMedia()
    end 

    return true
end

