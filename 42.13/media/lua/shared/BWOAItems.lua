BWOAItems = BWOAItems or {}

BWOAItems.GetItemClass = function(item)
    local class = "normal"
    if (item:isFood() and not item:isPoison()) then
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
    elseif item:isRecordedMedia() then
        class = "media"
    end
    return class
end
