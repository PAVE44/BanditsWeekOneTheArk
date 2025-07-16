BWOAPrepareTools = BWOAPrepareTools or {}

BWOAPrepareTools.DarkenLight = function(x, y, z)
    local cell = getCell()
    local square = cell:getOrCreateGridSquare(x, y, z)
    local objects = square:getObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        if instanceof(object, "IsoLightSwitch") then
            local sprite = object:getSprite()
            local props = sprite:getProperties()
            if props:Is("CustomName") then
                customName = props:Val("CustomName")
                if customName == "Switch" then
                    object:setActive(false)
                    square:removeLightSwitch()
                end

            end
        end
    end
end

BWOAPrepareTools.AddWorldItem = function(x, y, z, itemType, data)
    local cell = getCell()
    local square = cell:getOrCreateGridSquare(x, y, z)
    local item = BanditCompatibility.InstanceItem(itemType)
    item = square:AddWorldInventoryItem(item, data.x, data.y, data.z)

    if data.rx then
        item:setWorldXRotation(data.rx)
    end
    if data.ry then
        item:setWorldYRotation(data.ry)
    end
    if data.rz then
        item:setWorldZRotation(data.rz)
    end

end 