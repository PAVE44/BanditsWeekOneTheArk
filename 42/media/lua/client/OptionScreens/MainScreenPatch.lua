require "MainScreen"

MainScreen.titleTextureNow = 1

MainScreenInitialise = MainScreen.initialise

function MainScreen:initialise()
	MainScreenInitialise(self)
    self.titleTextureLight = getTexture("media/textures/title_light.png")
    self.titleTextureDark = getTexture("media/textures/title_dark.png")
end

MainScreenPrerender = MainScreen.prerender

function MainScreen:prerender()
    MainScreenPrerender(self)

    if not self.inGame then
        if MainScreen.titleTextureNow == 1 then
            self:drawTextureScaled(self.titleTextureLight, 0, 0, self.width, self.height, 1, 1, 1, 0.8, 0)
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
            self:drawTextureScaled(self.titleTextureDark, 0, 0, self.width, self.height, 1, 1, 1, 0.8, 0)
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
    end
end
