UINoah = ISPanel:derive("UINoah")

function UINoah:initialise()
    self.bgtex = getTexture("media/textures/C64_bg2.png")
    self.bgtexOff = getTexture("media/textures/C64_bg2_off.png")
    self.afont = AngelCodeFont.new("media/fonts/EN/2x/C64.fnt", "media/fonts/EN/2x/C64_0.png")
    ISPanel.initialise(self)
end

function UINoah:createChildren()
end

function UINoah:setText(text)
    self.text = text
end

function UINoah:onRightClick(button)
end

function UINoah:update()
    ISPanel.update(self)
end

function UINoah:prerender()

    local gmd = GetBWOAModData()
    local noah = gmd.noah

    if BWOANoah.IsOn() then
        self:drawTextureScaled(self.bgtex, 0, 0, 820, 688, 1, 1, 1, 1, 0)

        local padLeft, padTop = 106, 116
        local x, y = self:getX(), self:getY()

        for i=1, 25 do
            if self.text[i] then
                self.afont:drawString(x + padLeft, y + padTop + ((i-1) * 16), 1, self.text[i], 0.380, 0.443, 0.714, 1)
            end
        end
    else
        self:drawTextureScaled(self.bgtexOff, 0, 0, 820, 688, 1, 1, 1, 1, 0)
    end
    ISPanel.prerender(self)
end

function UINoah:new(x, y, width, height)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0, g=0, b=0, a=0}
    o.backgroundColor = {r=0, g=0, b=0, a=0}
    o.width = width
    o.height = height
    o.moveWithMouse = true
    UINoah.instance = o
    ISDebugMenu.RegisterClass(self)
    return o
end
