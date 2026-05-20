require "TimedActions/ISBaseTimedAction"

TAFixGX9 = ISBaseTimedAction:derive("TAFixGX9");

function TAFixGX9:findGen()
    local gmd = GetBWOAModData()
    local generators = gmd.generators
    for k, gen in pairs(generators) do
        if gen.x == self.square:getX() and gen.y == self.square:getY() and gen.z == self.square:getZ() then
            return gen
        end
    end
    return nil
end

function TAFixGX9:isValid()
    local gen = self:findGen()
    if not gen then return false end

    if self.actionType == "addCoolant" then
        local coolant = self.character:getPrimaryHandItem()
        if coolant then
            local fluidContainer = coolant:getFluidContainer()
            if fluidContainer then
                local amountHave = fluidContainer:getAmount() * 100
                if amountHave > 0 then
                    return true
                end
            end
        end
    elseif self.actionType == "addLubricant" then
        local lubricant = self.character:getPrimaryHandItem()
        if lubricant then
            local fluidContainer = lubricant:getFluidContainer()
            if fluidContainer then
                local amountHave = fluidContainer:getAmount() * 100
                if amountHave > 0 then
                    return true
                end
            end
        end
    elseif self.actionType == "repair" then
        local wrench = self.character:getPrimaryHandItem()
        local enginePart = self.character:getSecondaryHandItem()
        if wrench and enginePart then
            return true
        end
    end
    return false
end

function TAFixGX9:update()
    
end

function TAFixGX9:start()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    
    if self.actionType == "addCoolant" then
        self.sound = self.character:playSound("GeneratorAddFuel")
        local coolant = self.character:getPrimaryHandItem()
        self:setActionAnim("Pour")
        self:setOverrideHandModels(coolant, nil)
        if coolant then
            local fluidContainer = coolant:getFluidContainer()
            if fluidContainer and fluidContainer:isPrimaryFluidType("EngineCoolant") then
                local amountHave = fluidContainer:getAmount() * 100
                local gen = self:findGen()
                local amountNeeded = 100 - gen.coolant
                if amountHave >= amountNeeded then
                    self.maxTime = (amountNeeded * 2) + 1
                    --self.action:setTime(self.maxTime)
                    fluidContainer:adjustAmount((amountHave - amountNeeded) / 100)
                    self.newAmount = 100
                 else
                    self.maxTime = (amountHave * 2) + 1
                    --self.action:setTime(self.maxTime)
                    fluidContainer:adjustAmount(0)
                    self.newAmount = gen.coolant + amountHave
                end
            end
        end
    elseif self.actionType == "addLubricant" then
        self.sound = self.character:playSound("GeneratorAddFuel")
        local lubricant = self.character:getPrimaryHandItem()
        self:setActionAnim("Pour")
        self:setOverrideHandModels(lubricant, nil)
        if lubricant then
            local fluidContainer = lubricant:getFluidContainer()
            if fluidContainer and fluidContainer:isPrimaryFluidType("EngineLubricant") then
                local amountHave = fluidContainer:getAmount() * 100
                local gen = self:findGen()
                local amountNeeded = 100 - gen.lubricant
                if amountHave >= amountNeeded then
                    self.maxTime = (amountNeeded * 2) + 1
                    --self.action:setTime(self.maxTime)
                    fluidContainer:adjustAmount((amountHave - amountNeeded) / 100)
                    self.newAmount = 100
                else
                    self.maxTime = (amountHave * 2) + 1
                    --self.action:setTime(self.maxTime)
                    fluidContainer:adjustAmount(0)
                    self.newAmount = gen.lubricant + amountHave
                end
            end
        end
    elseif self.actionType == "repair" then
        self.sound = self.character:playSound("GeneratorRepair")
        self:setActionAnim("Loot")
        local wrench = self.character:getPrimaryHandItem()
        local enginePart = self.character:getSecondaryHandItem()
        if wrench and enginePart then
            self:setOverrideHandModels(wrench, enginePart)
            local gen = self:findGen()
            self.newAmount = gen.condition + 10
            if self.newAmount > 100 then self.newAmount = 100 end
        end
    end
end

function TAFixGX9:stop()
    if self.sound then
        self.character:stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.stop(self)
    
end

function TAFixGX9:perform()
    if self.sound then
        self.character:stopOrTriggerSound(self.sound)
    end

    if self.newAmount then
        local gen = self:findGen()
        if gen then
            if self.actionType == "addCoolant" then
                gen.coolant = self.newAmount
            elseif self.actionType == "addLubricant" then
                gen.lubricant = self.newAmount
            elseif self.actionType == "repair" then
                local enginePart = self.character:getSecondaryHandItem()
                if enginePart then
                    gen.condition = self.newAmount
                    local inventory = self.character:getInventory()
                    inventory:Remove(enginePart)
                    self.character:setSecondaryHandItem(nil)
                end
            end
        end
    end
    
    ISBaseTimedAction.perform(self)
end

function TAFixGX9:new(character, square, actionType)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.character = character
    o.square = square
    o.stopOnWalk = false
    -- o.stopOnRun = false
    o.maxTime = 150

    -- custom fields
    o.actionType = actionType
    return o
end

return TAFixGX9;
