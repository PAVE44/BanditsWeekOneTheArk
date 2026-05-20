ZombieActions = ZombieActions or {}

local function predicateAll(item)
    -- item:getType()
	return true
end

ZombieActions.Cook = {}
ZombieActions.Cook.onStart = function(zombie, task)

    task.anim = "ChopFood"
    zombie:setBumpType(task.anim)

    return true
end

ZombieActions.Cook.onWorking = function(zombie, task)
    if task.makePosition and task.makePosition.y then
        zombie:faceLocationF(task.makePosition.x, task.makePosition.y)
    end
    local bumpType = zombie:getBumpType()
    if bumpType ~= task.anim then
        zombie:setBumpType(task.anim)
    end
    
    local recipe = task.recipe
    if recipe.sound then
        local emitter = zombie:getEmitter()
        if not emitter:isPlaying(recipe.sound) then
            emitter:playSound(recipe.sound)
        end
    end
    return false
end

ZombieActions.Cook.onComplete = function(zombie, task)

    local emitter = zombie:getEmitter()
    local recipe = task.recipe
    local makePosition = task.makePosition
    local ingredients = task.ingredients
    local vesselReady = BWOABaseObjects.EnsureItemTypeAt(recipe.vessel, makePosition.x, makePosition.y, makePosition.z, recipe.vesselCnt)

    if recipe.sound then
        local emitter = zombie:getEmitter()
        if emitter:isPlaying(recipe.sound) then
            emitter:stopSoundByName(recipe.sound)
        end
    end 

    if not vesselReady then return true end
    
    local square = zombie:getCell():getGridSquare(makePosition.x, makePosition.y, makePosition.z)
    if not square then return true end

    for i=1, recipe.vesselCnt do
        local wobs = square:getWorldObjects()
        for i = 0, wobs:size()-1 do
            local witem = wobs:get(i)
            local wx, wy, wz = witem:getWorldPosX(), witem:getWorldPosY(), witem:getWorldPosZ()
            wx, wy, wz = wx - math.floor(wx), wy - math.floor(wy), wz - math.floor(wz)
            local vesselItem = witem:getItem()
            local vesselItemType = vesselItem:getFullType()
            if vesselItemType == recipe.vessel then
                local resultItem = BanditCompatibility.InstanceItem(recipe.result)
                if resultItem then
                    resultItem:setCalories(0)
                    resultItem:setLipids(0)
                    resultItem:setProteins(0)
                    resultItem:setCarbohydrates(0)
                    resultItem:setHungChange(0)
                    resultItem:setBaseHunger(0)
                    resultItem:setThirstChange(0)
                    resultItem:setUnhappyChange(0)
                    resultItem:setBoredomChange(0)
                    for _, ing in ipairs(ingredients) do
                        resultItem:addExtraItem(ing)

                        local ingItem = BanditCompatibility.InstanceItem(ing)
                        resultItem:setCalories(resultItem:getCalories() + ingItem:getCalories())
                        resultItem:setLipids(resultItem:getLipids() + ingItem:getLipids())
                        resultItem:setProteins(resultItem:getProteins() + ingItem:getProteins())
                        resultItem:setCarbohydrates(resultItem:getCarbohydrates() + ingItem:getCarbohydrates())
                        resultItem:setHungChange(resultItem:getHungChange() + ingItem:getHungChange())
                        resultItem:setBaseHunger(resultItem:getBaseHunger() + ingItem:getBaseHunger())
                        resultItem:setThirstChange(resultItem:getThirstChange() + ingItem:getThirstChange())
                        resultItem:setUnhappyChange(-25)
                        resultItem:setBoredomChange(-25)
                    end

                    if recipe.cook then
                        resultItem:setIsCookable(true)
                    end

                    square:removeWorldObject(witem)
                    square:transmitRemoveItemFromSquare(witem)

                    witem:removeFromWorld()
                    witem:removeFromSquare()
                    witem:setSquare(nil)

                    local item = witem:getItem()
                    item:setWorldItem(nil)

                    square:AddWorldInventoryItem(resultItem, wx, wy, wz)

                    square:RecalcProperties()
                    square:RecalcAllWithNeighbours(true)
                    break
                end


                

            end
        end
    end

    for _, ing in ipairs(ingredients) do 
        BWOAPermaInv.RemoveOneOfType(zombie, ing)
    end

    return true
end
