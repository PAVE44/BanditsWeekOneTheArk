require "BWOABandit"

BWOASequence = BWOASequence or {}

-- when player starts the game
BWOASequence.Start = function(params)

    -- fade out

    local volume = getSoundManager():getSoundVolume()

    BWOAEventControl.Add("FadeOut", {time=0, mute=true}, 0)

    -- player start coords
    local px = Bandit.playerStart.x
    local py = Bandit.playerStart.y
    local pz = Bandit.playerStart.z

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
        voice = Bandit.emmaStart.voiceId,
        fullname = Bandit.emmaStart.fullname,
    }

    BWOAEventControl.Add("SpawnGroup", emma, 2100)
    
    -- fade in
    BWOAEventControl.Add("FadeIn", {time = 6, volume = volume, unmute=true}, 2700)
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

BWOASequence.Chapter = function(params)
    BWOAEventControl.Add("Chapter", {tex = params.tex}, 100)
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

BWOASequence.DarkClouds = function(params)
    local player = getSpecificPlayer(0)
    if player:getZ() < 0 then return end

    BWOASound.PlayPlayer({sound = "AmbientDarkClouds"})

    BWOATex.tex = getTexture("media/textures/dark_clouds.png")
    BWOATex.speed = 0.005
    BWOATex.x = -5000
    BWOATex.y = -5000
    BWOATex.tw = 10000
    BWOATex.th = 10000
    BWOATex.oscilate = true
    BWOATex.mode = "slide"
    BWOATex.alpha = 0.02
    BWOATex.alphaMax = 3
end

BWOASequence.Earthquake = function(params)
    local player = getSpecificPlayer(0)

    local d = 1
    BWOAMusic.Play("MusicEarthquake", 0.8, 1)
    
    d = 750
    BWOAEventControl.Add("Shaker", {status = true}, d)

    d = 1100
    local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma"})
    if target.dist < BWOAChat.talkDist * 2 then
        local anim = BanditUtils.Choice({"Spooked1", "Spooked2"})
        local tab = {id=target.id, txt="Earthquake!", sound="BWOAEarthquake_Female_21_1", anim=anim}
        BWOAEventControl.Add("SayBandit", tab, d)
    end

    d = 2000
    BWOAEventControl.Add("AlarmOn", {}, d)

    BWOASound.ClearNoah()
    BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
    BWOASound.AddNoah({sound = BWOASound.noahSounds.STRUCTURAL})
    
    d = 1200
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

    d = d + 200
    BWOAEventControl.Add("Shaker", {status = false}, d)

    
    if params.fire then

        local d = 0
        local coords = {
            {x = 9944, y = 12634, z = -4},
            {x = 9945, y = 12634, z = -4},
            {x = 9944, y = 12635, z = -4},
            {x = 9945, y = 12635, z = -4},
            {x = 9945, y = 12633, z = -4},
            {x = 9945, y = 12632, z = -4},
            {x = 9946, y = 12634, z = -4},
            {x = 9947, y = 12634, z = -4},
            {x = 9947, y = 12633, z = -4},
            {x = 9948, y = 12634, z = -4},
            {x = 9948, y = 12634, z = -4},
            {x = 9949, y = 12634, z = -4},
            {x = 9950, y = 12634, z = -4},
            {x = 9951, y = 12634, z = -4},
            {x = 9952, y = 12634, z = -4},
            {x = 9953, y = 12634, z = -4},
            {x = 9953, y = 12633, z = -4},
            {x = 9953, y = 12632, z = -4},
            {x = 9953, y = 12635, z = -4},
            {x = 9953, y = 12631, z = -4},
            {x = 9954, y = 12632, z = -4},
            {x = 9953, y = 12630, z = -4},
            {x = 9953, y = 12630, z = -4},
        }

        local first = true
        for _, c in ipairs(coords) do
            local params = {
                x = c.x + ZombRand(2),
                y = c.y + ZombRand(2),
                z = c.z,
            }
            BWOAEventControl.Add("Fire", params, d)
            d = d + 30 + ZombRand(110)

            if first then
                BWOASound.PlayLocation({
                    sound = "ExplosionFar1",
                    x = c.x,
                    y = c.y,
                    z = c.z
                })
                first = false
            end
        end
    end
