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
    local vtype = "Base.pzkPostapoTanker"

    local vehicle = addVehicle(vtype, x, y, z)
    if not vehicle then return end

    vehicle:setGeneralPartCondition(0.4, 0)
    vehicle:setRust(100)

    for i = 0, vehicle:getPartCount() - 1 do
        local container = vehicle:getPartByIndex(i):getItemContainer()
        if container then
            container:removeAllItems()
        end
    end

    vehicle:addKeyToGloveBox()
    
    local md = vehicle:getModData()
    md.BWOA = {}
    md.BWOA.fuel = 982
    -- vehicle:putKeyInIgnition(vehicle:createVehicleKey())

    local partNames = {"DoorFrontLeft", "DoorFrontRight"}
    for _, partName in ipairs(partNames) do
        local part = vehicle:getPartById(partName)
        if part then
            local door = part:getDoor()
            if door then
                door:setLockBroken(false)
            end
        end
    end
end

function BWOAScenes.FuelTruck:populate()

end
