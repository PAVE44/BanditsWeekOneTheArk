forageSystem.forageDefinitions['Plantain'] = nil
forageSystem.forageDefinitions['Comfrey'] = nil
forageSystem.forageDefinitions['CommonMallow'] = nil
forageSystem.forageDefinitions['LemonGrass'] = nil
forageSystem.forageDefinitions['BlackSage'] = nil

local function generateMedicinalPlantSeedsDefs()
	local itemDefs = {
		PlantainSeeds = {
			type = "Base.BroadleafPlantainSeed",
			minCount = 2,
			maxCount = 5,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
			spawnFuncs = { forageSystem.doGenericItemSpawn },
		},
		ComfreySeed = {
			type = "Base.ComfreySeed",
			minCount = 2,
			maxCount = 5,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
			altWorldTexture = forageSystem.worldSprites.vines,
			spawnFuncs = { forageSystem.doGenericItemSpawn },
		},
		CommonMallowSeed = {
			type = "Base.CommonMallowSeed",
			minCount = 2,
			maxCount = 5,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
			spawnFuncs = { forageSystem.doGenericItemSpawn },
			altWorldTexture = forageSystem.worldSprites.vines,
		},
		LemonGrassSeed = {
			type = "Base.LemonGrassSeed",
			minCount = 2,
			maxCount = 5,
			xp = 5,
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
			spawnFuncs = { forageSystem.doGenericItemSpawn },
			altWorldTexture = getTexture("media/textures/Foraging/worldSprites/lemongrass_worldSprite.png"),
		},
		BlackSageSeed = {
			type = "Base.BlackSageSeed",
			minCount = 2,
			maxCount = 5,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
			spawnFuncs = { forageSystem.doGenericItemSpawn },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
		},
	};
	for itemName, itemDef in pairs(itemDefs) do
		forageSystem.addForageDef(itemName, itemDef);
	end;
end

generateMedicinalPlantSeedsDefs();
