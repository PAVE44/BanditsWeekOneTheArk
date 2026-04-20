require "BWOABandit"

BasementThemes = BasementThemes or {}

local theme = {}

theme.cid = Bandit.clanMap.BasementPreppers

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
            {["Base.CannedSardines"] = 1},
            {["Base.CannedCorn"] = 1},
            {["Base.CannedMushroomSoup"] = 1},
            {["Base.CannedChili"] = 1},
            {["Base.CannedPeas"] = 1},
            {["Base.CannedPineapple"] = 1},
            {["Base.CannedBolognese"] = 2},
            {["Base.HazmatSuitUrban"] = 1},
            {["Base.GasmaskFilter"] = 6},
            {["Base.Oxygen_Tank"] = 2},
            {["Base.JerryCan"] = 2},
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
                [3] = {x=0, y=2, name="furniture_shelving_01_25"},
                [4] = {x=0, y=3, name="furniture_shelving_01_24"},
            },
            e = {
                [1] = {x=0, y=0, name="furniture_shelving_01_25"},
                [2] = {x=0, y=1, name="furniture_shelving_01_24"},
            },
        }
    },
    ["lockers"] = {
        chance = 90,
        items = {
            {["Base.AssaultRifle"] = 1},
            {["Base.556Clip"] = 1},
            {["Base.556Box"] = 2},
            {["Base.556Bullets"] = 14},
            {["Base.Pistol2"] = 1},
            {["Base.45Clip"] = 1},
            {["Base.Bullets45"] = 9},
            {["Base.Bullets45Box"] = 1},
            {["Base.FirstAidKit_Military"] = 1},
            {["Base.Jacket_ArmyCamoUrban"] = 2},
            {["Base.Trousers_CamoUrban"] = 2},
            {["Base.Shirt_CamoUrban"] = 2},
            {["Base.Tshirt_CamoUrban"] = 2},
            {["Base.BookAiming1"] = 1},
            {["Base.BookAiming2"] = 1},
            {["Base.BookReloading1"] = 1},
            {["Base.BookReloading2"] = 1},
            {["Base.BookCooking1"] = 1},
            {["Base.WeaponMag1"] = 1},
            {["Base.WeaponMag2"] = 1},
            {["Base.WeaponMag3"] = 1},
            {["Base.WeaponMag4"] = 1},
            {["Base.WeaponMag5"] = 1},
            {["Base.WeaponMag6"] = 1},
            {["Base.WeaponMag7"] = 1},
            {["Base.BlowTorch"] = 1},
            {["Base.WeldingMask"] = 1},
            {["Base.PropaneTank"] = 1},
            {["Base.FishingRod"] = 1},
            {["Base.FishingTackle"] = 1},
            {["Base.FishingTackle2"] = 1},
            {["Base.HamRadio2"] = 7},
            {["Base.EngineParts"] = 4},
            {["Bandits.EngineLubricant"] = 1},
        },
        dirs = {
            n = {
                [1] = {x=0, y=0, name="location_military_generic_01_30"},
                [2] = {x=0, y=0, name="location_military_generic_01_30"},
            },
            s = {
                [1] = {x=0, y=0, name="location_military_generic_01_22"},
                [2] = {x=1, y=0, name="location_military_generic_01_22"},
            },
            w = {
                [1] = {x=0, y=0, name="location_military_generic_01_31"},
                [2] = {x=0, y=1, name="location_military_generic_01_31"},
            },
            e = {
                [1] = {x=0, y=0, name="location_military_generic_01_23"},
                [2] = {x=0, y=1, name="location_military_generic_01_23"},
            },
        }
    },
    ["table"] = {
        chance = 100,
        surface = true,
        dirs = {
            n = {
                [1] = {x=0, y=0, name="furniture_tables_high_01_50"},
                [2] = {x=1, y=0, name="furniture_tables_high_01_51"},
            },
            s = {
                [1] = {x=0, y=0, name="furniture_tables_high_01_50"},
                [2] = {x=1, y=0, name="furniture_tables_high_01_51"},
            },
            w = {
                [1] = {x=0, y=0, name="furniture_tables_high_01_49"},
                [2] = {x=0, y=1, name="furniture_tables_high_01_48"},
            },
            e = {
                [1] = {x=0, y=0, name="furniture_tables_high_01_49"},
                [2] = {x=0, y=1, name="furniture_tables_high_01_48"},
            },
        }
    },
    ["bed1"] = {
        chance = 100,
        dirs = {
            n = {
                [1] = {x=0, y=0, name="furniture_bedding_01_58"},
                [2] = {x=1, y=0, name="furniture_bedding_01_59"},
            },
            s = {
                [1] = {x=0, y=0, name="furniture_bedding_01_58"},
                [2] = {x=1, y=0, name="furniture_bedding_01_59"},
            },
            w = {
                [1] = {x=0, y=0, name="furniture_bedding_01_57"},
                [2] = {x=0, y=1, name="furniture_bedding_01_55"},
            },
            e = {
                [1] = {x=0, y=0, name="furniture_bedding_01_57"},
                [2] = {x=0, y=1, name="furniture_bedding_01_56"},
            },
        }
    },
    ["bed2"] = {
        chance = 90,
        dirs = {
            n = {
                [1] = {x=0, y=0, name="furniture_bedding_01_58"},
                [2] = {x=1, y=0, name="furniture_bedding_01_59"},
            },
            s = {
                [1] = {x=0, y=0, name="furniture_bedding_01_58"},
                [2] = {x=1, y=0, name="furniture_bedding_01_59"},
            },
            w = {
                [1] = {x=0, y=0, name="furniture_bedding_01_57"},
                [2] = {x=0, y=1, name="furniture_bedding_01_56"},
            },
            e = {
                [1] = {x=0, y=0, name="furniture_bedding_01_57"},
                [2] = {x=0, y=1, name="furniture_bedding_01_56"},
            },
        }
    },
    ["usa"] = {
        chance = 1000,
        attachment = true,
        dirs = {
            s = {
                [1] = {x=0, y=0, name="walls_decoration_01_16"},
            },
            e = {
                [1] = {x=0, y=0, name="walls_decoration_01_17"},
            },
        }
    },
    ["worldmap"] = {
        chance = 100,
        dirs = {
            s = {
                [1] = {x=0, y=0, name="location_community_school_01_22"},
                [2] = {x=1, y=0, name="location_community_school_01_23"},
            },
            e = {
                [1] = {x=0, y=0, name="location_community_school_01_31"},
                [1] = {x=0, y=1, name="location_community_school_01_30"},
            },
        }
    },
    ["cork"] = {
        chance = 100,
        dirs = {
            s = {
                [1] = {x=0, y=0, name="location_business_office_generic_01_7"},
            },
            e = {
                [1] = {x=0, y=0, name="location_business_office_generic_01_15"},
            },
        }
    },
    ["chest1"] = {
        chance = 100, 
        items = {
            {["Base.MilitaryMedal"] = 1},
            {["Base.PhotoBook"] = 1},
            {["Base.Photo"] = 1},
            {["Base.Pistol"] = 1},
            {["Base.9mmCLip"] = 1},
            {["Base.Bullets9mm"] = 14},
            {["Base.Briefs_White"] = 2},
            {["Base.Vest_DefaultTEXTURE"] = 2},
            {["Base.Socks_Heavy"] = 3},
        },
        dirs = {
            c = {
                [1] = {x=0, y=0, name="furniture_storage_02_29"}
            }
        }
    },
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="chair_seating_indoor_01_60"}}}},
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="chair_seating_indoor_01_61"}}}},
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="chair_seating_indoor_01_62"}}}},
    ["chair"] = {chance = 25, dirs = {c = {[1] = {x=0, y=0, name="chair_seating_indoor_01_63"}}}},
    ["woodscrap1"] = {chance = 100, blocks=false, dirs = {c = {[1] = {x=0, y=0, name="fencing_damaged_01_137"}}}},
    ["trash1"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash2"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash3"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash4"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash5"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["palette"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="construction_01_5"}}}},


}

