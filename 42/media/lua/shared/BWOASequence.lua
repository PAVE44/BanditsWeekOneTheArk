require "BWOABandit"

BWOASequence = BWOASequence or {}

-- when player starts the game
BWOASequence.Start = function(params)

    -- fade out

    local volume = getSoundManager():getSoundVolume()

    BWOAEventControl.Add("FadeOut", {time=0}, 0)

    -- player start coords
    local px = Bandit.playerStart.x
    local py = Bandit.playerStart.y
    local pz = Bandit.playerStart.y

    -- BWOAEventControl.Add("Teleport", {x = px, y = py, z = pz}, 0)

    BWOAEventControl.Add("WorldSetup", {}, 1)
    BWOAEventControl.Add("PlayerSetup", {x = px, y = py, z = pz}, 2)

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

    BWOAEventControl.Add("ElecShut", {}, 900)

    BWOAEventControl.Add("ClearBaseFromZombies", {}, 1000)
    BWOAEventControl.Add("ClearBaseFromZombies", {}, 2000)

    local emma = {
        cid = "0b0c0c24-a9f7-4b04-a3e2-72f33b3d82ce",
        x = Bandit.emmaStart.x,
        y = Bandit.emmaStart.y,
        z = Bandit.emmaStart.z,
        program = "Emma",
        size = 1,
        voice = 1,
    }

    BWOAEventControl.Add("SpawnGroup", emma, 2100)
    
    -- fade in
    BWOAEventControl.Add("FadeIn", {time = 6, volume = volume}, 2700)
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

BWOASequence.Earthquake = function(params)
    local player = getSpecificPlayer(0)

    local d = 1
    BWOAEventControl.Add("PlayPlayer", {sound = "AmbientRumble"}, d)

    d = 800
    local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma"})
    if target.dist < BWOAChat.talkDist then
        local anim = BanditUtils.Choice({"Spooked1", "Spooked2"})
        local tab = {id=target.id, txt="Earthquake!", anim=anim}
        BWOAEventControl.Add("SayBandit", tab, d)
    end

    d = 2000
    BWOAEventControl.Add("AlarmOn", {}, d)

    BWOASound.ClearNoah()
    BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
    BWOASound.AddNoah({sound = BWOASound.noahSounds.STRUCTURAL})
    
    d = 1000
    for j = 1, params.duration do
        local x = params.x1 + ZombRand(params.x2 - params.x1)
        local y = params.y1 + ZombRand(params.y2 - params.y1)
        local z = params.z

        for i = 1, params.intensity do
            d = d + 20 + ZombRand(35)
            local params = {
                x = x,
                y = y,
                z = z,
            }
            BWOAEventControl.Add("WallCrack", params, d)
        end
    end
end

