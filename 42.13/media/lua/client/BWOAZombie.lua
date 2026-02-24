local femaleHairChoices = {
    "Bald",
    "Bald",
    "Bald",
    "Bald",
    "Long",
}
local maleHairChoices = {
    "Bald",
    "Bald",
    "Bald",
    "Bald",
    "Bald",
    "Bald",
    "Baldspot",
    "Messy",
    "MessyCurly",
    "Recede",
    "Picard",
    "Long",
}

local beardChoices = {
    "",
    "",
    "",
    "",
    "LongScruffy",
    "LongScruffy",
    "LongScruffy",
    "Full",
    "Long",
}

local function onZombieUpdate(zombie)

    --[[
    local md = zombie:getModData()
    if not md.BWOA then md.BWOA = {} end

    if md.BWOA.beautified then return end
    ]]

    if zombie:getVariableBoolean("Bandit") then return end

    if zombie:getZ() <= -2 then return end

    if zombie:isSkeleton() then return end
    
    local hv = zombie:getHumanVisual()

    local skin = hv:getSkinTexture()
    local newskin
    local newhair
    local newbeard
    if zombie:isFemale() then
        -- newskin = "F_ZedBody04_level3"
        newskin = "M_ZedBody_Burnt"
        newhair = BanditUtils.Choice(femaleHairChoices)
    else
        -- newskin = "M_ZedBody04_level3"
        newskin = "M_ZedBody_Burnt"
        newhair = BanditUtils.Choice(maleHairChoices)
        newbeard = BanditUtils.Choice(beardChoices)
    end

    local c = ZombRandFloat(0.1, 0.45)
    local color = ImmutableColor.new(c, c, c, 1)

    if skin ~= newskin then
        
        hv:setSkinTextureName(newskin)

        if newhair then
            hv:setHairModel(newhair)
            hv:setHairColor(color)
        end

        if newbeard then
            hv:setBeardModel(newbeard)
            hv:setBeardColor(color)
            hv:setNaturalBeardColor(color)
        end

        local maxIndex = BloodBodyPartType.MAX:index()
        for i = 0, maxIndex - 1 do
            local part = BloodBodyPartType.FromIndex(i)
            -- hv:setBlood(part, 1)
            hv:setDirt(part, 1)
            zombie:addHole(part);
            zombie:addLotsOfDirt(part, 1, true)

            local items = zombie:getItemVisuals()
            for i=0, items:size()-1 do
                local item = items:get(i)
                if item then
                    item:setDirt(part, 1)
                    local tint = item:getTint()
                    if tint then
                        local r, g, b = tint:getRedFloat(), tint:getGreenFloat(), tint:getBlueFloat()
                        local newtint = ImmutableColor.new(r * 0.3, g * 0.3, b * 0.3, 1)
                        item:setTint(newtint)
                    end
                end
            end

        end

        for i = 1, ZombRand(10) do
            zombie:addRandomVisualDamages()
        end

        

        zombie:resetModelNextFrame()
        zombie:resetModel()


    end

end

local function onDeadBodySpawn(body)
    local md = body:getModData()
    if not md.BWOA then md.BWOA = {} end

    if body:isSkeleton() and not md.BWOA.reanimated and ZombRand(50) == 0 then
        local age = getGameTime():getWorldAgeHours()
        body:setReanimateTime(age + ZombRandFloat(0.1, 0.7)) -- now plus 6 - 42 minutes
        md.BWOA.reanimated = true
    end
end

Events.OnZombieUpdate.Remove(onZombieUpdate)
Events.OnZombieUpdate.Add(onZombieUpdate)

Events.OnDeadBodySpawn.Remove(onDeadBodySpawn)
Events.OnDeadBodySpawn.Add(onDeadBodySpawn)