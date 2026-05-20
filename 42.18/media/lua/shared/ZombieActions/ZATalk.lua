ZombieActions = ZombieActions or {}

ZombieActions.Talk = {}
ZombieActions.Talk.onStart = function(zombie, task)
    if task.txt then
        local textColor = task.txtColor or {r=0.2, g=0.8, b=0.1}
        zombie:addLineChatElement(task.txt, textColor.r, textColor.g, textColor.b)
    end

    if task.voice then
        local bx, by, bz = zombie:getX(), zombie:getY(), zombie:getZ()
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
