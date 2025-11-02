BWOAMissions = BWOAMissions or {}

BWOAMissions.new = true

BWOAMissions.missions = {
    [1] = {
        name = "Meet Emma",
        desc = "Find and talk to Emma.",
        revealed = true
    },
    [2] = {
        name = "Change",
        desc = "Find and wear a bunker suit.",
    },
    [3] = {
        name = "Fix air vent",
        desc = "Find an air vent located on the surface\nand fix it using a wrench.",
    }
}

BWOAMissions.GetRevealed = function()
    local missions = BWOAMissions.missions
    local missionsRevealed = {}

    for i, mission in pairs(missions) do
        if mission.revealed then
            missionsRevealed[i] = mission
        end
    end

    return missionsRevealed
end

BWOAMissions.Reveal = function(missionId)
    local mission = BWOAMissions.missions[missionId]
    if mission and not mission.accomplished then
        mission.revealed = true
        BWOAMissions.new = true
        BWOASound.PlayPlayer({sound="AmbientHorn"})
    end
    -- todo: launch reveal mission popup
end

BWOAMissions.IsRevealed = function(missionId)
    local mission = BWOAMissions.missions[missionId]
    if mission and mission.revealed then
        return true
    end
    return false
end

BWOAMissions.Hide = function(missionId)
    local mission = BWOAMissions.missions[missionId]
    if mission then
        mission.revealed = nil
    end
end

BWOAMissions.Accomplish = function(missionId)
    BWOAMissions.missions[missionId].accomplished = true
    BWOAMissions.new = true
    if BWOAMissions.onAccomplish[missionId] then
        BWOAMissions.onAccomplish[missionId]()
    end
    -- todo: launch completion mission popup
end

BWOAMissions.IsAccomplished = function(missionId)
    local mission = BWOAMissions.missions[missionId]
    if mission and mission.accomplished then
        return true
    end
    return false
end

BWOAMissions.IsActive = function(missionId)
    local mission = BWOAMissions.missions[missionId]
    if mission and mission.revealed and not mission.accomplished then
        return true
    end
    return false
end

BWOAMissions.onAccomplish = {}

BWOAMissions.onAccomplish[1] = function()
end

BWOAMissions.onAccomplish[2] = function()
end