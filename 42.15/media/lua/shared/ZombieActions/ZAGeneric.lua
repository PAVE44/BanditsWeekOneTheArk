ZombieActions = ZombieActions or {}

ZombieActions.Generic = {}
ZombieActions.Generic.onStart = function(zombie, task)


    if task.txt then
        local textColor = task.txtColor or {r=0.2, g=0.8, b=0.1}
        zombie:addLineChatElement(task.txt, textColor.r, textColor.g, textColor.b)
    end

    if task.voice then
        local bx, by, bz = zombie:getX(), zombie:getY(), zombie:getZ()
        BWOASound.PlayCharacter({character = zombie, sound = task.voice})
    end

    if task.primaryItem then
        local itemHeld = zombie:getPrimaryHandItem()
        if not itemHeld or itemHeld:getFullType() ~= task.primaryItem then
            local itemHeld = BanditCompatibility.InstanceItem(task.primaryItem)
            if itemHeld then
                zombie:setPrimaryHandItem(itemHeld)
            end
        end
    end

    if task.secondaryItem then
        local itemHeld = zombie:getSecondaryHandItem()
        if not itemHeld or itemHeld:getFullType() ~= task.secondaryItem then
            local itemHeld = BanditCompatibility.InstanceItem(task.secondaryItem)
            if itemHeld then
                zombie:setSecondaryHandItem(itemHeld)
            end
        end
    end

    if task.voice then
        local bx, by, bz = zombie:getX(), zombie:getY(), zombie:getZ()
        BWOASound.PlayCharacter({character = zombie, sound = task.voice})
    end
    return true
end



ZombieActions.Generic.onWorking = function(zombie, task)

    if task.ox then
        local newx = math.floor(zombie:getX() + task.ox)
        zombie:setX(newx)
    end
    if task.oy then
        local newy = math.floor(zombie:getY() + task.oy)
        zombie:setY(newy)
    end
    if task.oz then
        local newz = math.floor(zombie:getZ() + task.oz)
        zombie:setZ(newz)
    end

    if task.fx and task.fy then
        zombie:faceLocationF(task.fx, task.fy)
    end

    if zombie:getBumpType() ~= task.anim then
        if task.looped then
            zombie:setBumpType(task.anim)
        else
            return true 
        end
    end
    return false
end

ZombieActions.Generic.onComplete = function(zombie, task)
    return true
end
