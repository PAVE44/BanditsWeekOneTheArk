require "TimedActions/ISBaseTimedAction"
require "BWOAUtils"

TADecontaminate = ISBaseTimedAction:derive("TADecontaminate")

local function predicateAll(item)
    return true
end

function TADecontaminate:isValid()
    local itemPrimary = self.character:getPrimaryHandItem()
    if itemPrimary and itemPrimary:getFullType() == "Base.KnapsackSprayer" then 
        local fluidContainer = itemPrimary:getFluidContainer()
        if fluidContainer and fluidContainer:getAmount() > 0 then
            return true 
        end
    end
    return false
end

function TADecontaminate:update() end

function TADecontaminate:start()
    self:setActionAnim("NBCSpray")
    if self.square then
        self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    end
    local emitter = self.character:getEmitter()
    if emitter then emitter:playSound("AmbientMist") end

    local itemPrimary = self.character:getPrimaryHandItem()
    if itemPrimary and itemPrimary:getFullType() == "Base.KnapsackSprayer" then 
        local fluidContainer = itemPrimary:getFluidContainer()
        if fluidContainer and fluidContainer:getAmount() > 0 then
            self.fluidType = fluidContainer:getPrimaryFluid()
        end
    end

    local mx, my = self.character:getX(), self.character:getY()
    local mz = self.character:getZ()
    local tx, ty = self.square:getX(), self.square:getY()
    local dx = tx - mx
    local dy = ty - my
    local length = math.sqrt(dx * dx + dy * dy)
    -- avoid division by zero
    if length > 0 then
        dx = dx / length
        dy = dy / length
    end

    local step = 0.9
    local instances = 5

    if length < step * instances then
        step = length / instances
    end

    local effectName = "mist"
    if self.fluidType == Fluid.Acid then
        effectName = "gas"
    end

    for i = 1, instances do
        mx = mx + dx * step
        my = my + dy * step
        
        local effect = {
            x = mx,
            y = my,
            z = mz,
            size = 160 + (i*30),
            name = effectName,
            frameCnt = 40,
            frameRnd = true,
            repCnt = 4,
            fluid = tostring(self.fluidType),
        }
        BWOAEventControl.Add("Effect", effect, 100 + (i * 6))

    end
end

function TADecontaminate:stop()
    ISBaseTimedAction.stop(self)
end

function TADecontaminate:perform()
    local itemPrimary = self.character:getPrimaryHandItem()
    if itemPrimary and itemPrimary:getFullType() == "Base.KnapsackSprayer" then 
        local fluidContainer = itemPrimary:getFluidContainer()
        if fluidContainer and fluidContainer:getAmount() > 0 then
            local newAmount = fluidContainer:getAmount() - 0.25
            if newAmount < 0 then newAmount = 0 end
            fluidContainer:Empty()
            fluidContainer:addFluid(self.fluidType, newAmount)
        end
    end

    ISBaseTimedAction.perform(self)
end

function TADecontaminate:new(character, square, item)
    local o = ISBaseTimedAction.new(self, character)
    o.character = character
    o.item = item
    o.square = square
    o.stopOnWalk = true
    o.stopOnRun = true
    o.maxTime = 60
    return o
end

return TADecontaminate
