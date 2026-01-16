require "TimedActions/ISBaseTimedAction"

TAFuelIntake = ISBaseTimedAction:derive("TAFuelIntake");

function TAFuelIntake:isValid()
    return true
end

function TAFuelIntake:start()
    self.character:faceLocationF(self.square:getX() + 0.5, self.square:getY() + 0.5)
    self:setActionAnim("Loot")
    self:setAnimVariable("LootPosition", "Low")
    self.sound = self.character:playSound("GeneratorAddFuel")
end

function TAFuelIntake:getVehicle()
    local cell = getCell()
    local sqs = {
        {x = 9925, y = 12616, z = 0},
        {x = 9926, y = 12616, z = 0},
        {x = 9927, y = 12616, z = 0},
        {x = 9928, y = 12616, z = 0},
        {x = 9925, y = 12615, z = 0},
        {x = 9926, y = 12615, z = 0},
        {x = 9927, y = 12615, z = 0},
        {x = 9928, y = 12616, z = 0},
    }

    for _, sq in pairs(sqs) do
        local square = cell:getGridSquare(sq.x, sq.y, sq.z)
        if square then
            local vehicle = square:getVehicleContainer()
            if vehicle then
                return vehicle
            end
        end
    end
end

function TAFuelIntake:update()
    local vehicle = TAFuelIntake:getVehicle()
    if vehicle then
        local md = vehicle:getModData()
        local fuel = md.BWOA.fuel
        
        local gmd = GetBWOAModData()

        local step = 0.05
        for _, generator in pairs(gmd.generators) do
            local missing = 100 - generator.fuel
            if missing > 0 then
                generator.fuel = generator.fuel + (step / 10)
                md.BWOA.fuel = fuel - step
                print ("ARK: " .. (generator.fuel + step) .. " CAR: " .. fuel - step)
            end
        end
    end

    ISBaseTimedAction.perform(self)
end

function TAFuelIntake:stop()
	self.character:stopOrTriggerSound(self.sound)
    BWOAMissions.Accomplish(6)
    ISBaseTimedAction.stop(self)
end

function TAFuelIntake:perform()
    BWOAMissions.Accomplish(6)
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function TAFuelIntake:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
    local vehicle = TAFuelIntake:getVehicle()
    local fuel = vehicle:getModData().BWOA.fuel
	return fuel * 25
end

function TAFuelIntake:new(character, square)
	local o = ISBaseTimedAction.new(self, character)
	o.square = square
	o.maxTime = o:getDuration()
	return o;
end