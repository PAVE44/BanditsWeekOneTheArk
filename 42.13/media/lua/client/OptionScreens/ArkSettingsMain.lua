
require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"

require "defines"

ArkSettingsMain = ISPanelJoypad:derive("ArkSettingsMain");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local COL1_WIDTH = 320
local COL2_MARGIN = UI_BORDER_SPACING * 3
local CONTROL_WIDTH = 260
local LABEL_WIDTH = 260

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function ArkSettingsMain:initialise()
    ISPanelJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function ArkSettingsMain:instantiate()
    
    --self:initialise();
    self.javaObject = UIElement.new(self);
    self.javaObject:setX(self.x);
    self.javaObject:setY(self.y);
    self.javaObject:setHeight(self.height);
    self.javaObject:setWidth(self.width);
    self.javaObject:setAnchorLeft(self.anchorLeft);
    self.javaObject:setAnchorRight(self.anchorRight);
    self.javaObject:setAnchorTop(self.anchorTop);
    self.javaObject:setAnchorBottom(self.anchorBottom);
    self:createChildren();
end

function ArkSettingsMain:onComboBoxSelected(combo, optionName)
    SandboxVars.BWOA[optionName] = combo.selected
end

function ArkSettingsMain:onTickBoxSelected(_, state, optionName)
    SandboxVars.BWOA[optionName] = state
end

function ArkSettingsMain:updateSettings()
    for settingName, control in pairs(self.controls) do
        local settingKey = settingName:match("%.(.*)")
        if control.type == "checkbox" then
            control.selected[1] = SandboxVars.BWOA[settingKey]
        elseif control.type == "enum" then
            control.selected = SandboxVars.BWOA[settingKey]
        end
    end
end

