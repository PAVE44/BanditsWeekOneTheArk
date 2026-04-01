require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Toolbag = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Toolbag:placeObjects()
end

function BWOAScenes.Toolbag:placeItems()
    local cell = getCell()
    local square = cell:getGridSquare(self.x, self.y, self.z)
    local building = square:getBuilding()
    local room = building:getRandomRoom()
    local def = room:getRoomDef()
    local itemSquare = def:getFreeSquare()

    local x, y, z
    if itemSquare then
        x, y, z = itemSquare:getX(), itemSquare:getY(), itemSquare:getZ()
    else
        x, y, z = 10033, 12731, 1
    end

    local bag = BanditCompatibility.InstanceItem("Base.Bag_Military")
    local md = bag:getModData()
    md.BWOA = {}
    md.BWOA.onTaken = {}
    md.BWOA.onTaken.accomplishMissionId = 7
    md.BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"
    md.BWOA.onTaken.revealDialogueId = "100.10.1"

    local tools = {"Base.Sledgehammer", "Base.Crowbar", "Base.BoltCutters", "Base.Hammer", "Base.Screwdriver"}
    local container = bag:getItemContainer()
    for _, itemType in ipairs(tools) do
        local item = BanditCompatibility.InstanceItem(itemType)
        container:AddItem(item)
    end
    BWOAPrepareTools.AddWorldItemSpecial(x, y, z, bag)
end

function BWOAScenes.Toolbag:placeCorpses()
end

function BWOAScenes.Toolbag:placeVehicles()
end

function BWOAScenes.Toolbag:populate()
end
