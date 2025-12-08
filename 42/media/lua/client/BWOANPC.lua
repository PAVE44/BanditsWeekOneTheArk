BWOANPC = BWOANPC or {}

local function manageNPC()
    local cache = BanditZombie.CacheLightB
    if not cache then return end

    for id, npc in pairs(cache) do
        if true then --  npc.brain.permanent then
            local bandit = BanditZombie.GetInstanceById(id)
            if bandit then
                local brain = BanditBrain.Get(bandit)

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