function ArkSettingsMain:create()
    local x = UI_BORDER_SPACING + 1
    local y = UI_BORDER_SPACING + FONT_HGT_TITLE + x
    
    -- BOTTOM BUTTON
    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, self.onOptionMouseDown);
    self.backButton.internal = "BACK"
    self.backButton:initialise()
    self.backButton:instantiate()
    self.backButton:setAnchorLeft(true)
    self.backButton:setAnchorTop(false)
    self.backButton:setAnchorBottom(true)
    self.backButton:enableCancelColor()
    self:addChild(self.backButton)

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_play"))
    self.playButton = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_play"), self, self.onOptionMouseDown);
    self.playButton.internal = "NEXT"
    self.playButton:initialise()
    self.playButton:instantiate()
    self.playButton:setAnchorLeft(false)
    self.playButton:setAnchorRight(true)
    self.playButton:setAnchorTop(false)
    self.playButton:setAnchorBottom(true)
    self.playButton:setEnable(true)
    self.playButton:setSound("activate", "UIActivatePlayButton")
    self.playButton:enableAcceptColor()
    self:addChild(self.playButton);

    local y = UI_BORDER_SPACING + 1 + FONT_HGT_TITLE + 8

    self.infoPanel = ISRichTextPanel:new(UI_BORDER_SPACING+1, y, self:getWidth() - (UI_BORDER_SPACING * 2) - 2, self:getHeight() - (UI_BORDER_SPACING * 2) - 2)
    self.infoPanel:setAnchorLeft(true)
    -- self.infoPanel:setAnchorTop(true)
    self.infoPanel:setAnchorBottom(true)
    self.infoPanel.drawBorder = false
    self.infoPanel.backgroundColor = {r=0.9, g=0.1, b=0, a=0.4}
    self.infoPanel:initialise()
    self.infoPanel:instantiate()
    self.infoPanel:addScrollBars(false)
    self.infoPanel:paginate()
    self:addChild(self.infoPanel)
    -- self.infoPanel:addScrollBars()
    self.infoPanel:paginate()
    self.infoPanel:setText("It is recommended that you make a frequent backup of your save file. One of the reasons is that you will have only one life and no ability to respawn. But also game crashes may lead to save file corruption, and you will have no way to recover your progress. Your save files are located in the Zomboid/Saves directory. ")

    y = self.infoPanel:getBottom() + (2 * FONT_HGT_SMALL) + (2 * UI_BORDER_SPACING)

  
    self.settingsLabel = ISLabel:new(UI_BORDER_SPACING+1 + 20, y, BUTTON_HGT, "Settings", 1, 1, 1, 1, UIFont.Medium, true)
    self.settingsLabel:initialise()
    self.settingsLabel:instantiate()
    self:addChild(self.settingsLabel)

    self.falloutLabel = ISLabel:new(LABEL_WIDTH + CONTROL_WIDTH + (2 * UI_BORDER_SPACING) + 80, y, BUTTON_HGT, "Fallout Curve", 1, 1, 1, 1, UIFont.Medium, true)
    self.falloutLabel:initialise()
    self.falloutLabel:instantiate()
    self:addChild(self.falloutLabel)

    local leftX = LABEL_WIDTH
    y = self.settingsLabel:getBottom() + UI_BORDER_SPACING

    local settingsTable = ServerSettingsScreen.getSandboxSettingsTable()
    self.controls = {}

    self.maxLabelWidth = 0
    for _, page in ipairs(settingsTable) do
        for _, setting in ipairs(page.settings) do
            if setting.name:startsWith("BWOA") then
                local settingName = setting.translatedName
                local labelWidth = getTextManager():MeasureStringX(UIFont.Small, settingName)
                self.maxLabelWidth = math.max(self.maxLabelWidth, labelWidth)
                local settingKey = setting.name:match("%.(.*)")
                local tooltip = setting.tooltip
                if tooltip then
                    tooltip = tooltip:gsub("\\n", "\n")
                    tooltip = tooltip:gsub("\\\"", "\"")
                end
                if setting.type == "checkbox" then
                    local label = ISLabel:new(leftX - UI_BORDER_SPACING, y, BUTTON_HGT, settingName, 1, 1, 1, 1, UIFont.Small, false)
                    label:initialise()
                    label:instantiate()
                    self:addChild(label)

                    local control = ISTickBox:new(leftX, y, CONTROL_WIDTH, BUTTON_HGT, "", self, self.onTickBoxSelected, settingKey)
                    control:addOption("")
                    control.type = "checkbox"
                    control.selected[1] = SandboxVars.BWOA[settingKey]
                    if setting.tooltip then
                        control.tooltip = tooltip
                    end
                    self:addChild(control)
                    self.controls[setting.name] = control
                elseif setting.type == "enum" then
                    local label = ISLabel:new(leftX - UI_BORDER_SPACING, y, BUTTON_HGT, settingName, 1, 1, 1, 1, UIFont.Small, false)
                    label:initialise()
                    label:instantiate()
                    self:addChild(label)

                    local control = ISComboBox:new(leftX, y, CONTROL_WIDTH, BUTTON_HGT, self, self.onComboBoxSelected, settingKey)
                    if tooltip then
                        control.tooltip = { defaultTooltip = tooltip }
                    end
                    control:initialise()
                    control.type = "enum"
                    for index, value in ipairs(setting.values) do
                        control:addOption(value)
                        if index == SandboxVars.BWOA[setting.name:match("%.(.*)")] then
                            control.selected = index
                        end
                    end
                    self:addChild(control)
                    self.controls[setting.name] = control
                end
                y = y + FONT_HGT_MEDIUM + UI_BORDER_SPACING
            end
        end
    end


    -- DISABLE BUTTON
    self:disableBtn();
end

function ArkSettingsMain.onResolutionChange(oldw, oldh, neww, newh)
    if not MainScreen.instance then return end
	local self = MainScreen.instance

    local uis = {
        { self.arkSettingsMain, 0.7, 0.8 },
    }

    for _,ui in ipairs(uis) do
		if ui[1] and ui[1].javaObject and instanceof(ui[1].javaObject, 'UIElement') then
			local width = neww * ui[2]
			local height = newh * ui[3]
			if neww <= 1024 then
				width = neww * 0.95
				height = newh * 0.95
			end
			ui[1]:setWidth(width)
			ui[1]:setHeight(height)
			ui[1]:setX((neww - width) / 2)
			ui[1]:setY((newh - height) / 2)
			ui[1]:recalcSize()
		end
	end

    local width = self.arkSettingsMain:getWidth() - (UI_BORDER_SPACING * 2) - 2
    local height = self.arkSettingsMain:getHeight() - (UI_BORDER_SPACING * 2) - 2
    self.arkSettingsMain.infoPanel:setWidth(width)
    self.arkSettingsMain.infoPanel:setHeight(height)

