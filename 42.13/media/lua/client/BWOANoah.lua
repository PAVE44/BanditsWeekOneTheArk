local function show()
    if not BWOANoah.shown then
        local screenWidth, screenHeight = getCore():getScreenWidth(), getCore():getScreenHeight()
        local modalWidth, modalHeight = 820, 688
        local modalX = (screenWidth / 2) - (modalWidth / 2)
        local modalY = (screenHeight / 2) - (modalHeight / 2)
        local text = BWOANoah.Screens[BWOANoah.screen](BWOANoah.screenData)

        modal = UINoah:new(modalX, modalY, modalWidth, modalHeight)
        modal:initialise()
        modal:setText(text)
        modal:addToUIManager()
        BWOANoah.modal = modal
        BWOANoah.shown = true
    end
end

local function close()
    if BWOANoah.shown and BWOANoah.modal then
        BWOANoah.modal:close()
        BWOANoah.shown = false
        BWOANoah.modal = nil
    end
end

local function loadScreen()
    if BWOANoah.shown and BWOANoah.modal then 
        local text = BWOANoah.Screens[BWOANoah.screen](BWOANoah.screenData)
        BWOANoah.modal:setText(text)
    end
end

local function onPlayerUpdate(player)
    local px, py = player:getX(), player:getY()
    if math.abs(px - BWOARooms.Control.noah.x) > 3 or math.abs(py - BWOARooms.Control.noah.y) > 3 then
        close()
    end
end

local function onKeyPressed(keynum)
    local gmd = GetBWOAModData()
    local ventilation = gmd.ventilation

    if BWOANoah.shown and BWOANoah.modal then 
        getSpecificPlayer(0):playSound("UIKey")
    end

    if BWOANoah.screen == "Main" then
        if keynum == Keyboard.KEY_1 then
            BWOANoah.screen = "Power"
        elseif keynum == Keyboard.KEY_2 then
            BWOANoah.screen = "Atmospheric"
        elseif keynum == Keyboard.KEY_3 then
            BWOANoah.screen = "Hydraulics"
        elseif keynum == Keyboard.KEY_4 then
            BWOANoah.screen = "Environmental"
        elseif keynum == Keyboard.KEY_5 then
        elseif keynum == Keyboard.KEY_6 then
            BWOANoah.screen = "Alarms"
        elseif keynum == Keyboard.KEY_9 then
            close()
            return
        end
    elseif BWOANoah.screen == "Power" then
        if keynum == Keyboard.KEY_1 then
            BWOANoah.screen = "Generator"
            BWOANoah.screenData = {id=1}
        elseif keynum == Keyboard.KEY_2 then
            BWOANoah.screen = "Generator"
            BWOANoah.screenData = {id=2}
        elseif keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Main"
        end
    elseif BWOANoah.screen == "Generator" then
        if keynum == Keyboard.KEY_1 then
            BWOANoah.screen = "GeneratorManual"
        elseif keynum == Keyboard.KEY_2 then
            BWOANoah.screen = "GeneratorToggle"
        elseif keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Power"
        end
    elseif BWOANoah.screen == "GeneratorManual" then
        if keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Generator"
        end
    elseif BWOANoah.screen == "GeneratorToggle" then
        if keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Generator"
        end
    elseif BWOANoah.screen == "Atmospheric" then
        if keynum == Keyboard.KEY_1 then
            BWOANoah.screen = "Ventilation"
        elseif keynum == Keyboard.KEY_2 then
            BWOANoah.screen = "Heating"
        elseif keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Main"
        end
    elseif BWOANoah.screen == "Ventilation" then
        if keynum == Keyboard.KEY_1 then
            ventilation.active = not ventilation.active
        elseif keynum == Keyboard.KEY_2 then
            ventilation.open = not ventilation.open
        elseif keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Atmospheric"
        end
    elseif BWOANoah.screen == "Heating" then
        if keynum == Keyboard.KEY_1 then
            ventilation.heating = not ventilation.heating
        elseif keynum == Keyboard.KEY_2 then
            ventilation.tempTarget = ventilation.tempTarget - 0.5
            if ventilation.tempTarget < 4 then
                ventilation.tempTarget = 4
            end
        elseif keynum == Keyboard.KEY_3 then
            ventilation.tempTarget = ventilation.tempTarget + 0.5
            if ventilation.tempTarget > 26 then
                ventilation.tempTarget = 26
            end
        elseif keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Atmospheric"
        end
    elseif BWOANoah.screen == "Hydraulics" then
        if keynum == Keyboard.KEY_1 then
            BWOANoah.screen = "PumpManual"
        elseif keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Main"
        end
    elseif BWOANoah.screen == "PumpManual" then
        if keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Generator"
        end
    elseif BWOANoah.screen == "Environmental" then
        if keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Main"
        end
    elseif BWOANoah.screen == "Alarms" then
        if keynum == Keyboard.KEY_1 then
            if BWOABaseAPI.alarm then
                BWOABaseAPI.AlarmOff()
            else
                BWOABaseAPI.AlarmOn()
            end
        elseif keynum == Keyboard.KEY_2 then
            BWOANoah.screen = "AlarmsManual"
        elseif keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Main"
        end
    elseif BWOANoah.screen == "AlarmsManual" then
        if keynum == Keyboard.KEY_9 then
            BWOANoah.screen = "Alarms"
        end
    end
    loadScreen()
