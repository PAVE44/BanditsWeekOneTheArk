require "Basements/BGeneric"

BWOABasements = BWOABasements or {}

BWOABasements.Double = BWOABasements.Generic:derive("BWOABasements.Generic")

function BWOABasements.Double:buildWalls()
    local sx, sy, sz = self.x, self.y, self.z
    local dx, dy = self.dx, self.dy
    local wy = self.wy

    local wallSprites = BanditUtils.Choice(self.sprites.wallOptions)
    --BWOABuildTools.Wall (sx, sy, sz, wallSprites.wallNW)
    for x = sx + 1, sx + dx do
        BWOABuildTools.Wall (x, sy, sz, wallSprites.wallN)
        BWOABuildTools.Wall (x, sy + dy + 1, sz, wallSprites.wallN)
    end
    for y = sy + 1, sy + dy do
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

    BWOABuildTools.Wall (sx, sy + wy + 1, sz, wallSprites.wallNW)
    for x = sx + 1, sx + dx do
        if x == sx + 4 then
            BWOABuildTools.Generic (x, sy + wy + 1, sz, wallSprites.doorframeN)
            BWOABuildTools.Door (x, sy + wy + 1, sz, true, self.sprites.doorN)
        else
            BWOABuildTools.Wall (x, sy + wy + 1, sz, wallSprites.wallN)
        end
    end
end

function BWOABasements.Double:new(x, y, room, theme)
    local self = setmetatable({}, BWOABasements.Double)

    -- const
    self.name = "Double"
    self.dx = 6 + ZombRand(4)
    self.dy = 8 + ZombRand(2)
    self.wy = math.floor(self.dy / 2)

    self.furnitureAreas = {
        [1] = {
            x1 = x,
            y1 = y + 1,
            x2 = x + self.dx,
            y2 = y + self.wy,
        },
        [2] = {
            x1 = x,
            y1 = y + self.wy + 1,
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