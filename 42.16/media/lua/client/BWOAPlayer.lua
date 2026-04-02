require "BanditPlayer"
require "BanditActionInterceptor"

BanditPlayer.CheckFriendlyFire = function(bandit, attacker)
    return
end

BWOAPlayer = BWOAPlayer or {}

BWOAPlayer.tick = 0

BWOAPlayer.dreamStage = 1
BWOAPlayer.dreamNo = 1
BWOAPlayer.inside = 0
BWOAPlayer.outside = 0

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
    [1] = {hours = 29, person = "Emma_Robinson", qid = "300.1"},
    [2] = {hours = 65, person = "Emma_Robinson", qid = "300.3"},
    [3] = {hours = 168, person = "Emma_Robinson", qid = "300.4"},
}

local roomRevealMap = {
    ["GENERATOR_ROOM"]          = {person = "Emma_Robinson", qid = "100.1"},
    ["FOODGARDEN"]              = {person = "Emma_Robinson", qid = "100.3"},
    ["LIBRARY"]                 = {person = "Emma_Robinson", qid = "100.4"},
    ["CHAPEL"]                  = {person = "Emma_Robinson", qid = "100.5"},
    ["LABORATORY"]              = {person = "Emma_Robinson", qid = "100.6"},
    ["ARMORY"]                  = {person = "Emma_Robinson", qid = "100.8"},
    ["DECONTAMINATION_CHAMBER"] = {person = "Emma_Robinson", qid = "100.9"},
    ["AIRVENTROOM"]             = {person = "Emma_Robinson", qid = "100.10"},
    -- ["INCINERATOR_ROOM"]        = {person = "Emma_Robinson", qid = "100.10"},
}

local traitRevealMap = {
    {trait = CharacterTrait.SMOKER, person = "Emma_Robinson", qid = "200.1"},
    {trait = CharacterTrait.SHORT_SIGHTED, person = "Emma_Robinson", qid = "200.2"},
}

local dreamRevealMap = {
    [1]  = {hours = 36,  qid = "2000.1",  nid = nil,            rmid = nil, txt = "What a dream!"},
    [2]  = {hours = 72,  qid = "2000.2",  nid = nil,            rmid = nil, txt = "Damn dreams..."},
    [3]  = {hours = 108, qid = "2000.3",  nid = "Island",       rmid = nil, txt = "Where am I?"},
    [4]  = {hours = 144, qid = "2000.4",  nid = nil,            rmid = nil, txt = "This was different..."},
    [5]  = {hours = 180, qid = "2000.5",  nid = nil,            rmid = 100, txt = "I think this is important."},
    [6]  = {hours = 216, qid = "2000.6",  nid = "Fall",         rmid = 110, txt = "This cannot be happening!!!"},
    [7]  = {hours = 252, qid = "2000.7",  nid = "Council",      rmid = nil, txt = "What is this place?"},
    [8]  = {hours = 288, qid = "2000.8",  nid = "MirrorRoom",   rmid = nil, txt = "Emma? Where are you?"},
    [9]  = {hours = 324, qid = "2000.9",  nid = "Finnegan",     rmid = nil, txt = "I think I know this place!"},
    [10] = {hours = 360, qid = "2000.10", nid = "Maze",         rmid = nil, txt = "A labyrinth? Great..."},
    [11] = {hours = 396, qid = "2000.11", nid = "FamilyHouse",  rmid = nil, txt = "This is my house! I remember!"},
}

local proximityRevealMap = {
    [1] = {x=8318, y=11636, z=0, dist=6, amid = 10}
}

