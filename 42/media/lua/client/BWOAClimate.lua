
local FALLOUT_START = -2160   -- WorldAge when fallout begins
local FALLOUT_END = 8640      -- WorldAge when fallout ends
local TEMP_LERP = 70          -- Maximum temperature drop
local TEMP_STEP = 0.5         -- Rate of temperature change per day

BWOAClimate = BWOAClimate or {}
BWOAClimate.temp = 0

function onClimateTick()
    local world = getWorld()
    local cm = world:getClimateManager()
    local wfx = getCell():getWeatherFX()
    local temp = cm:getClimateFloat(4)  -- Temperature controller
    local snow = cm:getClimateBool(0)

    -- Reset to default climate behavior
    temp:setEnableOverride(false)
    snow:setEnableOverride(false)

    local wa = getGameTime():getWorldAgeHours()
    local overrideTemp

    -- Determine temperature override based on world age
    if wa < FALLOUT_START or wa > FALLOUT_END then
        overrideTemp = 0
    elseif wa < FALLOUT_START + (TEMP_LERP / TEMP_STEP) then
        overrideTemp = (FALLOUT_START - wa) * TEMP_STEP
    elseif wa > FALLOUT_END - (TEMP_LERP / TEMP_STEP) then
        overrideTemp = (wa - FALLOUT_END) * TEMP_STEP
    else
        overrideTemp = -TEMP_LERP
    end

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


    local ambient = cm:getClimateFloat(ClimateManager.FLOAT_AMBIENT);
    ambient:setEnableOverride(true)
    ambient:setOverride(0.1, 1)

    local desaturation = cm:getClimateFloat(ClimateManager.FLOAT_DESATURATION);
    desaturation:setEnableOverride(true)
    desaturation:setOverride(0.5, 1)

    local fogIntensity = cm:getClimateFloat(ClimateManager.FLOAT_FOG_INTENSITY);
    fogIntensity:setEnableOverride(true)
    fogIntensity:setOverride(1, 1)

    local windIntensity = cm:getClimateFloat(ClimateManager.FLOAT_WIND_INTENSITY);
    windIntensity:setEnableOverride(true)
    windIntensity:setOverride(1, 1)

    ImprovedFog.setEnableEditing(true)
    ImprovedFog.setBaseAlpha(1)
    ImprovedFog.setSecondLayerAlpha(0.4)
    ImprovedFog.setTopAlphaHeight(0.24)
    ImprovedFog.setBottomAlphaHeight(0.5)
    ImprovedFog.setAlphaCircleAlpha(0.8)
    ImprovedFog.setAlphaCircleRad(2)
    ImprovedFog.setColorR(0.1)
    ImprovedFog.setColorG(0.15)
    ImprovedFog.setColorB(0.05)
end

Events.OnClimateTick.Add(onClimateTick)
