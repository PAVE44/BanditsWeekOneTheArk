BWOANightmares = BWOANightmares or {}

BWOANightmares.Activate = function(variant)
    player = getSpecificPlayer(0)
    if not player then return end

    local gmd = GetBWOAModData()
    gmd.nightmares.variant = variant
    gmd.nightmares.active = true

    local stats = player:getStats()
    gmd.nightmares.stats = {}
    gmd.nightmares.stats.boredom = stats:get(CharacterStat.BOREDOM)
    gmd.nightmares.stats.fitness = stats:get(CharacterStat.FITNESS)
    gmd.nightmares.stats.foodSickness = stats:get(CharacterStat.FOOD_SICKNESS)
    gmd.nightmares.stats.hunger = stats:get(CharacterStat.HUNGER)
    gmd.nightmares.stats.idleness = stats:get(CharacterStat.IDLENESS)
    gmd.nightmares.stats.morale = stats:get(CharacterStat.MORALE)
    gmd.nightmares.stats.nicotineWithdrawal = stats:get(CharacterStat.NICOTINE_WITHDRAWAL)
    gmd.nightmares.stats.poison = stats:get(CharacterStat.POISON)
    gmd.nightmares.stats.sanity = stats:get(CharacterStat.SANITY)
    gmd.nightmares.stats.sickness = stats:get(CharacterStat.SICKNESS)
    gmd.nightmares.stats.stress = stats:get(CharacterStat.STRESS)
    gmd.nightmares.stats.thirst = stats:get(CharacterStat.THIRST)
    gmd.nightmares.stats.unhappiness = stats:get(CharacterStat.UNHAPPINESS)
    gmd.nightmares.stats.zombieFever = stats:get(CharacterStat.ZOMBIE_FEVER)
    gmd.nightmares.stats.zombieInfection = stats:get(CharacterStat.ZOMBIE_INFECTION)
    
end

local function onPlayerUpdate(player)
    if not player then return end

    local gmd = GetBWOAModData()
    if not gmd.nightmares.active then return end

    local variant = gmd.nightmares.variant
    if not BWOANightmares[variant] then
        -- print ("No such nightmare!")
        gmd.nightmares.active = false
        return
    end

    local stats = player:getStats()

    -- stats that are affected by sleep
    local fatigue = stats:get(CharacterStat.FATIGUE) - 0.1
    if fatigue < 0 then fatigue = 0 end
    stats:set(CharacterStat.FATIGUE, fatigue - 0.1)

    -- stats that are set to specific values
    stats:set(CharacterStat.ENDURANCE, 1)
    stats:set(CharacterStat.INTOXICATION, 25)

    -- stats that are frozen
    local frozenStats = gmd.nightmares.stats
    stats:set(CharacterStat.BOREDOM, frozenStats.boredom)
    stats:set(CharacterStat.FITNESS, frozenStats.fitness)
    stats:set(CharacterStat.FOOD_SICKNESS, frozenStats.foodSickness)
    stats:set(CharacterStat.HUNGER, frozenStats.hunger)
    stats:set(CharacterStat.IDLENESS, frozenStats.idleness)
    stats:set(CharacterStat.MORALE, frozenStats.morale)
    stats:set(CharacterStat.NICOTINE_WITHDRAWAL, frozenStats.nicotineWithdrawal)
    stats:set(CharacterStat.POISON, frozenStats.poison)
    stats:set(CharacterStat.SANITY, frozenStats.sanity)
    stats:set(CharacterStat.SICKNESS, frozenStats.sickness)
    stats:set(CharacterStat.STRESS, frozenStats.stress)
    stats:set(CharacterStat.THIRST, frozenStats.thirst)
    stats:set(CharacterStat.UNHAPPINESS, frozenStats.unhappiness)
    stats:set(CharacterStat.ZOMBIE_FEVER, frozenStats.zombieFever)
    stats:set(CharacterStat.ZOMBIE_INFECTION, frozenStats.zombieInfection)
    
    local state = gmd.nightmares.state
    if state == "enter" then
        gmd.nightmares.state = "cycle"
        BWOANightmares[variant].onEnter(player)
    end

    if state == "cycle" then
        BWOANightmares[variant].onCycle(player)
        if BWOANightmares[variant].ShouldExit(player) then
            gmd.nightmares.state = "exit"
        end
    end

    if state == "exit" then
        gmd.nightmares.state = "post"
        BWOANightmares[variant].onExit(player)
        BWOAMusic.Stop()
    end

    if state == "post" then
        gmd.nightmares.state = "enter"
        BWOANightmares[variant].onPost(player)
        gmd.nightmares.active = false
    end
end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)