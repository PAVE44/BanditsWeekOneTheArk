require "TimedActions/ISBaseTimedAction"

TAAddCorpse = ISBaseTimedAction:derive("TAAddCorpse");

function TAAddCorpse:isValid()
    return true
    -- return self.character:isDraggingCorpse()
end

function TAAddCorpse:waitToStart()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    return self.character:isFacingLocation(self.square:getX() + 0.5, self.square:getY() + 0.5, 0.1)
end

function TAAddCorpse:start()
    local zombie = self.character:getGrapplingTarget()
    if zombie then
        self.zombie = zombie
        self.character:LetGoOfGrappled("Dropped")
        self.zombie:setForwardIsoDirection(IsoDirections.S)
        self.zombie:setZ(self.square:getZ() + 0.5)
        self.zombie:setX(self.square:getX() + 0.7)
        self.zombie:setY(self.square:getY() + 0.75)
        self.zombie:getModData().fixedZ = self.square:getZ() + 0.34
        if self.zombie:getModData().isDeadBandit then
            if BWOAMissions.IsAccomplished(5) then
                BWOAMissions.Accomplish(14)
                BWOADialogues.Reveal("Emma_Robinson", "100.6.2")
            end
        else
            BWOAMissions.Accomplish(5)
            BWOADialogues.Reveal("Emma_Robinson", "100.6.1.1.1")
        end
    end
end

function TAAddCorpse:stop()
    ISBaseTimedAction.stop(self)
end

function TAAddCorpse:update()
end

function TAAddCorpse:perform()
    ISBaseTimedAction.perform(self)
end

function TAAddCorpse:new(character, square)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.character = character
    o.square = square
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 1000

    -- custom fields

    return o
end

return TAAddCorpse;
