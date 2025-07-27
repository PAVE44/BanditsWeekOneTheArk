BWOASquareLoader = BWOASquareLoader or {}

BWOASquareLoader.burnMap = {
    ["Base.CarLights"]        = "Base.CarNormalBurnt",
    ["Base.CarLuxury"]        = "Base.LuxuryCarBurnt",
    ["Base.NormalCarPolice"]  = "Base.NormalCarBurntPolice",
    ["Base.CarNormal"]        = "Base.CarNormalBurnt",
    ["Base.CarStationWagon"]  = "Base.CarNormalBurnt",
    ["Base.ModernCar"]        = "Base.ModernCar02Burnt",
    ["Base.ModernCar02"]      = "Base.SmallCar02Burnt",
    ["Base.SmallCar02"]       = "Base.SmallCar02Burnt",
    ["Base.CarSmall02"]       = "Base.SmallCar02Burnt",
    ["Base.SmallCar"]         = "Base.SmallCarBurnt",
    ["Base.CarSmall"]         = "Base.SmallCarBurnt",
    ["Base.SportsCar"]        = "Base.SportsCarBurnt",
    ["Base.OffRoad"]          = "Base.OffRoadBurnt",
    ["Base.LuxuryCar"]        = "Base.LuxuryCarBurnt",
    ["Base.SUV"]              = "Base.SUVBurnt",
    ["Base.Taxi"]             = "Base.TaxiBurnt",
    ["Base.CarTaxi"]          = "Base.TaxiBurnt",
    ["Base.CarTaxi2"]         = "Base.TaxiBurnt",
    ["Base.PickUpVanLights"]  = "Base.PickUpVanLightsBurnt",
    ["Base.PickUpVan"]        = "Base.PickUpVanBurnt",
    ["Base.VanAmbulance"]     = "Base.AmbulanceBurnt",
    ["Base.VanRadio"]         = "Base.VanRadioBurnt",
    ["Base.VanSeats"]         = "Base.VanSeatsBurnt",
    ["Base.Van"]              = "Base.VanBurnt",
    ["Base.StepVan"]          = "Base.VanBurnt",          -- has no better alternative
    ["Base.PickupSpecial"]    = "Base.PickupSpecialBurnt",
    ["Base.PickUpTruck"]      = "Base.PickupBurnt",
    ["Base.Pickup"]           = "Base.PickupBurnt",
}

local burnVehicle = function(vehicle)
    local burnMap = BWOASquareLoader.burnMap
    local scriptName = vehicle:getScriptName()
    if scriptName:embodies("Burnt") then return end

    for k, v in pairs(burnMap) do
        if scriptName:embodies(k) then
            local ax = vehicle:getAngleX()
            local ay = vehicle:getAngleY()
            local az = vehicle:getAngleZ()
            vehicle:permanentlyRemove()

            local vehicleBurnt = BanditUtils.AddVehicle(v, IsoDirections.S, vehicle:getSquare())
            if vehicleBurnt then
                for i = 0, vehicleBurnt:getPartCount() - 1 do
                    local container = vehicleBurnt:getPartByIndex(i):getItemContainer()
                    if container then
                        container:removeAllItems()
                    end
                end
                vehicleBurnt:getModData().BWO = {}
                vehicleBurnt:getModData().BWO.wasRepaired = true
                vehicleBurnt:setAngles(ax, ay, az)
            end
            break
        end
    end
end

local burnSquare = function(square)
    local x, y, z = square:getX(), square:getY(), square:getZ()
    if z < 0 then return end

    square:BurnWalls(false)
    local md = square:getModData()
    if not md.BWO then md.BWO = {} end
    md.BWO.burnt = true

    if BanditUtils.HasZoneType(x, y, z, "Nav") then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            local sprite = object:getSprite()
            if sprite then
                local spriteName = sprite:getName()
                if spriteName and spriteName:embodies("street") then
                    local rn = ZombRand(8)
                    local overlaySprite
                    if rn < 2  then
                        overlaySprite = "floors_overlay_street_01_" .. ZombRand(44)
                    elseif rn == 2 then
                        overlaySprite = "blends_streetoverlays_01_" .. ZombRand(32)
                    end
                    if overlaySprite then
                        local attachments = object:getAttachedAnimSprite()
                        if not attachments or attachments:size() == 0 then
                            object:setAttachedAnimSprite(ArrayList.new())
                        end
                        object:getAttachedAnimSprite():add(getSprite(overlaySprite):newInstance())
                    end
                    break
                end
            end
        end
    elseif BanditUtils.HasZoneType(x, y, z, "TownZone") then
        local rnd = ZombRand(10)
        if rnd == 1 then
            local obj = IsoObject.new(square, "floors_burnt_01_1", "")
            square:AddSpecialObject(obj)
            obj:transmitCompleteItemToClients()
        elseif rnd == 2 or rnd == 3 then
            local rn = ZombRand(54)
            local sprite = "trash_01_" .. tostring(rn)
            local obj = IsoObject.new(square, sprite, "")
            square:AddSpecialObject(obj)
            obj:transmitCompleteItemToClients()
        end
    end
end

local processSquare = function(square)
    local md = square:getModData()
    if not md.BWO then md.BWO = {} end

    -- post nuke world destroyer
    if not md.BWO.processed then
        burnSquare(square)
        local vehicle = square:getVehicleContainer()
        if vehicle then
            burnVehicle(vehicle)
        end
        md.BWO.processed = true
    end
end

-- Events.LoadGridsquare.Add(processSquare)
