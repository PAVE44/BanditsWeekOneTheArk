require "NewGameScreen"

local newGameScreenClickPlay = NewGameScreen.clickPlay

function NewGameScreen:clickPlay()
    newGameScreenClickPlay(self)

    MapSpawnSelect.instance:setVisible(false, self.joyfocus);

    if MainScreen.instance.createWorld then
        local seed = WorldGenUtils.INSTANCE:generateSeed()
        WorldGenParams.INSTANCE:setSeedString(seed)
        local sdf = SimpleDateFormat.new("yyyy-MM-dd_HH-mm-ss", Locale.ENGLISH)
        local name = "ARK_v" .. BWOAMenu.version .. "_" .. sdf:format(Calendar.getInstance():getTime())
        getWorld():setWorld(sanitizeWorldName(name))
		getWorld():setWorld(sanitizeWorldName(name))
    end

    setSpawnRegion("Muldraugh, KY")
	getCore():setSelectedMap("Muldraugh, KY")
    
    if getWorld():getGameMode() == "Sandbox" and not checkSaveFileExists("map_sand.bin") then
		MainScreen.instance.sandOptions.previousScreen = "NewGameScreen";
		MainScreen.instance.sandOptions:setVisible(true, self.joyfocus)
    else
        MainScreen.instance.charCreationProfession.previousScreen = "NewGameScreen";
        MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus)
    end

end