theme.items = {
    {["Base.Book"] = 2},
    {["Base.TinCanEmpty"] = 3},
    {["Base.TinCanEmpty"] = 3},
    {["Base.TinCanEmpty"] = 2},
    {["Base.TinCanEmpty"] = 1},
    {["Base.ToiletPaper"] = 3},
    {["Base.ToiletPaper"] = 3},
    {["Base.ToiletPaper"] = 3},
    {["Base.Bucket"] = 1},
    {["Base.WaterDispenserBottle"] = 1},
    {["Base.WaterBottle"] = 2},
    {["Base.Lantern_Hurricane"] = 1},
    {["Base.Bag_WeaponBag"] = 1},
    {["Base.FirewoodBundle"] = 1},
    {["Base.Bag_TrashBag"] = 1},
    {["Base.Gin"] = 1},
    {["Base.Vodka"] = 1},
    {["Base.CardDeck"] = 1},
    {["Base.CheckerBoard"] = 1},
    {["Base.PhotoAlbum"] = 1},
    {["Base.PropaneTank"] = 1},
    {["Base.RippedSheets"] = 1},
    {["Base.RippedSheets"] = 3},
    {["Base.RippedSheets"] = 1},
    {["Base.SoupBowl"] = 1},
    {["Base.Bowl"] = 2},
    {["Base.Yoyo"] = 1},
    {["Base.WoodAxe"] = 1},
    {["Base.Pillow"] = 1},
    {["Base.Pillow"] = 1},
    {["Base.ArmyBoots"] = 3},
    {["Base.TentGreen_Packed"] = 1},
    {["Base.Bag_Satchel_Military"] = 1},
    {["Base.DuctTape"] = 1},
    {["Base.Glue"] = 1},
    {["Base.Woodglue"] = 1},
    {["Base.Rope"] = 1},
    {["Base.ScrewsBox"] = 1},
    {["Base.NailsBox"] = 1},
    {["Base.Wire"] = 2},
    {["Base.MechanicMag1"] = 1},
    {["Base.MechanicMag2"] = 1},
    {["Base.MechanicMag3"] = 1},
}

theme.corpses = {}

BasementThemes["preppers"] = theme
