ZombieActions = ZombieActions or {}

ZombieActions.Talk = {}
ZombieActions.Talk.onStart = function(zombie, task)
    if task.txt then
        zombie:addLineChatElement(task.txt, 0.2, 0.8, 0.1)
    end

    if task.sound then
        zombie:playSound(task.sound)
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
