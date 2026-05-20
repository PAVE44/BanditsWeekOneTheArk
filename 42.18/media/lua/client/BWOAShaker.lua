BWOAShaker = BWOAShaker or {}

BWOAShaker.status = false -- whether shaker effect is active
BWOAShaker.step = 0 -- how much to offset player position
BWOAShaker.stepInc = 0.0005 -- how much to increase step each update
BWOAShaker.stepMax = 0.18 -- maximum step value
BWOAShaker.oscilator = 1 -- used to alternate direction of shake
BWOAShaker.tick = 0 -- tick counter (during shake tick, player movement is paralysed)

BWOAShaker.SetStatus = function(status)
    BWOAShaker.status = status
end

local onPlayerUpdate = function(player)
    
    local player = getSpecificPlayer(0)
    if not player then return end

    if BWOAShaker.tick % 2 == 0 then
        
        local x, y = player:getX(), player:getY()

        if BWOAShaker.status then
            BWOAShaker.step = BWOAShaker.step + BWOAShaker.stepInc
            if BWOAShaker.step > BWOAShaker.stepMax then
                BWOAShaker.step = BWOAShaker.stepMax
            end
        else
            BWOAShaker.step = BWOAShaker.step - BWOAShaker.stepInc
            if BWOAShaker.step < 0 then
                BWOAShaker.step = 0
            end
        end

        if BWOAShaker.step > 0 then

            local stats = player:getStats()
            stats:set(CharacterStat.INTOXICATION, BWOAShaker.step * 100 / BWOAShaker.stepMax)

            local newx, newy = x + BWOAShaker.step * BWOAShaker.oscilator, y + BWOAShaker.step * -BWOAShaker.oscilator

            player:setX(newx)
            player:setY(newy)
            player:setLastX(newx)
            player:setLastY(newy)

            BWOAShaker.oscilator = BWOAShaker.oscilator * -1
        end
    end

    BWOAShaker.tick = BWOAShaker.tick + 1

    if BWOAShaker.tick > 100 then
        BWOAShaker.tick = 0
    end

end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)
