require "MainScreen"

MainScreen.titleTextureNow = 1
MainScreen.start = true
MainScreen.alphaBG = 0

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
end

local mainScreenGetAllUIs = MainScreen.getAllUIs

function MainScreen:getAllUIs()
    local ret = mainScreenGetAllUIs(self)
    table.insert(ret, self.arkSettingsMain)
end

MainScreenInitialise = MainScreen.initialise

function MainScreen:initialise()
	MainScreenInitialise(self)
    self.titleTextureLight = getTexture("media/textures/title_light.png")
    self.titleTextureDark = getTexture("media/textures/title_dark.png")
    self.alphaBG = 0
    if not self.inGame and not isDemo() then
        BWOAMusic.Play("MusicIntro", 1, 1)
    end
end

MainScreenPrerender = MainScreen.prerender

function MainScreen:prerender()
    MainScreenPrerender(self)

    if not self.inGame then
        if MainScreen.start then
            MainScreen.alphaBG = MainScreen.alphaBG + 0.0005
            if MainScreen.alphaBG > 1 then 
                MainScreen.alphaBG = 1 
                MainScreen.start = false
            end
            UIManager.DrawTexture(self.titleTextureLight, 0, 0, self.width, self.height, MainScreen.alphaBG)
        else

            if MainScreen.titleTextureNow == 1 then
                MainScreen.alphaBG = MainScreen.alphaBG + 0.025
                if MainScreen.alphaBG > 1 then 
                    MainScreen.alphaBG = 1
                end
                local rnd = ZombRand(1000)
                if rnd == 1 then
                    MainScreen.titleTextureNow = 2
                    local emitter = getSoundManager():getUIEmitter()
                    if MainScreen.instance and (not MainScreen.instance.inGame) then
                        emitter:setPos(0, 0, 0)
                        emitter:playSound("UILightFlicker")
                    end
                end
            elseif MainScreen.titleTextureNow == 2 then
                MainScreen.alphaBG = MainScreen.alphaBG - 0.05
                if MainScreen.alphaBG < 0 then 
                    MainScreen.alphaBG = 0
                end

                local rnd = ZombRand(200)
                if rnd == 1 then
                    MainScreen.titleTextureNow = 1
                    local emitter = getSoundManager():getUIEmitter()
                    if MainScreen.instance and (not MainScreen.instance.inGame) then
                        emitter:setPos(0, 0, 0)
                        emitter:playSound("UILightFlicker")
                    end
                end
            end
            UIManager.DrawTexture(self.titleTextureDark, 0, 0, self.width, self.height, 1)
            UIManager.DrawTexture(self.titleTextureLight, 0, 0, self.width, self.height, MainScreen.alphaBG)
        end
    end
end
