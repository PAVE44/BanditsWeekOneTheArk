require "TimedActions/ISBaseTimedAction"

TAAddNBCToItem = ISBaseTimedAction:derive("TAAddNBCToItem");

function TAAddNBCToItem:isValid()
    local item = self.character:getPrimaryHandItem()
    if item:getFullType() == "Bandits.NBCTablets" then
        return true
    end
    return false
end

function TAAddNBCToItem:update()
end

function TAAddNBCToItem:start()
    self.sound = self.character:playSound("DropOnWater")
    
    local item = self.character:getPrimaryHandItem()
    if item and item:getFullType() == "Bandits.NBCTablets" then
        self:setOverrideHandModels(item, nil)
        self:setActionAnim("Pour")
    end
end

function TAAddNBCToItem:stop()
     if self.sound then
        self.character:stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.stop(self)
end

function TAAddNBCToItem:perform()
    if self.sound then
        self.character:stopOrTriggerSound(self.sound)
    end

    local item = self.character:getPrimaryHandItem()
    if item and item:getFullType() == "Bandits.NBCTablets" then

        local fluidContainer = self.itemTarget:getFluidContainer()
        local amount = fluidContainer:getAmount()
        fluidContainer:Empty()
        fluidContainer:addFluid("NBCSolution", amount)
        item:Use()
    end

    ISBaseTimedAction.perform(self)
end

function TAAddNBCToItem:new(character, itemTarget)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.character = character
    o.itemTarget = itemTarget
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 70

    -- custom fields

    return o
end

return TAAddNBCToItem;
