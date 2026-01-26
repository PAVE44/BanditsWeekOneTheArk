require "ISUI/ISPanelJoypad"
require "BWOADialogues"
require "BWOAChat"

UIDialogue = ISPanelJoypad:derive("UIDialogue");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local PADDING = 12
local DIAL_LIST_HGT = 320
function UIDialogue:initialise()
    ISPanelJoypad.initialise(self);

    self.dialListBox = ISScrollingListBox:new(PADDING, PADDING + FONT_HGT_MEDIUM + PADDING, self:getWidth() - (2 * PADDING), DIAL_LIST_HGT)
    self.dialListBox.itemheight = FONT_HGT_MEDIUM + PADDING
    self.dialListBox.backgroundColor.a = 0
    self:addChild(self.dialListBox)
    self.dialListBox:clear()

    local dialogues = BWOADialogues.GetQuestions(self.person)

    if BWOAChat.last[self.person] then
        self.dialListBox:addItem(id, { index = 0, qst = "Can you repeat that?"})
    end

    for id, dialogue in pairs(dialogues) do
        self.dialListBox:addItem(id, { index = id, qst = dialogue.qst})
    end

    self.maxWidth = getTextManager():MeasureStringX(UIFont.Medium, "Speak to " .. self.person)
    self.dialListBox.doDrawItem = function(list, y, item, alt)
        local h = list.itemheight

        if (list.mouseoverselected == item.index) and list:isMouseOver() and not list:isMouseOverScrollBar() then
            list:drawMouseOverHighlight(0, y, list:getWidth(), item.height-1);
        end
        
        local width = getTextManager():MeasureStringX(UIFont.Medium, item.item.qst)
        self.maxWidth = math.max(width, self.maxWidth)

        list:drawText(item.item.qst, 4, y + 6, 1, 1, 1, 1, UIFont.Medium)
        list:drawRect(0, y + h - 1, list:getWidth(), 1, 1, 0.4, 0.4, 0.4)
        
        return y + h
    end

    self.dialListBox.onMouseUp = function(listBox, x, y)
        local itemText = listBox.items[listBox.selected].item.qst
        BWOAChat.Say(itemText, self.person)
        self:destroy()
    end
    
    self.cancel = ISButton:new((self:getWidth() - 100) / 2, PADDING + FONT_HGT_MEDIUM + PADDING + DIAL_LIST_HGT + PADDING, 100, 24, getText("UI_Cancel"), self, UIDialogue.onClick)
    self.cancel.internal = "CANCEL"
    self.cancel:initialise()
    self.cancel:instantiate()
    self.cancel.borderColor = {r=1, g=1, b=1, a=0.1}
    self:addChild(self.cancel)

    self:setHeight(self.cancel:getBottom() + PADDING)

    self:insertNewLineOfButtons(self.cancel)


end

function UIDialogue:destroy()
    UIManager.setShowPausedMessage(true);
    self:setVisible(false);
    self:removeFromUIManager();
end

function UIDialogue:sendMessage()
    local txt = self:getText()
    self:unfocus()
    UIManager.setShowPausedMessage(true);
    self.parent:setVisible(false);
    self.parent:removeFromUIManager();
    BWOChat.Say(txt)
end

function UIDialogue:onClick(button)

    if button.internal == "CANCEL" then
        self:destroy();
    end

    self:updateNow()
end

function UIDialogue:prerender()
    self:setWidth(self.maxWidth + (PADDING * 5))
    self.dialListBox:setWidth(self.maxWidth + (PADDING * 3))
    self.cancel:setX((self:getWidth() - 100) / 2)
    self.backgroundColor.a = 0.5
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawTextCentre("Speak to " .. self.person, self:getWidth()/2, 10, 1, 1, 1, 1, UIFont.Medium);
end

function UIDialogue:render()
end

function UIDialogue:update()
end

function UIDialogue:updateNow()
end

function UIDialogue:new(x, y, width, height, character, program)
    local o = {}
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.program = program
    o.person = Bandit.prg2person[program]
    o.name = nil
    o.backgroundColor = {r=0, g=0, b=0, a=0.5}
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
    o.width = width
    o.height = height
    o.anchorLeft = true
    o.anchorRight = true
    o.anchorTop = true
    o.anchorBottom = true

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

