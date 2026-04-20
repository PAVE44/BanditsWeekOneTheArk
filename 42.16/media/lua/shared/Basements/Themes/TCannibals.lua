require "BWOABandit"

BasementThemes = BasementThemes or {}

local theme = {}

theme.cid = Bandit.clanMap.BasementCannibals

theme.sprites = {}
theme.sprites.stairs1 = "fixtures_stairs_01_64"
theme.sprites.stairs2 = "fixtures_stairs_01_65"
theme.sprites.stairs3 = "fixtures_stairs_01_66"
theme.sprites.floor = "floors_exterior_street_01_0"
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
            {["Bandits.HumanMeat"] = 1},
            {["Bandits.HumanBrain"] = 1},
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
            {["Base.Salt"] = 1},
            {["Base.Pepper"] = 1},
            {["Base.Hotsauce"] = 1},
            {["Base.PowderedGarlic"] = 1},
            {["Base.Ketchup"] = 2},
            {["Base.MayonnaiseFull"] = 1},
            {["Bandits.HumanMeat"] = 7},
            {["Bandits.MincedHumanMeat"] = 7},
            {["Bandits.HumanBrain"] = 2},
            {["Base.Pot"] = 2},
            {["Base.Saucepan"] = 2},
            {["Base.Vodka"] = 1},
            {["Base.JerryCan"] = 4},
            {["Base.Battery"] = 4},
            {["Base.Book"] = 3},
            {["Base.CandleBox"] = 1},
            {["Base.Matches"] = 3},
            {["Base.CigaretteSingle"] = 7},
            {["Base.FirstAidKit"] = 1},
            {["Base.Garbagebag"] = 3},
            {["Base.Garbagebag"] = 1},
            {["Base.Handtorch"] = 1},
            {["Base.BaseballBat"] = 1},
            {["Base.RevolverCase1"] = 1},
            {["Base.Handaxe"] = 1},
            {["Base.HazmatSuitBlack"] = 1},
            {["Base.Apron_Black"] = 3},
            {["Base.GasmaskFilter"] = 3},
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
    ["tablesmall"] = {
        chance = 100, 
        items = {
            {["Base.BookButchering1"] = 1},
            {["Base.BookButchering2"] = 1},
            {["Base.BookButchering3"] = 1},
            {["Base.BookButchering4"] = 1},
            {["Base.BookButchering5"] = 1},
        },
        dirs = {
            c = {
                [1] = {x=0, y=0, name="carpentry_02_10"}
            }
        }
    },
    ["poster"] = {
        chance = 100,
        attachment = true,
        dirs = {
            s = {
                [1] = {x=0, y=0, name="location_community_medical_01_11"},
            },
            e = {
                [1] = {x=0, y=0, name="location_community_medical_01_12"},
            },
        }
    },
    ["saw"] = {chance = 200, dirs = {c = {[1] = {x=0, y=0, name="industry_02_155"}}}},
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

theme.items = {
    {["Base.Shoes_BlackBoots"] = 1},
    {["Base.Book"] = 2},
    {["Base.TinCanEmpty"] = 3},
    {["Base.TinCanEmpty"] = 3},
    {["Base.ToiletPaper"] = 4},
    {["Base.Bucket"] = 1},
    {["Base.Bucket"] = 1},
    {["Base.Bucket"] = 1},
    {["Base.Bucket"] = 1},
    {["Base.SmashedBottle"] = 1},
    {["Base.SmashedBottle"] = 1},
    {["Base.SmashedBottle"] = 1},
    {["Base.SmashedBottle"] = 2},
    {["Bandits.HumanBone"] = 4},
    {["Bandits.HumanBone"] = 3},
    {["Bandits.HumanBone"] = 7},
    {["Bandits.HumanBone"] = 2},
    {["Bandits.HumanBone"] = 5},
    {["Bandits.HumanBone"] = 3},
    {["Bandits.HumanBrain"] = 1},
    {["Bandits.HumanBone"] = 11},
    {["Bandits.HumanBone"] = 1},
    {["Bandits.HumanBone"] = 4},
    {["Bandits.HumanBone"] = 8},
    {["Base.Hominid_Skull"] = 1},
    {["Base.Hominid_Skull"] = 1},
    {["Base.Hominid_Skull"] = 1},
    {["Base.Hominid_Skull"] = 2},
    {["Base.WaterDispenserBottle"] = 1},
    {["Base.WaterBottle"] = 2},
    {["Base.Lantern_Hurricane"] = 1},
    {["Base.Bag_WeaponBag"] = 1},
    {["Base.FirewoodBundle"] = 3},
    {["Base.Bag_TrashBag"] = 1},
    {["Base.Gin"] = 1},
    {["Base.CardDeck"] = 1},
    {["Base.CheckerBoard"] = 1},
    {["Base.RippedSheets"] = 1},
    {["Base.RippedSheets"] = 3},
    {["Base.RippedSheets"] = 3},
    {["Base.RippedSheets"] = 3},
    {["Base.RippedSheets"] = 1},
    {["Base.ClubHammer"] = 1},
    {["Base.Saw"] = 1},
    {["Base.SmallSaw"] = 1},
    {["Base.Scalpel"] = 1},
    {["Base.KitchenKnife"] = 1},
    {["Base.KitchenKnife"] = 1},
    {["Base.MeatCleaver"] = 1},
    {["Base.MeatCleaver"] = 1},
    {["Base.MeatCleaver"] = 1},
    {["Base.HacksawBlade"] = 1},
    {["Base.CircularSawblade"] = 1},
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
    {["Base.Jumper_VNeck"] = 2},
    {["Base.Socks_Long"] = 3},
    {["Base.Pillow"] = 1},
    {["Base.Trousers"] = 1},
    {["Base.Tshirt_WhiteLongSleeveTINT"] = 1},
    {["Base.Tshirt_WhiteLongSleeveTINT"] = 1},
    {["Base.Tshirt_WhiteTINT"] = 1},
    {["Base.Tshirt_WhiteTINT"] = 1},
    {["Base.Tshirt_WhiteTINT"] = 1},
    {["Base.Tshirt_WhiteTINT"] = 1},
    {["Base.Briefs_Rag"] = 2},
    {["Base.Briefs_Rag"] = 1},
    {["Base.Skirt_Normal"] = 1},
    {["Base.Razor"] = 2},
    {["Base.Dung_Rat"] = 1},
    {["Base.Dung_Rat"] = 1},
    {["Base.Dung_Rat"] = 1},
    {["Base.Dung_Rat"] = 1},
    {["Base.CookingMag5"] = 1},
}

theme.corpses = {
    ["corpse1"] = {
        chance = 200, 
        femaleChance = 50,
        outfits = {"Naked"},
    },
    ["corpse2"] = {
        chance = 200, 
        femaleChance = 50,
        outfits = {"Naked"},
    },
}

BasementThemes["cannibals"] = theme

