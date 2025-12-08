BWOAMissions = BWOAMissions or {}

BWOAMissions.new = true

BWOAMissions.missions = {
    [1] = {
        name = "Meet Emma",
        desc = "Find and talk to Emma.\nPress \"T\" to open chat panel.",
        revealed = true
    },
    [2] = {
        name = "Change",
        desc = "Find and wear a bunker suit.",
    },
    [3] = {
        name = "Fix air vent",
        desc = "Find an air vent located on the surface\nand fix it using a wrench.",
    },
    [4] = {
        name = "Find a hidden basement",
        desc = "Go outside and find at least one basement with a hidden entrance in the floor.",
    },
    [5] = {
        name = "Obtain zombie specimen",
        desc = "Bring a zombie corpse to the laboratory.",
    },
    [6] = {
        name = "Bring fuel truck to the Ark",
        desc = "Fuel truck is located on Dixie Highway leading to Muldraugh Ruins.\nBring the truck home and pump the fuel to the underground tank.",
    },
    [7] = {
        name = "Find the missing tool bag",
        desc = "The bag is located in the remainings of the Community Center in March Ridge Ruins.",
    },
    [8] = {
        name = "Find missing survivors",
        desc = "Locate Dave's group. Their last know location is south east of Rosewood Ruins.\nThey planned to stop at one of the houses on their way back to the Ark.",
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
        if mission.revealed then
            missionsRevealed[i] = mission
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
    end
    -- todo: launch completion mission popup
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