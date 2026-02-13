local database = {}
local temp = {}

local base = {
    x1 = 9930,
    x2 = 9980,
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
        objects = {}
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
                if customName then
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
                temp.items[oid] = {
                    x = x,
                    y = y,
                    z = z,
                    ftype = ftype
                }
            end
        end
    end

    local wobs = square:getWorldObjects()
    for i = 0, wobs:size()-1 do
        local o = wobs:get(i)
        local item = o:getItem()
        local ftype = item:getFullType() 
        temp.items[oid] = {
            x = x,
            y = y,
            z = z,
            ftype = ftype
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

Events.OnGameStart.Remove(onGameStart)
Events.OnGameStart.Add(onGameStart)

Events.OnTick.Remove(onTick)
Events.OnTick.Add(onTick)