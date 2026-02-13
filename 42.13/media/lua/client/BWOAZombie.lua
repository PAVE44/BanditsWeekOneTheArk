local function onZombieUpdate(zombie)

    --[[
    local md = zombie:getModData()
    if not md.BWOA then md.BWOA = {} end

    if md.BWOA.beautified then return end
    ]]

    if zombie:getVariableBoolean("Bandit") then return end
    
    local hv = zombie:getHumanVisual()

    local skin = hv:getSkinTexture()
    
    local newskin
    if zombie:isFemale() then
        newskin = "F_ZedBody04_level3"
    else
        newskin = "M_ZedBody04_level3"
    end

    if skin ~= newskin then

        hv:setSkinTextureName(newskin)

        local maxIndex = BloodBodyPartType.MAX:index()
        for i = 0, maxIndex - 1 do
            local part = BloodBodyPartType.FromIndex(i)
            -- hv:setBlood(part, 1)
            hv:setDirt(part, 1)
            zombie:addHole(part);
            zombie:addLotsOfDirt(part, 1, true)
        end

        for i = 1, ZombRand(10) do
            zombie:addRandomVisualDamages()
        end

        zombie:resetModelNextFrame()
        zombie:resetModel()


    end

end

Events.OnZombieUpdate.Remove(onZombieUpdate)
Events.OnZombieUpdate.Add(onZombieUpdate)