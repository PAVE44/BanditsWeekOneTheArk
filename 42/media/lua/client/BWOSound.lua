BWOASound = BWOASound or {}

BWOASound.objects = {}
BWOASound.tick = 0
BWOASound.maxDist = 50

function BWOASound.AddToObject(tab)
    table.insert(BWOASound.objects, tab)
end

function BWOASound.RemoveFromObject(tab)
    for i, effect in ipairs(BWOASound.objects) do
        if effect.x == tab.x and effect.y == tab.y and effect.z == tab.z then
            table.remove(BWOASound.objects, i)
            break
        end
    end
end

function BWOASound.Process()
    if isServer() then return end

    local player = getSpecificPlayer(0)
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local maxDist = BWOASound.maxDist
    local volume = getSoundManager():getSoundVolume()

    for _, effect in ipairs(BWOASound.objects) do
        if effect.x and effect.y and effect.z then

            if math.abs(effect.x - px) < maxDist and math.abs(effect.y - py) < maxDist and math.abs(effect.z - pz) < 1 then

                if not effect.emitter then
                    effect.emitter = getWorld():getFreeEmitter(effect.x, effect.y, effect.z)
                end

                effect.emitter:setVolumeAll(volume)

                if not effect.emitter:isPlaying(effect.sound) then
                    effect.emitter:playAmbientLoopedImpl(effect.sound)
                    effect.emitter:tick()
                end
            end
        end
    end
end

Events.OnTick.Add(BWOASound.Process)