end

function ArkSettingsMain:disableBtn()
    -- May be called during creation
    
end

function ArkSettingsMain:onOptionMouseDown(button, x, y)
    local joypadData = JoypadState.getMainMenuJoypad() or CoopCharacterCreation.getJoypad()
    if button.internal == "BACK" then
        self:setVisible(false)
        MainScreen.instance.charCreationMain:setVisible(true, joypadData);
    end
    
    if button.internal == "NEXT" then
        --        MainScreen.instance.charCreationMain:setVisible(false);
        --        MainScreen.instance.charCreationMain:removeChild(MainScreen.instance.charCreationHeader);
        --        MainScreen.instance.charCreationProfession:addChild(MainScreen.instance.charCreationHeader);
        --        MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus);

        -- saettings copy to sandbox


        -- override sandbox settings here
        SandboxVars.StartMonth = 11
        SandboxVars.StartDay = 9
        SandboxVars.StartTime = 5
        SandboxVars.TimeSinceApo = 100
        SandboxVars.ElecShut = 1
        SandboxVars.NatureAbundance = 1
        SandboxVars.FishAbundance = 1
        SandboxVars.FarmingSpeedNew = 2
        SandboxVars.KillInsideCrops = false
        SandboxVars.PlantGrowingSeasons = false
        SandboxVars.PlaceDirtAboveground = true
        SandboxVars.Helicopter = 1
        SandboxVars.Alarm = 1   
        SandboxVars.ErosionDays = 1000
        SandboxVars.EnableSnowOnGround = false
        SandboxVars.MaximumFireFuelHours = 24
        SandboxVars.BloodLevel = 5
        SandboxVars.SurvivorHouseChance = 1
        SandboxVars.VehicleStoryChance = 1
        SandboxVars.ZoneStoryChance = 1

        SandboxVars.ZombieLore.Memory = 1
        SandboxVars.ZombieLore.Sight = 1
        SandboxVars.ZombieLore.Hearing = 1
        SandboxVars.ZombieLore.Cognition = 1
        SandboxVars.ZombieLore.CrawlUnderVehicle = 7

        SandboxVars.Basement.SpawnFrequency = 7 -- always
       

        MainScreen.instance.charCreationMain:setVisible(false)

        -- set up the world
        if not getWorld():getMap() then
            getWorld():setMap("Muldraugh, KY");
        end
        if MainScreen.instance.createWorld then
            createWorld(getWorld():getWorld())
        end
        GameWindow.doRenderEvent(false);

        forceChangeState(LoadingQueueState.new());
    end

    self:disableBtn();
end

function ArkSettingsMain:update()
    ISPanel.update(self)
end

