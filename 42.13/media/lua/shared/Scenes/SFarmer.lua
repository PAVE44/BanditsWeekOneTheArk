require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Farmer = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Farmer:placeObjects()
    local x, y, z = self.x, self.y, self.z

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
    
end

function BWOAScenes.Farmer:populate()
    local player = getSpecificPlayer(0)
end
