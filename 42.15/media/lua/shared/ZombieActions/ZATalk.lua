ZombieActions = ZombieActions or {}

ZombieActions.Talk = {}
ZombieActions.Talk.onStart = function(zombie, task)
    if task.txt then
        zombie:addLineChatElement(task.txt, 0.2, 0.8, 0.1)
    end

    if task.voice then
        local bx, by, bz = zombie:getX(), zombie:getY(), zombie:getZ()
        --BWOASound.PlayLocation({x = bx, y = by, z = bz, sound = task.voice})
        BWOASound.PlayCharacter({character = zombie, sound = task.voice})
    end
    return true
end



ZombieActions.Talk.onWorking = function(zombie, task)

    zombie:faceLocationF(task.x, task.y)
    if zombie:getBumpType() ~= task.anim then return true end

    return false
end

ZombieActions.Talk.onComplete = function(zombie, task)
    
    return true
end
