ZombieActions = ZombieActions or {}

ZombieActions.Research = {}
ZombieActions.Research.onStart = function(zombie, task)

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



ZombieActions.Research.onWorking = function(zombie, task)

    if task.ox then
        zombie:setX(task.ox)
    end
    if task.oy then
        zombie:setY(task.oy)
    end
    if task.oz then
        zombie:setZ(task.oz)
    end

    -- zombie:addLineChatElement("x: " .. zombie:getX() .. ", y: " .. zombie:getY(), 1, 0, 1)

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

ZombieActions.Research.onComplete = function(zombie, task)
    local brain = BanditBrain.Get(zombie)

    local cap = 20
    
    -- zombie specimen available for research
    if BWOAMissions.IsAccomplished(5) then
        cap = cap + 20
    end

    -- human specimen available for research
    if BWOAMissions.IsAccomplished(14) then
        cap = cap + 20
    end

    -- secret syringe available for research
    if BWOAMissions.IsAccomplished(113) then
        cap = cap + 20
    end

    -- comfrey available for research
    if BWOAMissions.IsAccomplished(113) then
        cap = cap + 20
    end

    local stalled = false
    if brain.research then
        brain.research = brain.research + 0.01
        if brain.research > cap then
            brain.research = cap
            stalled = true
        end
    else
        brain.research = 0.01
    end

    if brain.research > 85 then
        BWOADialogues.Hide("Emma_Robinson", "400.1")
        BWOADialogues.Hide("Emma_Robinson", "400.2")
        BWOADialogues.Hide("Emma_Robinson", "400.3")
        BWOADialogues.Hide("Emma_Robinson", "400.4")
        BWOADialogues.Reveal("Emma_Robinson", "400.4")
    elseif brain.research > 65 then
        BWOADialogues.Hide("Emma_Robinson", "400.1")
        BWOADialogues.Hide("Emma_Robinson", "400.2")
        BWOADialogues.Hide("Emma_Robinson", "400.3")
        BWOADialogues.Reveal("Emma_Robinson", "400.4")
    elseif brain.research > 45 then
        BWOADialogues.Hide("Emma_Robinson", "400.1")
        BWOADialogues.Hide("Emma_Robinson", "400.2")
        BWOADialogues.Reveal("Emma_Robinson", "400.3")
    elseif brain.research > 25 then
        BWOADialogues.Hide("Emma_Robinson", "400.1")
        BWOADialogues.Reveal("Emma_Robinson", "400.2")
    elseif brain.research > 5 then
        BWOADialogues.Reveal("Emma_Robinson", "400.1")
    end

    local txt = "Research: " .. string.format("%.2f", brain.research) .. "%"
    if stalled then
        txt = txt .. " (stalled)"
    end

    local textColor = task.txtColor or {r=0.2, g=0.8, b=0.1}
    zombie:addLineChatElement(txt, textColor.r, textColor.g, textColor.b)

    return true
end
