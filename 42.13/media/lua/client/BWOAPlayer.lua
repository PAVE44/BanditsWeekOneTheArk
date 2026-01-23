BWOAPlayer = BWOPlayer or {}

BWOAPlayer.tick = 0

BWOAPlayer.dreamStage = 1
BWOAPlayer.dreamNo = 1

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

local timeRevealMap = {
    [1] = {hours = 29, person = "Emma Robinson", qid = "300.1"},
}

local roomRevealMap = {
    ["GENERATOR_ROOM"]          = {person = "Emma Robinson", qid = "100.1"},
    ["FOODGARDEN"]              = {person = "Emma Robinson", qid = "100.3"},
    ["LIBRARY"]                 = {person = "Emma Robinson", qid = "100.4"},
    ["CHAPEL"]                  = {person = "Emma Robinson", qid = "100.5"},
    ["LABORATORY"]              = {person = "Emma Robinson", qid = "100.6"},
    ["ARMORY"]                  = {person = "Emma Robinson", qid = "100.8"},
    ["DECONTAMINATION_CHAMBER"] = {person = "Emma Robinson", qid = "100.9"},
    ["AIRVENTROOM"]             = {person = "Emma Robinson", qid = "100.10"},
    -- ["INCINERATOR_ROOM"]        = {person = "Emma Robinson", qid = "100.10"},
}

local traitRevealMap = {
    {trait = CharacterTrait.SMOKER, person = "Emma Robinson", qid = "200.1"},
}

local dreamRevealMap = {
    [1] = {hours = 24, qid = "2000.1", txt = "Arghgghhh!"},
    [2] = {hours = 48, qid = "2000.2", txt = "Not again...!"},
    [3] = {hours = 72, qid = "2000.3", txt = "Damn dream again!"},
    [4] = {hours = 96, qid = "2000.4", txt = "WTF... This was different..."},
    [5] = {hours = 120, qid = "2000.5", rmid = 100, txt = "I think this is important."},
    [6] = {hours = 144, qid = "2000.6", rmid = 110, txt = "I think this is important."},
}

local proximityRevealMap = {
    [1] = {x=8318, y=11636, z=0, dist=6, amid = 10}
}

local function predicateAll(item)
    -- item:getType()
	return true
