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
    end
    -- todo: launch reveal mission popup
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

BWOAMissions.onAccomplish = {}

BWOAMissions.onAccomplish[1] = function()
end

BWOAMissions.onAccomplish[2] = function()
end