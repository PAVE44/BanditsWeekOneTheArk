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

    if not globalData.decontaminator then 
        globalData.decontaminator = {
            x = 9948,
            y = 12622,
            z = -5,
            concentration = 85,
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

    if not globalData.arkNetwork then 
        globalData.arkNetwork = {
            { -- Kentucky Ohio River Ark (PLAYER),
                id = 46,
                lat = 37.8825,
                long = -86.0059,
                player = true,
                dist = 0,
                status = 0, -- 0 = concealed, 1 = declared, 2 = offline
                changed = 0,
            },
            { -- Southern Indiana Ark, 
                id = 47,
                lat = 38.5432, 
                long = -86.1794,
                dist = 55,
                status = 0,
                changed = 0,
            },
            { -- Eastern Kentucky Appalachian Ark
                id = 48,
                lat = 37.3467,
                long = -83.2895,
                dist = 170,
                status = 2,
                changed = 0,
            },
            { -- Western West Virginia Ark
                id = 49,
                lat = 38.2215,
                long = -81.7983,
                dist = 230,
                status = 0,
                changed = 0,
            },
            { -- Southern Illinois Shawnee Ark
                id = 50,
                lat = 37.5194,
                long = -88.6782,
                dist = 170,
                status = 0,
                changed = 0,
            },
            { -- Western Virginia Blue Ridge Ark
                id = 51,
                lat = 37.4831,
                long = -79.6420,
                dist = 350,
                status = 2,
                changed = 0,
            },
            { -- Northern Georgia Mountain Ark
                id = 52,
                lat = 34.8962,
                long = -84.3177,
                dist = 320,
                status = 1,
                changed = 0,
                raidAgeStart = 300,
                raidAgeEnd = 4000
            },
            { -- Central Pennsylvania Ridge Ark
                id = 53,
                lat = 40.4804,
                long = -77.9021,
                dist = 450,
                status = 2,
                changed = 0,
            },
        }
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
