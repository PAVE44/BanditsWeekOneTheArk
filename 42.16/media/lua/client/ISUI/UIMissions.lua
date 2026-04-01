require "ISUI/ISPanelJoypad"
require "BWOAMissions"

UIMissions = ISPanelJoypad:derive("UIMissions");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local PADDING = 12
local MISSION_LIST_HGT = 320
function UIMissions:initialise()
    ISPanelJoypad.initialise(self);

    ISEquippedItem.instance.missionBtn:setImage(ISEquippedItem.instance.missionIconOn);

    BWOAMissions.new = false

    self.missionListBox = ISScrollingListBox:new(PADDING, PADDING + FONT_HGT_MEDIUM + PADDING, self:getWidth() - (2 * PADDING), MISSION_LIST_HGT)
    self.missionListBox.itemheight = FONT_HGT_MEDIUM + PADDING + (FONT_HGT_SMALL * 2) + PADDING
    self.missionListBox.backgroundColor.a = 0
    self:addChild(self.missionListBox)
    self.missionListBox:clear()

    local missions = BWOAMissions.GetRevealed()

    for id, mission in pairs(missions) do
        self.missionListBox:addItem(id, { index = id, name = mission.name, desc = mission.desc, accomplished = mission.accomplished})
    end

    self.maxWidth = 0
    self.missionListBox.doDrawItem = function(list, y, item, alt)
        local h = list.itemheight

        if (list.mouseoverselected == item.index) and list:isMouseOver() and not list:isMouseOverScrollBar() then
            list:drawMouseOverHighlight(0, y, list:getWidth(), item.height-1);
        end
        
        local width1 = getTextManager():MeasureStringX(UIFont.Medium, item.item.name)
        local width2 = getTextManager():MeasureStringX(UIFont.Small, item.item.desc)
        local width =  math.max(width1, width2)
        self.maxWidth = math.max(width, self.maxWidth)

        local alpha = 1
        if item.item.accomplished then
            alpha = 0.4
        end

        list:drawText(item.item.name, 4, y + 6, alpha, alpha, alpha, 1, UIFont.Medium)
        list:drawText(item.item.desc, 4, y + 6 + FONT_HGT_MEDIUM, alpha, alpha, alpha, 1, UIFont.FONT_HGT_SMALL)

        list:drawRect(0, y + h - 1, list:getWidth(), 1, 1, 0.4, 0.4, 0.4)
        
        return y + h
    end

    self.missionListBox.onMouseUp = function(listBox, x, y)

    end
    
    self.cancel = ISButton:new((self:getWidth() - 100) / 2, PADDING + FONT_HGT_MEDIUM + PADDING + MISSION_LIST_HGT + PADDING, 100, 24, getText("UI_Close"), self, UIMissions.onClick)
    self.cancel.internal = "CLOSE"
    self.cancel:initialise()
    self.cancel:instantiate()
    self.cancel.borderColor = {r=1, g=1, b=1, a=0.1}
    self:addChild(self.cancel)

    self:setHeight(self.cancel:getBottom() + PADDING)

    self:insertNewLineOfButtons(self.cancel)


end

function UIMissions:destroy()
    UIManager.setShowPausedMessage(true);
    self:setVisible(false);
    self:removeFromUIManager();
end

function UIMissions:onClick(button)

    if button.internal == "CLOSE" then
        ISEquippedItem.instance.missionBtn:setImage(ISEquippedItem.instance.missionIconOff);
        self:destroy();
    end

    self:updateNow()
end

function UIMissions:prerender()
    self:setWidth(self.maxWidth + (PADDING * 5))
    self.missionListBox:setWidth(self.maxWidth + (PADDING * 3))
    self.cancel:setX((self:getWidth() - 100) / 2)
    self.backgroundColor.a = 0.5
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawTextCentre(getText("UI_BWOA_Missions"), self:getWidth()/2, 10, 1, 1, 1, 1, UIFont.Medium);
end

function UIMissions:render()
end

function UIMissions:update()
end

function UIMissions:updateNow()
end

function UIMissions:new(x, y, width, height, character)
    local o = {}
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;

    local player = character:getPlayerNum()
    if y == 0 then
        o.y = (getPlayerScreenHeight(player) - height) / 2
        o:setY(o.y)
    end
    if x == 0 then
        o.x = (getPlayerScreenWidth(player) - width) / 2
        o:setX(o.x)
    end
    
    return o;
end

