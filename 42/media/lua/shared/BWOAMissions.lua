BWOAMissions = BWOAMissions or {}

BWOAMissions.missions = {
    [1] = {
        name = "Get dressed",
        desc = "Find and wear a bunker suit.",
    }
}

BWOAMissions.Reveal = function(missionId)
    BWOAMissions.missions[missionId].revealed = true
    -- todo: launch reveal mission popup
end

BWOAMissions.Hide = function(missionId)
    BWOAMissions.missions[missionId].revealed = nil
end

BWOAMissions.Accomplish = function(missionId)
    BWOAMissions.missions[missionId].accomplished = true
    if BWOAMissions.onAccomplish[missionId] then
        BWOAMissions.onAccomplish[missionId]()
    end
    -- todo: launch completion mission popup
end

BWOAMissions.onAccomplish = {}

BWOAMissions.onAccomplish[1] = function()

end