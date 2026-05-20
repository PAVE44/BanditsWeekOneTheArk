local database = {}
local temp = {}

local base = {
    x1 = 9930,
    x2 = 9981,
    y1 = 12600,
    y2 = 12650
}

local size = 10

local cursor = {
    x = base.x1,
    y = base.y1
}

local function predicateAll(item)
    -- item:getType()
	return true
end

local function deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for k, v in pairs(orig) do
            copy[deepCopy(k)] = deepCopy(v)
        end
        -- Comment out next line if you don’t need metatables
        -- setmetatable(copy, getmetatable(orig))
    else
        copy = orig
    end
    return copy
end

local function reset()
    temp = {
        items = {},
        objects = {},
        blood = {},
    }
end

local function store()
    database = deepCopy(temp)
    reset()
    -- print ("done")
end

local function getId(object)
    return object:getX() .. ":" .. object:getY() .. ":" .. object:getZ()
end

local objectWhitelist = {
    ["Toilet"] = true,
    ["Shower"] = true,
    ["Beds"] = true,
    ["Bed"] = true,
    ["Radio"] = true,
    ["Couch"] = true,
    ["Chair"] = true,
    ["Stool"] = true,
    ["Television"] = true,
    ["Piano"] = true,
    ["Computer"] = true,
    ["Microscope"] = true,
    ["Oven"] = true,
}

local function analyze(x, y, z)
    local square = getCell():getGridSquare(x, y, z)
    if not square then return end

    local hasAccessSquare = BanditUtils.HasAccessSquare(square)
    if not hasAccessSquare then 
        return
    end

    local oid = getId(square)

    local objects = square:getObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        -- local properties = object:getProperties()
            
        local sprite = object:getSprite()
        if sprite then
            local props = sprite:getProperties()
            if props:has("CustomName") then
                local customName = props:get("CustomName")
                if customName and objectWhitelist[customName] then
                    local facing
                    if props:has("Facing") then
                        facing = props:get("Facing")
                    end
                    temp.objects[oid] = {
                        x = x,
                        y = y,
                        z = z,
                        cn = customName,
                        f = facing
                    }

                    if instanceof(object, "IsoStove") then
                        temp.objects[oid].active = object:Activated()
                    elseif instanceof(object, "IsoTelevision") then
                        temp.objects[oid].active = object:getDeviceData():getIsTurnedOn()
                    end
                end
            end
        end

        local container = object:getContainer()
        if container and not container:isEmpty() then

            local items = ArrayList.new()
            container:getAllEvalRecurse(predicateAll, items)
            for i=0, items:size()-1 do
                local item = items:get(i)
                local ftype = item:getFullType()
                local class = BWOAItems.GetItemClass(item)
                local cooked = item:isCooked()

                if not temp.items[oid] then
                    temp.items[oid] = {}
                end

                if temp.items[oid][ftype] then
                    temp.items[oid][ftype].cnt = temp.items[oid][ftype].cnt + 1
                else
                    temp.items[oid][ftype] = {
                        x = x,
                        y = y,
                        z = z,
                        ftype = ftype,
                        class = class,
                        cooked = cooked,
                        cnt = 1,
                    }
                end
            end
        end
    end

    local wobs = square:getWorldObjects()
    for i = 0, wobs:size()-1 do
        local o = wobs:get(i)
        local item = o:getItem()
        local ftype = item:getFullType()
        local radiated = item:getModData().radiated
        local class = BWOAItems.GetItemClass(item)
        local cooked = item:isCooked()

        if not temp.items[oid] then
            temp.items[oid] = {}
        end

        if temp.items[oid] and temp.items[oid][ftype] then
            temp.items[oid][ftype].cnt = temp.items[oid][ftype].cnt + 1
        else
            temp.items[oid][ftype] = {
                x = x,
                y = y,
                z = z,
                ftype = ftype,
                class = class,
                r = radiated,
                ground = true,
                cooked = cooked,
                cnt = 1
            }
        end
    end

    local hasBlood = square:haveBlood()
    if hasBlood then
        temp.blood[oid] = {
            x = x,
            y = y,
            z = z
        }
    end
end

local function onGameStart()
    store()
end

local function onTick()
    local x1 = cursor.x
    local x2 = x1 + size - 1
    local y1 = cursor.y
    local y2 = y1 + size - 1

    for x=x1, x2 do
        for y=y1, y2 do
            analyze(x, y, -4)
        end
    end

    -- print ("CX: " .. cursor.x .. " CY: " .. cursor.y)

    cursor.x = cursor.x + size
    if cursor.x >= base.x2 then
        cursor.y = cursor.y + size
        cursor.x = base.x1
        if cursor.y >= base.y2 then
            store()
            cursor.x = base.x1
            cursor.y = base.y1
        end
    end

    local debug1 = temp
    local debug2 = database

end

store()

BWOABaseObjects = BWOABaseObjects or {}

BWOABaseObjects.FindAllObjects = function(customNames, opts)
    local objectsFound = {}
    local objs = database.objects

    for _, customName in pairs(customNames) do
        for id, obj in pairs(objs) do
            if obj.cn == customName then
                table.insert(objectsFound, obj)
            end
        end
    end

    return objectsFound
end