end

local function everyOneMinute()
    loadScreen()
end


BWOANoah = BWOANoah or {}
BWOANoah.shown = false
BWOANoah.screen = "Main"
BWOANoah.screenData = {}

BWOANoah.Show = function()
    show()
end

BWOANoah.Screens = {}

BWOANoah.ScreenTemplate = function()
    local text = {}
    for i=1, 25 do
        text[i] = ""
    end

    text[1] = "           *** NOAH V1.2. ***      "
    text[2] = "      (C)1983 ADVANCED CYBERNETICS "
    return text
end

BWOANoah.Screens.Main = function()
    local text = BWOANoah.ScreenTemplate()
    text[5] = "OPTIONS:"
    text[7] = "1. POWER CONTROL"
    text[9] = "2. ATMOSPHERIC REGULATION"
    text[11] = "3. HYDRAULICS"
    text[13] = "4. ENVIRONMENTAL REPORT"
    text[15] = "5. ACCESS CONTROL"
    text[17] = "6. ALARMS"
    text[25] = "9. EXIT"
    return text
end

-- POWER SCREENS -- 

BWOANoah.Screens.Power = function()
    local text = BWOANoah.ScreenTemplate()
    text[5]  = "POWER CONTROL"

    text[7]  = "> GRID:  ACTIVE"
    text[8]  = "> USAGE: " .. string.format("%.2f", BWOABaseControl.gridPowerUsing) .. "L/h"

    text[11]  = "SELECT UNIT:"
    text[12]  = "1. MAIN: MASS-GENFAC GX-9"
    text[13]  = "2. BCKP: MASS-GENFAC GX-9"

    text[25] = "9. RETURN"

    return text
end

BWOANoah.Screens.Generator = function(data)
    local gmd = GetBWOAModData()

    local text = BWOANoah.ScreenTemplate()

    local key
    if data.id == 1 then
        text[5]  = "MAIN: MASS-GENFAC GX-9"
        key = "main"
    else
        text[5]  = "BCKP: MASS-GENFAC GX-9"
        key = "backup"
    end

    local generator = gmd.generators[key]

    if generator.active then
        text[7]  = "> STATUS:    ON"
    else
        text[7]  = "> STATUS:    OFF"
    end

    text[8]  = "> CONDITION: " .. string.format("%.1f", generator.condition) .. "%"
    text[9]  = "> FUEL:      " .. string.format("%.1f", generator.fuel) .. "%"

    text[11]  = "OPTIONS:"
    text[12]  = "1. INSTRUCTION MANUAL"

    if generator.active then
        text[13]  = "2. SHUT DOWN"
        BWOANoah.screenData = {id = data.id, startUp = false, shutDown = true}
    else
        text[13]  = "2. START-UP"
        BWOANoah.screenData = {id = data.id, startUp = true, shutDown = false}
    end

    text[25] = "9. RETURN"

    return text
end

BWOANoah.Screens.GeneratorManual = function(data)
    local text = BWOANoah.ScreenTemplate()
    text[5]   = "MASS-GENFAC COMBUSTION GENERATOR      "
    text[6]   = "MODEL: GX-9 TYPE: UNLEADED GASOLINE   "
    text[7]   = "MANUFACTURER: MASS-GENFAC CO.         "
    text[8]   = "VERSION: FIELD EDITION V1.4           "
    text[10]  = "The GX-9 is a heavy-duty,             "
    text[11]  = "gasoline-powered generator designed   "
    text[12]  = "for isolated / underground facilities."
    text[13]  = "It provides continuous AC output to   "
    text[14]  = "bunker grid systems and auxiliary     "
    text[15]  = "modules."
    text[16]  = "Warning: failure to maintain the GX-9 "
    text[17]  = "may result in sudden shutdowns, power "
    text[18]  = "loss. In severe cases, neglect may    "
    text[19]  = "cause the generator to ignite!        "
    text[23]  = "OPTIONS:        "
    text[25]  = "9. RETURN"
    return text
