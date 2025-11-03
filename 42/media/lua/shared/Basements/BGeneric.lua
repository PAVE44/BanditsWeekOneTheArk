BWOABasements = BWOABasements or {}

BWOABasements.Generic = {}
BWOABasements.Generic.__index = BWOABasements.Generic

function BWOABasements.Generic:buildFloors()
    local cell = getCell()
    local sx, sy = self.x, self.y
    local dx, dy = self.dx, self.dy

    for x = sx, sx + dx do
        for y = sy, sy + dy do
            BWOABuildTools.Floor(x, y, -1, self.sprites.floor)
        end
    end
end

function BWOABasements.Generic:buildWalls()
    local cell = getCell()
    local sx, sy = self.x, self.y
    local dx, dy = self.dx, self.dy

    BWOABuildTools.Wall (sx, sy, -1, self.sprites.wallNW)
    for x = sx + 1, sx + dx do
        BWOABuildTools.Wall (x, sy, -1, self.sprites.wallN)
    end
    for y = sy + 1, sy + dy do
        BWOABuildTools.Wall (sx, y, -1, self.sprites.wallW)
    end

    BWOABuildTools.Wall (sx, sy + 1, -1, self.sprites.wallNW)
    BWOABuildTools.Wall (sx + 1, sy + 1, -1, self.sprites.wallN)
    BWOABuildTools.Wall (sx + 2, sy + 1, -1, self.sprites.wallN)
    BWOABuildTools.Wall (sx + 3, sy + 1, -1, self.sprites.wallN)
    BWOABuildTools.Generic (sx + 4, sy + 1, -1, self.sprites.doorframeN)
    BWOABuildTools.Door (sx + 4, sy + 1, -1, true, self.sprites.doorN)
    BWOABuildTools.Wall (sx + 5, sy + 1, -1, self.sprites.wallN)
    BWOABuildTools.Wall (sx + 5, sy + 1, -1, self.sprites.wallN)
    BWOABuildTools.Wall (sx + 6, sy, -1, self.sprites.wallNW)
    BWOABuildTools.Wall (sx + 6, sy + 1, -1, self.sprites.wallSE)
end

function BWOABasements.Generic:buildStairs()
    local cell = getCell()
    local sx, sy = self.x, self.y
    local dx, dy = self.dx, self.dy

    local stairs = {
        [1] = {
            x = sx,
            y = sy,
            spriteName = self.sprites.stairs3
        },
        [2] = {
            x = sx + 1,
            y = sy,
            spriteName = self.sprites.stairs2
        },
        [3] = {
            x = sx + 2,
            y = sy,
            spriteName = self.sprites.stairs1
        }
    }

    for _, stair in pairs(stairs) do
        local squareUp = cell:getGridSquare(stair.x, stair.y, 0)
        local objects = squareUp:getObjects()
        for i = objects:size()-1, 0, -1 do
            local object = objects:get(i)
            squareUp:transmitRemoveItemFromSquare(object)
        end
        squareUp:setSquareChanged()

        BWOABuildTools.Generic (stair.x, stair.y, -1, stair.spriteName)
    end
end

function BWOABasements.Generic:recalcFurnitureArea()
    self.furnitureMap = {}
    for x = self.furnitureArea.x1, self.furnitureArea.x2 do
        for y = self.furnitureArea.y1, self.furnitureArea.y2 do
            local fdir = "c"
            if x == self.furnitureArea.x1 then
                fdir = "e"
            elseif x == self.furnitureArea.x2 then
                fdir = "w"
            elseif y == self.furnitureArea.y1 then
                fdir = "s"
            elseif y == self.furnitureArea.y2 then
                fdir = "n"
            end
            table.insert(self.furnitureMap, {
                x = x,
                y = y,
                dir = fdir
            })
        end
    end

    for i = #self.furnitureMap, 2, -1 do
        local j = ZombRand(i) + 1
        self.furnitureMap[i], self.furnitureMap[j] = self.furnitureMap[j], self.furnitureMap[i]
    end
end