BWOAPlayer.itemMemoryRegain = {
    -- running
    {itemType = "Shoes_TrainerTINT", perk = "Sprinting", xp = 200, chance=30},
    {itemType = "Shoes_RedTrainers", perk = "Sprinting", xp = 600, chance=70},

    -- long blade
    {itemType = "Machete", perk = "LongBlade", xp = 400, chance=100},

    -- short blade
    {itemType = "HuntingKnife", perk = "SmallBlade", xp = 300, chance=50},
    {itemType = "KitchenKnife", perk = "SmallBlade", xp = 100, chance=50},

    -- axe
    {itemType = "Axe", perk = "Axe", xp = 400, chance=40},
    {itemType = "HandAxe", perk = "Axe", xp = 300, chance=40},
    {itemType = "WoodAxe", perk = "Axe", xp = 400, chance=40},

    -- aiming
    {itemType = "Pistol", perk = "Aiming", xp = 600, chance=100},
    {itemType = "Pistol2", perk = "Aiming", xp = 300, chance=20},
    {itemType = "Pistol3", perk = "Aiming", xp = 300, chance=20},
    {itemType = "AssaultRifle", perk = "Aiming", xp = 300, chance=20},
    {itemType = "AssaultRifle2", perk = "Aiming", xp = 300, chance=20},
    {itemType = "HuntingRifle", perk = "Aiming", xp = 450, chance=15},

    -- reloading
    {itemType = "9mmClip", perk = "Reloading", xp = 600, chance=100},
    {itemType = "45Clip", perk = "Reloading", xp = 300, chance=20},
    {itemType = "44Clip", perk = "Reloading", xp = 300, chance=20},
    {itemType = "M14Clip", perk = "Reloading", xp = 300, chance=20},
    {itemType = "556Clip", perk = "Reloading", xp = 300, chance=20},
    {itemType = "308Clip", perk = "Reloading", xp = 450, chance=15},

    -- carpentry
    {itemType = "Hammer", perk = "Woodwork", xp = 400, chance=60},
    {itemType = "BallPeenHammer", perk = "Woodwork", xp = 400, chance=40},
    {itemType = "Nails", perk = "Woodwork", xp = 200, chance=20},
    {itemType = "Plank", perk = "Woodwork", xp = 200, chance=20},

    -- first aid
    {itemType = "Bandage", perk = "Doctor", xp = 150, chance=100},
    {itemType = "SutureNeedle", perk = "Doctor", xp = 150, chance=100},
    {itemType = "SutureNeedleHolder", perk = "Doctor", xp = 150, chance=100},

    -- electrical
    {itemType = "Screwdriver", perk = "Electricity", xp = 200, chance=100},

    -- mechanics
    {itemType = "Wrench", perk = "Mechanics", xp = 150, chance=100},
    {itemType = "CarKey", perk = "Mechanics", xp = 75, chance=50},
    {itemType = "TireIron", perk = "Mechanics", xp = 75, chance=40},
    {itemType = "LugWrench", perk = "Mechanics", xp = 75, chance=50},
    {itemType = "EngineParts", perk = "Mechanics", xp = 150, chance=60},
    {itemType = "Jack", perk = "Mechanics", xp = 75, chance=60},
    {itemType = "TirePump", perk = "Mechanics", xp = 75, chance=60},
    {itemType = "Screws", perk = "Mechanics", xp = 75, chance=30},

    -- metalworking
    {itemType = "SheetMetal", perk = "MetalWelding", xp = 75, chance=40},
    {itemType = "SmallSheetMetal", perk = "MetalWelding", xp = 75, chance=40},
    {itemType = "BlowTorch", perk = "MetalWelding", xp = 200, chance=100},
    {itemType = "WeldingMask", perk = "MetalWelding", xp = 200, chance=100},
    {itemType = "WeldingRods", perk = "MetalWelding", xp = 75, chance=20},

    -- cooking
    {itemType = "Onion", perk = "Cooking", xp = 75, chance=100},
    {itemType = "Avocado", perk = "Cooking", xp = 75, chance=10},
    {itemType = "Carrots", perk = "Cooking", xp = 75, chance=10},
    {itemType = "Broccoli", perk = "Cooking", xp = 75, chance=10},
    {itemType = "Cabbage", perk = "Cooking", xp = 75, chance=10},
    {itemType = "Cucumber", perk = "Cooking", xp = 75, chance=10},
    {itemType = "Tomato", perk = "Cooking", xp = 75, chance=10},
    {itemType = "Bowl", perk = "Cooking", xp = 75, chance=20},
    {itemType = "Butter", perk = "Cooking", xp = 75, chance=20},
    {itemType = "Pot", perk = "Cooking", xp = 75, chance=20},
    {itemType = "Pan", perk = "Cooking", xp = 75, chance=20},
    {itemType = "Pasta", perk = "Cooking", xp = 75, chance=20},
    {itemType = "Plate", perk = "Cooking", xp = 75, chance=20},
    {itemType = "Spatula", perk = "Cooking", xp = 125, chance=50},

    -- maintenance
    {itemType = "DuctTape", perk = "Maintenance", xp = 300, chance=80},
    {itemType = "Glue", perk = "Maintenance", xp = 150, chance=25},
    {itemType = "Woodglue", perk = "Maintenance", xp = 150, chance=25},

    -- farming
    {itemType = "HandShovel", perk = "Farming", xp = 300, chance=80},
    {itemType = "WateredCan", perk = "Farming", xp = 150, chance=50},
    {itemType = "GardenFork", perk = "Farming", xp = 150, chance=25},
    {itemType = "BasilBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "BellPepperBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "BarleyBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "BroccoliBagSeed2", perk = "Farming", xp = 50, chance=15},
    {itemType = "CabbageBagSeed2", perk = "Farming", xp = 50, chance=15},
    {itemType = "CarrotBagSeed2", perk = "Farming", xp = 50, chance=15},
    {itemType = "CauliflowerBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "CilantroBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "CornBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "CucumberBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "FlaxBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "GarlicBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "GreenpeasBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "HabaneroBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "HopsBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "JalapenoBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "KaleBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "LavenderBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "LeekBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "LemonGrassBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "LettuceBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "MarigoldBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "MintBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "OnionBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "OreganoBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "ParsleyBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "PoppyBagSeed", perk = "Farming", xp = 50, chance=15},
    {itemType = "PotatoBagSeed2", perk = "Farming", xp = 50, chance=15},
    {itemType = "PumpkinBagSeed", perk = "Farming", xp = 50, chance=15},

    -- fishing
    {itemType = "FishingRod", perk = "Fishing", xp = 300, chance=50},
    {itemType = "FishingTackle", perk = "Fishing", xp = 75, chance=25},
    {itemType = "FishingTackle2", perk = "Fishing", xp = 75, chance=25},

    -- foraging
    {itemType = "MushroomGeneric1", perk = "PlantScavenging", xp = 75, chance=25},
    {itemType = "MushroomGeneric2", perk = "PlantScavenging", xp = 75, chance=25},
    {itemType = "MushroomGeneric3", perk = "PlantScavenging", xp = 75, chance=25},
    {itemType = "MushroomGeneric4", perk = "PlantScavenging", xp = 75, chance=25},
    {itemType = "MushroomGeneric5", perk = "PlantScavenging", xp = 75, chance=25},
    {itemType = "MushroomGeneric6", perk = "PlantScavenging", xp = 75, chance=25},
}

local timeMemoryRegain = {
    {hours = 2, minutes = 30, perk="Strength", xp=2500, txt="Physical Recovery"},
    {hours = 4, minutes = 0, perk="Strength", xp=2600, txt="Physical Recovery"},
    {hours = 8, minutes = 0, perk="Strength", xp=2700, txt="Physical Recovery"},
    {hours = 16, minutes = 0, perk="Strength", xp=2800, txt="Physical Recovery"},
    {hours = 24, minutes = 0, perk="Strength", xp=2700, txt="Physical Recovery"},
    {hours = 36, minutes = 0, perk="Nimble", xp=150, txt="Physical Recovery"},
    {hours = 48, minutes = 0, perk="Strength", xp=2600, txt="Physical Recovery"},
    {hours = 72, minutes = 0, perk="Agility", xp=150, txt="Physical Recovery"},
    {hours = 96, minutes = 0, perk="Strength", xp=2500, txt="Physical Recovery"},
    {hours = 120, minutes = 0, perk="Lightfoot", xp=150, txt="Physical Recovery"},
    {hours = 144, minutes = 0, perk="Sneak", xp=150, txt="Physical Recovery"},
    {hours = 192, minutes = 0, perk="Strength", xp=1000, txt="Physical Recovery"},
}

local function predicateAll(item)
    -- item:getType()
	return true
end

local isUsingMask = function(player)
    local stats = player:getStats()
    local endurance = stats:get(CharacterStat.ENDURANCE)

    local suitFull = player:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD)
    if suitFull and suitFull:hasTag(ItemTag.HAZMAT_SUIT) and suitFull:canBeActivated() and suitFull:isActivated() then return true end

    local mask = player:getWornItem(ItemBodyLocation.MASK_EYES)
                 or player:getWornItem(ItemBodyLocation.FULL_HAT)
                 or player:getWornItem(ItemBodyLocation.SCBA)

    if mask then
        if mask:hasTag(ItemTag.GAS_MASK) then
            local filter = mask:getUsedDelta()
            filter = filter - (0.00012 * (2 - endurance))
            mask:setUsedDelta(filter)
            return true 
        elseif mask:hasTag(ItemTag.SCBA) and mask:canBeActivated() and mask:isActivated() then 
            return true 
        end
    end

    return false
