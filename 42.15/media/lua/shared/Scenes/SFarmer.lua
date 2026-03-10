require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Farmer = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Farmer:placeObjects()
    local x, y, z = self.x, self.y, self.z

    -- destroy neighbors house
    BanditUtils.ClearSpace(7157, 9681, 0, 14, 14)
    
    -- bookshelf

end

function BWOAScenes.Farmer:placeItems()
    local x, y, z = self.x, self.y, self.z

    -- farming books
    -- farming equipment [trowel, garden fork, watering can, sprays]
    -- seeds and seedbags
    -- farming magazines
    -- FishingHookBox
    -- exposure survival 3
    -- Farmer notebook
end

function BWOAScenes.Farmer:placeCorpses()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Farmer:placeVehicles()

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
        {type = "Base.pzkPlaneSection1", x = 7174, y = 9687, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection2", x = 7152, y = 9687, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection3", x = 7143, y = 9687, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection2", x = 7135, y = 9687, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneSection4", x = 7126, y = 9687, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingL2", x = 7140, y = 9677, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingL1", x = 7140, y = 9667, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingR2", x = 7140, y = 9700, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneWingR1", x = 7140, y = 9712, z = 0, angleOffset = -86, angleRand = 9},
        {type = "Base.pzkPlaneEngine", x = 7157, y = 9700, z = 0, angleOffset = -86, angleRand = 15, stopEngine = true},
        {type = "Base.pzkPlaneEngine", x = 7150, y = 9706, z = 0, angleOffset = -70, angleRand = 30, stopEngine = true},
    }
    
    for _, vehicle in ipairs(vehicles) do
        local part = addVehicle(vehicle.type, vehicle.x, vehicle.y, vehicle.z)
        part:setAngles(0, vehicle.angleOffset + ZombRand(vehicle.angleRand), 0)
        if vehicle.stopEngine then
            stopEngine(part)
        end
    end

    
    

end

function BWOAScenes.Farmer:populate()
    local player = getSpecificPlayer(0)
end
