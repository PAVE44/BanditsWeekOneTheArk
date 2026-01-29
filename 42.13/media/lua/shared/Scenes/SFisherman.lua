require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Fisherman = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Fisherman:placeObjects()
    local x, y, z = self.x, self.y, self.z

    -- bookshelf

end

function BWOAScenes.Fisherman:placeItems()
    local x, y, z = self.x, self.y, self.z

    -- fishing books
    -- fishing equipment
    -- cooler
    -- FishingHookBox
    -- exposure survival 1, 2
    -- Base.FishingMag1
    -- Base.FishingMag2
    -- Base.SurvivalSchematic
    -- Fisherman note
end

function BWOAScenes.Fisherman:placeCorpses()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Fisherman:placeVehicles()
    
end

function BWOAScenes.Fisherman:populate()
    local player = getSpecificPlayer(0)
end
