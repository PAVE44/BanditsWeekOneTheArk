require "BWOADialogues"
require "BWOAMissions"

BWOAGlobalData = {}

function InitBWOAModData(isNewGame)

    -- BANDIT GLOBAL MODDATA
    local globalData = ModData.getOrCreate("BanditWeekOneTheArk")
    if isClient() then
        ModData.request("BanditWeekOneTheArk")
    end

    if not globalData.noah then
        globalData.noah = true
    end

    if not globalData.generators then 
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
    end

    if not globalData.ventilation then 
        globalData.ventilation = {
            active = true,
            co2 = 884,
            filter = 88,
            heating = true,
            open = true,
            tempTarget = 21,
            temp = 21,
        }
    end

    if not globalData.airintakes then 
        globalData.airintakes = {
            [1] = {
                x = 9940, 
                y = 12633, 
                z = 0,
                broken = true,
            },
            [2] = {
                x = 9940, 
                y = 12634, 
                z = 0, 
                broken = false,
            },
            [3] = {
                x = 9941, 
                y = 12633, 
                z = 0, 
                broken = false,
            },
            [4] = {
                x = 9941, 
                y = 12634, 
                z = 0, 
                broken = false,
            }
        }
    end

    if not globalData.waterpump then 
        globalData.waterpump = {
            x = 9946,
            y = 12620,
            active = true,
        }
    end

    if not globalData.alerting then 
        globalData.alerting = {
            generatorFuelAlert = 10,
            generatorConditionAlert = 10,
            radiationAlert = 10,
            co2Alert = 10,
            waterPumpConditionAlert = 10,
        }
    end

    if not globalData.hatches then 
        globalData.hatches = {}
    end

    if not globalData.dialogues then 
        globalData.dialogues = BWOADialogues.dialogues
    end

    if not globalData.missions then 
        globalData.missions = BWOAMissions.missions
    end

    if not globalData.placeEvents then 
        globalData.placeEvents = BWOAPlaceEvents.events
    end

    if not globalData.itemMemoryRegain then 
        globalData.itemMemoryRegain = BWOAPlayer.itemMemoryRegain
    end

    if not globalData.permanentNPC then 
        globalData.permanentNPC = {}
    end

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
