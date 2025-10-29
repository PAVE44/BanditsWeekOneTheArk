BWOAPlayer = BWOPlayer or {}

BWOAPlayer.tick = 0

local bodyParts = {}
table.insert(bodyParts, {bname=BloodBodyPartType.Head, name=BodyPartType.Head, chance=1000})
table.insert(bodyParts, {bname=BloodBodyPartType.Torso_Lower, name=BodyPartType.Torso_Lower, chance=600})
table.insert(bodyParts, {bname=BloodBodyPartType.Torso_Upper, name=BodyPartType.Torso_Upper, chance=450})
table.insert(bodyParts, {bname=BloodBodyPartType.Groin, name=BodyPartType.Groin, chance=300})
table.insert(bodyParts, {bname=BloodBodyPartType.Neck, name=BodyPartType.Neck, chance=200})
table.insert(bodyParts, {bname=BloodBodyPartType.UpperArm_R, name=BodyPartType.UpperArm_R, chance=100})
table.insert(bodyParts, {bname=BloodBodyPartType.UpperArm_L, name=BodyPartType.UpperArm_L, chance=75})
table.insert(bodyParts, {bname=BloodBodyPartType.ForeArm_R, name=BodyPartType.ForeArm_R, chance=50})
table.insert(bodyParts, {bname=BloodBodyPartType.ForeArm_L, name=BodyPartType.ForeArm_L, chance=35})
table.insert(bodyParts, {bname=BloodBodyPartType.Hand_R, name=BodyPartType.Hand_R, chance=20})
table.insert(bodyParts, {bname=BloodBodyPartType.Hand_L, name=BodyPartType.Hand_L, chance=10})

local roomRevealMap = {
    ["GENERATOR_ROOM"] = {person = "Emma Robinson", qid = "100.1"},
   
    ["HYDROPONICS"]    = {person = "Emma Robinson", qid = "100.3"},
    ["LIBRARY"]        = {person = "Emma Robinson", qid = "100.4"},
    ["CHAPEL"]         = {person = "Emma Robinson", qid = "100.5"},
    ["LABORATORY"]     = {person = "Emma Robinson", qid = "100.6"},
    ["BEDROOM_ONE"]    = {person = "Emma Robinson", qid = "100.7"},
    
}

local traitRevealMap = {
    ["Smoker"]      = {person = "Emma Robinson", qid = "200.1"},
}

local onPlayerUpdate = function(player)
    if BWOAPlayer.tick >= 64 then
        BWOAPlayer.tick = 0
    end

    local px, py, pz = player:getX(), player:getY(), player:getZ()

    -- room discovery
    if BWOAPlayer.tick % 32 == 0 then
        local room = BWOAUtils.GetRoom(px, py, pz)
        if room then
            local revealData = roomRevealMap[room.name]
            if revealData then
                BWOADialogues.Reveal(revealData.person, revealData.qid)
            end
        end
    end

    -- player trait discovery
    if BWOAPlayer.tick == 1 then
        for trait, tab in pairs(traitRevealMap) do
            if player:HasTrait(trait) then
                BWOADialogues.Reveal(tab.person, tab.qid)
            end
        end
    end

    BWOAPlayer.tick = BWOAPlayer.tick + 1
end

