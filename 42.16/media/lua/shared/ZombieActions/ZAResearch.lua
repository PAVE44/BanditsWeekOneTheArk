ZombieActions = ZombieActions or {}

ZombieActions.Research = {}
ZombieActions.Research.onStart = function(zombie, task)

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
    local gmd = GetBWOAModData()

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
    if BWOAMissions.IsAccomplished(103) then
        cap = cap + 20
    end

    local multiplier = 744 / BWOAClimate.falloutEndsOptionMap[SandboxVars.BWOA.FalloutEnds]
    local stalled = false
    if gmd.research then
        gmd.research = gmd.research + 0.05 * multiplier
        if gmd.research > cap then
            gmd.research = cap
            stalled = true
        end
    else
        gmd.research = 0.05 * multiplier
    end

    if gmd.research >= 100 then
        BWOADialogues.Hide("Emma_Robinson", "400.1")
        BWOADialogues.Hide("Emma_Robinson", "400.2")
        BWOADialogues.Hide("Emma_Robinson", "400.3")
        BWOADialogues.Hide("Emma_Robinson", "400.4")
        BWOADialogues.Hide("Emma_Robinson", "400.5")
        BWOADialogues.Reveal("Emma_Robinson", "400.6")
    elseif gmd.research > 85 then
        if BWOAMissions.IsAccomplished(103) then
            BWOADialogues.Hide("Emma_Robinson", "400.1")
            BWOADialogues.Hide("Emma_Robinson", "400.2")
            BWOADialogues.Hide("Emma_Robinson", "400.3")
            BWOADialogues.Hide("Emma_Robinson", "400.4")
            BWOADialogues.Reveal("Emma_Robinson", "400.5")
        end
    elseif gmd.research > 65 then
        if BWOAMissions.IsAccomplished(113) then
            BWOADialogues.Hide("Emma_Robinson", "400.1")
            BWOADialogues.Hide("Emma_Robinson", "400.2")
            BWOADialogues.Hide("Emma_Robinson", "400.3")
            BWOADialogues.Reveal("Emma_Robinson", "400.4")
        end
    elseif gmd.research > 45 then
        if BWOAMissions.IsAccomplished(14) then
            BWOADialogues.Hide("Emma_Robinson", "400.1")
            BWOADialogues.Hide("Emma_Robinson", "400.2")
            BWOADialogues.Reveal("Emma_Robinson", "400.3")
        end
    elseif gmd.research > 25 then
        if BWOAMissions.IsAccomplished(5) then
            BWOADialogues.Hide("Emma_Robinson", "400.1")
            BWOADialogues.Reveal("Emma_Robinson", "400.2")
        end
    elseif gmd.research > 5 then
        BWOADialogues.Reveal("Emma_Robinson", "400.1")
    end

    local txt = getText("IGUI_Halo_Research") .. ": " .. string.format("%.2f", gmd.research) .. "%"
    if stalled then
        txt = txt .. " (" .. getText("IGUI_Halo_Research_Stalled") .. ")"
    end

    local textColor = task.txtColor or {r=0.2, g=0.8, b=0.1}
    zombie:addLineChatElement(txt, textColor.r, textColor.g, textColor.b)

    return true
end
