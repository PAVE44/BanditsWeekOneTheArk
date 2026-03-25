BWOANightmares = BWOANightmares or {}

BWOANightmares.Activate = function(variant)
    local gmd = GetBWOAModData()
    gmd.nightmares.variant = variant
    gmd.nightmares.active = true
end

local function onPlayerUpdate(player)
    if not player then return end

    local gmd = GetBWOAModData()
    if not gmd.nightmares.active then return end

    local variant = gmd.nightmares.variant
    if not BWOANightmares[variant] then
        print ("No such nightmare!")
        gmd.nightmares.active = false
        return
    end

    local stats = player:getStats()
    local fatigue = stats:get(CharacterStat.FATIGUE) - 0.1
    if fatigue < 0 then fatigue = 0 end
    stats:set(CharacterStat.FATIGUE, fatigue - 0.1)
    
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

    end

    if state == "post" then
        gmd.nightmares.state = "enter"
        BWOANightmares[variant].onPost(player)
        gmd.nightmares.active = false
    end
end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)