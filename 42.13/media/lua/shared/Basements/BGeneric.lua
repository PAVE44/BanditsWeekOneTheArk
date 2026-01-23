BWOABasements = BWOABasements or {}

BWOABasements.Generic = {}
BWOABasements.Generic.__index = BWOABasements.Generic

function BWOABasements.Generic:buildFloors()
    local cell = getCell()
    local sx, sy, sz = self.x, self.y, self.z
    local dx, dy = self.dx, self.dy

    for x = sx, sx + dx do
        for y = sy, sy + dy do
            BWOABuildTools.Floor(x, y, sz, self.sprites.floor)
        end
    end
end

function BWOABasements.Generic:makeRoom()

    function makeID(int1, int2, int3)
        local int0 = (int2 % 2^16) * 2^16 + (int1 % 2^16)
        return int0 * 2^32 + (int3 % 2^32)
    end

    local sx, sy, sz = self.x, self.y, self.z
    local dx, dy = self.dx, self.dy

    local id = 11259175162085380
    local metaGrid = getWorld():getMetaGrid()
    local def = metaGrid:getRoomDefByID(id)

    local cell = getCell()
    local worldX = math.floor(sx / getCellSizeInSquares())
    local worldY = math.floor(sy / getCellSizeInSquares())
    local newId = makeID(worldX, worldY, 10000 + ZombRand(10000))

    local newDef = RoomDef.new(newId, "bandit")
    newDef:copyFrom(def)

    local rect = newDef:getRects():get(0)
    rect:set(sx, sy + 1, dx, dy - 1)
    newDef:CalculateBounds()

    local metaCell = metaGrid:getCellData(worldX, worldY)
    metaCell:addRoom(newDef, worldX, worldY)

    room = newDef:getIsoRoom()

end

function BWOABasements.Generic:buildCeiling()
    local cell = getCell()
    local sx, sy, sz = self.x, self.y, self.z
    local dx, dy = self.dx, self.dy

    for x = sx, sx + dx do
        for y = sy + 1, sy + dy do
            BWOABuildTools.Floor(x, y, sz + 1, self.sprites.ceiling)
        end
    end
end

function BWOABasements.Generic:buildWalls()
    local cell = getCell()
    local sx, sy, sz = self.x, self.y, self.z
    local dx, dy = self.dx, self.dy

    local wallSprites = BanditUtils.Choice(self.sprites.wallOptions)
    BWOABuildTools.Wall (sx, sy, sz, wallSprites.wallNW)
    for x = sx, sx + dx do
        BWOABuildTools.Wall (x, sy, sz, wallSprites.wallN)
        BWOABuildTools.Wall (x, sy + dy + 1, sz, wallSprites.wallN)
    end
    for y = sy, sy + dy do
        BWOABuildTools.Wall (sx, y, sz, wallSprites.wallW)
        BWOABuildTools.Wall (sx + dx + 1, y, sz, wallSprites.wallW)
    end

    BWOABuildTools.Wall (sx, sy + 1, sz, wallSprites.wallNW)
    BWOABuildTools.Wall (sx + 1, sy + 1, sz, wallSprites.wallN)
    BWOABuildTools.Wall (sx + 2, sy + 1, sz, wallSprites.wallN)
    BWOABuildTools.Wall (sx + 3, sy + 1, sz, wallSprites.wallN)
    BWOABuildTools.Generic (sx + 4, sy + 1, sz, wallSprites.doorframeN)
    BWOABuildTools.Door (sx + 4, sy + 1, sz, true, self.sprites.doorN)
    BWOABuildTools.Wall (sx + 5, sy + 1, sz, wallSprites.wallN)
    BWOABuildTools.Wall (sx + 5, sy + 1, sz, wallSprites.wallN)
    BWOABuildTools.Wall (sx + 6, sy, sz, wallSprites.wallNW)
    BWOABuildTools.Wall (sx + 6, sy + 1, sz, wallSprites.wallSE)
end