end

BWOANoah.Screens.GeneratorToggle = function(data)
    local gmd = GetBWOAModData()

    local text = BWOANoah.ScreenTemplate()

    local key
    if data.id == 1 then
        text[5]  = "MAIN: MASS-GENFAC GX-9"
        key = "main"
    else
        text[5]  = "BCKP: MASS-GENFAC GX-9"
        key = "backup"
    end

    local generator = gmd.generators[key]

    if data.shutDown then
        if generator.active then
            text[7]  = "SHUT DOWN: AWAITING..."
            generator.active = false
        else
            text[7]  = "SHUT DOWN: SUCCESS."
        end
    elseif data.startUp then
        if generator.fuel > 0 and generator.condition > 3 then
            if not generator.active then
                BWOASound.PlayLocation({
                    sound = "AmbientGeneratorStart",
                    x = generator.x,
                    y = generator.y,
                    z = generator.z
                })
                text[7]  = "START-UP: AWAITING..."
                generator.active = true
            else
                text[7]  = "START-UP: SUCCESS."
            end
        else
            text[7]  = "START-UP: FAIL."
        end
    end

    text[23]  = "OPTIONS:        "
    text[25]  = "9. RETURN"
    return text
end

-- VENTILLATION SCREENS -- 

BWOANoah.Screens.Atmospheric = function()
    local text = BWOANoah.ScreenTemplate()
    text[5]  = "ATMOSPHERIC REGULATION"

    text[7]  = "SELECT UNIT:"
    text[8]  = "1. CIRCUAIR HE-3 Module Ventilation"
    text[9]  = "2. CIRCUAIR HE-3 Module Heating"

    text[25] = "9. RETURN"
    return text
end

BWOANoah.Screens.Ventilation = function()

    BWOADialogues.Reveal("Emma_Robinson", "100.2")

    local gmd = GetBWOAModData()

    local ventilation = gmd.ventilation

    local text = BWOANoah.ScreenTemplate()
    text[5]  = "CIRCUAIR HE-3: VENTILATION"

    if ventilation.active then
        text[6] = "> STATUS:               ON"
    else
        text[6] = "> STATUS:               OFF"
    end

    if ventilation.open then
        text[7] = "> EXTERNAL AIR VALVE:   OPEN"
    else
        text[7] = "> EXTERNAL AIR VALVE:   CLOSED"
    end

    text[8] = "> CO2:                  " .. string.format("%05.0f", ventilation.co2) .. " ppm"
    text[9] = "> FILTER:              " .. string.format("%04.1f", ventilation.filter) .. "%"

    text[11] = "OPTIONS:"
    if ventilation.active then
        text[12]  = "1. SHUT DOWN"
    else
        text[12]  = "1. START-UP"
    end

    if ventilation.open then
        text[13]  = "2. CLOSE EXTERNAL AIR VALVE"
    else
        text[13]  = "2. OPEN EXTERNAL AIR VALVE"
    end

    text[25] = "9. RETURN"

    return text
end

BWOANoah.Screens.Heating = function()
    local gmd = GetBWOAModData()

    local ventilation = gmd.ventilation

    local text = BWOANoah.ScreenTemplate()
    text[5]  = "CIRCUAIR HE-3: HEATING"

    if ventilation.heating then
        text[6] = "> STATUS:             ON"
    else
        text[6] = "> STATUS:             OFF"
    end

    local temp = ventilation.temp
    local tempTarget = ventilation.tempTarget
    local tempSuffix = "C"
    if not getCore():getOptionDisplayAsCelsius() then
        temp = Temperature.CelsiusToFahrenheit(temp)
        tempTarget = Temperature.CelsiusToFahrenheit(tempTarget)
        tempSuffix = "F"
    end

    text[7] = "> TEMPERATURE SENSOR: " .. string.format("%.1f", temp) .. tempSuffix
    text[8] = "> TEMPERATURE TARGET: " .. string.format("%.1f", tempTarget) .. tempSuffix

    text[10]  = "OPTIONS:"

    if ventilation.heating then
        text[11]  = "1. DISABLE"
        text[12]  = "2. TEMPERATURE (-)"
        text[13]  = "3. TEMPERATURE (+)"
    else
        text[11]  = "1. ENABLE"
    end

    text[25] = "9. RETURN"

    return text
end

BWOANoah.Screens.Probes = function()
    local text = BWOANoah.ScreenTemplate()
    return text
end

-- WATER SCREENS -- 

