require "TimedActions/ISBaseTimedAction"

TAAddNBCMixer = ISBaseTimedAction:derive("TAAddNBCMixer");

function TAAddNBCMixer:isValid()
    local inventory = self.character:getInventory()
    local hasItem = inventory:containsTypeRecurse("Bandits.NBCTablets")
    return hasItem
end

function TAAddNBCMixer:update()
    
end

function TAAddNBCMixer:start()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    self:setActionAnim("Pour")
    self.character:playSound("DropOnWater")
end

function TAAddNBCMixer:stop()
    ISBaseTimedAction.stop(self)
end

function TAAddNBCMixer:perform()
    local inventory = self.character:getInventory()
    local tablets = inventory:getFirstTypeRecurse("Bandits.NBCTablets")
    if tablets then
        local gmd = GetBWOAModData()
        local decontaminator = gmd.decontaminator
        decontaminator.concentration = 100
        inventory:Remove(tablets)
    end

    ISBaseTimedAction.perform(self)
end

function TAAddNBCMixer:new(character, square)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.character = character
    o.square = square
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 70

    -- custom fields

    return o
end

return TAAddNBCMixer;
