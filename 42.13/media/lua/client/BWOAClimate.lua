
local FALLOUT_START = -2208   -- WorldAge when fallout begins
local FALLOUT_END = 4416 -- 4380      -- WorldAge when fallout ends
local PEAK_POINT = 0.65 -- 65% into the fallout period
local TEMP_LERP = -50          -- Maximum temperature drop
local RAD_LERP = 5000

if SandboxVars.BWOA.FalloutStarted then
    local optionMap = {
        -168, -744, -2208, -4416, -8832, -17664
    }
    FALLOUT_START = optionMap[SandboxVars.BWOA.FalloutStarted]
end

if SandboxVars.BWOA.FalloutEnds then
    local optionMap = {
        168, 744, 2208, 4416, 8832, 17664
    }
    FALLOUT_END = optionMap[SandboxVars.BWOA.FalloutEnds]
end

if SandboxVars.BWOA.FalloutCurve then
    local optionMap = {
        0.2, 0.35, 0.5, 0.65, 0.8
    }
    PEAK_POINT = optionMap[SandboxVars.BWOA.FalloutCurve]
end

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
    local wa = getGameTime():getWorldAgeHours()

    updateForageZones()

    local ambient = cm:getClimateFloat(ClimateManager.FLOAT_AMBIENT)
    local desaturation = cm:getClimateFloat(ClimateManager.FLOAT_DESATURATION)
    local fogIntensity = cm:getClimateFloat(ClimateManager.FLOAT_FOG_INTENSITY)
    local windIntensity = cm:getClimateFloat(ClimateManager.FLOAT_WIND_INTENSITY)
    local temp = cm:getClimateFloat(4)
    local snow = cm:getClimateBool(0)

    temp:setEnableOverride(false)
    snow:setEnableOverride(false)

    -- calculate temperature and radiation
    local radiation = 0
    local overrideTemp = 0
    if wa >= FALLOUT_START and wa <= FALLOUT_END then
        local duration = FALLOUT_END - FALLOUT_START
        local t = (wa - FALLOUT_START) / duration

        local s
        if t <= PEAK_POINT then
            s = math.sin((t / PEAK_POINT) * (math.pi / 2))
        else
            s = math.sin(
                (math.pi / 2) +
                ((t - PEAK_POINT) / (1 - PEAK_POINT)) * (math.pi / 2)
            )
        end

        radiation = s * RAD_LERP
        overrideTemp = s * TEMP_LERP
    end

    BWOAClimate.radiation = radiation

    if radiation > 0 then
        
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
    
        ambient:setEnableOverride(true)
        ambient:setOverride(0.1, 1)
        
        local desaturationValue = math.floor(BanditUtils.Lerp(radiation, 0, 5000, 0, 0.7) * 100) / 100
        desaturation:setEnableOverride(true)
        desaturation:setOverride(desaturationValue, 1)
        
        local fogValue = math.floor(BanditUtils.Lerp(radiation, 0, 5000, 0, 1) * 100) / 100
        fogIntensity:setEnableOverride(true)
        fogIntensity:setOverride(fogValue, 1)
        
        local windValue = math.floor(BanditUtils.Lerp(radiation, 0, 5000, 0, 1) * 100) / 100
        windIntensity:setEnableOverride(true)
        windIntensity:setOverride(windValue, 1)

        -- renderer not ready for this updates right after game start
        if BWOAClimate.tick > 3 then
            ImprovedFog.setEnableEditing(true)
            ImprovedFog.setBaseAlpha(0.75)
            ImprovedFog.setSecondLayerAlpha(0.4)
            ImprovedFog.setTopAlphaHeight(0.25)
            ImprovedFog.setBottomAlphaHeight(0.5)
            ImprovedFog.setAlphaCircleAlpha(0.25)
            ImprovedFog.setAlphaCircleRad(4)

            local dls = cm:getDayLightStrength()
            local r = math.floor(BanditUtils.Lerp(dls, 0, 1, 0.15, 0.6) * 100) / 100
            local g = math.floor(BanditUtils.Lerp(dls, 0, 1, 0.26, 0.9) * 100) / 100
            local b = math.floor(BanditUtils.Lerp(dls, 0, 1, 0.20, 0.72) * 100) / 100
            print ("DLS: " .. dls .. " R: " .. r .. " G: " .. g .. " B: " .. b)
            ImprovedFog.setColorR(r)
            ImprovedFog.setColorG(g)
            ImprovedFog.setColorB(b)
        end

        if isClient() then
            getClimateManager():transmitTriggerStorm(10)
        else
            getClimateManager():triggerCustomWeatherStage(WeatherPeriod.STAGE_BLIZZARD, 10)
        end

        BWOAClimate.tick = BWOAClimate.tick + 1

        if radiation > 1000 and BWOAClimate.lastQuake > 2000 then
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

    else

        ambient:setEnableOverride(false)
        desaturation:setEnableOverride(false)
        fogIntensity:setEnableOverride(false)
        windIntensity:setEnableOverride(false)
    end

    
end

Events.OnClimateTick.Add(onClimateTick)