function BWOABasements.Generic:buildStairs()
    local cell = getCell()
    local sx, sy, sz = self.x, self.y, self.z

    local stairs = {
        [1] = {
            x = sx,
            y = sy,
            z = sz,
            spriteName = self.sprites.stairs3,
            connect = true
        },
        [2] = {
            x = sx + 1,
            y = sy,
            z = sz,
            spriteName = self.sprites.stairs2
        },
        [3] = {
            x = sx + 2,
            y = sy,
            z = sz,
            spriteName = self.sprites.stairs1
        }
    }

    for _, stair in pairs(stairs) do
        BWOABuildTools.ClearAll(stair.x, stair.y, 0)

        BWOABuildTools.Generic (stair.x, stair.y, stair.z, stair.spriteName)
        if stair.connectTo then
            -- local above = IsoGridSquare.new(getCell(), nil, stair.x, stair.y-1, stair.z + 1)
            local above = cell:getGridSquare(stair.x-1, stair.y, stair.z + 1)
            cell:ConnectNewSquare(above, false)
        end
    end
end

function BWOABasements.Generic:recalcFurnitureArea()
    self.furnitureMap = {}
    for k, furnitureArea in ipairs(self.furnitureAreas) do
        self.furnitureMap[k] = {}
        for x = furnitureArea.x1, furnitureArea.x2 do
            for y = furnitureArea.y1, furnitureArea.y2 do
                local fdir = "c"
                if x == furnitureArea.x1 then
                    fdir = "e"
                elseif x == furnitureArea.x2 then
                    fdir = "w"
                elseif y == furnitureArea.y1 then
                    fdir = "s"
                elseif y == furnitureArea.y2 then
                    fdir = "n"
                end
                table.insert(self.furnitureMap[k], {
                    x = x,
                    y = y,
                    dir = fdir
                })
            end
        end

        for i = #self.furnitureMap[k], 2, -1 do
            local j = ZombRand(i) + 1
            self.furnitureMap[k][i], self.furnitureMap[k][j] = self.furnitureMap[k][j], self.furnitureMap[k][i]
        end
    end
end

function BWOABasements.Generic:placeFurniture()
    local cell = getCell()
    local sz = self.z

    local roomCnt = #self.furnitureMap

    for k, furnitureMap in ipairs(self.furnitureMap) do
        for _, fconfig in pairs(self.furniture) do
            if math.floor(fconfig.chance / roomCnt) > ZombRand(100) then
                local done = false
                for _, fmap in ipairs(furnitureMap) do
                    if not done and not fmap.taken then
                        for dir, dirs in pairs(fconfig.dirs) do
                            if dir == fmap.dir then
                                local allGood = true
                                for _, sconfig in ipairs(dirs) do
                                    local square = cell:getGridSquare(fmap.x + sconfig.x, fmap.y + sconfig.y, sz)
                                    if not square or not square:isFree(false) or square:getDoor(true) or square:getDoor(false) then
                                        allGood = false
                                        break
                                    end
                                end

                                if allGood then
                                    for _, sconfig in ipairs(dirs) do
                                        local bx, by, bz = fmap.x + sconfig.x, fmap.y + sconfig.y, sz
                                        if fconfig.fireplace then
                                            BWOABuildTools.Fireplace (bx, by, bz, sconfig.name)
                                        elseif fconfig.mannequin then
                                            BWOABuildTools.Mannequin (bx, by, bz, sconfig.script, sconfig.dir)
                                        elseif fconfig.attachment then
                                            local square = cell:getGridSquare(bx, by, bz)
                                            local wall
                                            if dir == "n" or dir == "s" then
                                                wall = square:getWall(true)
                                            else
                                                wall = square:getWall(false)
                                            end
                                            if wall then
                                                local attachments = wall:getAttachedAnimSprite()
                                                if not attachments or attachments:size() == 0 then
                                                    wall:setAttachedAnimSprite(ArrayList.new())
                                                else
                                                    wall:clearAttachedAnimSprite()
                                                end
                                                wall:getAttachedAnimSprite():add(getSprite(sconfig.name):newInstance())
                                            end
                                        else
                                            BWOABuildTools.Generic (bx, by, bz, sconfig.name)
                                        end

                                        for _, f in ipairs(furnitureMap) do
                                            if f.x == bx and f.y == by then
                                                f.taken = true
                                                f.surface = fconfig.surface
                                                f.items = fconfig.items
                                            end
                                        end
                                    end
                                    done = true
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function BWOABasements.Generic:placeLights()
    for k, furnitureMap in ipairs(self.furnitureMap) do
        for _, fmap in ipairs(furnitureMap) do
            if fmap.surface then
                local rndOpts = {8, 9, 10, 11, 12, 13, 32, 33, 34, 35, 36, 37, 40, 41, 42, 43, 44, 45, 48, 49, 50, 51, 52, 53}
                local rnd = BanditUtils.Choice(rndOpts)
                BWOABuildTools.LampBattery(fmap.x, fmap.y, self.z, "lighting_indoor_01_" .. rnd)
            end
        end
    end
