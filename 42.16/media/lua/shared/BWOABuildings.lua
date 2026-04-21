BWOABuildings = BWOABuildings or {}

BWOABuildings.hatches = {}

BWOABuildings.exceptions = {
    {x1 = 9875, y1 = 12570, x2 = 10230, y2 = 12700}, -- ARK
    {x1 = 10070, y1 = 11125, x2 = 10155, y2 = 11205}, -- maniac
    {x1 = 8300, y1 = 11585, x2 = 8445, y2 = 11825}, -- Rosewood Elementary School and farmerddwsd
    {x1 = 7050, y1 = 8154, x2 = 7880, y2 = 8560}, -- Fallas Lake
    {x1 = 360, y1 = 9900, x2 = 540, y2 = 10000}, -- Ekron Church
    {x1 = 5500, y1 = 12400, x2 = 5710, y2 = 12520}, -- Secret Lab
    {x1 = 10830, y1 = 9980, x2 = 10940, y2 = 10070}, -- Muldraugh Doc
    {x1 = 9810, y1 = 12910, x2 = 9860, y2 = 12930}, -- Hunter
}

local getHatchId = function(x, y)
    return x .. "-" .. y
end

BWOABuildings.LoadHatches = function()
    local gmd = GetBWOAModData()
    for id, hatch in pairs(gmd.hatches) do
        local k = "Hatch-" .. id
        BWOAMenu.specialObjectsHighlight[k] = {
            x = hatch.x, y = hatch.y, z = 0, spriteName = "street_decoration_01_15", dist = 3,
            highLightFunc = BWOAMenu.specialObjectsCanHighlight.Hatch,
            menuFunc = BWOAMenu.specialObjectsMenu.Hatch,
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

        local isException = false
        for _, exception in ipairs(BWOABuildings.exceptions) do
            if x1 >= exception.x1 and x2 <= exception.x2 and y1 >= exception.y1 and y2 <= exception.y2 then
                isException = true
                -- print ("EXCEPTION: " .. x1 .. "," .. y1 .. " - " .. x2 .. "," .. y2)
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

    -- triggers highlight rebuild
    BWOAMenu.highlightClusters = nil
end
