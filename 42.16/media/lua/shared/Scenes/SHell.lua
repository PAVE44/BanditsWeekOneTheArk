require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Hell = BWOAScenes.Abstract:derive("BWOAScenes.Hell")

function BWOAScenes.Hell:placeObjects()
    BWOABuildTools.Generator(18001, 3810, -12, 100, 100, true, true, true)
    BWOABuildTools.Generator(18001, 3820, -12, 100, 100, true, true, true)
    BWOABuildTools.Generator(18001, 3830, -12, 100, 100, true, true, true)
    BWOABuildTools.Generator(18001, 3840, -12, 100, 100, true, true, true)
    BWOABuildTools.Generator(18019, 3810, -12, 100, 100, true, true, true)
    BWOABuildTools.Generator(18019, 3820, -12, 100, 100, true, true, true)
    BWOABuildTools.Generator(18019, 3830, -12, 100, 100, true, true, true)
    BWOABuildTools.Generator(18019, 3840, -12, 100, 100, true, true, true)
end

function BWOAScenes.Hell:placeItems()
end

function BWOAScenes.Hell:placeCorpses()
end

function BWOAScenes.Hell:placeVehicles()
end

function BWOAScenes.Hell:populate()
    BanditUtils.ClearZombies(18000, 18020, 3800, 3850)
end
