
local FALLOUT_START = -2160   -- WorldAge when fallout begins
local FALLOUT_END = 8640      -- WorldAge when fallout ends
local TEMP_LERP = 60          -- Maximum temperature drop
local TEMP_STEP = 0.5         -- Rate of temperature change per day

BWOAClimate = BWOAClimate or {}
BWOAClimate.temp = 0

function onClimateTick()
    local world = getWorld()
    local cm = world:getClimateManager()
    local temp = cm:getClimateFloat(4)  -- Temperature controller

    -- Reset to default climate behavior
    temp:setEnableOverride(false)

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

end

Events.OnClimateTick.Add(onClimateTick)
