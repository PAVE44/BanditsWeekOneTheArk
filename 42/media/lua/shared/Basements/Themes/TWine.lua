require "BWOABandit"

BasementThemes = BasementThemes or {}

local theme = {}

theme.cid = Bandit.clanMap.BasementGeneric

theme.sprites = {}
theme.sprites.stairs1 = "fixtures_stairs_01_64"
theme.sprites.stairs2 = "fixtures_stairs_01_65"
theme.sprites.stairs3 = "fixtures_stairs_01_66"
theme.sprites.floor = "floors_interior_tilesandwood_01_41"
theme.sprites.ceiling = "carpentry_02_58"

theme.sprites.wallOptions = {
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

theme.sprites.doorN = "fixtures_doors_01_57"

theme.deco1 = "location_business_office_generic_01_36"
theme.deco2 = "location_business_office_generic_01_37"

theme.furniture = {
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
        chance = 1000,
        items = {
            {["Base.Pot"] = 1},
            {["Base.Firewood"] = 3},
        },
        fireplace = true,
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
            {["Base.WineRed_Boxed"] = 6},
            {["Base.WineBox"] = 3},
            {["Base.CannedSardines"] = 1},
            {["Base.CannedCorn"] = 1},
            {["Base.CannedMushroomSoup"] = 1},
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
    ["barrelshelf"] = {
        chance = 100,
        dirs = {
            n = {
                [1] = {x=0, y=0, name="location_business_distillery_01_4"},
                [2] = {x=1, y=0, name="location_business_distillery_01_4"},
                [3] = {x=2, y=0, name="location_business_distillery_01_3"},
            },
            s = {
                [1] = {x=0, y=0, name="location_business_distillery_01_4"},
                [2] = {x=1, y=0, name="location_business_distillery_01_4"},
                [3] = {x=2, y=0, name="location_business_distillery_01_3"},
            },
            w = {
                [1] = {x=0, y=0, name="location_business_distillery_01_0"},
                [2] = {x=0, y=1, name="location_business_distillery_01_2"},
                [3] = {x=0, y=2, name="location_business_distillery_01_2"},
                [4] = {x=0, y=3, name="location_business_distillery_01_1"},
            },
            e = {
                [1] = {x=0, y=0, name="location_business_distillery_01_0"},
                [2] = {x=0, y=1, name="location_business_distillery_01_2"},
                [3] = {x=0, y=2, name="location_business_distillery_01_2"},
                [4] = {x=0, y=3, name="location_business_distillery_01_1"},
            },
        }
    },
    ["tablesmall"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="carpentry_02_10"}}}},
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_44"}}}},
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_45"}}}},
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_46"}}}},
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_47"}}}},
    ["barrel1"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="location_business_distillery_01_8"}}}},
    ["barrel2"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="location_business_distillery_01_8"}}}},
    ["barrel3"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="location_business_distillery_01_9"}}}},
    ["barrel4"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="location_business_distillery_01_10"}}}},
    ["barrel5"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="location_business_distillery_01_10"}}}},
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

theme.items = {
    {["Base.Wine2"] = 1},
    {["Base.Wine2"] = 1},
    {["Base.Wine2"] = 2},
    {["Base.WineAged"] = 3},
    {["Base.Wine2"] = 5},
    {["Base.Wine2"] = 8},
    {["Base.Wine2"] = 7},
    {["Base.Wine2"] = 13},
    {["Base.Smashedbottle"] = 3},
    {["Base.Smashedbottle"] = 1},
    {["Base.Smashedbottle"] = 1},
    {["Base.Smashedbottle"] = 2},
    {["Base.SmashedBottle"] = 1},
    {["Base.SmashedBottle"] = 1},
    {["Base.Book"] = 2},
    {["Base.TinCanEmpty"] = 3},
    {["Base.TinCanEmpty"] = 3},
    {["Base.TinCanEmpty"] = 2},
    {["Base.TinCanEmpty"] = 1},
    {["Base.ToiletPaper"] = 3},
    {["Base.Bucket"] = 1},
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

theme.corpses = {}

BasementThemes["wine"] = theme
