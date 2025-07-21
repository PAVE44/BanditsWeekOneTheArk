BWOARooms = BWOARooms or {}

BWOARooms.Greenhouse = {}

BWOARooms.Greenhouse.Init = function ()
    BWOARooms.Greenhouse.name = "HYDROPONICS"
    BWOARooms.Greenhouse.x1 = 9962
    BWOARooms.Greenhouse.x2 = 9974
    BWOARooms.Greenhouse.y1 = 12578
    BWOARooms.Greenhouse.y2 = 12608
    BWOARooms.Greenhouse.z = -4
    BWOARooms.Greenhouse.ambience = ""
end

BWOARooms.Greenhouse.Build = function ()
    BWOARooms.Greenhouse.Init()

    --[[
    local cell = getCell()

    -- floors, walls, door
    local z = BWOARooms.Greenhouse.z
    for x = BWOARooms.Greenhouse.x1, BWOARooms.Greenhouse.x2 do
        for y = BWOARooms.Greenhouse.y1, BWOARooms.Greenhouse.y2 do
            BWOABuildTools.FloorConcrete(x, y, z)

            if x == BWOARooms.Greenhouse.x1 or x == BWOARooms.Greenhouse.x2 then
                BWOABuildTools.WallWConcrete(x, y, z)

                if y % 5 == 0 then
                    BWOABuildTools.VentN(x, y, z)
                elseif y % 5 == 2 then
                    BWOABuildTools.Generic(x, y, z, "fixtures_bathroom_01_31")
                    BWOABuildTools.Generic(x, y, z, "street_decoration_01_13")
                end
            end

            if y == BWOARooms.Greenhouse.y1 then 
                BWOABuildTools.WallNConcrete(x, y, z)
            end
        end
    end

    BWOABuildTools.DoorNConcrete(cell:getGridSquare(9965, 12608, z))

    -- equipment
    for x = 9963, 9970 do
        BWOABuildTools.Fridge(x, 12578, z)
    end

    -- farmplots
    local seeds = {
        "BellPepper", "Tomato", "Broccoli", "Cabbages" , "Carrots" , "Cauliflower", "Corn", 
        "Cucumber", "Garlic", "Greenpeas", 'Lettuce', "Onion", "Potatoes", "Potatoes", "Potatoes", "Potatoes", 
        "Soybeans", "Spinach", "Strawberryplant", "SugarBeets", "Turnip", "Zucchini"
    }

    local seedIdx = 0
    local seedType 
    local z = BWOARooms.Greenhouse.z
    for _, x in pairs({9963, 9964, 9966, 9967, 9969, 9970}) do
        for y = BWOARooms.Greenhouse.y1 + 3, BWOARooms.Greenhouse.y2 - 2 do

            if seedIdx == 0 then
                seedType = BanditUtils.Choice(seeds)
            end
            seedIdx = seedIdx + 1
            if seedIdx == 4 then seedIdx = 0 end
            
            BWOABuildTools.FarmPlot(x, y, z, seedType)
        end
    end

    -- lights
    for _, x in pairs({9964, 9966, 9968, 9970, 9972}) do
        for y = BWOARooms.Greenhouse.y1 + 3, BWOARooms.Greenhouse.y2 - 2 do
            BWOABuildTools.LampCeilingNS(x, y, z)
        end
    end

    ]]
end

BWOARooms.Greenhouse.SetEmitters = function ()
    for y=12580, 12605, 5 do
        BWOASound.AddToObject({x=9961.5, y=y + 0.5, z=-4, sound="AmbientVent"})
        BWOASound.AddToObject({x=9973.5, y=y + 0.5, z=-4, sound="AmbientVent"})
    end
end

BWOARooms.Greenhouse.Prepare = function ()
end


