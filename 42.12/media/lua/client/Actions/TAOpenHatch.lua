require "TimedActions/ISBaseTimedAction"

TAOpenHatch = ISBaseTimedAction:derive("TAOpenHatch");

function TAOpenHatch:isValid()
    return true
end

function TAOpenHatch:update()
    
end

function TAOpenHatch:start()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    self:setActionAnim("Loot")
    self:setAnimVariable("LootPosition", "Low")
end

function TAOpenHatch:stop()
    ISBaseTimedAction.stop(self)
end

function TAOpenHatch:perform()
    self.character:playSound("BreakBarricadePlank")
    local x, y = self.square:getX(), self.square:getY()
    local theme = BanditUtils.Choice({"generic", "wine", "preppers", "wicked", "cannibals"})
    local builder = BanditUtils.Choice({"Generic", "Double"})
    local basement = BWOABasements[builder]:new(x, y, self.square:getRoom(), theme)
    basement:build()

    BWOABuildings.RemoveHatch(x, y)

    BWOAMissions.Accomplish(4)
    BWOADialogues.Reveal("Emma Robinson", "5.1.1.1.1")

    ISBaseTimedAction.perform(self)
end

function TAOpenHatch:new(character, square)
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

return TAOpenHatch;
