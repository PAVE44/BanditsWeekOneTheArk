BWOASequence = BWOASequence or {}

-- when player starts the game
BWOASequence.Start = function(params)
    -- fade out
    BWOAEventControl.Add("FadeOut", {time=0}, 0)

    -- player start coords
    local px = 9966
    local py = 12622
    local pz = 0
    BWOAEventControl.Add("Teleport", {x = px, y = py, z = pz}, 100)

    -- fade in
    BWOAEventControl.Add("FadeIn", {time=4}, 3000)
end

BWOASequence.EmergencyLights = function(params)
    local d = 100 + ZombRand(100)
    if params.active then
        for roomName, _ in pairs(BWOARooms) do
            if BWOARooms[roomName].els then
                BWOAEventControl.Add("EmergencyLights", {roomName=roomName, active=params.active}, d)
                d = d + 100 + ZombRand(100)
            end
        end
    end
end



