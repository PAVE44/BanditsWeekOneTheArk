BWOANightmares = BWOANightmares or {}

BWOANightmares.active = false
BWOANightmares.variant = "Fall"
BWOANightmares.state = "enter"

BWOANightmares.Activate = function(variant)
    BWOANightmares.variant = variant
    BWOANightmares.active = true
end

local function onPlayerUpdate(player)
    if not player then return end
    if not BWOANightmares.active then return end

    local variant = BWOANightmares.variant
    if not BWOANightmares[variant] then
        print ("No such nightmare!")
        BWOANightmares.active = false
        return
    end
    
    local state = BWOANightmares.state
    if state == "enter" then
        BWOANightmares.state = "cycle"
        BWOANightmares[variant].onEnter(player)
    end

    if state == "cycle" then
        BWOANightmares[variant].onCycle(player)
        if BWOANightmares[variant].ShouldExit(player) then
            BWOANightmares.state = "exit"
        end
    end

    if state == "exit" then
        BWOANightmares.state = "post"
        BWOANightmares[variant].onExit(player)
    end

    if state == "post" then
        BWOANightmares.state = "enter"
        BWOANightmares[variant].onPost(player)
        BWOANightmares.active = false
    end
end

Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)