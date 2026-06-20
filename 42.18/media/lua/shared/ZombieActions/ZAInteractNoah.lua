ZombieActions = ZombieActions or {}

local function predicateAll(item)

	return true
end

ZombieActions.InteractNoah = {}
ZombieActions.InteractNoah.onStart = function(zombie, task)
    task.anim = "Give"
    zombie:setBumpType(task.anim)

    return true
end

ZombieActions.InteractNoah.onWorking = function(zombie, task)
    zombie:faceLocationF(task.noah.x, task.noah.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.InteractNoah.onComplete = function(zombie, task)
    if task.operation == "disableAlarm" and BWOABaseAPI.alarm then
        if BWOANoah.screen == "Main" then
            BWOANoah.screen = "Alarms"
            zombie:playSound("UIKey")
            BWOANoah.LoadScreen()
        elseif BWOANoah.screen == "Alarms" then
            if BWOABaseAPI.alarm then
                BWOABaseAPI.AlarmOff()
                zombie:playSound("UIKey")
                BWOANoah.LoadScreen()
            end
        else
            BWOANoah.screen = "Main"
            zombie:playSound("UIKey")
            BWOANoah.LoadScreen()
        end
    end
        
    return true
end