end

local getClothingStats = function(player)
    local immuneRadiation = 0
    local dyspnoea = false
    local suffocation = false
    local hasGoodMask = false

    local suitFull = player:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD)
    if suitFull and suitFull:hasTag(ItemTag.HAZMAT_SUIT) then
        local itemVisual = suitFull:getVisual()
        local suitHoles = itemVisual:getHolesNumber()
        immuneRadiation = 100 - (suitHoles * 10)

        if suitFull:canBeActivated() and suitFull:isActivated() then
            local oxygen = suitFull:getUsedDelta()
            if oxygen < 0.05 then
                suffocation = true
            elseif oxygen < 0.1 then
                dyspnoea = true
            else
                hasGoodMask = true
            end

        else
            suffocation = true
        end

    else
        local suit = player:getWornItem(ItemBodyLocation.BOILERSUIT)
        if suit and suit:hasTag(ItemTag.HAZMAT_SUIT) then
            local itemVisual = suit:getVisual()
            local suitHoles = itemVisual:getHolesNumber()
            immuneRadiation = 70 - (suitHoles * 10)
        end

        local mask = player:getWornItem(ItemBodyLocation.MASK_EYES)
                     or player:getWornItem(ItemBodyLocation.FULL_HAT)
                     or player:getWornItem(ItemBodyLocation.SCBA)

        if mask then
            if mask:hasTag(ItemTag.GAS_MASK) then
                local filter = mask:getUsedDelta()
                if filter < 0.05 then
                    suffocation = true
                elseif filter < 0.1 then
                    dyspnoea = true
                else
                    hasGoodMask = true
                end
                if filter > 0 then
                    immuneRadiation = immuneRadiation + 30
                end
            elseif mask:hasTag(ItemTag.SCBA) then
                if mask:canBeActivated() and mask:isActivated() then
                    local oxygen = mask:getUsedDelta()
                    if oxygen < 0.05 then
                        suffocation = true
                    elseif oxygen < 0.1 then
                        dyspnoea = true
                    else
                        hasGoodMask = true
                    end
                    if oxygen > 0 then
                        immuneRadiation = immuneRadiation + 30
                    end
                else
                    suffocation = true
                end
            end
        end
    end

    immuneRadiation = PZMath.clamp(immuneRadiation, 1, 100)

    return immuneRadiation, hasGoodMask, dyspnoea, suffocation
