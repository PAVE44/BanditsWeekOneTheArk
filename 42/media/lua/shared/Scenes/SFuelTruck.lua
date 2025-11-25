require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.FuelTruck = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.FuelTruck:placeObjects()

end

function BWOAScenes.FuelTruck:placeItems()

end

function BWOAScenes.FuelTruck:placeCorpses()

end

function BWOAScenes.FuelTruck:placeVehicles()
    local x, y, z = self.x, self.y, self.z
    local vtype = "Base.PickUpTruckLightsFossoil"
    local data = {
        dir = IsoDirections.E,
        fuel = 50,
        condition = 30
    }
    BWOAPrepareTools.AddVehicle(x, y, z, vtype, data)
end

function BWOAScenes.FuelTruck:populate()

end
