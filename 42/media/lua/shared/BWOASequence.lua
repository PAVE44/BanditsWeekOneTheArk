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
        cid = Bandit.clanMap.Emma,
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

BWOASequence.Horde = function(params)
    local player = getSpecificPlayer(0)
    local params = {
        size = params.intensity,
        x = 9956,
        y = 12616,
        z = 0,
        outfit = "Generic01",
        femaleChance = 45
    }
    BWOAEventControl.Add("HordeAt", params, 100)
end

BWOASequence.Assault = function(params)
    local player = getSpecificPlayer(0)
    local group = {
        cid = Bandit.clanMap.Surface1,
        x = 9956,
        y = 12616,
        z = 0,
        program = "Bandit",
        size = 6,
    }
    BWOAEventControl.Add("SpawnGroup", group, 100)
end

BWOASequence.Decontamination = function(params)
    local player = getSpecificPlayer(0)
    local px, py, pz = player:getX(), player:getY(), player:getZ()

    BWOASound.AddNoah({sound = BWOASound.noahSounds.DECONTAMINATION})

    local mx = math.ceil((params.x1 + params.x2) / 2)
    local my = math.ceil((params.y1 + params.y2) / 2)
    local mz = params.z
    if pz == mz and math.abs(mx - px) < 20 and math.abs(my - py) < 20 then

        local sx, sy, sz = 9947, 12624, -4
        local soundParams = {x = mx, y = my, z = mz, sound="AmbientMist"}
        BWOAEventControl.Add("PlayLocation", soundParams, 1600)

        local offset = -3 * mz
        for i = 1, 20 do
            local effect = {}
            effect.x = params.x1 + ZombRand(params.x2 - params.x1) + offset
            effect.y = params.y1 + ZombRand(params.y2 - params.y1) + offset
            effect.z = 0
            effect.size = 400
            effect.name = "mist"
            effect.frameCnt = 60
            effect.frameRnd = true
            effect.repCnt = 17 + ZombRand(3)
            effect.colors = {r=0.9, g=0.9, b=1.0, a=0.2}
            BWOAEventControl.Add("Effect", effect, 1600 + (i * 10) + ZombRand(10))
        end
    end

    BWOAEventControl.Add("Decontaminate", params, 2600)
end