end

local onPlayerUpdate = function(player)
    if BWOAPlayer.tick >= 256 then
        BWOAPlayer.tick = 0
    end

    local px, py, pz = player:getX(), player:getY(), player:getZ()

    -- ugly hack to fix getting stuck on basement stairs
    if pz < 0 and pz > -0.01 then
        local fd = player:getForwardDirection()
        fd:setLength(0.1)
        if player:isStrafing() then
            player:setX(px - fd:getX())
            player:setY(py - fd:getY())
        else
            player:setX(px + fd:getX())
            player:setY(py + fd:getY())
        end
    end

    -- lava
    if BWOAPlayer.tick % 16 == 0 then
        if not player:getVehicle() then
            local square = player:getSquare()
            if square then
                local objects = square:getObjects()
                for i=0, objects:size()-1 do
                    local object = objects:get(i)                
                    local sprite = object:getSprite()
                    if sprite then
                        local props = sprite:getProperties()
                        if props:has("CustomName") then
                            local customName = props:get("CustomName")
                            if customName and customName == "Lava" then
                                player:SetOnFire()
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    -- room discovery
    if BWOAPlayer.tick % 32 == 1 then
        local room = BWOAUtils.GetRoom(px, py, pz)
        if room then
            local revealData = roomRevealMap[room.name]
            if revealData then
                BWOADialogues.Reveal(revealData.person, revealData.qid)
            end
        end
    end

    -- time discovery
    if BWOAPlayer.tick % 32 == 2 then
        local hours = math.floor(getGameTime():getWorldAgeHours()) - 10
        for _, tab in ipairs(timeRevealMap) do
            if hours >= tab.hours then
                BWOADialogues.Reveal(tab.person, tab.qid)
            end
        end
    end

    -- player trait discovery
    if BWOAPlayer.tick % 32 == 3 then
        for _, tab in ipairs(traitRevealMap) do
            if player:hasTrait(tab.trait) then
                BWOADialogues.Reveal(tab.person, tab.qid)
            end
        end
    end

    -- player proximity to location discovery
    if BWOAPlayer.tick % 32 == 4 then
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

    -- player clothing mission completion, TODO: move to onwear action
    if BWOAPlayer.tick % 32 == 5 then 
        local suit = player:getWornItem(ItemBodyLocation.BOILERSUIT)
        if suit then
            BWOAMissions.Accomplish(2)
        end
    end

    -- player at location mission completion and dialogue reveal
    if BWOAPlayer.tick % 32 == 6 then 
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
    end

    -- breath sound update
    if BWOAPlayer.tick % 16 == 7 then 
        local isMask = isUsingMask(player)
        if isMask then
            player:stopPlayerVoiceSound("")
            local stats = player:getStats()
            local endurance = stats:get(CharacterStat.ENDURANCE)
            if endurance > 0.7 then
                if BWOAPlayer.tick == 7 then
                    BWOASound.PlayPlayer({sound = "GasMaskSlow"})
                end
            elseif endurance > 0.4 then

                if BWOAPlayer.tick % 128 == 7 then
                    BWOASound.PlayPlayer({sound = "GasMaskMedium"})
                end
            else
                if BWOAPlayer.tick % 64 == 7 then
                    BWOASound.PlayPlayer({sound = "GasMaskFast"})
                end

            end
        end
    end

    -- dreams
    local emitter = player:getEmitter()
    local dreamShouldStart = false
    local dreamShouldEnd = false
    if player:isAsleep() then
        getCore():setOptionUIRenderFPS(60)
        local nh = math.floor(getGameTime():getTimeOfDay()) + 2
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

        -- autosave: wont work for now - need to have copyWorld function but its not exposed
        --[[

        local world = getWorld()
        local gameSaveWorld = world:getWorld()
        local newGameSaveWorld = gameSaveWorld .. "_autosave"
        world:setWorld(newGameSaveWorld)
        createWorld(newGameSaveWorld)
        ]]

        BWOAMusic.Stop()
        BWOAPlayer.soundStart = "Dream" .. tostring(BWOAPlayer.dreamNo) .. "Start"
        BWOAPlayer.soundEnd = "Dream" .. tostring(BWOAPlayer.dreamNo) .. "End"
        emitter:playSound(BWOAPlayer.soundStart)
        BWOAPlayer.dreamStage = 2

        -- handle emma teleports here
        local npcData, bandit = BWOANPC.Get("Emma")
        if npcData and bandit then
            local brain = BanditBrain.Get(bandit)
            if brain.wantToLeave then
                brain.wantToLeave = false
                BWOANPC.Teleport("Emma", 10116, 11185, -2)
            end
        end
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
                    BWOADialogues.Reveal("Emma_Robinson", dreamData.qid)
                end
                if dreamData.txt then
                    BWOAEventControl.Add("SayPlayer", {txt = dreamData.txt}, 2500)
                end
                if dreamData.nid then
                    BWOANightmares.Activate(dreamData.nid)
                end
                break
            end
        end

        BWOAPlayer.dreamStage = 1
    end

    -- tick update
    BWOAPlayer.tick = BWOAPlayer.tick + 1
