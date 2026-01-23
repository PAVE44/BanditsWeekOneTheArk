
local FALLOUT_START = -90   -- WorldAge when fallout begins
local FALLOUT_END = 4380      -- WorldAge when fallout ends
local TEMP_LERP = 50          -- Maximum temperature drop
local TEMP_STEP = 0.5         -- Rate of temperature change per day
local RAD_LERP = 5000
local RAD_STEP = 28

BWOAClimate = BWOAClimate or {}
BWOAClimate.temp = 0
BWOAClimate.radiation = 0
BWOAClimate.tick = 0

BWOAClimate.lastQuake = 0

local function updateForageZones()

    local radiation = BWOAClimate.radiation
    local clean = RAD_LERP - radiation
    local plantMod = BanditUtils.Lerp(clean, 0, RAD_LERP, 0, 1)
    local mushroomMod = BanditUtils.Lerp(radiation, 0, RAD_LERP, 0, 10)
    
    -- Berries
    for k, v in pairs(forageSystem.categoryDefinitions["Berries"].zones) do
        forageSystem.categoryDefinitions["Berries"].zones[k] = v * plantMod
    end

    -- Fruits
    for k, v in pairs(forageSystem.categoryDefinitions["Fruits"].zones) do
        forageSystem.categoryDefinitions["Fruits"].zones[k] = v * plantMod
    end

    -- Vegetables
    for k, v in pairs(forageSystem.categoryDefinitions["Vegetables"].zones) do
        forageSystem.categoryDefinitions["Vegetables"].zones[k] = v * plantMod
    end

    -- Crops
    for k, v in pairs(forageSystem.categoryDefinitions["Crops"].zones) do
        forageSystem.categoryDefinitions["Crops"].zones[k] = v * plantMod
    end

    -- Mushrooms
    for k, v in pairs(forageSystem.categoryDefinitions["Mushrooms"].zones) do
        forageSystem.categoryDefinitions["Mushrooms"].zones[k] = v * mushroomMod
    end

    -- MedicinalPlants
    for k, v in pairs(forageSystem.categoryDefinitions["MedicinalPlants"].zones) do
        forageSystem.categoryDefinitions["MedicinalPlants"].zones[k] = v * plantMod
    end

    -- WildPlants
    for k, v in pairs(forageSystem.categoryDefinitions["WildPlants"].zones) do
        forageSystem.categoryDefinitions["WildPlants"].zones[k] = v * plantMod
    end
    
    -- WildHerbs
    for k, v in pairs(forageSystem.categoryDefinitions["WildHerbs"].zones) do
        forageSystem.categoryDefinitions["WildHerbs"].zones[k] = v * plantMod
    end

    -- Trash
    forageSystem.categoryDefinitions["Trash"].zones.TownZone        = 65
    forageSystem.categoryDefinitions["Trash"].zones.TrailerPark     = 65
    forageSystem.categoryDefinitions["Trash"].zones.Vegitation      = 15

    -- Junk
    forageSystem.categoryDefinitions["Junk"].zones.TownZone        = 35
    forageSystem.categoryDefinitions["Junk"].zones.TrailerPark     = 35
    forageSystem.categoryDefinitions["Junk"].zones.Vegitation      = 10
end

local function onClimateTick()
    local world = getWorld()
    local cm = world:getClimateManager()
    local wfx = getCell():getWeatherFX()
    local temp = cm:getClimateFloat(4)  -- Temperature controller
    local snow = cm:getClimateBool(0)

    temp:setEnableOverride(false)
    snow:setEnableOverride(false)

    local wa = getGameTime():getWorldAgeHours()

    local overrideTemp
    if wa < FALLOUT_START or wa > FALLOUT_END then
        overrideTemp = 0
    elseif wa < FALLOUT_START + (TEMP_LERP / TEMP_STEP) then
        overrideTemp = (FALLOUT_START - wa) * TEMP_STEP
    elseif wa > FALLOUT_END - (TEMP_LERP / TEMP_STEP) then
        overrideTemp = (wa - FALLOUT_END) * TEMP_STEP
    else
        overrideTemp = -TEMP_LERP
    end

    local radiation
    if wa < FALLOUT_START or wa > FALLOUT_END then
        radiation = 0
    elseif wa < FALLOUT_START + (RAD_LERP / RAD_STEP) then
        radiation = (wa - FALLOUT_START) * RAD_STEP
    elseif wa > FALLOUT_END - (RAD_LERP / RAD_STEP) then
        radiation = (FALLOUT_END - wa) * RAD_STEP
    else
        radiation = RAD_LERP
    end
    BWOAClimate.radiation = radiation

    -- Apply nuclear winter temperature offset
    local internalTemp = temp:getInternalValue()
    local newTemp = internalTemp + overrideTemp
    temp:setEnableOverride(true)
    temp:setOverride(newTemp, 1)

    BWOAClimate.temp = newTemp

    if newTemp < 0 then
        snow:setEnableOverride(true)
        snow:setOverride(true)
    end

    if isClient() then
        getClimateManager():transmitTriggerStorm(10)
    else
        getClimateManager():triggerCustomWeatherStage(WeatherPeriod.STAGE_BLIZZARD, 10)
    end

    local ambient = cm:getClimateFloat(ClimateManager.FLOAT_AMBIENT)
    ambient:setEnableOverride(true)
    ambient:setOverride(0.1, 1)

    local desaturation = cm:getClimateFloat(ClimateManager.FLOAT_DESATURATION)
    desaturation:setEnableOverride(true)
    desaturation:setOverride(0.7, 1)

    local fogIntensity = cm:getClimateFloat(ClimateManager.FLOAT_FOG_INTENSITY)
    fogIntensity:setEnableOverride(true)
    fogIntensity:setOverride(1, 1)

    local windIntensity = cm:getClimateFloat(ClimateManager.FLOAT_WIND_INTENSITY)
    windIntensity:setEnableOverride(true)
    windIntensity:setOverride(1, 1)

    -- renderer not ready for this updates right after game start
    if BWOAClimate.tick > 3 then
        ImprovedFog.setEnableEditing(true)
        ImprovedFog.setBaseAlpha(1)
        ImprovedFog.setSecondLayerAlpha(0.4)
        ImprovedFog.setTopAlphaHeight(0.25)
        ImprovedFog.setBottomAlphaHeight(0.5)
        ImprovedFog.setAlphaCircleAlpha(0.3)
        ImprovedFog.setAlphaCircleRad(3)
        ImprovedFog.setColorR(0.15)
        ImprovedFog.setColorG(0.25)
        ImprovedFog.setColorB(0.20)
    end

    BWOAClimate.tick = BWOAClimate.tick + 1

    if BWOAClimate.lastQuake > 2000 then
        if ZombRand(1000) == 0 then
            local playerList = BanditPlayer.GetPlayers()
            for i=0, playerList:size()-1 do
                local player = playerList:get(i)
                if player then
                    BWOASequence.Earthquake({intensity = 30, duration=20, x1 = 9950, y1 = 12600, x2 = 9980, y2 = 12640, z = -4})
                end
            end
            BWOAClimate.lastQuake = 0
        end
    end
    BWOAClimate.lastQuake = BWOAClimate.lastQuake + 1

    updateForageZones()
end

Events.OnClimateTick.Add(onClimateTick)
