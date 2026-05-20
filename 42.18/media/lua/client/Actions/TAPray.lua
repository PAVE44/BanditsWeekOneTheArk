require "TimedActions/ISBaseTimedAction"

TAPray = ISBaseTimedAction:derive("TAPray");

function TAPray:isValid()
    return true
end

function TAPray:update()
    
end

function TAPray:start()

    BWOATex.tex = getTexture("media/textures/nightmare_mask2.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 1

    self:setActionAnim("Pray")
    BWOAMusic.Play("MusicChapel", 0.6, 1)

end

function TAPray:stop()
    ISBaseTimedAction.stop(self)
    BWOAMusic.Stop()
    BWOATex.speed = 0.01
end

function TAPray:update()
    ISBaseTimedAction.stop(self)
    local stats = self.character:getStats()
    local endurance = stats:get(CharacterStat.ENDURANCE)
    local boredom = stats:get(CharacterStat.BOREDOM)
    local unhappiness = stats:get(CharacterStat.UNHAPPINESS)

    if boredom > 0 then
        stats:set(CharacterStat.BOREDOM, boredom - 0.1)
    end
    if unhappiness > 0 then
        stats:set(CharacterStat.UNHAPPINESS, unhappiness - 0.02)
    end
end

function TAPray:perform()
    ISBaseTimedAction.perform(self)

    BWOATex.tex = getTexture("media/textures/blast_w.png")
    BWOATex.speed = 0.03
    BWOATex.mode = "full"
    BWOATex.alpha = 1.4

    local bodyDamage = self.character:getBodyDamage()

    local maxIndex = BodyPartType.MAX:index()
    for i = 0, maxIndex - 1 do
        local partName = BodyPartType.FromIndex(i)
        local part = bodyDamage:getBodyPart(partName)
        if part then
            if bodyDamage:IsBitten(partName) then
                bodyDamage:SetBitten(partName, false)
                if part:IsInfected() then
                    part:SetInfected(false)
                end
            end
        end
    end

    bodyDamage:setInfected(false)
    bodyDamage:setIsFakeInfected(false)
    bodyDamage:setInfectionTime(-1.0)
    bodyDamage:setInfectionMortalityDuration(-1.0);

    local stats = self.character:getStats()
    stats:set(CharacterStat.ZOMBIE_INFECTION, 0)

end

function TAPray:new(character)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.character = character
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 4000

    -- custom fields

    return o
end

return TAPray;
