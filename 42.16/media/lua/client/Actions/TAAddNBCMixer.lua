require "TimedActions/ISBaseTimedAction"

TAAddNBCMixer = ISBaseTimedAction:derive("TAAddNBCMixer");

function TAAddNBCMixer:findDecontaminator()
    local gmd = GetBWOAModData()
    local decontaminator = gmd.decontaminator
    if decontaminator.x == self.square:getX() and decontaminator.y == self.square:getY() and decontaminator.z == self.square:getZ() then
        return decontaminator
    end
    return nil
end

function TAAddNBCMixer:isValid()
    local item = self.character:getPrimaryHandItem()
    if item:getFullType() == "Bandits.NBCTablets" then
        return true
    end
    return false
end

function TAAddNBCMixer:update()
    
end

function TAAddNBCMixer:start()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    self.sound = self.character:playSound("DropOnWater")
    
    local item = self.character:getPrimaryHandItem()
    self:setOverrideHandModels(item, nil)
    self:setActionAnim("Pour")

end

function TAAddNBCMixer:stop()
     if self.sound then
        self.character:stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.stop(self)
end

function TAAddNBCMixer:perform()
    if self.sound then
        self.character:stopOrTriggerSound(self.sound)
    end
    local decontaminator = self:findDecontaminator()
    if decontaminator then
        if not decontaminator.concentration then
            decontaminator.concentration = 0
        end
        local item = self.character:getPrimaryHandItem()
        if item then
            item:Use()
            decontaminator.concentration = decontaminator.concentration + 50
            if decontaminator.concentration > 100 then
                decontaminator.concentration = 100
            end
        end
        
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
