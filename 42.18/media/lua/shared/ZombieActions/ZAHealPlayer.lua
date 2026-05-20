ZombieActions = ZombieActions or {}

ZombieActions.HealPlayer = {}
ZombieActions.HealPlayer.onStart = function(zombie, task)
    
    local partHealAnims = {
        ["Neck"] = "HealOtherHigh",
        ["Head"] = "HealOtherHigh",
        ["Groin"] = "HealOtherLow",
        ["Torso_Lower"] = "HealOther",
        ["Torso_Upper"] = "HealOtherHigh",
        ["UpperArm_R"] = "HealOtherHigh",
        ["UpperArm_L"] = "HealOtherHigh",
        ["ForeArm_R"] = "HealOther",
        ["ForeArm_L"] = "HealOther",
        ["Hand_R"] = "HealOther",
        ["Hand_L"] = "HealOther",
        ["UpperLeg_L"] = "HealOther",
        ["UpperLeg_R"] = "HealOther",
        ["LowerLeg_L"] = "HealOtherLow",
        ["LowerLeg_R"] = "HealOtherLow",
        ["Foot_L"] = "HealOtherLow",
        ["Foot_R"] = "HealOtherLow",
    }
    task.anim = partHealAnims[task.part] or "HealOther"
    zombie:setBumpType(task.anim)

    local player = getSpecificPlayer(0)
    local bodydamage = player:getBodyDamage()
    local bodyPart = bodydamage:getBodyPart(BodyPartType[task.part])
    local sound2

    if not bodyPart:bandaged() then
        if bodyPart:haveBullet() then
            task.jobType = getText("ContextMenu_Remove_Bullet")
            task.job = "removeBullet"
            task.jobInc = 0.002
            sound2 = "FirstAidRemoveFromWound"
        elseif bodyPart:haveGlass() then
            task.jobType = getText("ContextMenu_Remove_Glass")
            task.job = "removeGlass"
            task.jobInc = 0.002
            sound2 = "FirstAidRemoveFromWound"
        elseif bodyPart:deepWounded() and not bodyPart:stitched() then
            task.jobType = getText("ContextMenu_Stitch")
            task.job = "stitchWound"
            task.jobInc = 0.003
            sound2 = "FirstAidApplyStitch"
        elseif bodyPart:getFractureTime() > 0 and not bodyPart:isSplint() then
            task.jobType = getText("ContextMenu_Splint")
            task.job = "splint"
            task.jobInc = 0.003
            sound2 = "FirstAidApplySplint"
        else
            task.jobType = getText("ContextMenu_Bandage")
            task.job = "bandage"
            task.jobInc = 0.004
            sound2 = "FirstAidApplyBandage"
        end
    end
    task.jobDelta = 0

    local prefix = player:getDescriptor():getVoicePrefix()
    task.sound1 = player:playSound(prefix .. "ApplyBandage")
    if sound2 then
        task.sound2 = player:playSound(sound2)
    end

    return true
end

ZombieActions.HealPlayer.onWorking = function(zombie, task)
    
    local bumpType = zombie:getBumpType()
    if bumpType ~= task.anim then
        zombie:setBumpType(task.anim)
    end

    if not task.job then return true end

    local player = getSpecificPlayer(0)
    zombie:faceLocationF(player:getX(), player:getY())
    local bx, by, bz = zombie:getX(), zombie:getY(), zombie:getZ()
    local mx, my, mz = player:getX(), player:getY(), player:getZ()
    local dist = BanditUtils.DistTo(bx, by, mx, my)
    if dist > 2 then return true end
    
    local player = getSpecificPlayer(0)
    local bodydamage = player:getBodyDamage()
    local bodyPart = bodydamage:getBodyPart(BodyPartType[task.part])
    local infoPanel = getPlayerInfoPanel(player:getPlayerNum())
    if infoPanel then
        local args = {
            bodyPart = bodyPart,
            jobType = task.jobType,
            delta = task.jobDelta
        }
        infoPanel.healthView:setBodyPartAction(bodyPart, args)
        task.jobDelta = task.jobDelta + task.jobInc
    end

    if task.jobDelta >= 1 then
        task.jobDelta = 1
        return true
    end

    return false
end

ZombieActions.HealPlayer.onComplete = function(zombie, task)
    if not task.job then return true end

    local player = getSpecificPlayer(0)
    local bodydamage = player:getBodyDamage()
    local bodyPart = bodydamage:getBodyPart(BodyPartType[task.part])
    local infoPanel = getPlayerInfoPanel(player:getPlayerNum())
    if infoPanel then
        infoPanel.healthView:setBodyPartAction(bodyPart, nil)
        task.jobDelta = nil
        task.jobInc = nil
    end

    player:stopOrTriggerSound(task.sound1)
    player:stopOrTriggerSound(task.sound2)

    if task.job == "removeBullet" then
        bodyPart:setHaveBullet(false, 6)
    elseif task.job == "removeGlass" then
        bodyPart:setHaveGlass(false)
    elseif task.job == "stitchWound" then
        bodyPart:setStitched(true)
    elseif task.job == "splint" then
        bodyPart:setSplintItem("Base.Splint")
        bodyPart:setSplint(true, 3.0)
    elseif task.job == "bandage" then
        bodyPart:setBandaged(true, 3.0)
    end

    return true
end