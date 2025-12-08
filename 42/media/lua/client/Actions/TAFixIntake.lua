require "TimedActions/ISBaseTimedAction"

TAFixIntake = ISBaseTimedAction:derive("TAFixIntake");

function TAFixIntake:isValid()
    return true
end

function TAFixIntake:update()
    
end

function TAFixIntake:start()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    self:setActionAnim("Loot")
    self:setAnimVariable("LootPosition", "Low")
end

function TAFixIntake:stop()
    ISBaseTimedAction.stop(self)
end

function TAFixIntake:perform()
    local gmd = GetBWOAModData()
    local airintakes = gmd.airintakes
    airintakes[1].broken = false
    BWOAMissions.Accomplish(3)
    BWOADialogues.Reveal("Emma Robinson", "1000.5.1")

    ISBaseTimedAction.perform(self)
end

function TAFixIntake:new(character, square)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.character = character
    o.square = square
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 100

    -- custom fields

    return o
end

return TAFixIntake;
