require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.BarnCar = BWOAScenes.Abstract:derive("BWOAScenes.BarnCar")

function BWOAScenes.BarnCar:placeVehicles()

    local vtype = "Base.SportsCar_ez"

    local vehicle = addVehicle(vtype, 7249, 8346, 0)
    if not vehicle then return end

    vehicle:setGeneralPartCondition(0.9, 0)
    vehicle:setRust(100)
    vehicle:setAngles(0, 90, 0) -- to east
    vehicle:addKeyToGloveBox()

end

