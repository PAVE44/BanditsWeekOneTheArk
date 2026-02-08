BWOANPC = BWOANPC or {}

local function manageNPC()
    
    local cache = BanditZombie.CacheLightB
    if not cache then return end

    local gmd = GetBWOAModData()

    for id, npc in pairs(cache) do
        if npc.brain.program.name == "Emma" then

            local bandit = BanditZombie.GetInstanceById(id)
            if bandit then
                local brain = BanditBrain.Get(bandit)

                -- record last know position
                gmd.permanentNPC[id] = {
                    x = math.floor(bandit:getX() + 0.5),
                    y = math.floor(bandit:getY() + 0.5),
                    z = bandit:getZ(),
                    t = 0
                }

                if not brain.bladder then
                    brain.bladder = 0
                end
                if not brain.hunger then
                    brain.hunger = 0
                end
                if not brain.thirst then
                    brain.thirst = 0
                end
                if not brain.sadness then
                    brain.sadness = 0
                end

                brain.bladder = brain.bladder + 0.1
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

    -- protect from despawning
    local player = getSpecificPlayer(0)
    local px, py = player:getX(), player:getY()
    for id, data in pairs(gmd.permanentNPC) do
        if not cache[id] then
            if math.abs(px - data.x) < 70 and math.abs(py - data.y) < 70 then
                local square = getCell():getGridSquare(data.x, data.y, data.z)

                if square then
                    data.t = data.t + 1
                    if data.t > 2 then
                        print ("spawning emma at " .. data.x .. "," .. data.y .. "," .. data.z)
                        data.t = 0
                        local gmdBrain = GetBanditClusterData(id)
                        if gmdBrain[id] then
                            gmdBrain[id].bornCoords = {x = data.x, y = data.y, z = data.z}
                            sendClientCommand(player, 'Spawner', 'Restore', gmdBrain[id])
                            gmd.permanentNPC[id] = nil
                            return
                        else
                            print ("emma was killed naturally")
                            player:Say("Emma was killed!")
                            player:setHealth(0)
                            player:Kill(nil)
                            return
                        end
                    else
                        print ("emma is missing, waiting " .. data.t)
                    end
                else
                    print ("emma spawn square not loaded")
                end
            else
                print ("too far for npc despawn check")
            end
        end
    end
end

BWOANPC.ModBrain = function(id, k, v)
    local bandit = BanditZombie.GetInstanceById(id)
    if bandit then
        local brain = BanditBrain.Get(bandit)
        brain[k] = v
    end
end

Events.EveryOneMinute.Remove(manageNPC)
Events.EveryOneMinute.Add(manageNPC)