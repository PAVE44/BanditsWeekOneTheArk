require "MainScreen"

MainScreen.alphaBG = 0
MainScreen.alphaPZLogo = 0
MainScreen.alphaTheArkLogo = 0

local mainScreenInstantiate = MainScreen.instantiate
function MainScreen:instantiate()
    mainScreenInstantiate(self)

    if not self.inGame and not isDemo() then
        self.arkSettingsMain = ArkSettingsMain:new(0, 0, self:getWidth(), self:getHeight())

        self.arkSettingsMain:initialise()
        self.arkSettingsMain:setVisible(false)
        self.arkSettingsMain:setAnchorRight(true)
        self.arkSettingsMain:setAnchorLeft(true)
        self.arkSettingsMain:setAnchorBottom(true)
        self.arkSettingsMain:setAnchorTop(true)
        self.arkSettingsMain.backgroundColor = {r=0, g=0, b=0, a=0.8}
        self.arkSettingsMain.borderColor = {r=1, g=1, b=1, a=0.5}
        self:addChild(self.arkSettingsMain)

        local w = getCore():getScreenWidth();
	    local h = getCore():getScreenHeight();

        local uis = {
            { self.arkSettingsMain, 0.7, 0.8 },
        }
    
        for _,ui in ipairs(uis) do
            if ui[1] and ui[1].javaObject and instanceof(ui[1].javaObject, 'UIElement') then
                local width = w * ui[2]
                local height = h * ui[3]
                if w <= 1024 then
                    width = w * 0.95
                    height = h * 0.95
                end
                ui[1]:setWidth(width)
                ui[1]:setHeight(height)
                ui[1]:setX((w - width) / 2)
                ui[1]:setY((h - height) / 2)
                ui[1]:recalcSize()
            end
        end

        self.arkSettingsMain:create()
    end

    if self.resetLua then
        self.resetLua.onclick = function()
            BWOAMusic.Stop()
            getCore():ResetLua("default", "Force")
        end
    end
end

local mainScreenGetAllUIs = MainScreen.getAllUIs
function MainScreen:getAllUIs()
    local ret = mainScreenGetAllUIs(self)
    table.insert(ret, self.arkSettingsMain)
    return ret
end

MainScreenInitialise = MainScreen.initialise
function MainScreen:initialise()
    local emitter = getSoundManager():getUIEmitter()
    emitter:setPos(0, 0, 0)

    -- getSoundManager():setMusicState("PauseMenu") -- disabled here as it messes up the sound after save load
	MainScreenInitialise(self)
    self.titleTextureBG = getTexture("media/textures/w1title.png")
    self.titleTexturePZLogo = getTexture("media/textures/pzlogo.png")
    self.titleTextureTheArkLogo = getTexture("media/textures/thearklogo.png")
    self.alphaBG = 0
    self.alphaPZLogo = 0
    self.alphaTheArkLogo = 0
    if not self.inGame and not isDemo() then
        BWOAMusic.Play("MusicIntro", 1, 1)
    end
end

MainScreenPrerender = MainScreen.prerender
function MainScreen:prerender()
    MainScreenPrerender(self)
    getCore():setOptionUIRenderFPS(60)
    getSoundManager():setMusicState("PauseMenu")

    local function playLogoSound()
        local emitter = getSoundManager():getUIEmitter()
        emitter:setPos(0, 0, 0)

        if MainScreen.instance and (not MainScreen.instance.inGame) then
            emitter:setPos(0, 0, 0)
            emitter:playSound("UIActivatePlayButton")
        end
    end

    if not self.inGame then
        MainScreen.alphaBG = MainScreen.alphaBG + 0.00075
        if MainScreen.alphaBG > 1 then 
            MainScreen.alphaBG = 1 
        end

        if MainScreen.alphaBG > 0.99 then
            if MainScreen.alphaPZLogo == 0 then
                -- playLogoSound()
            end

            MainScreen.alphaPZLogo = MainScreen.alphaPZLogo + 0.0025
            if MainScreen.alphaPZLogo > 1 then 
                MainScreen.alphaPZLogo = 1 
            end

            if MainScreen.alphaPZLogo > 0.25 then
                if MainScreen.alphaTheArkLogo == 0 then
                    playLogoSound()
                end

                MainScreen.alphaTheArkLogo = MainScreen.alphaTheArkLogo + 0.0035
                if MainScreen.alphaTheArkLogo > 1 then 
                    MainScreen.alphaTheArkLogo = 1 
                end
            end
        end
        UIManager.DrawTexture(self.titleTextureBG, 0, 0, self.width, self.height, MainScreen.alphaBG)

        local x = self.bottomPanel:getX() / 3
        local height = self.bottomPanel:getY()
        local scale = height / 672

        UIManager.DrawTexture(self.titleTexturePZLogo, x, 20 * scale, 632 * scale, 418 * scale, MainScreen.alphaPZLogo)
        UIManager.DrawTexture(self.titleTextureTheArkLogo, x + 37 * scale, 450 * scale, 558 * scale, 234 * scale, MainScreen.alphaTheArkLogo)
    end
end