end

local manageGeigerEffect = function(player, radiation)

    local hasGeiger = false

    local function isGeiger(item)
        return item and item:getType() == "GeigerCounter"
    end

    local slots = {
        "Walkie Belt Left",
        "Walkie Belt Right",
        "Webbing Left Walkie",
        "Webbing Right Walkie"
    }

    for _, slot in ipairs(slots) do
        if isGeiger(player:getAttachedItem(slot)) then
            hasGeiger = true
            break
        end
    end

    if not hasGeiger and isGeiger(player:getPrimaryHandItem()) then
        hasGeiger = true
    end

    if not hasGeiger and isGeiger(player:getSecondaryHandItem()) then
        hasGeiger = true
    end
    
    if hasGeiger then
        local intensity = BanditUtils.Lerp(radiation, 0, 4000, 0, 6)
        intensity = math.floor(intensity + 0.5)
        if intensity > 6 then intensity = 6 end
        BWOAEventControl.Add("PlayPlayer", {sound = "AmbientGeiger" .. intensity}, 1)
    end
end

local getRadiationForPlayer = function(player)
    local cell = getCell()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local radiation = BWOAClimate.radiation
    local multiplier = 1
    if pz <= -2 then 
        multiplier = 0
    elseif pz > -2 and pz < 0 then
        multiplier = 0.2
    end
    if not player:isOutside() then multiplier = multiplier * 0.8 end
    radiation = radiation * multiplier

    -- radiation from items in inventory
    local items = ArrayList.new()
    local inventory = player:getInventory()
    inventory:getAllEvalRecurse(predicateAll, items)
    for i=0, items:size()-1 do
        local item = items:get(i)
        if item:getModData().radiated then
            radiation = radiation + 30
        end
    end

    -- radiation from items on ground
    local groundItems = {}
    for y = py - 1, py + 1 do
        for x = px - 1, px + 1 do
            local square = cell:getGridSquare(x, y, pz)
            if square then
                local wobs = square:getWorldObjects()
                for i = 0, wobs:size()-1 do
                    local o = wobs:get(i)
                    local groundItem = o:getItem()
                    if groundItem then
                        table.insert(groundItems, groundItem)
                    end
                end

                local objects = square:getStaticMovingObjects()
                for i=0, objects:size()-1 do
                    local object = objects:get(i)
                    if instanceof (object, "IsoDeadBody") then
                        local inventory = object:getContainer()
                        if inventory then
                            local items = ArrayList.new()
                            inventory:getAllEvalRecurse(predicateAll, items)
                            for j=0, items:size()-1 do
                                local item = items:get(j)
                                table.insert(groundItems, item)
                            end
                        end
                    end
                end
            end
        end
    end
    for _, groundItem in ipairs(groundItems) do
        if groundItem:getModData().radiated then
            radiation = radiation + 20
        end
    end
    return radiation
end

local applyRadiationToItems = function(player)
    local cell = getCell()
    local px, py, pz = player:getX(), player:getY(), player:getZ()

    local hasSuit = (player:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD) and player:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD):hasTag(ItemTag.HAZMAT_SUIT))
                    or (player:getWornItem(ItemBodyLocation.BOILERSUIT) and player:getWornItem(ItemBodyLocation.BOILERSUIT):hasTag(ItemTag.HAZMAT_SUIT))
    
    local items = ArrayList.new()
    local inventory = player:getInventory()
    inventory:getAllEvalRecurse(predicateAll, items)
    for i=0, items:size()-1 do
        local item = items:get(i)
        local ftype = item:getFullType()
        if hasSuit then
            if instanceof(item, "Clothing") then
                if item:hasTag(ItemTag.HAZMAT_SUIT) or item:hasTag(ItemTag.GAS_MASK) then
                    item:getModData().radiated = true
                end
                if not item:isWorn() then
                    item:getModData().radiated = true
                end
            else
                item:getModData().radiated = true
            end
        else
            item:getModData().radiated = true
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
                    if groundItem then
                        table.insert(groundItems, groundItem)
                    end
                end

                local objects = square:getStaticMovingObjects()
                for i=0, objects:size()-1 do
                    local object = objects:get(i)
                    if instanceof (object, "IsoDeadBody") then
                        local inventory = object:getContainer()
                        if inventory then
                            inventory:getAllEvalRecurse(predicateAll, items)
                            for j=0, items:size()-1 do
                                local item = items:get(j)
                                table.insert(groundItems, item)
                            end
                        end
                    end
                end
            end
        end
    end
    for _, groundItem in ipairs(groundItems) do
        groundItem:getModData().radiated = true
    end

end

