require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Hunter = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Hunter:placeObjects()
    local x, y, z = self.x, self.y, self.z

    -- ammo locker
    -- bookshelf
    -- throfies
    -- placed traps
end

function BWOAScenes.Hunter:placeItems()
    local x, y, z = self.x, self.y, self.z

    -- trapping books
    -- hunting rifle and ammo
    -- traps as items
    -- hunter note
end

function BWOAScenes.Hunter:placeCorpses()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Hunter:placeVehicles()
    
end

function BWOAScenes.Hunter:populate()
    local player = getSpecificPlayer(0)
end
