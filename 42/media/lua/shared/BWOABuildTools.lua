BWOABuildTools = BWOABuildTools or {}

BWOABuildTools.Generic = function(square, spriteName)
    local obj = IsoObject.new(square, spriteName, "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.FloorConcrete = function(square)
    local obj = IsoObject.new(square, "floors_exterior_street_01_0", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    buildUtil.setHaveConstruction(square, true)
    square:setSquareChanged()
end

BWOABuildTools.WallWConcrete = function(square)
    local obj = IsoObject.new(square, "walls_garage_01_36", "")
    obj:setType(IsoObjectType.wall)
    obj:setAttachedAnimSprite(ArrayList.new())
    obj:getAttachedAnimSprite():add(getSprite("walls_commercial_02_32"):newInstance())
    obj:getAttachedAnimSprite():add(getSprite("overlay_grime_wall_01_0"):newInstance())
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    buildUtil.setHaveConstruction(square, true)
    square:setSquareChanged()
end

BWOABuildTools.WallNConcrete = function(square)
    local obj = IsoObject.new(square, "walls_garage_01_37", "")
    obj:setType(IsoObjectType.wall)
    obj:setAttachedAnimSprite(ArrayList.new())
    obj:getAttachedAnimSprite():add(getSprite("walls_commercial_02_33"):newInstance())
    obj:getAttachedAnimSprite():add(getSprite("overlay_grime_wall_01_1"):newInstance())
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    buildUtil.setHaveConstruction(square, true)
    square:setSquareChanged()
end

BWOABuildTools.DoorNConcrete = function(square)
    local objects = square:getObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        local spriteName = object:getSprite():getName()
        if spriteName == "walls_garage_01_37" then
            square:transmitRemoveItemFromSquare(object)
            break
        end

        local obj = IsoObject.new(square, "walls_garage_01_47", "")
        square:AddSpecialObject(obj)
        obj:transmitCompleteItemToServer()

        local obj = IsoDoor.new(cell, square, getSprite("fixtures_doors_01_21"), true)
        square:AddSpecialObject(obj)
        obj:transmitCompleteItemToServer()

        buildUtil.setHaveConstruction(square, true)
        square:setSquareChanged()
    end
end

BWOABuildTools.DoorWConcrete = function(square)
    local objects = square:getObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        local spriteName = object:getSprite():getName()
        if spriteName == "walls_garage_01_36" then
            square:transmitRemoveItemFromSquare(object)
            break
        end

        local obj = IsoObject.new(square, "walls_garage_01_46", "")
        square:AddSpecialObject(obj)
        obj:transmitCompleteItemToServer()

        local obj = IsoDoor.new(getCell(), square, getSprite("fixtures_doors_01_52"), true)
        square:AddSpecialObject(obj)
        obj:transmitCompleteItemToServer()

        buildUtil.setHaveConstruction(square, true)
        square:setSquareChanged()
    end
end

BWOABuildTools.VentN = function(square)
    local obj = IsoObject.new(square, "rooftop_furniture_4", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.BookshelfW = function(square)
    local obj = IsoObject.new(square, "furniture_shelving_01_44", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.Fridge = function(square)
    local obj = IsoObject.new(square, "appliances_refrigeration_01_40", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.LampSmall = function(square)
    local obj = getSprite("lighting_indoor_01_32")
    local spriteProps = obj:getProperties()
    spriteProps:Set("lightR", "100")
    spriteProps:Set("lightG", "100")
    spriteProps:Set("lightB", "100")
    spriteProps:Set("LightRadius", "6")

    obj = IsoLightSwitch.new(getCell(), square, obj, square:getRoomID())
    obj:setUseBattery(false)
    obj:addLightSourceFromSprite()
    obj:setActive(true)
    square:AddSpecialObject(obj)
    obj:setActive(true)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.LampCeiling = function(square)
    local obj = getSprite("lighting_indoor_03_21")
    local spriteProps = obj:getProperties()
    spriteProps:Set("lightR", "100")
    spriteProps:Set("lightG", "100")
    spriteProps:Set("lightB", "100")
    spriteProps:Set("LightRadius", "6")

    obj = IsoLightSwitch.new(getCell(), square, obj, square:getRoomID())
    obj:setUseBattery(false)
    obj:addLightSourceFromSprite()
    obj:setActive(true)
    square:AddSpecialObject(obj)
    obj:setActive(true)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.FarmPlot = function(square, seedType)
    local obj = IsoObject.new(square, "blends_natural_01_64", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    SFarmingSystem.instance:plow(square)
    local plant = SFarmingSystem.instance:getLuaObjectAt(square:getX(), square:getY(), square:getZ())
    
    if plant then 
        plant.waterLvl = 100
        if plant.state == "plow" then
            plant:seed(seedType, 0)
            plant.health = 100
        end
        SFarmingSystem.instance:growPlant(plant, nil, true)
        SFarmingSystem.instance:growPlant(plant, nil, true)
        SFarmingSystem.instance:growPlant(plant, nil, true)
        SFarmingSystem.instance:growPlant(plant, nil, true)
        -- SFarmingSystem.instance:growPlant(plant, nil, true)
        -- SFarmingSystem.instance:growPlant(plant, nil, true)
    end
end