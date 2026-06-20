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
    bodyDamage:setInfected(false)
	bodyDamage:setInfectionMortalityDuration(-1)
	bodyDamage:setInfectionTime(-1)
	-- bodyDamage:setInfectionLevel(0)
	local bodyParts = bodyDamage:getBodyParts()
	for i=bodyParts:size()-1, 0, -1  do
		local bodyPart = bodyParts:get(i)
		bodyPart:SetInfected(false)
	end
	bodyDamage:setInfected(false)

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
