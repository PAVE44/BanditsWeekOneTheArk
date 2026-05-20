BWOANPC = BWOANPC or {}

local function manageNPC()

    local cache = BanditZombie.CacheLightB
    if not cache then return end

    local player = getSpecificPlayer(0)
    local px, py = player:getX(), player:getY()

    local gmd = GetBWOAModData()

    for id, npc in pairs(cache) do
        if npc.brain.program.name == "Emma" then

            local bandit = BanditZombie.GetInstanceById(id)
            local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
            if bandit then
                local brain = BanditBrain.Get(bandit)

                -- custom mission logic
                if BWOAMissions.IsAccomplished(50) then
                    if bz < -3 and bx > 9950 and bx < 9980 and by > 12600 and by < 12650 then
                        BWOAMissions.Accomplish(51)
                    end
                end

                -- record last know position
                if not gmd.permanentNPC[id] then
                    gmd.permanentNPC[id] = {}
                end

                gmd.permanentNPC[id].name = "Emma"
                gmd.permanentNPC[id].x = math.floor(bandit:getX() + 0.5)
                gmd.permanentNPC[id].y = math.floor(bandit:getY() + 0.5)
                gmd.permanentNPC[id].z = bandit:getZ()
                gmd.permanentNPC[id].t = 0
                
                brain.voice = Bandit.emmaStart.voiceId

                if not brain.bladder then
                    brain.bladder = 0
                end
                if not brain.hunger then
                    brain.hunger = 10
                end
                if not brain.thirst then
                    brain.thirst = 0
                end
                if not brain.sadness then
                    brain.sadness = 0
                end

                brain.bladder = brain.bladder + 0.06
                brain.hunger = brain.hunger + 0.1
                brain.hunger = brain.hunger + 0.08
                brain.sadness = brain.sadness - 1

                if brain.bladder > 100 then
                    brain.bladder = 100
                end
                if brain.hunger > 100 then
                    brain.hunger = 100
                end
                if brain.thirst > 100 then
                    brain.thirst = 100
                end
                if brain.sadness < 0 then
                    brain.sadness = 0
                end

                Bandit.ForceSyncPart(bandit, brain)
            end
        end

    end

    -- TELEPORT 
    for id, data in pairs(gmd.permanentNPC) do
        if data.teleportFrom then
            local tp = data.teleportFrom
            local square = getCell():getGridSquare(tp.x, tp.y, tp.z)
            local bandit = BanditZombie.GetInstanceById(id)
            if square and bandit then
                bandit:removeFromWorld()
                bandit:removeFromSquare()

                gmd.permanentNPC[id].teleportFrom = nil
                gmd.permanentNPC[id].teleportFromDone = true
            end
        end

        if data.teleportTo then
            local tp = data.teleportTo
            local square = getCell():getGridSquare(tp.x, tp.y, tp.z)
            if square then
                local gmdBrain = GetBanditClusterData(id)
                if gmdBrain[id] then
                    gmdBrain[id].bornCoords = {x = tp.x, y = tp.y, z = tp.z}
                    sendClientCommand(player, 'Spawner', 'Restore', gmdBrain[id])
                    gmd.permanentNPC[id].teleportTo = nil
                    gmd.permanentNPC[id].teleportToDone = true
                end
            end
        end

        if data.teleportToDone and data.teleportFromDone then
            local args = {}
            args.id = id
            sendClientCommand(player, 'Commands', 'BanditRemove', args)

            BanditZombie.CacheLightB[id] = nil
            gmd.permanentNPC[id] = nil
        end
    end

    -- protect from despawning
    local sqs = {
        {x=0, y=0},
        {x=-1, y=0},
        {x=1, y=0},
        {x=0, y=-1},
        {x=0, y=1}
    }

    for id, data in pairs(gmd.permanentNPC) do
        if not cache[id] and not data.teleportTo then
            if math.abs(px - data.x) < 70 and math.abs(py - data.y) < 70 then

                for _, sq in pairs(sqs) do
                    local square = getCell():getGridSquare(data.x + sq.x, data.y + sq.y, data.z)

                    if square then
                        data.t = data.t + 1
                        if data.t > 20 then
                            --print ("spawning emma at " .. data.x .. "," .. data.y .. "," .. data.z)
                            data.t = 0
                            local gmdBrain = GetBanditClusterData(id)
                            if gmdBrain[id] then
                                gmdBrain[id].bornCoords = {x = data.x, y = data.y, z = data.z}
                                sendClientCommand(player, 'Spawner', 'Restore', gmdBrain[id])
                                gmd.permanentNPC[id] = nil
                                return
                            else
                                print ("emma was killed naturally")
                                player:Say("Emma died!")
                                player:setHealth(0)
                                player:Kill(nil)
                                return
                            end
                        else
                            -- print ("emma is missing, waiting " .. data.t)
                        end
                    else
                        -- print ("emma spawn square not loaded")
                    end
                end
            else
                -- print ("too far for npc despawn check")
            end
        end
    end
end

BWOANPC.ModBrain = function(id, k, v)
    local bandit = BanditZombie.GetInstanceById(id)
    if bandit then
        local brain = BanditBrain.Get(bandit)
        brain[k] = v
        Bandit.ForceSyncPart(bandit, brain)
    end
end

BWOANPC.Teleport = function(name, x, y, z)
    local gmd = GetBWOAModData()

    for _, data in pairs(gmd.permanentNPC) do
        if data.teleportTo or data.teleportFrom then
            print ("already teleporting, skipping")
            
        else
            if data.name == name then
                data.teleportTo = {
                    x = x,
                    y = y,
                    z = z,
                }
                data.teleportFrom = {
                    x = data.x,
                    y = data.y,
                    z = data.z,
                }
            end
        end
    end
end

BWOANPC.Get = function(name)
    local gmd = GetBWOAModData()
    local retData, retBandit

    for id, data in pairs(gmd.permanentNPC) do
        if data.name == name then
            retData = data
            local bandit = BanditZombie.GetInstanceById(id)
            if bandit then
                retBandit = bandit
            end
        end
    end

    return retData, retBandit
end

Events.EveryOneMinute.Remove(manageNPC)
Events.EveryOneMinute.Add(manageNPC)