BWOAScenes = BWOAScenes or {}

BWOAScenes.Abstract = {}
BWOAScenes.Abstract.__index = BWOAScenes.Abstract

function BWOAScenes.Abstract:placeObjects()
end

function BWOAScenes.Abstract:placeItems()
end

function BWOAScenes.Abstract:placeCorpses()
end

function BWOAScenes.Abstract:placeVehicles()
end


function BWOAScenes.Abstract:populate()
end

function BWOAScenes.Abstract:build()
    self:placeObjects()
    self:placeItems()
    self:placeCorpses()
    self:placeVehicles()
    self:populate()
end

function BWOAScenes.Abstract:derive(type)
    local derived = {}
    setmetatable(derived, { __index = self })
    derived.__index = derived
    derived.Type = type
    return derived
end

function BWOAScenes.Abstract:new(x, y, z)
    local o = setmetatable({}, self)
    o.x = x
    o.y = y
    o.z = z
    return o

end