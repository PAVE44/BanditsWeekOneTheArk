BWOASequence = BWOASequence or {}

-- when player starts the game
BWOASequence.Start = function(params)
    -- fade out
    BWOAEventControl.Add("FadeOut", {time=0}, 0)

    -- player start coords
    local px = 9966
    local py = 12622
    local pz = -4
    BWOAEventControl.Add("Teleport", {x = px, y = py, z = pz}, 0)

    BWOAEventControl.Add("PlayerSetup", {x = px, y = py, z = pz}, 0)

    -- build
    for roomName, _ in pairs(BWOARooms) do
        if BWOARooms[roomName].Build then
            BWOAEventControl.Add("BuildRoom", {roomName=roomName}, 500)
        end
        if BWOARooms[roomName].Prepare then
            BWOAEventControl.Add("PrepareRoom", {roomName=roomName}, 600)
        end
        if BWOARooms[roomName].SetEmitters then
            BWOAEventControl.Add("SetRoomEmitters", {roomName=roomName}, 700)
        end
        if BWOARooms[roomName].SetFlickers then
            BWOAEventControl.Add("SetRoomFlickers", {roomName=roomName}, 800)
        end
        if BWOARooms[roomName].SetAnims then
            BWOAEventControl.Add("SetRoomAnims", {roomName=roomName}, 900)
        end
    end

    BWOAEventControl.Add("ClearBaseFromZombies", {}, 1000)
    BWOAEventControl.Add("ClearBaseFromZombies", {}, 2000)

    BWOAEventControl.Add("ElecShut", {}, 1100)
    
    -- fade in
    BWOAEventControl.Add("FadeIn", {time=4}, 3000)
end

-- when players loads a previous game
BWOASequence.Resume = function(params)
    for roomName, _ in pairs(BWOARooms) do
        if BWOARooms[roomName].SetEmitters then
            BWOAEventControl.Add("SetRoomEmitters", {roomName=roomName}, 0)
        end
        if BWOARooms[roomName].SetFlickers then
            BWOAEventControl.Add("SetRoomFlickers", {roomName=roomName}, 100)
        end
        if BWOARooms[roomName].SetAnims then
            BWOAEventControl.Add("SetRoomAnims", {roomName=roomName}, 200)
        end
    end
end

BWOASequence.EmergencyLights = function(params)
    local d = 1
    if params.active ~= nil then
        for roomName, _ in pairs(BWOARooms) do
            if BWOARooms[roomName].els then
                BWOAEventControl.Add("EmergencyLights", {roomName=roomName, active=params.active}, d)
                d = d + 75 + ZombRand(225)
            end
        end
    end
end



