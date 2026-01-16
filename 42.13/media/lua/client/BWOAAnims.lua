BWOAAnims = BWOAAnims or {}

BWOAAnims.tick = 0
BWOAAnims.tab = {}

BWOAAnims.Add = function(tab)
    local id = tab.x .. ":" .. tab.y .. ":" .. tab.z
    BWOAAnims.tab[id] = tab
end

BWOAAnims.Remove = function(tab)
    local id = tab.x .. ":" .. tab.y .. ":" .. tab.z
    BWOAAnims.tab[id] = nil
end

local function onTick()
    if isServer() then return end

    BWOAAnims.tick = BWOAAnims.tick + 1
    if BWOAAnims.tick == 12 then
        BWOAAnims.tick = 0
    end

    if BWOAAnims.tick ~= 2 then return end

    local function getObject(x, y, z, name)
        local square = getCell():getGridSquare(x, y, z)
        if square then
            local objects = square:getObjects()
            for i=0, objects:size()-1 do
                local object = objects:get(i)                
                local sprite = object:getSprite()
                if sprite then
                    local props = sprite:getProperties()
                    if props:has("CustomName") then
                        local customName = props:get("CustomName")
                        if name == customName then
                            return object
                        end
                    end
                end
            end
        end
    end

    for _, effect in pairs(BWOAAnims.tab) do
        local object = getObject(effect.x, effect.y, effect.z, effect.objName)
        if object then
            if not effect.frame then effect.frame = 1 end

            local spriteName = effect.frameList[effect.frame]

            local attachments = object:getAttachedAnimSprite()
            if not attachments or attachments:size() == 0 then
                object:setAttachedAnimSprite(ArrayList.new())
            else
                object:clearAttachedAnimSprite()
            end
            object:getAttachedAnimSprite():add(getSprite(spriteName):newInstance())
            effect.frame = effect.frame + 1
            if effect.frame > #effect.frameList then effect.frame = 1 end
        end
    end

end

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)