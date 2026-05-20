require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Plane = BWOAScenes.Abstract:derive("BWOAScenes.Plane")

function BWOAScenes.Plane:placeObjects()
    local x, y, z = self.x, self.y, self.z

    -- bookshelf

end

function BWOAScenes.Plane:placeItems()
    local x, y, z = self.x, self.y, self.z

end

function BWOAScenes.Plane:placeCorpses()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Plane:placeVehicles()

    local function stopEngine(vehicle)
        local trunkPart = vehicle:getPartById("TrunkDoor")
        if trunkPart then
            local trunkDoor = trunkPart:getDoor()
            if trunkDoor then
                trunkDoor:setOpen(true)
            end
        end
    end

    local vehicles = {
        {type = "Base.pzkPlaneSection1", x = self.x, y = self.y, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection2", x = self.x -22, y = self.y, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection3", x = self.x -31, y = self.y, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection2", x = self.x -39, y = self.y, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection4", x = self.x -48, y = self.y, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingL2", x = self.x -34, y = self.y - 10, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingL1", x = self.x -34, y = self.y - 20, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingR2", x = self.x -34, y = self.y + 13, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingR1", x = self.x -34, y = self.y + 25, z = self.z, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneEngine", x = self.x -17, y = self.y + 13, z = self.z, angleOffset = -86, angleRand = 15, stopEngine = true},
        {type = "Base.pzkPlaneEngine", x = self.x -24, y = self.y + 19, z = self.z, angleOffset = -70, angleRand = 30, stopEngine = true},
    }
    
    for _, vehicle in ipairs(vehicles) do
        local part = addVehicle(vehicle.type, vehicle.x, vehicle.y, vehicle.z)
        part:setAngles(0, vehicle.angleOffset + ZombRand(vehicle.angleRand), 0)
        if vehicle.stopEngine then
            stopEngine(part)
        end
    end
end

function BWOAScenes.Plane:populate()
    local player = getSpecificPlayer(0)
end
