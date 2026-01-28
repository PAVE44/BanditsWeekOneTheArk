
local procedural_basement_spawn_locations = {
    {x=9814, y=12918, stairDir="N", choices={"lot_basement_house_01"}}, -- trapper house MR
}

local function addBasements()
    local api = Basements.getAPIv1()
    api:addSpawnLocations('Muldraugh, KY', procedural_basement_spawn_locations)
end

Events.OnLoadMapZones.Add(addBasements)