end

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

    -- time discovery
    if BWOAPlayer.tick == 1 then
        local hours = math.floor(getGameTime():getWorldAgeHours()) - 10
        for _, tab in ipairs(timeRevealMap) do
            if hours >= tab.hours then
                BWOADialogues.Reveal(tab.person, tab.qid)
            end
        end
    end

    -- player trait discovery
    if BWOAPlayer.tick == 2 then
        for _, tab in ipairs(traitRevealMap) do
            if player:hasTrait(tab.trait) then
                BWOADialogues.Reveal(tab.person, tab.qid)
            end
        end
    end

    -- player proximity to location discovery
    if BWOAPlayer.tick == 3 then
        for _, tab in ipairs(proximityRevealMap) do
            if math.abs(px - tab.x) < tab.dist and math.abs(py - tab.y) < tab.dist and pz == tab.z then
                if tab.rmid then
                    BWOAMissions.Reveal(tab.rmid)
                end
                if tab.amid then
                    BWOAMissions.Accomplish(tab.amid)
                end
                if tab.person and tab.qid then
                    BWOADialogues.Reveal(tab.person, tab.qid)
                end
            end
        end
    end

    -- player clothing mission completion
    if BWOAPlayer.tick == 3 then 
        local suit = player:getWornItem(ItemBodyLocation.BOILERSUIT)
        if suit then
            BWOAMissions.Accomplish(2)
        end
    end

    -- player at location mission completion and dialogue reveal
    local placeEvents = BWOAPlaceEvents.events
    for k_, placeEvent in pairs(placeEvents) do
        if placeEvent.accomplishMissionId or (placeEvent.revealDialoguePerson and placeEvent.revealDialogueId) then
            if math.abs(px - placeEvent.x) < 6 and math.abs(py - placeEvent.y) < 6 and pz == placeEvent.z then
                if placeEvent.accomplishMissionId then
                    BWOAMissions.Accomplish(placeEvent.accomplishMissionId)
                end
                if placeEvent.revealDialoguePerson and placeEvent.revealDialogueId then
                    BWOADialogues.Reveal(placeEvent.revealDialoguePerson, placeEvent.revealDialogueId)
                end
            end
        end
    end

    -- dreams
    local emitter = player:getEmitter()
    local dreamShouldStart = false
    local dreamShouldEnd = false
    if player:isAsleep() then
        nh = math.floor(getGameTime():getTimeOfDay()) + 2
        if (nh >= 24) then
            nh = nh - 24
        end

        player:setForceWakeUpTime(nh)

        if BWOAPlayer.dreamStage == 1 then
            local hours = player:getHoursSurvived()
            for dreamNo, dreamData in pairs(dreamRevealMap) do
                if hours < dreamData.hours then
                    BWOAPlayer.dreamNo = dreamNo
                    break
                end
            end

            if BWOAPlayer.dreamNo then
                dreamShouldStart = true
            end
        elseif BWOAPlayer.dreamStage == 2 then
            if not emitter:isPlaying(BWOAPlayer.soundStart) then
                dreamShouldEnd = true
            end
        end
    else
        -- player wakes before dream end
        if BWOAPlayer.dreamStage == 2 then
            dreamShouldEnd = true
        end
    end

    if dreamShouldStart then
        BWOAPlayer.soundStart = "Dream" .. tostring(BWOAPlayer.dreamNo) .. "Start"
        BWOAPlayer.soundEnd = "Dream" .. tostring(BWOAPlayer.dreamNo) .. "End"
        emitter:playSound(BWOAPlayer.soundStart)
        BWOAPlayer.dreamStage = 2
    end

    if dreamShouldEnd then
        emitter:playSound(BWOAPlayer.soundEnd)
        emitter:stopSoundByName(BWOAPlayer.soundStart)
        BanditPlayer.WakeEveryone()
        local stats = player:getStats()
        stats:set(CharacterStat.PANIC, 100)

        for dreamNo, dreamData in pairs(dreamRevealMap) do
            if dreamNo == BWOAPlayer.dreamNo then
                if dreamData.amid then
                    BWOAMissions.Accomplish(dreamData.amid)
                end
                if dreamData.rmid then
                    BWOAMissions.Reveal(dreamData.rmid)
                end
                if dreamData.qid then
                    BWOADialogues.Reveal("Emma Robinson", dreamData.qid)
                end
                if dreamData.txt then
                    BWOAEventControl.Add("SayPlayer", {txt = dreamData.txt}, 100)
                end
                break
            end
        end

        BWOAPlayer.dreamStage = 1
    end

    -- tick update
    BWOAPlayer.tick = BWOAPlayer.tick + 1
end