function BWOABasements.Generic:placeFurniture()
    local cell = getCell()
    local sx, sy = self.x, self.y
    local dx, dy = self.dx, self.dy

    self:recalcFurnitureArea()

    for fname, fconfig in pairs(self.furniture) do
        if fconfig.chance > ZombRand(100) then
            local done = false
            for _, fmap in ipairs(self.furnitureMap) do
                if not done and not fmap.taken then
                    for dir, dirs in pairs(fconfig.dirs) do
                        if dir == fmap.dir then
                            local allGood = true
                            for _, sconfig in ipairs(dirs) do
                                local square = cell:getGridSquare(fmap.x + sconfig.x, fmap.y + sconfig.y, -1)
                                if not square or not square:isFree(false) then
                                    allGood = false
                                    break
                                end
                            end

                            if allGood then
                                for _, sconfig in ipairs(dirs) do
                                    BWOABuildTools.Generic (fmap.x + sconfig.x, fmap.y + sconfig.y, -1, sconfig.name)
                                    fmap.taken = true
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

function BWOABasements.Generic:build()
    self:buildFloors()
    self:buildWalls()
    self:buildStairs()
    self:placeFurniture()

end

function BWOABasements.Generic:new(x, y)
    local self = setmetatable({}, BWOABasements.Generic)

    -- const
    self.name = "Generic"
    self.dx = 8
    self.dy = 6

    self.sprites = {}
    self.sprites.stairs1 = "fixtures_stairs_01_64"
    self.sprites.stairs2 = "fixtures_stairs_01_65"
    self.sprites.stairs3 = "fixtures_stairs_01_66"
    self.sprites.floor = "floors_exterior_street_01_0"
    self.sprites.wallW = "walls_exterior_house_02_16"
    self.sprites.wallN = "walls_exterior_house_02_17"
    self.sprites.wallNW = "walls_exterior_house_02_18"
    self.sprites.wallSE = "walls_exterior_house_02_19"
    self.sprites.doorframeN = "walls_exterior_house_02_27"
    self.sprites.doorN = "fixtures_doors_01_57"

    self.deco1 = "location_business_office_generic_01_36"
    self.deco2 = "location_business_office_generic_01_37"

    self.furnitureArea = {
        x1 = x,
        y1 = y + 1,
        x2 = x + self.dx,
        y2 = y + self.dy,
    }

    self.furnitureMap = {}

    self.furniture = {
        ["logs"] = {
            chance = 100,
            dirs = {
                n = {
                    [1] = {x=0, y=0, name="camping_01_28"},
                    [2] = {x=1, y=0, name="camping_01_29"},
                },
                s = {
                    [1] = {x=0, y=0, name="camping_01_28"},
                    [2] = {x=1, y=0, name="camping_01_29"},
                }
            }
        },
        ["stove"] = {
            chance = 100,
            dirs = {
                n = {[1] = {x=0, y=0, name="appliances_cooking_01_18"}},
                s = {[1] = {x=0, y=0, name="appliances_cooking_01_17"}},
                w = {[1] = {x=0, y=0, name="appliances_cooking_01_19"}},
                e = {[1] = {x=0, y=0, name="appliances_cooking_01_16"}},
            }
        },
        ["toilet"] = {
            chance = 100,
            dirs = {
                n = {[1] = {x=0, y=0, name="fixtures_bathroom_01_3"}},
                s = {[1] = {x=0, y=0, name="fixtures_bathroom_01_0"}},
                w = {[1] = {x=0, y=0, name="fixtures_bathroom_01_2"}},
                e = {[1] = {x=0, y=0, name="fixtures_bathroom_01_1"}},
            }
        },
        ["armchair"] = {
            chance = 100,
            dirs = {
                n = {[1] = {x=0, y=0, name="furniture_seating_indoor_01_11"}},
                s = {[1] = {x=0, y=0, name="furniture_seating_indoor_01_9"}},
                w = {[1] = {x=0, y=0, name="furniture_seating_indoor_01_10"}},
                e = {[1] = {x=0, y=0, name="furniture_seating_indoor_01_8"}},
            }
        },
        ["table"] = {
            chance = 100,
            dirs = {
                n = {
                    [1] = {x=0, y=0, name="carpentry_01_28"},
                    [2] = {x=1, y=0, name="carpentry_01_29"},
                },
                s = {
                    [1] = {x=0, y=0, name="carpentry_01_28"},
                    [2] = {x=1, y=0, name="carpentry_01_29"},
                },
                w = {
                    [1] = {x=0, y=0, name="carpentry_01_31"},
                    [2] = {x=0, y=1, name="carpentry_01_30"},
                },
                e = {
                    [1] = {x=0, y=0, name="carpentry_01_31"},
                    [2] = {x=0, y=1, name="carpentry_01_30"},
                },
            }
        },
        ["matress1"] = {
            chance = 100,
            dirs = {
                n = {
                    [1] = {x=0, y=0, name="carpentry_02_76"},
                    [2] = {x=1, y=0, name="carpentry_02_77"},
                },
                s = {
                    [1] = {x=0, y=0, name="carpentry_02_76"},
                    [2] = {x=1, y=0, name="carpentry_02_77"},
                },
                w = {
                    [1] = {x=0, y=0, name="carpentry_02_79"},
                    [2] = {x=0, y=1, name="carpentry_02_78"},
                },
                e = {
                    [1] = {x=0, y=0, name="carpentry_02_79"},
                    [2] = {x=0, y=1, name="carpentry_02_78"},
                },
            }
        },
        ["matress2"] = {
            chance = 90,
            dirs = {
                n = {
                    [1] = {x=0, y=0, name="carpentry_02_76"},
                    [2] = {x=1, y=0, name="carpentry_02_77"},
                },
                s = {
                    [1] = {x=0, y=0, name="carpentry_02_76"},
                    [2] = {x=1, y=0, name="carpentry_02_77"},
                },
                w = {
                    [1] = {x=0, y=0, name="carpentry_02_79"},
                    [2] = {x=0, y=1, name="carpentry_02_78"},
                },
                e = {
                    [1] = {x=0, y=0, name="carpentry_02_79"},
                    [2] = {x=0, y=1, name="carpentry_02_78"},
                },
            }
        },
        ["matress3"] = {
            chance = 90,
            dirs = {
                c = {
                    [1] = {x=0, y=0, name="carpentry_02_76"},
                    [2] = {x=1, y=0, name="carpentry_02_77"},
                },
            }
        },
        ["matress4"] = {
            chance = 90,
            dirs = {
                c = {
                    [1] = {x=0, y=0, name="carpentry_02_76"},
                    [2] = {x=1, y=0, name="carpentry_02_77"},
                },
            }
        },
        ["tablesmall"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="carpentry_02_10"}}}},
        ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_44"}}}},
        ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_45"}}}},
        ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_46"}}}},
        ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_47"}}}},
        ["barrel"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="crafted_01_32"}}}},
        ["oxygen"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="industry_03_7"}}}},
        ["woodscrap1"] = {chance = 100, blocks=false, dirs = {c = {[1] = {x=0, y=0, name="fencing_damaged_01_137"}}}},
        ["woodscrap2"] = {chance = 100, blocks=false, dirs = {c = {[1] = {x=0, y=0, name="fencing_damaged_01_138"}}}},
        ["woodscrap3"] = {chance = 100, blocks=false, dirs = {c = {[1] = {x=0, y=0, name="fencing_damaged_01_139"}}}},
        ["trash1"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
        ["trash2"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
        ["trash3"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
        ["trash4"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
        ["trash5"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
        ["palette"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="construction_01_5"}}}},


    }

    self.container1 = "trashcontainers_01_27"
    self.container2 = "furniture_storage_02_16"
    self.shelf = "carpentry_02_68"
    self.oxygen = "industry_03_7"
    self.barrel1 = "crafted_01_32"
    self.barrel2 = "industry_01_23"

    self.matress1 = "carpentry_02_78" --76
    self.matress2 = "carpentry_02_79" -- 77

    self.armchair1 = "furniture_seating_01_44" -- 45

    self.armchair2 = "furniture_seating_indoor_01_8" -- 8=E, 9=S, 10=W, 11=N

    -- vars
    self.x = x
    self.y = y

    return self
end