local applyRadiationPlayer = function(player, dose)
    if player:isGodMod() then return end

    local md = player:getModData()

    -- organism fighting back
    dose = dose - 0.5
    if md.bwoa.drug.PotassiumIodine and md.bwoa.drug.PotassiumIodine > 0 then
        dose = dose - 1.5
    end

    -- update player radiation level
    md.bwoa.radiation = md.bwoa.radiation + dose

    -- full recovery
    if md.bwoa.radiation < 0 then
        dose = 0
        md.bwoa.radiation = 0
        md.bwoa.timeRadiated = 0
    end

    if dose >= 0.5 then
        HaloTextHelper.addTextWithArrow(player, "Radiation +" .. string.format("%.1f", dose), true, HaloTextHelper.getColorRed())
    elseif dose <= -0.5 then
        HaloTextHelper.addTextWithArrow(player, "Radiation " .. string.format("%.1f", dose), false, HaloTextHelper.getColorGreen())
    end

    -- update time radiated
    if md.bwoa.radiation >= 100 then
        md.bwoa.timeRadiated = md.bwoa.timeRadiated + 1
    end
end

local updateRadiationEffects = function(player)
    local md = player:getModData()
    local bodyDamage = player:getBodyDamage()
    local stats = player:getStats()

    if md.bwoa.radiation >= 3000 then -- Central nervous system syndrome
        for _, sbp in ipairs(bodyParts) do
            local burnBodyPart = bodyDamage:getBodyPart(sbp.name)
            if ZombRand(16) == 1 and not burnBodyPart:isBurnt() then
                burnBodyPart:setBurned()
                local sound = player:getDescriptor():getVoicePrefix() .. "DeathFall" -- "DeathAlone" or "DeathEaten"
                local emitter = player:getEmitter()
                if not emitter:isPlaying(sound) then
                    emitter:playSound(sound)
                end
            end
        end
    elseif md.bwoa.radiation >= 100 and md.bwoa.radiation < 3000 then  -- Hematopoietic syndrome phase
        -- md.bwoa.timeRadiated = 1500

        if md.bwoa.timeRadiated > 1440 then -- latent subphase
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
                BWOADialogues.Reveal("Emma_Robinson", "1000.3")
            end
        end

        if md.bwoa.timeRadiated > 480 and md.bwoa.timeRadiated < 2100 then -- prodromal subphase
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
                BWOADialogues.Reveal("Emma_Robinson", "1000.3")
            end
        end

    elseif md.bwoa.radiation < 16 then -- all good my boy
        --[[
        md.bwoa.timeRadiated = md.bwoa.timeRadiated - 1
        if md.bwoa.timeRadiated < 0 then md.bwoa.timeRadiated = 0 end

        ]]
    end
    print ("PLAYER RADIATION: RAD: " .. md.bwoa.radiation .. " EXPO: " .. md.bwoa.timeRadiated)
end

local updateSewerEffects = function(player)
    --[[
    if not player:isProtectedFromToxic() then
        local smell = player:getCorpseSicknessRate()
        smell = smell + 50
        player:setCorpseSicknessRate(smell)
    end
    ]]
end

local applyCO2IntoxicationPlayer = function(player, dose)
    local bodyDamage = player:getBodyDamage()
    local stats = player:getStats()
    local md = player:getModData()
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
    local coughChance = 0

    if dose > 60000 then
        healthExpected = 0
        sickExpected = 100
        headAcheExpected = 100
        fatigueExpected = 0.90
        drunkExpected = 100
        enduranceExpected = 0.30
        panicExpected = 70
        coughChance = 100
    elseif dose > 30000 then
        sickExpected = 55
        headAcheExpected = 80
        fatigueExpected = 0.90
        drunkExpected = 80
        enduranceExpected = 0.55
        panicExpected = 50
        coughChance = 50
    elseif dose > 10000 then
        sickExpected = 55
        headAcheExpected = 60
        fatigueExpected = 0.86
        drunkExpected = 20
        enduranceExpected = 0.65
        panicExpected = 20
        coughChance = 20
    elseif dose > 5000 then
        BWOADialogues.Reveal("Emma_Robinson", "1000.4")
        sickExpected = 55
        headAcheExpected = 55
        fatigueExpected = 0.74
        enduranceExpected = 0.70
    elseif dose > 2000 then
        headAcheExpected = 50
        fatigueExpected = 0.62
    elseif dose > 1000 then
        fatigueExpected = 0.40
    end

    if md.bwoa.drug.Aspirin and md.bwoa.drug.Aspirin > 0 and headAcheExpected then
        headAcheExpected = headAcheExpected / 2
    end

    if md.bwoa.drug.NBCTablets and md.bwoa.drug.NBCTablets > 0 then
        sickExpected = 100
        headAcheExpected = 100
        drunkExpected = 100
    end

    if md.bwoa.drug.Pentoxifylline and md.bwoa.drug.Pentoxifylline > 0 and fatigueExpected and enduranceExpected then
        fatigueExpected = fatigueExpected / 3
        enduranceExpected = enduranceExpected / 3
    end

    if healthExpected then
        if health > healthExpected then 
            bodyDamage:setOverallBodyHealth(health - 12)
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
            stats:set(CharacterStat.INTOXICATION, drunk + 5)
        end
    end
    if enduranceExpected then
        if endurance > enduranceExpected then 
            stats:set(CharacterStat.ENDURANCE, endurance - 0.05)
        end
    end
    if panicExpected then
        if panic < panicExpected then 
            stats:set(CharacterStat.PANIC, panicExpected)
        end
    end

    local rnd = ZombRand(100)
    if rnd < coughChance then
        local sound = player:getDescriptor():getVoicePrefix() .. "MuffledCough"
        local emitter = player:getEmitter()
        if not emitter:isPlaying(sound) then
            emitter:stopSoundByName("GasMaskSlow")
            emitter:stopSoundByName("GasMaskMedium")
            emitter:stopSoundByName("GasMaskFast")
            emitter:playSound(sound)
        end
    end
