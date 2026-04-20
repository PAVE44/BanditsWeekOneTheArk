BWOAZombie = BWOAZombie or {}

BWOAZombie.tick = 0

BWOAZombie.femaleHairChoices = {
    "Bald",
    "Bald",
    "Bald",
    "Bald",
    "Long",
}
BWOAZombie.maleHairChoices = {
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

BWOAZombie.beardChoices = {
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

local function predicateAll(item)
    -- item:getType()
	return true
end


local function onZombieUpdate(zombie)

    if BWOAZombie.tick >= 64 then
        BWOAZombie.tick = 0
    end

    -- AUTOPSY TABLE HACK
    if zombie:getModData().fixedZ then
        zombie:setZ(zombie:getModData().fixedZ)
    end

    -- radiation
    local radiation = BWOAClimate.radiation
    if radiation > 100 then
        if zombie:getZ() >= 0 then
            zombie:getModData().radiated = true
        end
    end

    -- lava
    if BWOAZombie.tick % 16 == 0 then
        local square = zombie:getSquare()
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)                
            local sprite = object:getSprite()
            if sprite then
                local props = sprite:getProperties()
                if props:has("CustomName") then
                    local customName = props:get("CustomName")
                    if customName and customName == "Lava" then
                        zombie:SetOnFire()
                        break
                    end
                end
            end
        end

        if zombie:isOnFire() then 
            zombie:setHealth(zombie:getHealth() - 0.1)
        end
    end

    BWOAZombie.tick = BWOAZombie.tick + 1
    
    -- zombie beaufication
    if zombie:getVariableBoolean("Bandit") then return end
    if zombie:getZ() <= -2 then return end
    if zombie:getModData().isDeadBandit then return end

    if zombie:isSkeleton() then 
        if zombie:getHealth() > 0.1 then
            zombie:setHealth(0.1)
        end
        return
    end

    -- zombie:addLineChatElement(tostring(zombie:getHealth()), 0.5, 0.5, 0.5)

    if not BanditCompatibility.IsReanimatedForGrappleOnly(zombie) then
        local newskin
        local newhair
        local newbeard

        local hv = zombie:getHumanVisual()
        local skin = hv:getSkinTexture()

        if zombie:isFemale() then
            newskin = "M_ZedBody_Burnt" -- fixme (make female texture)
            newhair = BanditUtils.Choice(BWOAZombie.femaleHairChoices)
        else
            newskin = "M_ZedBody_Burnt"
            newhair = BanditUtils.Choice(BWOAZombie.maleHairChoices)
            newbeard = BanditUtils.Choice(BWOAZombie.beardChoices)
        end

        local c = ZombRandFloat(0.1, 0.45)
        local color = ImmutableColor.new(c, c, c, 1)

        if skin ~= newskin then
            zombie:setHealth(zombie:getHealth() * 0.6)
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

end

local function onDeadBodySpawn(body)
    local md = body:getModData()
    if not md.BWOA then md.BWOA = {} end

    if md.radiated then
        local inventory = body:getContainer()
        if inventory then
            local items = ArrayList.new()
            inventory:getAllEvalRecurse(predicateAll, items)
            for j=0, items:size()-1 do
                local item = items:get(j)
                item:getModData().radiated = true
            end
        end
    end

    if body:getModData().fixedZ then
        body:setZ(body:getModData().fixedZ)
    end

    if SandboxVars.BWOA.SkeletonReanimation then
        -- note: skeletons may lead to crashes if players aim at them with guns
        if body:isSkeleton() and not md.BWOA.reanimated and ZombRand(30) == 0 then
            local age = getGameTime():getWorldAgeHours()
            body:setReanimateTime(age + ZombRandFloat(0.1, 2.0)) -- now plus 6 - 120 minutes
            md.BWOA.reanimated = true
        end
    end
end

Events.OnZombieUpdate.Remove(onZombieUpdate)
Events.OnZombieUpdate.Add(onZombieUpdate)

Events.OnDeadBodySpawn.Remove(onDeadBodySpawn)
Events.OnDeadBodySpawn.Add(onDeadBodySpawn)