require "VehicleZoneDefinition"

for k, v in pairs(VehicleZoneDistribution) do
    VehicleZoneDistribution[k].chanceToSpawnBurnt = 100

    local newSpawnRate
    if v.spawnRate then
        newSpawnRate = v.spawnRate * 3
        if newSpawnRate > 100 then newSpawnRate = 100 end
    else
        newSpawnRate = 48
    end
    VehicleZoneDistribution[k].spawnRate = newSpawnRate

    
end