local function everyOneMinute()
    local player = getSpecificPlayer(0)
    if not player then return end

    if not player:isAlive() then return end

    if player:isGodMod() then return end

    local cell = getCell()
    local bodyDamage = player:getBodyDamage()
    local stats = player:getStats()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local gmd = GetBWOAModData()

    local md = player:getModData()
    if not md.bwoa then md.bwoa = {} end
    if not md.bwoa.drug then md.bwoa.drug = {} end

    local hasSuit
    local hasMask

    local suit = player:getWornItem(ItemBodyLocation.BOILERSUIT)
    if suit then
        if suit:hasTag(ItemTag.HAZMAT_SUIT) then 
            hasSuit = true
        end
    end

    local mask = player:getWornItem(ItemBodyLocation.MASK_EYES)
    if mask then
        if mask:hasTag(ItemTag.GAS_MASK) then
            hasMask = true
            local filter = mask:getUsedDelta()
            filter = filter - 0.001
            if filter < 0.1 and ZombRand(5) == 1 then
                local sound = player:getDescriptor():getVoicePrefix() .. "Cough"
                player:getEmitter():playVocals(sound)
            end
            if filter < 0 then 
                filter = 0 
                hasMask = false
            end
            mask:setUsedDelta(filter)
        end
    end

    local suitFull = player:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD)
    if suitFull then
        if suitFull:hasTag(ItemTag.HAZMAT_SUIT) then 
            hasSuit = true
            hasMask = true
        end
    end

    local hasGeiger = false
    local itemGeiger = player:getAttachedItem("Walkie Belt Left") or player:getAttachedItem("Walkie Belt Right") or player:getPrimaryHandItem() or player:getSecondaryHandItem()
    if itemGeiger then
        if itemGeiger:hasTag(ItemTag.MISC_ELECTRONIC) then
            hasGeiger = true
        end
    end

    -- radiation effect simulation
    if not md.bwoa.radiation then md.bwoa.radiation = 0 end
    if not md.bwoa.timeRadiatedHematopoietic then md.bwoa.timeRadiatedHematopoietic = 0 end
    if not md.bwoa.timeRadiatedGastrointernal then md.bwoa.timeRadiatedGastrointernal = 0 end

    local radiationBalance = 0
    local immuneRadiation = false
    if hasSuit and hasMask then immuneRadiation = true end

    local radiation = BWOAClimate.radiation
    local multiplayer = 1
    if pz <= -2 then 
        multiplayer = 0
    elseif pz > -2 and pz < 0 then
        multiplayer = 0.2
    end
    if not player:isOutside() then multiplayer = multiplayer * 0.8 end
    radiation = radiation * multiplayer

    -- radiation from items
    local items = ArrayList.new()
    local inventory = player:getInventory()
    inventory:getAllEvalRecurse(predicateAll, items)
    for i=0, items:size()-1 do
        local item = items:get(i)
        if item:getModData().radiated then
            radiation = radiation + 100
        end
    end

    local groundItems = {}
    for y = py - 1, py + 1 do
        for x = px - 1, px + 1 do
            local square = cell:getGridSquare(x, y, pz)
            if square then
                local wobs = square:getWorldObjects()
                for i = 0, wobs:size()-1 do
                    local o = wobs:get(i)
                    local groundItem = o:getItem()
                    table.insert(groundItems, groundItem)
                end
            end
        end
    end
    for _, groundItem in ipairs(groundItems) do
        if groundItem:getModData().radiated then
            radiation = radiation + 50
        end
    end

    if radiation > 0 then
        local dose = math.floor(radiation / 60)
        if not immuneRadiation then
            radiationBalance = radiationBalance + dose
        end

        -- geiger effect
        if hasGeiger then
            local intensity = BanditUtils.Lerp(radiation, 0, 4000, 0, 6)
            intensity = math.floor(intensity + 0.5)
            if intensity > 6 then intensity = 6 end
            BWOAEventControl.Add("PlayPlayer", {sound = "AmbientGeiger" .. intensity}, 1)
        end

        -- item contamination
        if multiplayer > 0 then
            for i=0, items:size()-1 do
                local item = items:get(i)
                local ftype = item:getFullType()
                if suit then
                    if instanceof(item, "Clothing") then
                        if item:hasTag(ItemTag.HAZMAT_SUIT) then
                            item:getModData().radiated = true
                        end
                    else
                        item:getModData().radiated = true
                    end
                else
                    item:getModData().radiated = true
                end
            end

            for _, groundItem in ipairs(groundItems) do
                groundItem:getModData().radiated = true
            end
        end
    end

    if not immuneRadiation and md.bwoa.radiation >= 100 and md.bwoa.radiation < 3000 then
        md.bwoa.timeRadiatedHematopoietic = md.bwoa.timeRadiatedHematopoietic + 1
    end

    -- md.bwoa.radiation = 700

    if md.bwoa.radiation >= 3000 then -- Central nervous system syndrome
        local scream = false
        for _, sbp in ipairs(bodyParts) do
            local burnBodyPart = bodyDamage:getBodyPart(sbp.name)
            if ZombRand(16) == 1 and not burnBodyPart:isBurnt() then
                burnBodyPart:setBurned()
                if not scream then
                    local sound = player:getDescriptor():getVoicePrefix() .. "DeathFall" -- "DeathAlone" or "DeathEaten"
                    player:getEmitter():playVocals(sound)
                    scream = true
                end
            end
        end
    elseif md.bwoa.radiation >= 100 and md.bwoa.radiation < 3000 then  -- Hematopoietic syndrome phase
        -- md.bwoa.timeRadiatedHematopoietic = 1500

        if md.bwoa.timeRadiatedHematopoietic > 1440 then -- latent subphase
            local sick = stats:get(CharacterStat.FOOD_SICKNESS)
            local sickExpected = md.bwoa.radiation / 10
            if sick < sickExpected then
                stats:set(CharacterStat.FOOD_SICKNESS, sick + 5)
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
            local fatigue = stats:get(CharacterStat.FATIGUE)
            local fatigueExpected = md.bwoa.radiation / 1000
            if fatigue < fatigueExpected then
                stats:set(CharacterStat.FATIGUE, fatigue + 0.1)
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

    radiationBalance = radiationBalance - 0.5
    if md.bwoa.drug.PotassiumIodine and md.bwoa.drug.PotassiumIodine > 0 then
        radiationBalance = radiationBalance - 1
    end

    md.bwoa.radiation = md.bwoa.radiation + radiationBalance
    if md.bwoa.radiation < 0 then
        radiationBalance = 0
        md.bwoa.radiation = 0
        md.bwoa.timeRadiatedHematopoietic = 0
        md.bwoa.timeRadiatedGastrointernal = 0
    end

    if radiationBalance >= 0.5 then
        HaloTextHelper.addTextWithArrow(player, "Radiation +" .. radiationBalance, true, HaloTextHelper.getColorRed())
    elseif radiationBalance <= -0.5 then
        HaloTextHelper.addTextWithArrow(player, "Radiation " .. radiationBalance, false, HaloTextHelper.getColorGreen())
    end

    print ("PLAYER RADIATION: RAD: " .. md.bwoa.radiation .. " EXPO HEMA: " .. md.bwoa.timeRadiatedHematopoietic .. " EXPO GAST: " .. md.bwoa.timeRadiatedGastrointernal)

    -- co2 intoxication simlation
    if pz < -2 and px >= 9900 and py >= 12590 and px < 9990 and py < 12660 and not hasMask then
        local ventilation = gmd.ventilation
        local head = bodyDamage:getBodyPart(BodyPartType.Head)
        local health = bodyDamage:getOverallBodyHealth()
        local sick = stats:get(CharacterStat.FOOD_SICKNESS)
        local headAche = stats:get(CharacterStat.PAIN)
        local fatigue = stats:get(CharacterStat.FATIGUE)
        local drunk = stats:get(CharacterStat.INTOXICATION)
        local endurance = stats:get(CharacterStat.ENDURANCE)
        local panic = stats:get(CharacterStat.PANIC)

        local healthExpected
        local sickExpected
        local headAcheExpected
        local fatigueExpected
        local drunkExpected
        local enduranceExpected
        local panicExpected

        if ventilation.co2 > 60000 then
            healthExpected = 0
            sickExpected = 55
            headAcheExpected = 80
            fatigueExpected = 0.9
            drunkExpected = 100
            enduranceExpected = 0.3
            panicExpected = 0.6
        elseif ventilation.co2 > 30000 then
            healthExpected = 50
            sickExpected = 55
            headAcheExpected = 80
            fatigueExpected = 0.9
            drunkExpected = 80
            enduranceExpected = 0.3
            panicExpected = 0.4
        elseif ventilation.co2 > 10000 then
            sickExpected = 55
            headAcheExpected = 60
            fatigueExpected = 0.85
            enduranceExpected = 0.3
            panicExpected = 0.2
        elseif ventilation.co2 > 5000 then
            BWOADialogues.Reveal("Emma Robinson", "1000.4")
            sickExpected = 55
            headAcheExpected = 55
            fatigueExpected = 0.80
            enduranceExpected = 0.3
        elseif ventilation.co2 > 2000 then
            headAcheExpected = 50
            fatigueExpected = 0.75
        elseif ventilation.co2 > 1000 then
            fatigueExpected = 0.65
        end

        if md.bwoa.drug.Aspirin and md.bwoa.drug.Aspirin > 0 and headAcheExpected then
            headAcheExpected = headAcheExpected / 2
        end

        if md.bwoa.drug.Pentoxifylline and md.bwoa.drug.Pentoxifylline > 0 and fatigueExpected and enduranceExpected then
            fatigueExpected = fatigueExpected / 3
            enduranceExpected = enduranceExpected / 3
        end

        if healthExpected then
            if health < healthExpected then 
                bodyDamage:getOverallBodyHealth(health - 1)
            end
        end
        if sickExpected then
            if sick < sickExpected then 
                stats:set(CharacterStat.FOOD_SICKNESS, sick + 5)
            end
        end
        if headAcheExpected then
            if headAche < headAcheExpected then 
                stats:set(CharacterStat.PAIN, headAche + 2)
            end
        end
        if fatigueExpected then
            if fatigue < fatigueExpected then 
                stats:set(CharacterStat.FATIGUE, fatigue + 0.05)
            end
        end
        if drunkExpected then
            if drunk < drunkExpected then 
                stats:set(CharacterStat.INTOXICATION, drunk + 1)
            end
        end
        if enduranceExpected then
            if endurance < enduranceExpected then 
                stats:set(CharacterStat.ENDURANCE, endurance + 0.05)
            end
        end
        if panicExpected then
            if panic < panicExpected then 
                stats:set(CharacterStat.PANIC, panic + 0.05)
            end
        end
    end

    if md.bwoa.drug.Aspirin and md.bwoa.drug.Aspirin > 0 then
        local cs = bodyDamage:getColdStrength()
        cs = cs - 0.8
        if cs < 0 then cs = 0 end
        bodyDamage:setColdStrength(cs)
    end

    -- drug in organism depletion
    for drug, dose in pairs(md.bwoa.drug) do
        dose = dose - 1
        if dose < 0 then dose = 0 end
        md.bwoa.drug[drug] = dose
    end

