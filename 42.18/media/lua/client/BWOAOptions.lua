BWOAOptions = BWOAOptions or {}

local options = PZAPI.ModOptions:create("BanditsWeekOneTheArk", getText("UI_optionscreen_BWOA_TheArk"))
options:addTitle(getText("UI_optionscreen_BWOA_TheArk"))

-- talk option
options:addKeyBind("TALK", getText("UI_optionscreen_BWOA_Talk"), Keyboard.KEY_T, getText("UI_optionscreen_BWOA_Talk"))
