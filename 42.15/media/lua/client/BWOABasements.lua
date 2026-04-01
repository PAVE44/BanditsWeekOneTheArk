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

-- NORTH STAIRS:

-- WEST STAIRS:
-- lot_basement_house_49_east - room with trophies, room with crates with ammo
-- lot_basement_house_54_east - room with and computers and jukebox and tv and small fridge, storageroom with 2 metalshelves
-- lot_basement_house_55_east - room with many bookshelves - librarylike, reading armchair and standing lamp
-- lot_basement_house_56_east - room with washing machines, room with shelves and tools, room with crates
-- lot_basement_house_58_east - room with shelves with tools, cardboxes, floodlight and table
-- lot_basement_house_59_east - big room with unfinished interior walls, shelf and crates
-- lot_basement_house_61_east - big room with percussion, wood logs, antique stove and boiler
-- lot_basement_house_62_B_east - big room with shop shelves with clothes, mirror, table
-- lot_basement_house_62_C_east - big room with shop racks with clothes, mirror, table, armchair
-- lot_basement_house_62_east - big room with shop racks with clothes, mirror, table, armchair
-- lot_basement_house_64_east - audiopile basement, nice walls
-- lot_basement_house_65_east - one room like poor kitchen with boiler, second room with antique stove and many logs
-- lot_basement_house_57 - nice walls, room with bed and table, 2nd identical room with bed and table, lobby with couch, computer, tv, separate storage area, room with metal shelve and washing machines
-- lot_basement_house_63 - one quite big room with kitchen anex and many metal shelves, picture of woman on wall
-- lot_basement_house_64_east 
-- lot_basement_house_66 - one room with speakers, tv2, guitar amp, ham radio, tables and some shelves
-- lot_basement_house_67_east - one room with a metal prison cage 2x2
-- lot_basement_house_68_east - small room with audio speakers and couch, second room with darts and american flag, small room with metal shelves, long corridor with counters
-- lot_basement_house_69 - 3 level base with everything
-- lot_basement_house_E2_01 - one small room with washing mashines and metal shelves, sink
-- lot_basement_house_E2_02 - gym, metalshelf and metal cabinet
-- lot_basement_house_E2_03 - two metal  shelves, washing mashines, 2 fridges, cardboxes, electroboxes
-- lot_basement_house_E2_04  - two metal  shelves, washing mashines, 2 metal cabinets
-- lot_basement_house_E2_05 - one room with carboxes, metal shelf and table +chair, room with toilet, room with pietrowe bed and sink, room with kitchen, room with shower
-- lot_basement_house_E_01 - room with boiler, washing mashines, metal shelf, carboxes and electrobox
-- lot_basement_house_E_02 - room with ammo box, cardboxes, desk and chair, small gym
-- lot_basement_house_E_03 - room with gym equip, electrobox, water pump
-- lot_basement_house_E_04 - room pretty empty, just 2 electroboxes, some chairsa and cardboxes and 2 metal barrels
-- lot_basement_house_E_05 - central room with kitchen and diner area and hamradio, room with pietrowe lozko and sink, room toilet, storage room with fridge, medical room with shower
-- lot_basement_house_medium_38_westpoint - anvil, loom, jukebox, flippers, sofa, cardboxes, couch
-- lot_basement_house_06_B_east - room with poolbilard and american flag, storage rtoom, main room with sofa, kitchen
-- lot_basement_house_06_C_east - room with double bed big, storage rtoom, main room shelves
-- lot_basement_house_06_D_east - room with percussion, microphone, storage room with no shelves, main room with logs and stove
-- lot_basement_house_06_E_east -poker room, , storage rooms, main room with crap
-- lot_basement_house_06_F_east -empty flower pots room, , storage rooms, main room with sofas
-- lot_basement_house_06_G_east -logs and stove room, , storage room empty, main room with crap
-- lot_basement_house_06_H_east -many desks with computers room,  storage room, main room with crap
-- lot_basement_house_06_I_east - room with trophies, storage room, main room with crap
-- lot_basement_house_07_B_east - very small, crates
-- lot_basement_house_07_C_east - very small, empty
-- lot_basement_house_07_D_east - very small, washing machines
-- lot_basement_house_07_east - very small, shelf
-- lot_basement_house_08 - room with bool bilard, room with 5 shelves
-- lot_basement_house_08_B - 2 rooms with crates
-- lot_basement_house_08_C - 2 rooms with logs and stove
-- lot_basement_house_08_D - 2 rooms with percussion and kitchen
-- lot_basement_house_08_E - 2 rooms hazard, bar, and storage


