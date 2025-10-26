require "ISEquippedItem"
require "BWOAMissions"

local UI_BORDER_SPACING = 10
local TEXTURE_WIDTH = 0
local TEXTURE_HEIGHT = 0

local function setTextureWidth()
    local size = getCore():getOptionSidebarSize()
    if size == 6 then
        size = getCore():getOptionFontSizeReal() - 1
    end
        TEXTURE_WIDTH = 48
    if size == 2  then
        TEXTURE_WIDTH = 64
    elseif size == 3  then
        TEXTURE_WIDTH = 80
    elseif size == 4  then
        TEXTURE_WIDTH = 96
    elseif size == 5 then
        TEXTURE_WIDTH = 128
    end

    TEXTURE_HEIGHT = TEXTURE_WIDTH * 0.75
end


local ISEquippedItemOnOptionMouseDown = ISEquippedItem.onOptionMouseDown

function ISEquippedItem:onOptionMouseDown(button, x, y)
    ISEquippedItemOnOptionMouseDown(self, button, x, y)
    if button.internal == "MISSIONS" then
        local modal = UIMissions:new(0, 0, 400, 600, getSpecificPlayer(0))
        modal:initialise();
        modal:addToUIManager();
    end
end

local ISEquippedItemInitialize = ISEquippedItem.initialise

function ISEquippedItem:initialise()
    ISEquippedItemInitialize(self)
    setTextureWidth()

    self.missionIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Mission_On_" .. TEXTURE_WIDTH .. ".png");
    self.missionIconOff = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Mission_Off_" .. TEXTURE_WIDTH .. ".png");

    self.missionBtnOscillatorLevel = 0.0;
    self.missionBtnOscillator = 0.0;
    self.missionBtnOscillatorDecelerator = 0.96;
    self.missionBtnOscillatorRate = 0.8;
    self.missionBtnOscillatorScalar = 15.6;
    self.missionBtnOscillatorStartLevel = 1.0;
    self.missionBtnOscillatorStep = 0.0;

    local children = ISEquippedItem.instance:getChildren()
    local lastChild
    local ymax = 0
    for _, child in pairs(children) do
        if child.y > ymax then
            lastChild = child
            ymax = child:getBottom()
        end
    end

    self.missionBtn = ISButton:new(0, ymax + UI_BORDER_SPACING + 5, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
    self.missionBtn:setImage(self.missionIconOff)
    self.missionBtn.internal = "MISSIONS"
    self.missionBtn:initialise()
    self.missionBtn:instantiate()
    self.missionBtn:setDisplayBackground(false)
    self.missionBtn:ignoreWidthChange()
    self.missionBtn:ignoreHeightChange()
    self:addChild(self.missionBtn)
    self:addMouseOverToolTipItem(self.missionBtn, "Missions" )

    self:shrinkWrap()

end

local ISEquippedItemRender = ISEquippedItem.render

function ISEquippedItem:render()
    ISEquippedItemRender(self)

    if BWOAMissions.new then
        self.missionBtnOscillatorLevel = 1
    else
        self.missionBtnOscillatorLevel = 0
    end

    if self.missionBtnOscillatorLevel >= 0.01 then
        local fpsFrac = (UIManager.getMillisSinceLastRender() / 33.3) * 0.5;
        self.missionBtnOscillatorLevel = self.missionBtnOscillatorLevel * self.missionBtnOscillatorDecelerator
        self.missionBtnOscillatorLevel = self.missionBtnOscillatorLevel - (self.missionBtnOscillatorLevel * (1 - self.missionBtnOscillatorDecelerator) * fpsFrac)
        self.missionBtnOscillatorStep = self.missionBtnOscillatorStep + self.missionBtnOscillatorRate * fpsFrac
        self.missionBtnOscillator = math.sin(self.missionBtnOscillatorStep)
        self.missionBtn:setX(self.missionBtnOscillator * self.missionBtnOscillatorLevel * self.missionBtnOscillatorScalar)
    elseif self.missionBtnOscillatorLevel < 0.01 then
        self.missionBtnOscillatorLevel = 0
        self.missionBtn:setX(self.missionBtnOscillator * self.missionBtnOscillatorLevel * self.missionBtnOscillatorScalar)
    end
end