end

function BWOABasements.Generic:placeItems()
    local cell = getCell()

    -- containers
    for k, furnitureMap in ipairs(self.furnitureMap) do
        for _, fmap in ipairs(furnitureMap) do
            if fmap.items then
                local square = cell:getGridSquare(fmap.x, fmap.y, self.z)
                if square then
                    local objects = square:getObjects()
                    for i=0, objects:size()-1 do
                        local object = objects:get(i)
                        local container = object:getContainer()
                        if container then
                            -- container:clear()

                            for _, iconfig in ipairs(fmap.items) do
                                for itemType, cntMax in pairs(iconfig) do
                                    local cnt = ZombRand(cntMax + 1)
                                    for i=1, cnt do
                                        local item = container:AddItem(itemType)
                                        if item then
                                            container:addItemOnServer(item)
                                        end
                                    end
                                end
                            end
                            ItemPicker.updateOverlaySprite(container:getParent())
                            break
                        end
                    end
                end
            end
        end
    end

    -- floor
    local items = self.items
    local j = 1
    for k, furnitureMap in ipairs(self.furnitureMap) do
        for _, fmap in ipairs(furnitureMap) do
            if items[j] then
                local surfaceOffset = BWOAPrepareTools.GetSurfaceOffset(fmap.x, fmap.y, self.z)
                local itemConf = items[j]
                for itemType, itemCntMax in pairs(itemConf) do
                    local cnt = ZombRand(itemCntMax + 1)
                    for i=1, cnt do
                        local data = {
                            x = ZombRandFloat(0.2, 0.8),
                            y = ZombRandFloat(0.2, 0.8),
                            z = surfaceOffset
                        }
                        BWOAPrepareTools.AddWorldItem(fmap.x, fmap.y, self.z, itemType, data)
                    end
                end
                j = j + 1
            else
                break
            end
        end
    end
end

function BWOABasements.Generic:placeCorpses()
    local roomCnt = #self.furnitureMap
    for k, furnitureMap in ipairs(self.furnitureMap) do
        for _, cconfig in pairs(self.corpses) do
            if math.floor(cconfig.chance / roomCnt) > ZombRand(100) then
                local done = false
                for _, fmap in ipairs(furnitureMap) do
                    if not fmap.taken then
                        fmap.taken = true
                        BWOAPrepareTools.AddHumanCorpse(fmap.x, fmap.y, self.z, cconfig.outfits, cconfig.femaleChance)
                        break
                    end
                end
            end
        end
    end
end

function BWOABasements.Generic:populate()
    local player = getSpecificPlayer(0)
    if not player then return end

    local args = {}
    args.cid = self.cid
    args.x = self.x + 5
    args.y = self.y + 3
    args.z = self.z
    args.program = "Basement"
    args.size = 4
    -- args.permanent = true
    if args.cid then
        sendClientCommand(player, 'Spawner', 'Clan', args)
    end
end

function BWOABasements.Generic:build()
    self:buildFloors()
    -- self:buildCeiling()
    self:buildWalls()
    self:buildStairs()
    -- self:makeRoom()
    self:recalcFurnitureArea()
    self:placeFurniture()
    self:placeLights()
    self:placeItems()
    self:placeCorpses()
    self:populate()
end

function BWOABasements.Generic:derive(type)
    local o = {}
    setmetatable(o, self)
    self.__index = self
	o.Type= type;
    return o
end

function BWOABasements.Generic:new(x, y, room, theme)
    local self = setmetatable({}, BWOABasements.Generic)

    -- const
    self.name = "Generic"
    self.dx = 6 + ZombRand(4)
    self.dy = 5 + ZombRand(3)

    self.furnitureAreas = {
        [1] = {
            x1 = x,
            y1 = y + 1,
            x2 = x + self.dx,
            y2 = y + self.dy,
        }
    }

    if theme then
        self.theme = theme
    else
        self.theme = "generic"
    end

    local themeData = BasementThemes[self.theme]
    for k, v in pairs(themeData) do
        self[k] = v
    end

    -- vars
    self.room = room
    self.x = x
    self.y = y
    self.z = -1

    return self
end