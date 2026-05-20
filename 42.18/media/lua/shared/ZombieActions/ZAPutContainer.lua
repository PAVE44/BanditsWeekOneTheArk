ZombieActions = ZombieActions or {}

ZombieActions.PutContainer = {}
ZombieActions.PutContainer.onStart = function(zombie, task)
    
    local hasItem = BWOAPermaInv.HasType(zombie, task.item.fullType)
    if not hasItem then return true end

    task.anim = "Give"
    zombie:setBumpType(task.anim)

    return true
end

ZombieActions.PutContainer.onWorking = function(zombie, task)
    zombie:faceLocationF(task.container.x, task.container.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.PutContainer.onComplete = function(zombie, task)
    local square = zombie:getCell():getGridSquare(task.container.x, task.container.y, task.container.z)
    if not square then return true end

    local hasItem = BWOAPermaInv.HasType(zombie, task.item.fullType)
    if not hasItem then return true end

    local oven = BWOABaseObjects.GetIsoObject(task.container)
    if oven then
        local container = oven:getContainer()
        if container then
            local item = BanditCompatibility.InstanceItem(task.item.fullType)
            if task.item.weight then
                item:setActualWeight(task.item.weight)
            end
            if task.item.calories then
                item:setCalories(task.item.calories)
            end
            if task.item.lipids then
                item:setLipids(task.item.lipids)
            end
            if task.item.proteins then
                item:setProteins(task.item.proteins)
            end
            if task.item.carbohydrates then
                item:setCarbohydrates(task.item.carbohydrates)
            end
            if task.item.hungerChange then
                item:setHungChange(task.item.hungerChange)
            end
            if task.item.baseHunger then
                item:setBaseHunger(task.item.baseHunger)
            end
            if task.item.thirstChange then
                item:setThirstChange(task.item.thirstChange)
            end
            if task.item.unhappyChange then
                item:setUnhappyChange(task.item.unhappyChange)
            end
            if task.item.boredomChange then
                item:setBoredomChange(task.item.boredomChange)
            end
            if task.item.extraItems then
                for i, extraItem in ipairs(task.item.extraItems) do
                    item:addExtraItem(extraItem)
                end
                item:setIsCookable(true)
            end
            if task.item.cooked then
                item:setCooked(true)
            end
            container:AddItem(item)
            BWOAPermaInv.RemoveOneOfType(zombie, task.item.fullType)
        end
    end

    return true
end

