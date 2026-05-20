require "TimedActions/ISBaseTimedAction"

TAOpenHatch = ISBaseTimedAction:derive("TAOpenHatch");

function TAOpenHatch:isValid()
    return self.character:getInventory():containsTag(ItemTag.CROWBAR)
end

function TAOpenHatch:update()
    
end

function TAOpenHatch:waitToStart()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    return self.character:shouldBeTurning()
end

function TAOpenHatch:start()
    local crowbar = BanditCompatibility.InstanceItem("Base.Crowbar")
    self:setOverrideHandModels(crowbar, nil)
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    self:setActionAnim("LeverOpenLow")
    self.sound = self.character:playSound("OpenHatch")
    
end

function TAOpenHatch:stop()
    ISBaseTimedAction.stop(self)
end

function TAOpenHatch:perform()
    self.character:stopOrTriggerSound(self.sound)
    self.character:playSound("BreakBarricadePlank")
    local x, y = self.square:getX(), self.square:getY()
    local theme = BanditUtils.Choice({"generic", "wine", "preppers", "wicked", "cannibals", "family"})
    local builder = BanditUtils.Choice({"Generic", "Double"})
    local basement = BWOABasements[builder]:new(x, y, self.square:getRoom(), theme)
    basement:build()

    BWOABuildings.RemoveHatch(x, y)

    BWOAMissions.Accomplish(4)
    BWOADialogues.Reveal("Emma_Robinson", "5.1.1.1.1")

    ISBaseTimedAction.perform(self)
end

function TAOpenHatch:new(character, square, item)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.character = character
    o.square = square
    o.item = item
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 180

    -- custom fields

    return o
end

return TAOpenHatch;
