BWOABuildings = BWOABuildings or {}

BWOABuildings.hatches = {}

BWOABuildings.exceptions = {
    "9921-12622", -- ARK
    "8321-11595", -- Rosewood Elementary School
    "8081-11520", -- Rosewood Mama McFudginton's
    "8081-11487", -- Rosewood Mama McFudginton's
    "7380-8349", -- Fallas Church
    "432-9911", -- Ekron Church
    "5537-12440", -- Secret Lab
}

local getHatchId = function(x, y)
    return x .. "-" .. y
end

BWOABuildings.LoadHatches = function()
    local gmd = GetBWOAModData()
    for id, hatch in pairs(gmd.hatches) do
        local k = "Hatch-" .. id
        BWOAMenu.specialObjectsHighlight[k] = {
            x = hatch.x, y = hatch.y, z = 0, spriteName = "street_decoration_01_15", option = "Open Hatch", 
            highLightFunc = BWOAMenu.specialObjectsCanHighlight.Hatch,
            actionFunc = BWOAMenu.specialObjectsAction.Hatch
        }
    end
end

BWOABuildings.CreateHatches = function()
    local gmd = GetBWOAModData()
    gmd.hatches = {}

    local defs = getWorld():getMetaGrid():getBuildings()

    local s2r = {
        [1] = 24,
        [2] = 16,
        [3] = 12,
        [4] = 7,
        [5] = 4,
    }

    local so = s2r[SandboxVars.BWOA.ShelterOccurance]

    for i=0, defs:size()-1 do
        local def = defs:get(i)
        local x1 = def:getX()
        local x2 = def:getX2()
        local y1 = def:getY()
        local y2 = def:getY2()
        local id = x1 .. "-" .. y1

        local isException = false
        for _, exception in ipairs(BWOABuildings.exceptions) do
            if id == exception then
                isException = true
                break
            end
        end

        if not isException and ZombRand(so) == 0 then
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
