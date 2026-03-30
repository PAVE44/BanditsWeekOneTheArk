require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.MirrorRoom = BWOAScenes.Abstract:derive("BWOAScenes.MirrorRoom")

function BWOAScenes.MirrorRoom:placeObjects()
    BWOABuildTools.Generator(18003, 3603, -4, 100, 100, true, true, true)

    BWOABuildTools.LampBatteryWeak(18003, 3604, -3, "lighting_indoor_02_45")
    BWOABuildTools.LampBatteryWeak(18001, 3602, -3, "lighting_indoor_02_44")

    local data = {r = 255, g = 80, b = 20, d=4}
    BWOABuildTools.LampCustom(18002, 3601, -3, "lighting_indoor_01_21", data)
    BWOABuildTools.LampCustom(18004, 3601, -3, "lighting_indoor_01_21", data)

    BWOABuildTools.LampBatteryWeak(18003, 3600, -3, "lighting_indoor_02_45")
    BWOABuildTools.LampBatteryWeak(18000, 3602, -3, "lighting_indoor_02_44")
    BWOABuildTools.LampBatteryWeak(18003, 3605, -3, "lighting_indoor_02_45")

end

function BWOAScenes.MirrorRoom:placeItems()
end

function BWOAScenes.MirrorRoom:placeCorpses()
end

function BWOAScenes.MirrorRoom:placeVehicles()
end

function BWOAScenes.MirrorRoom:populate()
    local player = getSpecificPlayer(0)
    BanditUtils.ClearZombies(18000, 18010, 3600, 3610)
end