end

local onTimedActionPerform = function(data)

    local character = data.character
    if not character then return end

    local action = data.action:getMetaType()
    if not action then return end

    local md = character:getModData()
    if not md.bwoa then md.bwoa = {} end

    if action == "ISTakePillAction" then
        if not md.bwoa.drug then md.bwoa.drug = {} end

        local drugMap ={
            ["Pills"] = { -- heals cold
                name = "Aspirin",
                dose = 120
            },
            ["PillsPotassiumIodine"] = { -- accumulated radiation will wear off quicker
                name = "PotassiumIodine",
                dose = 480
            },
            ["PillsPentoxifylline"] = { -- minimizes effects of high co2 
                name = "Pentoxifylline",
                dose = 240
            },
            ["PillsPrussianBlue"] = {
                name = "PrussianBlue",
                dose = 480
            },
            ["PillsNikethamide"] = { -- helps in hypotermia
                name = "Nikethamide",
                dose = 480
            },
        }

        local item = data.item
        local itemType = item:getType()
        if drugMap[itemType] then
            local drug = drugMap[itemType]
            if not md.bwoa.drug[drug.name] then md.bwoa.drug[drug.name] = 0 end
            md.bwoa.drug[drug.name] = md.bwoa.drug[drug.name] + drug.dose
        end
    elseif action == "ISInventoryTransferAction" then
        local item = data.item
        local destContainerParent = data.destContainer:getParent()

        -- that means taking things
        if instanceof(destContainerParent, "IsoPlayer") then 
            local md = item:getModData()
            if md.BWOA then
                if md.BWOA.accomplishMissionId then
                    BWOAMissions.Accomplish(md.BWOA.accomplishMissionId)
                end
                if md.BWOA.revealMissionId then
                    BWOAMissions.Reveal(md.BWOA.revealMissionId)
                end
                if md.BWOA.revealDialogueId and md.BWOA.revealDialoguePerson then
                    BWOADialogues.Reveal(md.BWOA.revealDialoguePerson, md.BWOA.revealDialogueId)
                end
            end
        end

    elseif action == "ISSeedActionNew" then
        if data.typeOfSeed == "Comfrey" then
            BWOAMissions.Accomplish(102)
        end

    elseif action == "ISHarvestPlantAction" then
        if data.plant.typeOfSeed == "Comfrey" then
            BWOAMissions.Accomplish(103)
        end

    elseif action == "TABAS_TakeShower" then

        local radiationBalance = 0.5 * md.bwoa.radiation
        md.bwoa.radiation = 1 - radiationBalance
        HaloTextHelper.addTextWithArrow(player, "Radiation " .. radiationBalance, false, HaloTextHelper.getColorGreen())
    end
end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)

Events.EveryOneMinute.Remove(everyOneMinute)
Events.EveryOneMinute.Add(everyOneMinute)

Events.OnTimedActionPerform.Remove(onTimedActionPerform)
Events.OnTimedActionPerform.Add(onTimedActionPerform)