BWOABaseObjects.FindClosestObject = function(customNames, point, opts)
    local distBest = math.huge
    local objBest
    local objs = database.objects

    for _, customName in pairs(customNames) do
        for id, obj in pairs(objs) do
            if obj.cn == customName then
                local distSq = ((obj.x - point.x + 0.5) * (obj.x - point.x + 0.5)) + ((obj.y - point.y + 0.5) * (obj.y - point.y + 0.5))
                if distSq < distBest then
                    objBest = obj
                    distBest = distSq
                end
            end
        end
    end

    if objBest then
        return objBest, math.sqrt(distBest)
    end
    return nil, nil
end

BWOABaseObjects.GetIsoObject = function(obj)
    local square = getCell():getGridSquare(obj.x, obj.y, obj.z)
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)                
            local sprite = object:getSprite()
            if sprite then
                local props = sprite:getProperties()
                if props:has("CustomName") then
                    local customName = props:get("CustomName")
                    if obj.cn == customName then
                        return object
                    end
                end
            end
        end
    end
end

BWOABaseObjects.EnsureObjectAt = function(cn, x, y, z)
    local objects = database.objects
    local x, y, z = math.floor(x), math.floor(y), math.floor(z)
    local cntExpected = cnt or 1
    local id = x .. ":" .. y .. ":" .. z
    local object = objects[id]
    if object and object.cn == cn then
        return true
    end
end

BWOABaseObjects.GetItemStackAt = function(x, y, z)
    local items = database.items
    local x, y, z = math.floor(x), math.floor(y), math.floor(z)
    local id = x .. ":" .. y .. ":" .. z
    local itemStack = items[id]
    
    return itemStack
end

BWOABaseObjects.FindClosestItemTypes = function(fullTypesList, point, opts)
    local distBest = math.huge
    local itemBest
    local items = database.items

    for id, itemStack in pairs(items) do
        for ftype, item in pairs(itemStack) do
            for _, fullType in pairs(fullTypesList) do
                if ftype == fullType then
                    if not opts or (opts.cooked == nil or (opts.cooked == item.cooked)) then
                        local distSq = ((item.x - point.x + 0.5) * (item.x - point.x + 0.5)) + ((item.y - point.y + 0.5) * (item.y - point.y + 0.5))
                        if distSq < distBest then
                            itemBest = item
                            distBest = distSq
                        end
                    end
                end
            end
        end
    end

    if itemBest then
        return itemBest, math.sqrt(distBest)
    end
    return nil, nil
end

BWOABaseObjects.EnsureItemTypeAt = function(fullType, x, y, z, cnt)
    local items = database.items
    local x, y, z = math.floor(x), math.floor(y), math.floor(z)
    local cntExpected = cnt or 1
    local id = x .. ":" .. y .. ":" .. z
    local itemStack = items[id]

    if itemStack then
        for ftype, item in pairs(itemStack) do
            if ftype == fullType and math.floor(item.x) == x and math.floor(item.y) == y and math.floor(item.z) == z and item.cnt >= cntExpected then
                return true
            end
        end
    end
    return false
end

BWOABaseObjects.FindClosestItemClass = function(class, point, opts)
    local distBest = math.huge
    local itemBest
    local items = database.items

    for id, itemStack in pairs(items) do
        for ftype, item in pairs(itemStack) do
            if item.class == class then
                local distSq = ((item.x - point.x + 0.5) * (item.x - point.x + 0.5)) + ((item.y - point.y + 0.5) * (item.y - point.y + 0.5))
                if distSq < distBest then
                    itemBest = item
                    distBest = distSq
                end
            end
        end
    end

    if itemBest then
        return itemBest, math.sqrt(distBest)
    end
    return nil, nil
end

BWOABaseObjects.FindClosestBlood = function(point, distMax)
    local distBest = math.huge
    local bloodBest
    local bloods = database.blood
    local distMaxSq = distMax * distMax

    for id, blood in pairs(bloods) do
        local distSq = ((blood.x - point.x + 0.5) * (blood.x - point.x + 0.5)) + ((blood.y - point.y + 0.5) * (blood.y - point.y + 0.5))
        if distSq < distBest and distSq <= distMaxSq then
            bloodBest = blood
            distBest = distSq
        end
    end

    if bloodBest then
        return bloodBest, math.sqrt(distBest)
    end
    return nil, nil
end

BWOABaseObjects.FindClosestRadiated = function(point, distMax)
    local distBest = math.huge
    local itemBest
    local items = database.items
    local distMaxSq = distMax * distMax

    for id, itemStack in pairs(items) do
        for ftype, item in pairs(itemStack) do
            if item.r then
                local distSq = ((item.x - point.x + 0.5) * (item.x - point.x + 0.5)) + ((item.y - point.y + 0.5) * (item.y - point.y + 0.5))
                if distSq < distBest and distSq <= distMaxSq then
                    itemBest = item
                    distBest = distSq
                end
            end
        end
    end

    if itemBest then
        return itemBest, math.sqrt(distBest)
    end
    return nil, nil
end

BWOABaseObjects.GetIsoItem = function(item)
    local square = getCell():getGridSquare(item.x, item.y, item.z)
    if square then
        local wobs = square:getWorldObjects()
        for i = 0, wobs:size()-1 do
            local o = wobs:get(i)
            local item = o:getItem()
            local ftype = item:getFullType()
            if ftype == item.ftype then
                return item
            end
        end
    end
end

Events.OnGameStart.Remove(onGameStart)
Events.OnGameStart.Add(onGameStart)

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)