local function everyOneMinute()

    -- radiation effect simulation
    local player = getSpecificPlayer(0)
    if not player then return end

    if player:isGodMod() then return end

    local bodyDamage = player:getBodyDamage()
    local stats = player:getStats()

    local md = player:getModData()
    if not md.bwoa then md.bwoa = {} end
    if not md.bwoa.radiation then md.bwoa.radiation = 0 end
    if not md.bwoa.timeRadiatedHematopoietic then md.bwoa.timeRadiatedHematopoietic = 0 end
    if not md.bwoa.timeRadiatedGastrointernal then md.bwoa.timeRadiatedGastrointernal = 0 end

    local immune = false
    local suit = player:getWornItem("Boilersuit")
    if suit then
        if suit:hasTag(ItemTag.HAZMAT_SUIT) then 
            local mask = player:getWornItem("MaskEyes")
            if mask then
                if mask:hasTag(ItemTag.GAS_MASK) then
                    immune = true
                end
            end
        end
    end
    local suit = player:getWornItem("FullSuitHead")
    if suit then
        if suit:hasTag(ItemTag.HAZMAT_SUIT) then 
            immune = true
        end
    end

    local radiation = BWOAClimate.radiation
    if radiation > 0 then
        local multiplayer = 1
        local z = player:getZ()
        if z <= -1 then 
            multiplayer = 0
        elseif z > -1 and z < 0 then
            multiplayer = -z
        end
        if not player:isOutside() then multiplayer = multiplayer * 0.8 end
        if multiplayer > 0 then
            if not immune then
                md.bwoa.radiation = md.bwoa.radiation + math.floor(radiation / 60)
            end
        end
    end

    if not immune and md.bwoa.radiation >= 100 and md.bwoa.radiation < 3000 then
        md.bwoa.timeRadiatedHematopoietic = md.bwoa.timeRadiatedHematopoietic + 1
    end

    -- md.bwoa.radiation = 700

    if md.bwoa.radiation >= 3000 then -- Central nervous system syndrome
        local sound = player:getDescriptor():getVoicePrefix() .. "DeathFall" -- "DeathAlone" or "DeathEaten"
        player:getEmitter():playVocals(sound)
        for _, sbp in ipairs(bodyParts) do
            local burnBodyPart = bodyDamage:getBodyPart(sbp.name)
            if ZombRand(6) == 1 and not burnBodyPart:isBurnt() then
                burnBodyPart:setBurned()
            end
        end
    elseif md.bwoa.radiation >= 100 and md.bwoa.radiation < 3000 then  -- Hematopoietic syndrome phase
        -- md.bwoa.timeRadiatedHematopoietic = 1500

        if md.bwoa.timeRadiatedHematopoietic > 1440 then -- latent subphase
            local sick = bodyDamage:getFoodSicknessLevel()
            local sickExpected = md.bwoa.radiation / 10
            if sick < sickExpected then 
                bodyDamage:setFoodSicknessLevel(sick + 5)
            end

            if ZombRand(20) == 0 then
                player:StopAllActionQueue()
                player:playEmote("feelfeint")
                local sound = player:getDescriptor():getVoicePrefix() .. "PainFromGlassCut"
                player:getEmitter():playVocals(sound)
                BWOADialogues.Reveal("Emma Robinson", "1000.3")
            end
        end

        if md.bwoa.timeRadiatedHematopoietic > 480 and md.bwoa.timeRadiatedHematopoietic < 2100 then -- prodromal subphase
            local fatigue = stats:getFatigue()
            local fatigueExpected = md.bwoa.radiation / 1000
            if fatigue < fatigueExpected then 
                stats:setFatigue(fatigue + 0.1) 
            end

            local head = bodyDamage:getBodyPart(BodyPartType.Head)
            local pain = head:getAdditionalPain()
            local painExpected = md.bwoa.radiation / 10
            if pain < painExpected then 
                head:setAdditionalPain(pain + 2)
            end

            if ZombRand(20) == 0 then
                player:StopAllActionQueue()
                player:playEmote("vomit")
                local sound = player:getDescriptor():getVoicePrefix() .. "Vomit"
                player:getEmitter():playVocals(sound)
                for i = 1, 12 do
                    local bx = player:getX() - 0.5 + ZombRandFloat(0.1, 0.9)
                    local by = player:getY() - 0.5 + ZombRandFloat(0.1, 0.9)
                    local bz = player:getZ()
                    player:getChunk():addBloodSplat(bx, by, bz, ZombRand(20))
                end
                BWOADialogues.Reveal("Emma Robinson", "1000.3")
            end
        end
        
    elseif md.bwoa.radiation < 16 then
        --[[
        md.bwoa.timeRadiatedHematopoietic = md.bwoa.timeRadiatedHematopoietic - 1
        if md.bwoa.timeRadiatedHematopoietic < 0 then md.bwoa.timeRadiatedHematopoietic = 0 end
    
        md.bwoa.timeRadiatedGastrointernal = md.bwoa.timeRadiatedGastrointernal - 1
        if md.bwoa.timeRadiatedGastrointernal < 0 then md.bwoa.timeRadiatedGastrointernal = 0 end
        ]]
    end

    md.bwoa.radiation = md.bwoa.radiation - 0.5
    if md.bwoa.radiation < 0 then 
        md.bwoa.radiation = 0
        md.bwoa.timeRadiatedHematopoietic = 0
        md.bwoa.timeRadiatedGastrointernal = 0
    end

    print ("RAD: " .. md.bwoa.radiation)
    print ("TIME: " .. md.bwoa.timeRadiatedHematopoietic)
end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)
Events.EveryOneMinute.Add(everyOneMinute)