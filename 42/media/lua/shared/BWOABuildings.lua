BWOABuildings = BWOABuildings or {}

BWOABuildings.hatches = {}

local getHatchId = function(x, y)
    return x .. "-" .. y
end

BWOABuildings.LoadHatches = function()
    local gmd = GetBWOAModData()
    for id, hatch in pairs(gmd.hatches) do
        local k = "Hatch-" .. id
        BWOAMenu.specialObjectsHighlight[k] = {
            x = hatch.x, y = hatch.y, z = 0, spriteName = "floors_burnt_01_0", option = "Open Hatch", 
            highLightFunc = BWOAMenu.specialObjectsCanHighlight.Hatch,
            actionFunc = BWOAMenu.specialObjectsAction.Hatch
        }
    end
end

BWOABuildings.CreateHatches = function()
    local gmd = GetBWOAModData()
    gmd.hatches = {}

    local defs = getWorld():getMetaGrid():getBuildings()

    for i=0, defs:size()-1 do
        local def = defs:get(i)
        if ZombRand(4) == 0 then
            local x1 = def:getX()
            local x2 = def:getX2()
            local y1 = def:getY()
            local y2 = def:getY2()

            local x = x1 + ZombRand(x2 - x1)
            local y = y1 + ZombRand(y2 - y1)

            local id = getHatchId(x, y)

            gmd.hatches[id] = {
                x = x,
                y = y
            }
        end
    end

    BWOABuildings.LoadHatches()
end

BWOABuildings.RemoveHatch = function(x, y)
    local gmd = GetBWOAModData()

    local id = getHatchId(x, y)
    gmd.hatches[id] = nil

    local k = "Hatch-" .. id
    BWOAMenu.specialObjectsHighlight[k] = nil
end
