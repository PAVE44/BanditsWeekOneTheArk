require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.SecretLab = BWOAScenes.Abstract:derive("BWOAScenes.SecretLab")

function BWOAScenes.SecretLab:placeObjects()
    BWOARooms.SecretLab.Build()
end

function BWOAScenes.SecretLab:placeItems()
    BWOARooms.SecretLab.Prepare() 
end

function BWOAScenes.SecretLab:placeCorpses()
    BWOARooms.SecretLab.PrepareCorpses()
end

function BWOAScenes.SecretLab:placeVehicles()
end

function BWOAScenes.SecretLab:populate()
end