end

BWOASequence.Horde = function(params)
    local player = getSpecificPlayer(0)

    local coords = {x = 9937, y = 12625, z = 0}

    if player:getZ() < -1 then
        local params = {
            size = params.intensity,
            x = coords.x,
            y = coords.y,
            z = coords.z,
            outfit = "Generic01",
            femaleChance = 45
        }
        BWOAEventControl.Add("HordeAt", params, 100)
    end
end

BWOASequence.Assault = function(params)
    local player = getSpecificPlayer(0)
    local cell = getCell()

    local coords = {x = 9931, y = 12625, z = 0, size = 1.5}
    local doors = {}

    if player:getZ() == -4 and (player:getX() >= 9965 or player:getY() >= 12636) then
        coords = {x=9930, y=12625, z=-4, size=1}

        doors = {
            {x = 9926, y = 12626, z = 0},
            {x = 9924, y = 12626, z = -4},
        }
    end

    local hostileGroupSize = SandboxVars.BWOA.HostileGroupSize or 3
    local hostileGroupMultipliers = {
        [1] = 0.20,
        [2] = 0.50,
        [3] = 1,
        [4] = 1.5,
        [5] = 2,
        [6] = 4
    }
    local hostileGroupMultiplier = math.ceil(hostileGroupMultipliers[hostileGroupSize])

    local group = {
        cid = params.cid,
        x = coords.x,
        y = coords.y,
        z = coords.z,
        program = "Assault",
        size = params.intensity * coords.size * hostileGroupMultiplier,
    }

    for _, doorConf in ipairs(doors) do
        local square = cell:getGridSquare(doorConf.x, doorConf.y, doorConf.z)
        if square then
            local objects = square:getObjects()
            if objects:size() > 1 then
                local object = objects:get(1)
                if instanceof(object, "IsoDoor") and not object:IsOpen() then
                    IsoDoor.toggleGarageDoor(object, true)
                end
            end
        end
    end
    BWOAEventControl.Add("SpawnGroup", group, 2000)

    if params.vtype then

        local x
        for i = 0, 10 do
            local testx = 9975 - (i * 6)
            local square = cell:getGridSquare(testx, 12693, 0)
            if square then
                local vehicle = square:getVehicleContainer()
                if not vehicle then
                    x = testx
                    break
                end
            end
        end

        if x then
            local carParams = {
                vtype = params.vtype,
                x = x,
                y = 12693,
                z = 0
            }
            BWOAEventControl.Add("SpawnVehicle", carParams, 2100)
        end
    end

    
end

BWOASequence.Decontamination = function(params)
    local player = getSpecificPlayer(0)
    local px, py, pz = player:getX(), player:getY(), player:getZ()

    local mx = math.ceil((params.x1 + params.x2) / 2)
    local my = math.ceil((params.y1 + params.y2) / 2)
    local mz = params.z
    if pz == mz and math.abs(mx - px) < 20 and math.abs(my - py) < 20 then

        BWOAEventControl.Add("DecontaminatePre", params, 10)

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

        BWOAEventControl.Add("DecontaminatePost", params, 6000)
    end
end

BWOASequence.Spooky = function(params)
    local time = 0
    for i = 1, params.cnt do
        local params = {
            tex = "spooky_1",
            sound = "Spooky1",
            volume = 0.2 * i,
            alpha = 0.3 * i,
            speed = 1 / i
        }
        time = time + 200 + ZombRand(200)
        BWOAEventControl.Add("Spooky", params, time)
    end
end

BWOASequence.BreakNoah = function(params)
    BWOANoah.ChangeState("error")
end

BWOASequence.Finale = function(params)
    BWOAEventControl.Add("FinaleStage1", {}, 1)
    BWOAEventControl.Add("FinaleStage2", {}, 26000)
    BWOAEventControl.Add("FinaleStage3", {}, 29100)
end

BWOASequence.Epilogue = function(params)
    BWOAEventControl.Add("EpilogueStage1", {}, 1000)
    BWOAEventControl.Add("EpilogueStage2", {}, 6000)
    BWOAEventControl.Add("EpilogueStage3", {}, 24600)
end


