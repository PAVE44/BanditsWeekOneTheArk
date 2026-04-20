BWOAMissions = BWOAMissions or {}

BWOAMissions.new = true

BWOAMissions.missions = {
    [1] = {
        name = getText("IGUI_Missions_1_Name"),
        desc = getText("IGUI_Missions_1_Description"),
        revealed = true
    },
    [2] = {
        name = getText("IGUI_Missions_2_Name"),
        desc = getText("IGUI_Missions_2_Description"),
    },
    [3] = {
        name = getText("IGUI_Missions_3_Name"),
        desc = getText("IGUI_Missions_3_Description"),
    },
    [4] = {
        name = getText("IGUI_Missions_4_Name"),
        desc = getText("IGUI_Missions_4_Description"),
    },
    [5] = {
        name = getText("IGUI_Missions_5_Name"),
        desc = getText("IGUI_Missions_5_Description"),
    },
    [6] = {
        name = getText("IGUI_Missions_6_Name"),
        desc = getText("IGUI_Missions_6_Description"),
    },
    [7] = {
        name = getText("IGUI_Missions_7_Name"),
        desc = getText("IGUI_Missions_7_Description"),
    },
    [8] = {
        name = getText("IGUI_Missions_8_Name"),
        desc = getText("IGUI_Missions_8_Description"),
    },
    [9] = {
        name = getText("IGUI_Missions_9_Name"),
        desc = getText("IGUI_Missions_9_Description"),
    },
    [10] = {
        name = getText("IGUI_Missions_10_Name"),
        desc = getText("IGUI_Missions_10_Description"),
    },
    [11] = {
        name = getText("IGUI_Missions_11_Name"),
        desc = getText("IGUI_Missions_11_Description"),
    },
    [12] = {
        name = getText("IGUI_Missions_12_Name"),
        desc = getText("IGUI_Missions_12_Description"),
    },
    [13] = {
        name = getText("IGUI_Missions_13_Name"),
        desc = getText("IGUI_Missions_13_Description"),
    },
    [14] = {
        name = getText("IGUI_Missions_14_Name"),
        desc = getText("IGUI_Missions_14_Description"),
    },
    [50] = {
        name = getText("IGUI_Missions_50_Name"),
        desc = getText("IGUI_Missions_50_Description"),
    },
    [51] = {
        name = getText("IGUI_Missions_51_Name"),
        desc = getText("IGUI_Missions_51_Description"),
    },
    [100] = {
        name = getText("IGUI_Missions_100_Name"),
        desc = getText("IGUI_Missions_100_Description"),
        chapter = "chapter_2",
    },
    [101] = {
        name = getText("IGUI_Missions_101_Name"),
        desc = getText("IGUI_Missions_101_Description"),
    },
    [102] = {
        name = getText("IGUI_Missions_102_Name"),
        desc = getText("IGUI_Missions_102_Description"),
    },
    [103] = {
        name = getText("IGUI_Missions_103_Name"),
        desc = getText("IGUI_Missions_103_Description"),
    },
    [110] = {
        name = getText("IGUI_Missions_110_Name"),
        desc = getText("IGUI_Missions_110_Description"),
        chapter = "chapter_3",
    },
    [111] = {
        name = getText("IGUI_Missions_111_Name"),
        desc = getText("IGUI_Missions_111_Description"),
    },
    [112] = {
        name = getText("IGUI_Missions_112_Name"),
        desc = getText("IGUI_Missions_112_Description"),
    },
    [113] = {
        name = getText("IGUI_Missions_113_Name"),
        desc = getText("IGUI_Missions_113_Description"),
    },
    [114] = {
        name = getText("IGUI_Missions_114_Name"),
        desc = getText("IGUI_Missions_114_Description"),
        chapter = "chapter_5",
    },
    [115] = {
        name = getText("IGUI_Missions_115_Name"),
        desc = getText("IGUI_Missions_115_Description"),
    },
    [120] = {
        name = getText("IGUI_Missions_120_Name"),
        desc = getText("IGUI_Missions_120_Description"),
        chapter = "chapter_4",
    },
}

BWOAMissions.LoadMissions = function()
    local gmd = GetBWOAModData()
    gmd.missions = BWOAMissions.missions
end

BWOAMissions.GetRevealed = function()
    local gmd = GetBWOAModData()
    local missions = gmd.missions
    local missionsRevealed = {}

    for i, mission in pairs(missions) do
        if mission.revealed and not mission.accomplished then
            table.insert(missionsRevealed, mission)
        end
    end

    for i, mission in pairs(missions) do
        if mission.revealed and mission.accomplished then
            table.insert(missionsRevealed, mission)
        end
    end

    return missionsRevealed
end

BWOAMissions.Reveal = function(missionId)
    local gmd = GetBWOAModData()
    local mission = gmd.missions[missionId]
    if mission and not mission.revealed and not mission.accomplished then
        mission.revealed = true
        BWOAMissions.new = true
        BWOASound.PlayPlayer({sound="AmbientHorn"})
    end
    -- todo: launch reveal mission popup
end

BWOAMissions.IsRevealed = function(missionId)
    local gmd = GetBWOAModData()
    local mission = gmd.missions[missionId]
    if mission and mission.revealed then
        return true
    end
    return false
end

BWOAMissions.Hide = function(missionId)
    local gmd = GetBWOAModData()
    local mission = gmd.missions[missionId]
    if mission then
        mission.revealed = nil
    end
end

BWOAMissions.Accomplish = function(missionId)
    local gmd = GetBWOAModData()
    local mission = gmd.missions[missionId]
    if mission and not mission.accomplished then
        mission.accomplished = true
        BWOAMissions.new = true
        if BWOAMissions.onAccomplish[missionId] then
            BWOAMissions.onAccomplish[missionId]()
        end

        if mission.chapter then
            BWOASequence.Chapter({tex = mission.chapter})
        end
    end
end

BWOAMissions.IsAccomplished = function(missionId)
    local gmd = GetBWOAModData()
    local mission = gmd.missions[missionId]
    if mission and mission.accomplished then
        return true
    end
    return false
end

BWOAMissions.IsActive = function(missionId)
    local gmd = GetBWOAModData()
    local mission = gmd.missions[missionId]
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