end

local applyDrugEffects = function(player)
    local md = player:getModData()
    if md.bwoa.drug then

        local bodyDamage = player:getBodyDamage()
        local stats = player:getStats()

        if md.bwoa.drug.Aspirin and md.bwoa.drug.Aspirin > 0 then
            local cs = bodyDamage:getColdStrength()
            cs = cs - 0.8
            if cs < 0 then cs = 0 end
            bodyDamage:setColdStrength(cs)
        end

        if md.bwoa.drug.Nikethamide and md.bwoa.drug.Nikethamide > 0 then
            local bodyTemp = stats:get(CharacterStat.TEMPERATURE)
            if bodyTemp < 36.5 then
                bodyTemp = bodyTemp + 0.1
                stats:set(CharacterStat.TEMPERATURE, bodyTemp)
            end
        end

        -- drug in organism depletion
        for drug, dose in pairs(md.bwoa.drug) do
            dose = dose - 1
            if dose < 0 then dose = 0 end
            md.bwoa.drug[drug] = dose
        end

    end
end

local function everyOneMinute()
    local player = getSpecificPlayer(0)
    if not player then return end
    if not player:isAlive() then return end

    local gmd = GetBWOAModData()
    if gmd.nightmares.active then return end

    local cell = getCell()
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local gmd = GetBWOAModData()
    local md = player:getModData()
    if not md.bwoa then md.bwoa = {} end
    if not md.bwoa.drug then md.bwoa.drug = {} end
    if not md.bwoa.radiation then md.bwoa.radiation = 0 end
    if not md.bwoa.timeRadiated then md.bwoa.timeRadiated = 0 end

    -- music conductor
    if player:isOutside() then
        if BWOAPlayer.inside > 480 then
            BWOAMusic.Play("MusicOutside", 0.6, 1)
        end
        BWOAPlayer.outside = BWOAPlayer.outside + 1
        BWOAPlayer.inside = 0
    elseif pz < -4 then
        if BWOAPlayer.outside > 480 then
            BWOAMusic.Play("MusicDepth", 0.6, 1)
        end
        BWOAPlayer.inside = BWOAPlayer.inside + 1
        BWOAPlayer.outside = 0
    else
        BWOAPlayer.inside = BWOAPlayer.inside + 1
    end
    -- print ("INSIDE TIME: " .. tostring(BWOAPlayer.inside) .. " OUTSIDE TIME: " .. tostring(BWOAPlayer.outside))

    -- time memory regain
    if SandboxVars.MemoryRegain then
        local gt = getGameTime()
        local hours = math.floor(gt:getWorldAgeHours()) - 10
        local minutes = gt:getMinutes()

        for _, regainConf in ipairs(timeMemoryRegain) do
            if regainConf.hours == hours and regainConf.minutes == minutes then
                BWOAEventControl.Add("HaloPlayer", {txt = regainConf.txt}, 100)
                BWOAEventControl.Add("HaloPlayer", {perk = regainConf.perk, xp = regainConf.xp}, 300)
            end
        end
    end

    -- radiation simulation
    local radiation = getRadiationForPlayer(player)
    local immuneRadiation, hasGoodMask, dyspnoea, suffocation = getClothingStats(player)

    local dose = 0
    if radiation > 0 then
        manageGeigerEffect(player, radiation)
        applyRadiationToItems(player)
        dose = ((100 - immuneRadiation) / 100) * math.floor(radiation / 50)
    end
    applyRadiationPlayer(player, dose)

    updateRadiationEffects(player)

    updateSewerEffects(player)

    -- co2 intoxication simulation
    if suffocation then
        applyCO2IntoxicationPlayer(player, 60001)
    elseif dyspnoea then
        applyCO2IntoxicationPlayer(player, 10001)
    elseif pz < -2 and px >= 9900 and py >= 12590 and px < 9990 and py < 12660 and not hasGoodMask then
        local ventilation = gmd.ventilation
        applyCO2IntoxicationPlayer(player, ventilation.co2)
    end

    applyDrugEffects(player)

end

