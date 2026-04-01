BWOAItems = BWOAItems or {}

BWOAItems.GetItemClass = function(item)
    local class = "normal"
    -- item:getFullType() == "Base.VHS_Retail"
    if item:isRecordedMedia() then
        class = "media"
    elseif (item:isFood() and not item:isPoison()) then
        if item:getOpeningRecipe() or item:getDoubleClickRecipe() then
            class = "food_packaged"
        else
            class = "food"
        end
    elseif instanceof(item, "ComboItem") then
        local fluidContainer = item:getFluidContainer()
        if fluidContainer and not fluidContainer:isPoisonous() and not fluidContainer:isEmpty() and not fluidContainer:isTainted() then
            class = "drink"
        end
    end
    return class
end

BWOAItems.GetFirstItemTypeWithFluid = function(fluidType)
    local player = getSpecificPlayer(0)
    if not player then return nil end

    local predicateFluidType = function(item)
        local fluidContainer = item:getFluidContainer()
        if fluidContainer and fluidContainer:isPrimaryFluidType(fluidType) and not fluidContainer:isEmpty() then
            return true
        end
        return false
    end

    local inventory = player:getInventory()
    local items = ArrayList.new()
    inventory:getAllEvalRecurse(predicateFluidType, items)
    if items:size() >= 1 then
        return items:get(0)
    end

    return nil
end