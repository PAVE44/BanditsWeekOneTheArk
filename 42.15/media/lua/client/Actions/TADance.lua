require "TimedActions/ISBaseTimedAction"

TADance = ISBaseTimedAction:derive("TADance");

function TADance:isValid()
    return true
end

function TADance:update()
    
end

function TADance:start()
    self.danceChoices = {"Dance1", "Dance2", "Dance3", "Dance4"}
    self:setActionAnim(BanditUtils.Choice(self.danceChoices))
end

function TADance:stop()
    ISBaseTimedAction.stop(self)
end

function TADance:update()
    ISBaseTimedAction.stop(self)
    local stats = self.character:getStats()
    local endurance = stats:get(CharacterStat.ENDURANCE)
    local boredom = stats:get(CharacterStat.BOREDOM)
    local unhappiness = stats:get(CharacterStat.UNHAPPINESS)

    if ZombRand(100) == 0 then
        self:setActionAnim(BanditUtils.Choice(self.danceChoices))
    end

    if boredom > 0 then
        stats:set(CharacterStat.BOREDOM, boredom - 0.1)
    end
    if unhappiness > 0 then
        stats:set(CharacterStat.UNHAPPINESS, unhappiness - 0.02)
    end
    if endurance > 0 then
        stats:set(CharacterStat.ENDURANCE, endurance - 0.0001)
    end
end

function TADance:perform()
    ISBaseTimedAction.perform(self)
end

function TADance:new(character)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.character = character
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 1000

    -- custom fields

    return o
end

return TADance;
