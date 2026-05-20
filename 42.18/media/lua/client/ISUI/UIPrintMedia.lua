require "ISUI/ISPanelJoypad"

UIPrintMedia = ISPanelJoypad:derive("UIPrintMedia");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local PADDING = 12

function UIPrintMedia:initialise()
    ISPanelJoypad.initialise(self);

    self.prev = ISButton:new(self:getWidth() / 2 - 102, self:getHeight() - 24, 40, 24, " << ", self, UIPrintMedia.onClick)
    self.prev.internal = "PREV"
    self.prev:initialise()
    self.prev:instantiate()
    self.prev.borderColor = {r=1, g=1, b=1, a=0.1}
    self:addChild(self.prev)

    self.close = ISButton:new((self:getWidth() - 100) / 2, self:getHeight() - 24, 100, 24, getText("UI_Close"), self, UIPrintMedia.onClick)
    self.close.internal = "CLOSE"
    self.close:initialise()
    self.close:instantiate()
    self.close.borderColor = {r=1, g=1, b=1, a=0.1}
    self:addChild(self.close)

    self.next = ISButton:new(self:getWidth() / 2 + 62, self:getHeight() - 24, 40, 24, " >> ", self, UIPrintMedia.onClick)
    self.next.internal = "NEXT"
    self.next:initialise()
    self.next:instantiate()
    self.next.borderColor = {r=1, g=1, b=1, a=0.1}
    self:addChild(self.next)

    self:insertNewLineOfButtons(self.prev, self.cancel, self.next)

end

function UIPrintMedia:destroy()
    UIManager.setShowPausedMessage(true);
    self:setVisible(false);
    self:removeFromUIManager();
end

function UIPrintMedia:onClick(button)

    if button.internal == "CLOSE" then
        self:destroy();
    elseif button.internal == "PREV" then
        local newPage = self.page - 1
        local newTexture = self:getTexture(self.tex, newPage)
        if newTexture then
            self.page = newPage
            self.texture = newTexture
        end
    elseif button.internal == "NEXT" then
        local newPage = self.page + 1
        local newTexture = self:getTexture(self.tex, newPage)
        if newTexture then
            self.page = newPage
            self.texture = newTexture
        end
    end

    self:updateNow()
end

function UIPrintMedia:prerender()
    -- self:setHeight(self.th + PADDING + self.cancel:getBottom() + PADDING)
    -- self:setWidth(self.tw + PADDING)
    self:drawTextureScaled(self.texture, 0, 0, self.width, self.height, 1, 1, 1, 1, 0)
end

function UIPrintMedia:render()
end

function UIPrintMedia:update()
end

function UIPrintMedia:updateNow()
end

function UIPrintMedia:getTexture(tex, page)
    return getTexture("media/textures/printMedia/" .. tex .. "_" .. tostring(page) .. ".png");
end

function UIPrintMedia:new(tex, character)
    local o = {}

    local player = character:getPlayerNum()
    local screenWidth = getPlayerScreenWidth(player)
    local screenHeight = getPlayerScreenHeight(player)
    local page = 1

    local texture = UIPrintMedia:getTexture(tex, page)
    local width = texture:getWidth();
    local height = texture:getHeight();

    local aspect = screenHeight * 0.85 / height
    width = width * aspect
    height = height * aspect
    
    local x = (screenWidth - width) / 2
    local y = (screenHeight - height) / 2
    
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.name = nil;
    o.tex = tex
    o.page = page
    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
    o.texture = texture;
    o.width = width
    o.height = height
    o:setY(o.y)
    o:setX(o.x)
    o:setWidth(o.width)
    o:setHeight(o.height)

    return o;
end