--{x=9814, y=12927, stairDir="W", access={"ba_exterior_west_northside_01"}, choices={"lot_basement_house_49_east"}}, -- hunter house

local procedural_basements = {
    ark_underground_all = { width=28, height=50, stairx=0, stairy=0, stairDir="N" },
    finnegan_research_group = { width=57, height=29, stairx=0, stairy=0, stairDir="" },
    council = { width=20, height=20, stairx=0, stairy=0, stairDir="" },
    maze = { width=60, height=60, stairx=0, stairy=0, stairDir="" },
    breach = { width=60, height=60, stairx=0, stairy=0, stairDir="" },
    family_house = { width=20, height=20, stairx=0, stairy=0, stairDir="" },
    mirror_room = { width=6, height=6, stairx=0, stairy=0, stairDir="" },
    sewer = { width=50, height=20, stairx=0, stairy=0, stairDir="" },
}

local procedural_basement_spawn_locations = {
    {x=10183, y=12634, stairDir="N", choices={"lot_basement_house_01"}}, -- vhs secret room
    {x=9814, y=12918, stairDir="N", choices={"lot_basement_house_49_east"}}, -- hunter house
    -- {x=8113, y=12221, stairDir="W", access="ba_exterior_west_northside_01", choices={"lot_basement_house_44_east"}}, -- fisherman  house
    {x=8340, y=11755, stairDir="W", access="ba_exterior_west_northside_01", choices={"lot_basement_house_06_F_east"}}, -- farmer house
    {x=9814, y=12927, stairDir="W", access="ba_exterior_west_northside_01", choices={"lot_basement_house_49_east"}}, -- hunter house
    {x=10862, y=10033, stairDir="W", access="ba_exterior_west_northside_01", choices={"lot_basement_house_57"}}, -- doc house
    {x=7174, y=9736, stairDir="N", choices={"lot_basement_house_02"}}, -- farmer house
    {x=18000, y=3000, z=-2, stairDir="", choices={"council"}}, -- the council room
    {x=18000, y=3200, z=-2, stairDir="", choices={"maze"}}, -- maze
    {x=18000, y=3400, z=-2, stairDir="", choices={"family_house"}}, -- family_house
    {x=18000, y=3600, z=-2, stairDir="", choices={"mirror_room"}}, -- mirror room
    {x=18000, y=4000, z=2, stairDir="", choices={"finnegan_research_group"}}, -- finnegan underground facility
    {x=9948, y=12600, z=-4, stairDir="N", choices={"ark_underground_all"}}, -- ark sublevel
    {x=10570, y=10600, z=1, stairDir="", choices={"breach"}}, -- breach
    {x=10360, y=12324, z=1, stairDir="", choices={"sewer"}}, -- sewer

    --{x=99999, y=99999, z=-1, stairDir="", access="name", choices={"basement_name"}},
}

local function addBasements()
        local api = Basements.getAPIv1()
    -- api:addAccessDefinitions('Muldraugh, KY', procedural_basement_access)
    api:addBasementDefinitions('Muldraugh, KY', procedural_basements)
    api:addSpawnLocations('Muldraugh, KY', procedural_basement_spawn_locations)
end

Events.OnLoadMapZones.Add(addBasements)
