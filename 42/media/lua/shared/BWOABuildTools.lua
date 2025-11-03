BWOABuildTools = BWOABuildTools or {}

BWOABuildTools.Floor = function(x, y, z, spriteName)
    local cell = getCell()
    local square = cell:getGridSquare(x, y, z)
    if square == nil and getWorld():isValidSquare(x, y, z) then
        square = cell:createNewGridSquare(x, y, z, true)
        local obj = IsoObject.new(square, spriteName, "")
        
        local crackSprite = "floors_overlay_street_01_" .. tostring(1 + ZombRand(43))
        obj:setAttachedAnimSprite(ArrayList.new())
        obj:getAttachedAnimSprite():add(getSprite(crackSprite):newInstance())

        square:AddSpecialObject(obj)
        obj:transmitCompleteItemToServer()
        square:setSquareChanged()
    end
end

BWOABuildTools.Wall = function(x, y, z, spriteName)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoObject.new(square, spriteName, "")
    if not obj then return end

    obj:setType(IsoObjectType.wall)

    local sprite = obj:getSprite()
    local props = sprite:getProperties()
    obj:setAttachedAnimSprite(ArrayList.new())
    if props:Is(IsoFlagType.WallW) then
        obj:getAttachedAnimSprite():add(getSprite("overlay_grime_wall_01_0"):newInstance())

        local rnd = 10
        if rnd == 1 then
            obj:getAttachedAnimSprite():add(getSprite("overlay_graffiti_wall_01_10"):newInstance())
        end
    elseif props:Is(IsoFlagType.WallN) then
        obj:getAttachedAnimSprite():add(getSprite("overlay_grime_wall_01_1"):newInstance())
    elseif props:Is(IsoFlagType.WallNW) then
        obj:getAttachedAnimSprite():add(getSprite("overlay_grime_wall_01_2"):newInstance())
    end

    local crackSprite = "d_wallcracks_1_" .. tostring(1 + ZombRand(70))
    obj:getAttachedAnimSprite():add(getSprite(crackSprite):newInstance())

    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    buildUtil.setHaveConstruction(square, true)
    square:setSquareChanged()
end

BWOABuildTools.Door = function(x, y, z, north, sprite)
    local cell = getCell()
    local square = getCell():getOrCreateGridSquare(x, y, z)
    
    for s, number in string.gmatch(sprite, "(.+)_(%d+)") do

        if not north then
            north = true
            if (number % 2 == 0) then
                north = false
            end
        end

        obj = IsoDoor.new(cell, square, sprite, north)
        square:AddSpecialObject(obj)
        obj:transmitCompleteItemToServer()
        buildUtil.setHaveConstruction(square, true)
        square:setSquareChanged()
    end
end

