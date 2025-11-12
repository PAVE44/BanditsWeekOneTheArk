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
    local cell = getCell()
    local sx, sy, sz = self.x, self.y, self.z
    local dx, dy = self.dx, self.dy

    for x = sx, sx + dx do
        for y = sy + 1, sy + dy do
            local square = getCell():getGridSquare(x, y, sz)
            square:getProperties():UnSet(IsoFlagType.exterior)
            square:setRoom(self.room)
            square:setRoomID(self.room:getRoomDef():getID())
            self.room:addSquare(square)
        end
    end
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
    local dx, dy = self.dx, self.dy

    local stairs = {
        [1] = {
            x = sx,
            y = sy,
            z = sz,
            spriteName = self.sprites.stairs3
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
        local squareUp = cell:getGridSquare(stair.x, stair.y, 0)
        local objects = squareUp:getObjects()
        for i = objects:size()-1, 0, -1 do
            local object = objects:get(i)
            squareUp:transmitRemoveItemFromSquare(object)
        end
        squareUp:setSquareChanged()

        BWOABuildTools.Generic (stair.x, stair.y, stair.z, stair.spriteName)
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
    local sx, sy, sz = self.x, self.y, self.z
    local dx, dy = self.dx, self.dy

    for fname, fconfig in pairs(self.furniture) do
        if fconfig.chance > ZombRand(100) then
            local done = false
            for _, fmap in ipairs(self.furnitureMap) do
                if not done and not fmap.taken then
                    for dir, dirs in pairs(fconfig.dirs) do
                        if dir == fmap.dir then
                            local allGood = true
                            for _, sconfig in ipairs(dirs) do
                                local square = cell:getGridSquare(fmap.x + sconfig.x, fmap.y + sconfig.y, sz)
                                if not square or not square:isFree(false) then
                                    allGood = false
                                    break
                                end
                            end

                            if allGood then
                                for _, sconfig in ipairs(dirs) do
                                    local bx, by, bz = fmap.x + sconfig.x, fmap.y + sconfig.y, sz
                                    if fconfig.fireplace then
                                        BWOABuildTools.Fireplace (bx, by, bz, sconfig.name)
                                    else
                                        BWOABuildTools.Generic (bx, by, bz, sconfig.name)
                                    end

                                    for _, f in ipairs(self.furnitureMap) do 
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

function BWOABasements.Generic:placeLights()
    for _, fmap in ipairs(self.furnitureMap) do
        if fmap.surface then
            local rndOpts = {8, 9, 10, 11, 12, 13, 32, 33, 34, 35, 36, 37, 40, 41, 42, 43, 44, 45, 48, 49, 50, 51, 52, 53}
            local rnd = BanditUtils.Choice(rndOpts)
            BWOABuildTools.LampBattery(fmap.x, fmap.y, self.z, "lighting_indoor_01_" .. rnd)
        end
    end
end

function BWOABasements.Generic:placeItems()
    local cell = getCell()

    -- containers
    for _, fmap in ipairs(self.furnitureMap) do
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

    -- floor
    local items = self.items
    local j = 1
    for _, fmap in ipairs(self.furnitureMap) do
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

function BWOABasements.Generic:populate()
    local player = getSpecificPlayer(0)
    if not player then return end

    local args = {}
    args.cid = Bandit.clanMap.BasementWeak
    args.x = self.x + 5
    args.y = self.y + 3
    args.z = self.z
    args.program = "Basement"
    args.size = 4
    -- args.permanent = true
    sendClientCommand(player, 'Spawner', 'Clan', args)
end

function BWOABasements.Generic:build()
    self:buildFloors()
    self:buildCeiling()
    self:buildWalls()
    self:buildStairs()
    self:makeRoom()
    self:placeFurniture()
    self:placeLights()
    self:placeItems()
    self:populate()
end

function BWOABasements.Generic:new(x, y, room)
    local self = setmetatable({}, BWOABasements.Generic)

    -- const
    self.name = "Generic"
    self.dx = 6 + ZombRand(4)
    self.dy = 4 + ZombRand(3)

    self.sprites = {}
    self.sprites.stairs1 = "fixtures_stairs_01_64"
    self.sprites.stairs2 = "fixtures_stairs_01_65"
    self.sprites.stairs3 = "fixtures_stairs_01_66"
    self.sprites.floor = "floors_exterior_street_01_0"
    self.sprites.ceiling = "carpentry_02_58"

    self.sprites.wallOptions = {
        [1] = { -- small brick grayish
            wallW = "walls_exterior_house_02_16",
            wallN = "walls_exterior_house_02_17",
            wallNW = "walls_exterior_house_02_18",
            wallSE = "walls_exterior_house_02_19",
            doorframeN = "walls_exterior_house_02_27",
        },
        [2] = { -- small brick orange
            wallW = "walls_exterior_house_02_36",
            wallN = "walls_exterior_house_02_37",
            wallNW = "walls_exterior_house_02_38",
            wallSE = "walls_exterior_house_02_39",
            doorframeN = "walls_exterior_house_02_47",
        },
        [3] = { -- small brick orange
            wallW = "walls_exterior_house_01_16",
            wallN = "walls_exterior_house_01_17",
            wallNW = "walls_exterior_house_01_18",
            wallSE = "walls_exterior_house_01_19",
            doorframeN = "walls_exterior_house_01_27",
        },
        [4] = { -- small brick red
            wallW = "walls_exterior_house_01_52",
            wallN = "walls_exterior_house_01_53",
            wallNW = "walls_exterior_house_01_54",
            wallSE = "walls_exterior_house_01_55",
            doorframeN = "walls_exterior_house_01_27",
        },
        [5] = { -- large brick
            wallW = "location_community_school_01_0",
            wallN = "location_community_school_01_1",
            wallNW = "location_community_school_01_2",
            wallSE = "location_community_school_01_3",
            doorframeW = "location_community_school_01_10",
            doorframeN = "location_community_school_01_11",
        }
    }
    
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
    self:recalcFurnitureArea()

    self.furniture = {
        ["logs"] = {
            chance = 100,
            items = {
                {["Base.Log"] = 2},
                {["Base.Firewood"] = 8},
            },
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
            items = {
                {["Base.Pot"] = 1},
                {["Base.Firewood"] = 3},
            },
            fireplace = 1,
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
        ["water"] = {
            chance = 100,
            dirs = {
                n = {[1] = {x=0, y=0, name="location_business_office_generic_01_57"}},
                s = {[1] = {x=0, y=0, name="location_business_office_generic_01_49"}},
                w = {[1] = {x=0, y=0, name="location_business_office_generic_01_56"}},
                e = {[1] = {x=0, y=0, name="location_business_office_generic_01_48"}},
            }
        },
        ["shelves"] = {
            chance = 100,
            items = {
                {["Base.CannedBolognese"] = 1},
                {["Base.TinnedSoup"] = 1},
                {["Base.CannedSardines"] = 1},
                {["Base.CannedCorn"] = 1},
                {["Base.CannedMushroomSoup"] = 1},
                {["Base.CannedCornedBeef"] = 1},
                {["Base.TunaTin"] = 1},
                {["Base.CannedFruitCocktail"] = 1},
                {["Base.CannedPotato2"] = 1},
                {["Base.CannedCarrots2"] = 1},
                {["Base.Pasta"] = 1},
                {["Base.Rice"] = 2},
                {["Base.OatsRaw"] = 1},
                {["Base.DriedLentils"] = 1},
                {["Base.Vodka"] = 1},
                {["Base.JerryCan"] = 4},
                {["Base.Battery"] = 4},
                {["Base.Book"] = 3},
                {["Base.CandleBox"] = 1},
                {["Base.Matches"] = 3},
                {["Base.CigaretteSingle"] = 7},
                {["Base.BeefJerky"] = 1},
                {["Base.Pop2"] = 2},
                {["Base.FirstAidKit"] = 1},
                {["Base.Garbagebag"] = 3},
                {["Base.Handtorch"] = 1},
                {["Base.PistolCase1"] = 1},
                {["Base.RevolverCase1"] = 1},
                {["Base.Handaxe"] = 1},
                {["Base.HazmatSuitBlack"] = 1},
                {["Base.GasmaskFilter"] = 7},
            },
            dirs = {
                n = {
                    [1] = {x=0, y=0, name="furniture_shelving_01_26"},
                    [2] = {x=1, y=0, name="furniture_shelving_01_27"},
                },
                s = {
                    [1] = {x=0, y=0, name="furniture_shelving_01_26"},
                    [2] = {x=1, y=0, name="furniture_shelving_01_27"},
                },
                w = {
                    [1] = {x=0, y=0, name="furniture_shelving_01_25"},
                    [2] = {x=0, y=1, name="furniture_shelving_01_24"},
                },
                e = {
                    [1] = {x=0, y=0, name="furniture_shelving_01_25"},
                    [2] = {x=0, y=1, name="furniture_shelving_01_24"},
                },
            }
        },
        ["table"] = {
            chance = 100,
            surface = true,
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

    self.items = {
        {["Base.Shoes_BlackBoots"] = 1},
        {["Base.Book"] = 2},
        {["Base.TinCanEmpty"] = 3},
        {["Base.TinCanEmpty"] = 3},
        {["Base.ToiletPaper"] = 3},
        {["Base.Bucket"] = 1},
        {["Base.SmashedBottle"] = 1},
        {["Base.SmashedBottle"] = 1},
        {["Base.WaterDispenserBottle"] = 1},
        {["Base.WaterBottle"] = 2},
        {["Base.Lantern_Hurricane"] = 1},
        {["Base.Bag_WeaponBag"] = 1},
        {["Base.FirewoodBundle"] = 1},
        {["Base.Bag_TrashBag"] = 1},
        {["Base.Gin"] = 1},
        {["Base.CardDeck"] = 1},
        {["Base.CheckerBoard"] = 1},
        {["Base.PhotoAlbum"] = 1},
        {["Base.PropaneTank"] = 1},
        {["Base.RippedSheets"] = 1},
        {["Base.RippedSheets"] = 3},
        {["Base.RippedSheets"] = 1},
        {["Base.Wine2Open"] = 1},
        {["Base.SoupBowl"] = 1},
        {["Base.Bowl"] = 2},
        {["Base.Yoyo"] = 1},
        {["Base.WoodAxe"] = 1},
        {["Base.Toolbox_Mechanic"] = 1},
        {["Base.Briefs_SmallTrunks_WhiteTINT"] = 1},
        {["Base.Vest_DefaultTEXTURE_TINT"] = 1},
        {["Base.Tshirt_WhiteTINT"] = 1},
        {["Base.Jumper_RoundNeck"] = 1},
        {["Base.Jumper_VNeck"] = 1},
        {["Base.Socks_Long"] = 3},
        {["Base.Pillow"] = 1},
    }

    -- vars
    self.room = room
    self.x = x
    self.y = y
    self.z = -1

    return self
end