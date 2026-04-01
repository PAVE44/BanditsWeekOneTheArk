BWOALights = BWOALights or {}

BWOALights.cache = {}
BWOALights.tick = 0
BWOALights.flicker = {}
BWOALights.rotator = {}

local MAX_TICK  = 64          -- full cycle
local STEP_DIV  = 2            -- how many ticks per step
local MAX_STEP  = MAX_TICK / STEP_DIV  -- 32 steps

BWOALights.AddFlicker = function(tab)
    table.insert(BWOALights.flicker, tab)
end

BWOALights.AddRotator = function(tab)
    table.insert(BWOALights.rotator, tab)
end

local function onTick()
    if isServer() then return end
    
    BWOALights.tick = (BWOALights.tick + 1) % MAX_TICK

    if BWOALights.tick % STEP_DIV ~= 0 then return end
   
    -- bulb flickering
    local power = BWOABaseControl.power
    if power then
        local flickers = BWOALights.flicker
        for _, effect in ipairs(flickers) do
            local lightSwitch = BanditUtils.GetLightSwitchMain(effect.x, effect.y, effect.z)
            if lightSwitch then
                local activated = lightSwitch:isActivated()
                local rnd = activated and 64 or 3
                if 1 + ZombRand(rnd) == 1 then
                    if activated then
                        local volume = getSoundManager():getSoundVolume()
                        lightSwitch:setActive(false, false, true)

                        local tab = {x = effect.x, y = effect.y, z = effect.z, sound = "AmbientBulbFlicker"}
                        BWOASound.PlayLocation(tab)
                    else
                        lightSwitch:setActive(true, false, true)
                    end
                end
            end
        end
    end

    -- moving lights
    local step1 = math.floor(BWOALights.tick / STEP_DIV) % MAX_STEP

    local step2 = step1 - 1
    if step2 < 0 then step2 = MAX_TICK / STEP_DIV - 1 end

    local step3 = step2 - 1
    if step3 < 0 then step3 = MAX_TICK / STEP_DIV - 1 end

    for _, effect in ipairs(BWOALights.rotator) do
        if effect.tick == step1 or effect.tick == step2 or effect.tick == step3 then
            local id = effect.x .. "-" .. effect.y .. "-" .. effect.z
            local lightSwitch = BWOALights.cache[id]

            if not lightSwitch then
                lightSwitch = BanditUtils.GetLightSwitch(effect.x, effect.y, effect.z)
                if lightSwitch then
                    BWOALights.cache[id] = lightSwitch
                end
            end

            if lightSwitch then
                local active = false
                if effect.tick == step1 or effect.tick == step2 then
                    active = true
                end
                lightSwitch:setActive(active, false, true)
            end
        end
    end

end

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)