local onTimedActionPerform = function(data)

    local character = data.character
    if not character then return end

    local action = data.action:getMetaType()
    if not action then return end

    local md = character:getModData()
    if not md.bwoa then md.bwoa = {} end

    local gmd = GetBWOAModData()

    local cx, cy, cz = character:getX(), character:getY(), character:getZ()

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
                dose = 45
            },
            ["NBCTablets"] = { -- it's not for eating!
                name = "NBCTablets",
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

    elseif action == "ISEatFoodAction" then
        local item = data.item
        if item:getModData().radiated then
            local dose = item:getActualWeight() * 800
            applyRadiationPlayer(character, dose)
        end

    elseif action == "ISSeedActionNew" then
        if data.typeOfSeed == "Comfrey" then
            BWOAMissions.Accomplish(102)
        end

    elseif action == "ISHarvestPlantAction" then
        if data.plant.typeOfSeed == "Comfrey" then
            BWOAMissions.Accomplish(103)
        end

    elseif action == "ISMoveablesAction" then
        local mode = data.mode
        local origSpriteName = data.origSpriteName
        if mode and origSpriteName then
            if origSpriteName == "recreational_01_0" or origSpriteName == "recreational_01_1" then -- jukebox
                if mode == "place" then
                    if character:getX() >= 9940 and character:getX() < 10000 and character:getY() > 12590 and character:getY() < 12660 then
                        BWOAMissions.Accomplish(11)
                    end
                end
            elseif origSpriteName == "recreational_01_12" or origSpriteName == "recreational_01_8" or origSpriteName == "recreational_01_28" or origSpriteName == "recreational_01_30" then -- piano
                if mode == "place" then
                    if character:getX() >= 9940 and character:getX() < 10000 and character:getY() > 12590 and character:getY() < 12660 then
                        BWOAMissions.Accomplish(12)
                    end
                end
            end
        end

    elseif action == "TABAS_TakeShower" then

        local radiationBalance = 0.5 * md.bwoa.radiation
        md.bwoa.radiation = 1 - radiationBalance
        HaloTextHelper.addTextWithArrow(player, "Radiation " .. radiationBalance, false, HaloTextHelper.getColorGreen())
    end
end

local onTransferItem = function(data, item)
    local gmd = GetBWOAModData()
    local destContainerParent = data.destContainer:getParent()
    local containerCharacter = data.destContainer:getCharacter()
    local player = data.character
    local cx, cy, cz = player:getX(), player:getY(), player:getZ()

    -- that means taking things
    if instanceof(destContainerParent, "IsoPlayer") or instanceof(containerCharacter, "IsoPlayer") then 

        -- mission or dialogue triggering
        local md = item:getModData()
        if md.BWOA and md.BWOA.onTaken then
            local onTaken = md.BWOA.onTaken
            if onTaken.accomplishMissionId then
                BWOAMissions.Accomplish(onTaken.accomplishMissionId)
            end
            if onTaken.revealMissionId then
                BWOAMissions.Reveal(onTaken.revealMissionId)
            end
            if onTaken.revealDialogueId and onTaken.revealDialoguePerson then
                BWOADialogues.Reveal(onTaken.revealDialoguePerson, onTaken.revealDialogueId)
            end
            if onTaken.hideDialogueId and onTaken.hideDialoguePerson then
                BWOADialogues.Hide(onTaken.hideDialogueId, onTaken.hideDialoguePerson)
            end
        end

        -- items triggering memory regain
        if SandboxVars.BWOA.MemoryRegain then
            local itemMemoryRegain = gmd.itemMemoryRegain
            local itemType = item:getType()
            for _, regainConf in ipairs(itemMemoryRegain) do
                if not regainConf.used and regainConf.itemType == itemType then
                    local rnd = ZombRand(100)
                    if rnd < regainConf.chance then
                        BWOAEventControl.Add("HaloPlayer", {txt = "Memory Regain"}, 100)
                        BWOAEventControl.Add("HaloPlayer", {perk = regainConf.perk, xp = regainConf.xp}, 300)
                    end
                    regainConf.used = true
                end
            end
        end

    -- this means dropping things or putting in container
    else 
        -- mission or dialogue triggering
        local md = item:getModData()
        if md.BWOA and md.BWOA.onDropArea then
            local dropArea = md.BWOA.onDropArea
            if cx >= dropArea.x1 and cx <= dropArea.x2 and cy >= dropArea.y1 and cy <= dropArea.y2 and cz == dropArea.z then
                if dropArea.accomplishMissionId then
                    BWOAMissions.Accomplish(dropArea.accomplishMissionId)
                end
                if dropArea.revealMissionId then
                    BWOAMissions.Reveal(dropArea.revealMissionId)
                end
                if dropArea.revealDialogueId and dropArea.revealDialoguePerson then
                    BWOADialogues.Reveal(dropArea.revealDialoguePerson, dropArea.revealDialogueId)
                end
                if dropArea.hideDialogueId and dropArea.hideDialoguePerson then
                    BWOADialogues.Hide(dropArea.hideDialogueId, dropArea.hideDialoguePerson)
                end
            end
        end
    end
end

local function onDeath(player)
    local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma"})
    BWOAChat.ChangeBrainParam({param="sadness", value=100, target = target})
end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)

Events.EveryOneMinute.Remove(everyOneMinute)
Events.EveryOneMinute.Add(everyOneMinute)

Events.OnTimedActionPerform.Remove(onTimedActionPerform)
Events.OnTimedActionPerform.Add(onTimedActionPerform)

Events.OnTransferItem.Remove(onTransferItem)
Events.OnTransferItem.Add(onTransferItem)

Events.OnPlayerDeath.Remove(BanditPlayer.onDeath)
Events.OnPlayerDeath.Add(BanditPlayer.onDeath)