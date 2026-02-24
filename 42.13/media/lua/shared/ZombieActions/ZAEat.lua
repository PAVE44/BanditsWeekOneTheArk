ZombieActions = ZombieActions or {}

ZombieActions.Eat = {}
ZombieActions.Eat.onStart = function(zombie, task)
    local itemConf = BWOAPermaInv.GetFood(zombie)
    if not itemConf then return false end

    -- to make the npc have the item visibly in hand, we need to use a "weapon" substitute of that item
    -- as weaponsprite is actually used to read the static model 

    local itemFood = BanditCompatibility.InstanceItem(itemConf.fullType)
    if not itemFood then return false end

    local subFullType = string.gsub(itemConf.fullType, "^[^%.]+", "Bandits")
    local itemHeld = BanditCompatibility.InstanceItem(subFullType)
    if not itemHeld then return false end

    zombie:setSecondaryHandItem(itemHeld)

    task.fullType = itemConf.fullType
    task.hc = itemConf.hc

    local eatType2Anim = {
        ["Plate"] = "EatFromPlateHand",
        ["Pot"] = "EatFromPot",
        ["EatSmall"] = "EatSmall",
        ["EatOffStick"] = "EatOffStick",
        ["2handforced"] = "Eat2Hands",
        ["EatBox"] = "EatFromPacket",
    }
    local eatType = itemFood:getEatType()
    local anim = "Eat1Hand"
    if eatType2Anim[eatType] then
        anim = eatType2Anim[eatType]
    end
    task.anim = anim
    zombie:setBumpType(task.anim)

    local sound = "Eating"
    local customEatSound = itemFood:getCustomEatSound()
    if customEatSound and customEatSound ~= "" then
        sound = customEatSound
    end
    task.sound = sound
    local emitter = zombie:getEmitter()
    if not emitter:isPlaying(task.sound) then
        emitter:playSound(task.sound)
    end

    return true
end

ZombieActions.Eat.onWorking = function(zombie, task)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.Eat.onComplete = function(zombie, task)
    local emitter = zombie:getEmitter()
    emitter:stopSoundByName(task.sound)

    zombie:setSecondaryHandItem(nil)
    -- local emitter = zombie:getEmitter()
    -- emitter:stopSoundByName("EmmaCry")
    BWOAPermaInv.Remove(zombie, task.fullType)

    zombie:addLineChatElement("-" .. task.hc .. " Hunger", 0, 1, 0, UIFont.Small, 30.0, "default")

    local brain = BanditBrain.Get(zombie)
    if brain then
        brain.hunger = brain.hunger - task.hc
        if brain.hunger < 0 then
            brain.hunger = 0
        end
    end
    return true
end