BWOABuildTools.Generic = function(x, y, z, spriteName)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoObject.new(square, spriteName, "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.WaterPump = function(x, y, z)
    local sprite = getSprite(WPIso.pumpSprites.ns)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local object = IsoClothingDryer.new(square:getCell(), square, sprite)
    object:setActivated(false)
    object:setMovedThumpable(true)
    object:createContainersFromSpriteProperties()
    object:transmitCompleteItemToServer()
    square:AddSpecialObject(object)
    WPVirtual.PumpAdd(x, y, z)
end

BWOABuildTools.WaterPipe = function(x, y, z)
    local sprite = getSprite(WPIso.pipeSprites.ns)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local object = IsoObject.new(square:getCell(), square, sprite)
    square:AddSpecialObject(object)
    object:transmitCompleteItemToServer()
    WPIso.BuildPipe(square)
end

BWOABuildTools.WaterValve = function(x, y, z)
    local sprite = getSprite(WPIso.valveSprites.ns)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local object = IsoObject.new(square:getCell(), square, sprite)
    square:AddSpecialObject(object)
    object:transmitCompleteItemToServer()
    WPVirtual.ValveAdd(x, y, z, 200)
end

BWOABuildTools.WaterSprinkler = function(x, y, z)
    local sprite = getSprite(WPIso.waterSprinklersSprites[1])
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local object = IsoObject.new(square:getCell(), square, sprite)
    square:AddSpecialObject(object)
    object:transmitCompleteItemToServer()
    WPVirtual.SprinklerAdd(x, y, z, 200)
end

BWOABuildTools.VentN = function(x, y, z)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoObject.new(square, "rooftop_furniture_4", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.VentW = function(x, y, z)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoObject.new(square, "rooftop_furniture_5", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.BookshelfW = function(x, y, z)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoObject.new(square, "furniture_shelving_01_44", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.Fridge = function(x, y, z)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoObject.new(square, "appliances_refrigeration_01_40", "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.Skeleton = function (x, y, z)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local spriteName = "location_shop_mall_01_68"
	local obj = IsoMannequin.new(getCell(), nil, getSprite(spriteName))
	obj:setMannequinScriptName("MannequinSkeleton01")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

local container = function(x, y, z, spriteName, data)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoObject.new(square, spriteName, "")
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end

BWOABuildTools.SmallTableN = function(x, y, z, data)
    local sprite = "furniture_storage_01_52"
    container(x, y, z, sprite, data)
end

BWOABuildTools.SmallTableS = function(x, y, z, data)
    local sprite = "furniture_storage_01_55"
    container(x, y, z, sprite, data)
end

local lamp = function(x, y, z, spriteName, data)
    local cell = getCell()
    local square = cell:getOrCreateGridSquare(x, y, z)
    local sprite = getSprite(spriteName)
    local spriteProps = sprite:getProperties()
    spriteProps:Set("lightR", tostring(data.r))
    spriteProps:Set("lightG", tostring(data.g))
    spriteProps:Set("lightB", tostring(data.b))
    spriteProps:Set("LightRadius",tostring(data.d))

    local ls = IsoLightSwitch.new(cell, square, sprite, square:getRoomID())
    if data.battery then
        ls:setCanBeModified(true)
        ls:setPower(1000)
        ls:setHasBattery(true)
        ls:setUseBatteryDirect(true)
    else
        ls:setUseBattery(false)
    end
    ls:addLightSourceFromSprite()
    ls:setPrimaryR(data.r / 255)
    ls:setPrimaryG(data.g / 255)
    ls:setPrimaryB(data.b / 255)
    square:AddSpecialObject(ls)
    if data.active == nil or data.active == true then
        ls:setActive(true)
    else
        ls:setActive(false)
    end
    -- ls:transmitCompleteItemToServer()
    square:setSquareChanged()

end

BWOABuildTools.EmergencyExitN = function(x, y, z)
    local data = {r = 70, g = 0, b = 0, d=2, active=false, battery=true}
    local sprite = "lighting_indoor_01_25"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.EmergencyExitW = function(x, y, z)
    local data = {r = 70, g = 0, b = 0, d=2, active=false, battery=true}
    local sprite = "lighting_indoor_01_24"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.EmergencyLightN = function(x, y, z)
    local data = {r = 70, g = 0, b = 0, d=2, active=false, battery=true}
    local sprite = "location_entertainment_theatre_01_138"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.EmergencyLightW = function(x, y, z)
    local data = {r = 70, g = 0, b = 0, d=2, active=false, battery=true}
    local sprite = "location_entertainment_theatre_01_136"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.EmergencyLightS = function(x, y, z)
    local data = {r = 70, g = 0, b = 0, d=2, active=false, battery=true}
    local sprite = "location_entertainment_theatre_01_142"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.EmergencyLightE = function(x, y, z)
    local data = {r = 70, g = 0, b = 0, d=2, active=false, battery=true}
    local sprite = "location_entertainment_theatre_01_140"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampOvalN = function(x, y, z)
    local data = {r = 255, g = 240, b = 88, d=4}
    local sprite = "lighting_outdoor_01_40"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampOvalW = function(x, y, z)
    local data = {r = 255, g = 240, b = 88, d=4}
    local sprite = "lighting_outdoor_01_41"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampOvalS = function(x, y, z)
    local data = {r = 255, g = 240, b = 88, d=4}
    local sprite = "lighting_outdoor_01_44"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampOvalE = function(x, y, z)
    local data = {r = 255, g = 240, b = 88, d=4}
    local sprite = "lighting_outdoor_01_45"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampDeskYellowN = function(x, y, z)
    local data = {r = 255, g = 240, b = 180, d=2}
    local sprite = "lighting_indoor_02_14"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampDeskYellowW = function(x, y, z)
    local data = {r = 255, g = 240, b = 180, d=2}
    local sprite = "lighting_indoor_02_13"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampDeskYellowS = function(x, y, z)
    local data = {r = 255, g = 240, b = 180, d=2}
    local sprite = "lighting_indoor_02_12"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampDeskYellowE = function(x, y, z)
    local data = {r = 255, g = 240, b = 180, d=2}
    local sprite = "lighting_indoor_02_15"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampCeilingNS = function(x, y, z)
    local data = {r = 255, g = 240, b = 180, d=7}
    local sprite = "lighting_indoor_03_21"
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.LampCustom = function(x, y, z, sprite)
    local data = {r = 255, g = 240, b = 180, d=7}
    lamp(x, y, z, sprite, data)
end

BWOABuildTools.TV = function(x, y, z, spriteName)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local obj = IsoTelevision.new(getCell(), square, getSprite(spriteName))
    obj:getDeviceData():getDevicePresets():clearPresets()
    
    square:AddSpecialObject(obj)
    obj:transmitCompleteItemToServer()
    square:setSquareChanged()
end


BWOABuildTools.FarmPlot = function(x, y, z, seedType)
    local square = getCell():getOrCreateGridSquare(x, y, z)
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

-- removal

BWOABuildTools.RemoveObject = function(x, y, z, customName)
    local square = getCell():getGridSquare(x, y, z)
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            local sprite = object:getSprite()
            if sprite then
                local props = sprite:getProperties()
                if props:Is("CustomName") and props:Val("CustomName") == customName then
                    square:transmitRemoveItemFromSquare(object)
                    break
                end
            end
        end
    end
end

-- batch building

BWOABuildTools.ELS = function(tab)
    for _, el in pairs(tab) do
        if el.dir == "N" then
            BWOABuildTools.EmergencyLightN(el.x, el.y, el.z)
        elseif el.dir == "W" then
            BWOABuildTools.EmergencyLightW(el.x, el.y, el.z)
        elseif el.dir == "S" then
            BWOABuildTools.EmergencyLightS(el.x, el.y, el.z)
        elseif el.dir == "E" then
            BWOABuildTools.EmergencyLightE(el.x, el.y, el.z)
        elseif el.dir == "XW" then
            BWOABuildTools.EmergencyExitW(el.x, el.y, el.z)
        elseif el.dir == "XN" then
            BWOABuildTools.EmergencyExitN(el.x, el.y, el.z)
        end
    end
end