function ArkSettingsMain:prerender()
    ArkSettingsMain.instance = self
    ISPanel.prerender(self);
    self:drawTextCentre("Welcome to the Ark", self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title);

    -- plotter
    local TEMP_LERP = -50
    local RAD_LERP = 5000
    local FALLOUT_START = BWOAClimate.falloutStartedOptionMap[SandboxVars.BWOA.FalloutStarted]
    local FALLOUT_END = BWOAClimate.falloutEndsOptionMap[SandboxVars.BWOA.FalloutEnds]
    local PEAK_POINT = BWOAClimate.falloutCurveOptionMap[SandboxVars.BWOA.FalloutCurve]

    local ax = LABEL_WIDTH + CONTROL_WIDTH + (2 * UI_BORDER_SPACING) + 100
    local ay = self.settingsLabel:getBottom() + UI_BORDER_SPACING
    local w = self:getWidth() - ax - (UI_BORDER_SPACING * 2)
    local h = 5 * (FONT_HGT_MEDIUM + UI_BORDER_SPACING)
    local back = 60
    local resolution = 24
    -- self:drawLine2(ax, ay, ax, ay + h, 1, 1, 1, 1)

    -- Y AXIS
    local ytick = {}
    for i = 1, 5 do
        if i == 1 then
            table.insert(ytick, "mrad/min")
        else
            table.insert(ytick, RAD_LERP * (6 - i) / 5)
        end
    end

    local i = 0
    for _, v in ipairs(ytick) do
        local y = ay + (i * (FONT_HGT_MEDIUM + UI_BORDER_SPACING))
        self:drawRectBorder(ax, y, w, 1, 1, 0.2, 0.2, 0.2) -- y axis tick
        self:drawTextRight(tostring(v), ax - 10, y - (FONT_HGT_MEDIUM / 2) + 3, 0.5, 0.5, 0.5, 1, UIFont.Small)
        i = i + 1
    end
    self:drawRectBorder(ax, ay, 1, h, 1, 1, 1, 1) -- y axis main

    -- X AXIS
    local i = 0
    local j = -math.floor(back/30)
    for wa = 0, w/30, 1 do

        local x = ax + i
        self:drawRectBorder(x, ay, 1, h, 1, 0.2, 0.2, 0.2) -- x axis tick
        self:drawTextCentre(tostring(j), x, ay + h + 10, 0.5, 0.5, 0.5, 1, UIFont.Small)
        i = i + 30
        j = j + 1
    end

    self:drawRectBorder(ax, ay + h, w, 1, 1, 1, 1, 1) -- x axis main

    -- STARTING POINT
    self:drawRectBorder(ax + back, ay, 1, h, 1, 1, 0.3, 0.3) -- y axis zero

    -- PLOT
    local i = 0
    for wa = -back * resolution, (w-back) * resolution, resolution do
        local radiation, overrideTemp = BWOAClimate.GetRadiationAndTemp(wa, FALLOUT_START, FALLOUT_END, PEAK_POINT, RAD_LERP, TEMP_LERP)
        local x = ax + i
        local y = ay + h - ((radiation / RAD_LERP) * h)
        self:drawRect(x, y, 2, 2, 1, 0.5, 1, 0.5)
        i = i + 1
    end


end

function ArkSettingsMain:render()
    ISPanel.render(self)
    local playerNum = 0
    self:renderJoypadNavigateOverlay(playerNum)
end

function ArkSettingsMain:onGainJoypadFocus(joypadData)
    if self:isDescendant(joypadData.switchingFocusFrom) then
        ISPanelJoypad.onGainJoypadFocus(self, joypadData);
        self:setISButtonForA(self.playButton);
        self:setISButtonForB(self.backButton);
        self:loadJoypadButtons(joypadData);
    else
        self:loadJoypadButtons(joypadData);
        joypadData.focus = self.characterPanel
        updateJoypadFocus(joypadData)
    end
end

function ArkSettingsMain:onLoseJoypadFocus(joypadData)
    self.playButton:clearJoypadButton()
    self.backButton:clearJoypadButton()
--    self:clearJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function ArkSettingsMain:requiredSize(panel)
    local xMax = 0
    local yMax = 0
    local children = panel:getChildren()
    for _,child in pairs(children) do
    if child.Type ~= "ISRect" and child.Type ~= "ISScrollBar" then
--    if child:getRight() > xMax then print(child.x, child.width, child.x + child.width, child.Type) end
        xMax = math.max(xMax, child:getRight())
        yMax = math.max(yMax, child:getBottom())
--        child:setVisible(true)
    end
    end
    return xMax,yMax
end

function ArkSettingsMain:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self.backButton:forceClick()
        return
    end
    if key == Keyboard.KEY_RETURN then
        self.playButton:forceClick()
        return
    end
end

function ArkSettingsMain:new (x, y, width, height)
    local o = {};
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.x = x;
    o.y = y;
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=1, g=1, b=1, a=0.5};
    o.itemheightoverride = {};
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.colorPanel = {};
    o.rArrow = getTexture("media/ui/ArrowRight.png");
    o.disabledRArrow = getTexture("media/ui/ArrowRight_Disabled.png");
    o.lArrow = getTexture("media/ui/ArrowLeft.png");
    o.disabledLArrow = getTexture("media/ui/ArrowLeft_Disabled.png");
    ArkSettingsMain.instance = o;
    return o;
end

Events.OnResolutionChange.Add(ArkSettingsMain.onResolutionChange)
