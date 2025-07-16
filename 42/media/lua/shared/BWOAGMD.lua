BWOAGlobalData = {}

function InitBWOAModData(isNewGame)

    -- BANDIT GLOBAL MODDATA
    local globalData = ModData.getOrCreate("BanditWeekOneTheArk")
    if isClient() then
        ModData.request("BanditWeekOneTheArk")
    end
    
    -- if not globalData.generators then 
        globalData.generators = {
            main = {
                x = 9946,
                y = 12620,
                z = -4,
                fuel = 77,
                condition = 81,
                powerUsing = 0,
                active = true
            },
            backup = {
                x = 9946,
                y = 12616,
                z = -4,
                fuel = 20,
                condition = 90,
                powerUsing = 0,
                active = false
            }
        }
    -- end

    -- if not globalData.ventilation then 
        globalData.ventilation = {
            active = true,
            heating = true,
            open = true,
            tempTarget = 21,
            temp = 21,
        }
    -- end

    -- if not globalData.waterpump then 
    globalData.waterpump = {
        x = 9946,
        y = 12620,
        active = true,
    }
-- end

    -- if not globalData.control then 
    globalData.alerting = {
        generatorFuelAlert = 10,
        generatorConditionAlert = 10,
        radiationAlert = 10,
        co2Alert = 10,
        waterPumpConditionAlert = 10,
    }
-- end

    BWOAGlobalData = globalData

end

function LoadBWOAModData(key, globalData)
    if isClient() then
        if key and globalData then
            if key == "BanditWeekOneTheArk" then
                BWOAGlobalData = globalData
            end
        end
    end
end

function GetBWOAModData()
    return BWOAGlobalData
end

function TransmitBWOAModData()
    ModData.transmit("BanditWeekOneTheArk")
end


Events.OnInitGlobalModData.Add(InitBWOAModData)
Events.OnReceiveGlobalModData.Add(LoadBWOAModData)