BWOANoah.Screens.Hydraulics = function(data)
    local gmd = GetBWOAModData()

    local text = BWOANoah.ScreenTemplate()

    text[5]  = "MAIN: HydroCore DeepDraw 1200"
    text[7]  = "> STATUS:    CONNECTION TIMEOUT"

    text[8]  = "> CONDITION: ERROR"
    text[9]  = "> FUEL:      ERROR"

    text[11]  = "OPTIONS:"
    text[12]  = "1. INSTRUCTION MANUAL"

    text[25] = "9. RETURN"

    return text
end

BWOANoah.Screens.PumpManual = function(data)
    local text = BWOANoah.ScreenTemplate()
    text[5]   = "HYDROCORE WATER PUMP                  "
    text[6]   = "MODEL: DEEPDRAW-1200                  "
    text[7]   = "MANUFACTURER: HYDROCORE LIMITED       "
    text[8]   = "VERSION: SUBTERRANEAN                 "
    text[10]  = "The DeepDraw-1200 is a heavy-duty,    "
    text[11]  = "externally powered water pump designed"
    text[12]  = "for isolated / underground facilities."
    text[13]  = "Engineered to access deep Oligocene   "
    text[14]  = "aquifer reserves. Integrated treatment"
    text[15]  = "and fiiltration system available.     "
    text[16]  = "Warning: failure to maintain the pump "
    text[17]  = "may result in efficiency loss, sudden "
    text[18]  = "shutdowns. In severe cases, neglect   "
    text[19]  = "may cause the water pump to ignite!   "
    text[23]  = "OPTIONS:        "
    text[25]  = "9. RETURN"
    return text
end

BWOANoah.Screens.Environmental = function()
    local text = BWOANoah.ScreenTemplate()
    local gmd = GetBWOAModData()
    local ventilation = gmd.ventilation
    local cm = getClimateManager()

    local temp = cm:getClimateFloat(4):getOverride()
    local tempSuffix = "C"

    local windSpeed = cm:getMaxWindspeedKph()
    local windSpeedSuffix = "km/h"

    local fogIntensity = cm:getFogIntensity() * 100

    local radiation = BWOAClimate.radiation
    
    if not getCore():getOptionDisplayAsCelsius() then
        temp = Temperature.CelsiusToFahrenheit(temp)
        tempSuffix = "F"
        windSpeed = cm:getMaxWindspeedMph()
        windSpeedSuffix = "m/h"
    end

    text[5]   = "SURFACE CONDITION REPORT              "
    text[7]   = "TEMPERATURE:   " .. string.format("%.1f", temp) .. tempSuffix
    text[8]   = "WIND SPEED:    " .. string.format("%.1f", windSpeed) .. windSpeedSuffix
    text[9]   = "FOG INTENSITY: " .. string.format("%.1f", fogIntensity) .. "%"
    text[10]   = "RADIATION:     " .. string.format("%.1f", radiation) .. "mR"
    text[25]  = "9. RETURN"
    return text
end

BWOANoah.Screens.Alarms = function()
    local text = BWOANoah.ScreenTemplate()
    text[5]  = "ALARMS"

    if BWOABaseAPI.alarm then
        text[7]  = "STATUS: ON"
    else
        text[7]  = "STATUS: OFF"
    end

    text[8]  = "HAZARD SENSORS: FIRE, BIO"
    text[10]  = "OPTIONS:"

    if BWOABaseAPI.alarm then
        text[11]  = "1. CANCEL ALARM"
    else
        text[11]  = "1. SOUND ALARM"
    end
    text[12]  = "2. INSTRUCTION MANUAL"

    text[25] = "9. RETURN"
    return text
end

BWOANoah.Screens.AlarmsManual = function(data)
    local text = BWOANoah.ScreenTemplate()
    text[5]   = "AUTOMATIC ALARM MODULE                "
    text[7]   = "Central alerting module is aggregating"
    text[8]  = "multiple sensors data for anomaly     "
    text[9]  = "detection. In case of anomaly audiable"
    text[10]  = "alarm is activated to alert the       "
    text[11]  = "inhabitants and voice messaging system"
    text[12]  = "informs about the nature of the       "
    text[13]  = "threat. Should the alarm get          "
    text[14]  = "activated, use central console for    "
    text[15]  = "manual deactivation only if the threat"
    text[16]  = "has been averted. "
    text[23]  = "OPTIONS:        "
    text[25]  = "9. RETURN"
    return text
end

-- CLIMATE SCREENS -- 

-- SECURITY SCREENS -- 


Events.OnPlayerUpdate.Remove(onPlayerUpdate)
Events.OnPlayerUpdate.Add(onPlayerUpdate)

Events.EveryOneMinute.Remove(everyOneMinute)
Events.EveryOneMinute.Add(everyOneMinute)

Events.OnKeyPressed.Remove(onKeyPressed)
Events.OnKeyPressed.Add(onKeyPressed)

    