ZombieActions = ZombieActions or {}

local function predicateAll(item)

	return true
end

ZombieActions.InteractPump = {}
ZombieActions.InteractPump.onStart = function(zombie, task)
    local pump = WPVirtual.PumpGet(task.obj.x, task.obj.y, task.obj.z)
    if not pump then return true end

    task.anim = "Give"
    zombie:setBumpType(task.anim)

    return true
end

ZombieActions.InteractPump.onWorking = function(zombie, task)
    zombie:faceLocationF(task.obj.x, task.obj.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.InteractPump.onComplete = function(zombie, task)
    local pump = WPVirtual.PumpGet(task.obj.x, task.obj.y, task.obj.z)
    if not pump then return true end

    if task.operation == "toggle" then
        local square = getCell():getGridSquare(task.obj.x, task.obj.y, task.obj.z)
        if square then
            local isoPump = WPIso.GetPump(square)
            if isoPump and not isoPump:isActivated() and pump and not pump.active and pump.efficiency > 0 and square:haveElectricity() then
                isoPump:setActivated(task.active)
                WPVirtual.PumpActivate(task.obj.x, task.obj.y, task.obj.z, task.active)
                if task.active then
                    WPSound.AddToObject(isoPump, "WPWaterPumpLoop", 0.5)
                else
                    WPSound.RemoveFromObject(isoPump)
                end
            end
        end
    end
    return true
end

