BWOALights = BWOALights or {}

BWOALights.tick = 0
BWOALights.flicker = {}

BWOALights.AddFlicker = function(tab)
    table.insert(BWOALights.flicker, tab)
end

local function onTick()
    if isServer() then return end

    BWOALights.tick = BWOALights.tick + 1
    if BWOALights.tick == 32 then
        BWOALights.tick = 0
    end

    local power = BWOABaseControl.power
    if not power then return end

    if BWOALights.tick > 1 then return end

    local volume = getSoundManager():getSoundVolume()

    for _, effect in ipairs(BWOALights.flicker) do
        local lightSwitch = BanditUtils.GetLightSwitch(effect.x, effect.y, effect.z)
        if lightSwitch then
            local activated = lightSwitch:isActivated()
            local rnd = activated and 64 or 3
            if 1 + ZombRand(rnd) == 1 then
                if activated then
                    lightSwitch:setActive(false, false, true)
                    local emitter = getWorld():getFreeEmitter(effect.x, effect.y, effect.z)
                    local id = emitter:playSound("LightFlicker")
                    emitter:setVolume(id, volume)
                else
                    lightSwitch:setActive(true, false, true)
                end
            end
        end
    end

end

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)