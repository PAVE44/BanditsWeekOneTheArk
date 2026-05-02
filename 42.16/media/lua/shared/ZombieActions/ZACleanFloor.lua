ZombieActions = ZombieActions or {}

ZombieActions.CleanFloor = {}
ZombieActions.CleanFloor.onStart = function(zombie, task)
    local broomItem = BanditCompatibility.InstanceItem("Base.Mop")
    if broomItem then
        zombie:setPrimaryHandItem(broomItem)
    end
    task.anim = "CleanFloor"
    zombie:setBumpType(task.anim)
    zombie:playSound("CleanBloodScrub")
    return true
end

ZombieActions.CleanFloor.onWorking = function(zombie, task)
    local bumpType = zombie:getBumpType()
    if bumpType ~= task.anim then
        zombie:setBumpType(task.anim)
    end
end

ZombieActions.CleanFloor.onComplete = function(zombie, task)
    zombie:getEmitter():stopAll()

    local square = zombie:getCell():getGridSquare(task.x, task.y, task.z)
    if not square then return true end

    square:removeBlood(false, false)
    zombie:setPrimaryHandItem(nil)

    if ZombRand(10) == 0 then
        BWOAPermaInv.RemoveOneOfType(zombie, "Base.Bleach")
    end

    return true
end