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

local addWorldItem = function(x, y, z, item, data)
    local cell = getCell()
    local square = cell:getOrCreateGridSquare(x, y, z)
    
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

BWOAPrepareTools.AddWorldItem = function(x, y, z, itemType, data)
    local item = BanditCompatibility.InstanceItem(itemType)
    addWorldItem(x, y, z, item, data)
end 

BWOAPrepareTools.AddWorldItemSpecial = function(x, y, z, item, data)
    addWorldItem(x, y, z, item, data)
end 

BWOAPrepareTools.AddItemsToContainer = function(x, y, z, items, customName, preserveCurrent)
    local square = getCell():getGridSquare(x, y, z)
    local container
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)                
            local sprite = object:getSprite()
            if sprite then
                local props = sprite:getProperties()
                if props:Is("CustomName") then
                    local cn = props:Val("CustomName")
                    if cn == customName then
                        container = object:getContainer()
                    end
                end
            end
        end
    end

    if container then
        if not preserveCurrent then
            container:clear()
        end
        for itemType, itemCnt in pairs(items) do
            for i=1, itemCnt do
                local item = container:AddItem(itemType)
                if item then
                    container:addItemOnServer(item)
                end
            end

            if not isClient() then
                -- if container:getParent() and container:getParent():getOverlaySprite() then
                    ItemPicker.updateOverlaySprite(container:getParent())
                -- end
            end
        end
        container:setDrawDirty(true)
    end
end
