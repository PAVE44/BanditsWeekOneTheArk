-- Project Zomboid Building Spawner
	-- by Alree // Unjammer
	-- This script use the Basement spawn system to force a building to spawn on the ground level

local function addDynamicBasementZones()
    local api   = Basements.getAPIv1()
    local mapID = 'Muldraugh, KY' --Map you want to target to place building on

    --------------------------------------------------------------
    -- 1 .  Register dummy basement: the 1×1 as PZ do not consider
	--		basement below 1x1 and smallest basement is 3x3
	--		this dummy allow to spawn a building witout basement below
	--		Not mandatory, this part can be commented/removed
    --------------------------------------------------------------
    api:addBasementDefinitions(mapID, {
        dummy = {          -- looks for media/binmap/dummy.pzby
            width    = 1,  height = 1,
            stairx   = 0,  stairy = 0,
            stairDir = 'N'
        }
    })

    --------------------------------------------------------------
    -- 2 .  Register the access (= the real house prefab)
    --------------------------------------------------------------
    api:addAccessDefinitions(mapID, {
        ['ba_house_medium_38'] = {         -- media/basement_access/2_Story_Building.pzby
            width    = 9,  height = 9,	 -- widht x height of the actual building (in tiles)
            stairx   = 0,  stairy = 0,	 -- position of stairs leading to basement, if any
            stairDir = 'N'				 -- orentation of stairs leagind to basement, if any
        }
    })

    --------------------------------------------------------------
    -- 3 .  Spawn-location that reserves a zone base on widht and height
    --      (≥2x2 to activate the bounding-box test)
    --------------------------------------------------------------
    api:registerBasementSpawnLocation(
        mapID,
        'SpawnHouse',	   				-- Name of the spawn, if you want to keep track of it
		'Basement', 	   				-- Zone type, as we use the Basement spawn system, do not change it
        10979, 10246,      				-- x, y (position in the world)
        0,                				-- z  (0 = ground level)
        2, 2,              				-- w, h  → any basement > 2 × 2 will trigger a random basement spawn (using 2x2 will only works if dummy.pzby is used)
        { Access = '2_Story_Building' } -- Name of the actual building, see addAccessDefinitions()
    )
end

local procedural_basement_spawn_locations = {
    {x=10183, y=12634, stairDir="N", choices={"lot_basement_house_01"}}, -- vhs secret room
    --{x=99999, y=99999, z=-1, stairDir="", access="name", choices={"basement_name"}},
}

local function addBasements()
        local api = Basements.getAPIv1()
    -- api:addAccessDefinitions('Muldraugh, KY', procedural_basement_access)
    -- api:addBasementDefinitions('Muldraugh, KY', procedural_basements)
    api:addSpawnLocations('Muldraugh, KY', procedural_basement_spawn_locations)
end

Events.OnLoadMapZones.Add(addBasements)
