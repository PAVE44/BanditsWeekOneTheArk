require "SpawnRegions"
require "BWOABandit"

function SpawnRegionMgr.getSpawnRegions()
	local regions = {
        [1] = {
            file = "media/maps/Muldraugh, KY/spawnpoints.lua",
            name = "Muldraugh, KY",
            points = {
                ["unemployed"] = {
                    [1] = {
                        ["posX"] = Bandit.playerStart.x,
                        ["posY"] = Bandit.playerStart.y,
                        ["posZ"] = Bandit.playerStart.z
                    }
                }
            }
        }
    }
    if not isClient() then
		triggerEvent("OnSpawnRegionsLoaded", regions)
	end
    return regions
end
