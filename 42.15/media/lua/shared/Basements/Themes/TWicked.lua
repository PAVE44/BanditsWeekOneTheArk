require "BWOABandit"

BasementThemes = BasementThemes or {}

local theme = {}

theme.cid = Bandit.clanMap.BasementWicked

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
    ["wardrobe"] = {
        chance = 200,
        items = {
            {["Base.Candle"] = 33},
            {["Base.Matches"] = 8},
            {["Base.Whistle_Bone"] = 1},
            {["Base.PowderedGarlic"] = 1},
            {["Base.Dice_Bone"] = 2},
            {["Base.Needle_Bone"] = 1},
            {["Base.LongStick"] = 2},
            {["Base.Broom"] = 2},
            {["Base.FirewoodBundle"] = 2},
            {["Base.Hat_HalloweenMaskWitch"] = 1},
            {["Base.BlackRobe"] = 4},
            {["Base.LavenderPetalsDried"] = 4},
            {["Base.MintHerbDried"] = 4},
            {["Base.RosePetalsDried"] = 4},
            {["Base.RosemaryDried"] = 4},
            {["Base.BlackSageDried"] = 4},
            {["Base.ChamomileDried"] = 4},
            {["Base.CommonMallowDried"] = 4},
            {["Base.MarigoldDried"] = 4},
            {["Base.TobaccoDried"] = 4},
            {["Base.WildGarlicDried"] = 4},
            {["Base.PlantainDried"] = 4},
            {["Base.MortarPestle"] = 1},
            {["Base.Twine"] = 3},
        },
        dirs = {
            s = {
                [1] = {x=0, y=0, name="furniture_storage_01_38"},
                [2] = {x=1, y=0, name="furniture_storage_01_39"},
            },
            e = {
                [1] = {x=0, y=0, name="furniture_storage_01_37"},
                [2] = {x=0, y=1, name="furniture_storage_01_36"},
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
    ["tablesmall"] = {
        chance = 100, 
        items = {
            {["Base.Book_Occult"] = 3},
            {["Base.Paperback_Occult"] = 5},
            {["Base.Book_Horror"] = 6},
        },
        dirs = {
            c = {
                [1] = {x=0, y=0, name="carpentry_02_10"}
            }
        }
    },
    ["chair"] = {chance = 33, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_44"}}}},
    ["chair"] = {chance = 33, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_45"}}}},
    ["chair"] = {chance = 33, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_46"}}}},
    ["chair"] = {chance = 33, dirs = {c = {[1] = {x=0, y=0, name="carpentry_01_47"}}}},
    ["barrel"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="crafted_01_32"}}}},
    ["woodscrap1"] = {chance = 100, blocks=false, dirs = {c = {[1] = {x=0, y=0, name="fencing_damaged_01_137"}}}},
    ["woodscrap2"] = {chance = 100, blocks=false, dirs = {c = {[1] = {x=0, y=0, name="fencing_damaged_01_138"}}}},
    ["woodscrap3"] = {chance = 100, blocks=false, dirs = {c = {[1] = {x=0, y=0, name="fencing_damaged_01_139"}}}},
    ["trash1"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash2"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash3"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash4"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["trash5"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="trash_01_" .. tostring(ZombRand(53))}}}},
    ["palette"] = {chance = 100, dirs = {c = {[1] = {x=0, y=0, name="construction_01_5"}}}},
    ["mannequin"] = {
        chance = 100, 
        mannequin = true,
        dirs = {
            c = {
                [1] = {x=0, y=0, script="Wizard", dir=IsoDirections.N}
            },
            n = {
                [1] = {x=0, y=0, script="Wizard", dir=IsoDirections.N}
            },
            s = {
                [1] = {x=0, y=0, script="Wizard", dir=IsoDirections.S}
            },
            w = {
                [1] = {x=0, y=0, script="Wizard", dir=IsoDirections.W}
            },
            e = {
                [1] = {x=0, y=0, script="Wizard", dir=IsoDirections.E}
            },

        }
    },


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
    {["Base.WaterDispenserBottle"] = 1},
    {["Base.WaterBottle"] = 2},
    {["Base.Lantern_Hurricane"] = 1},
    {["Base.Bag_WeaponBag"] = 1},
    {["Base.FirewoodBundle"] = 3},
    {["Base.Bag_TrashBag"] = 1},
    {["Base.Gin"] = 1},
    {["Base.OujaBoard"] = 1},
    {["Base.OujaBoard"] = 1},
    {["Base.OujaBoard"] = 1},
    {["Base.TarotCardDeck"] = 1},
    {["Base.TarotCardDeck"] = 1},
    {["Base.TarotCardDeck"] = 1},
    {["Base.Crystal"] = 1},
    {["Base.Doll"] = 6},
    {["Base.Doll"] = 1},
    {["Base.Doll"] = 2},
    {["Base.Doll"] = 1},
    {["Base.Doll"] = 3},
    {["Base.Doll"] = 1},
    {["Base.Doll"] = 1},
    {["Base.Doll"] = 1},
    {["Base.Doll"] = 2},
    {["Base.Doll"] = 6},
    {["Base.Doll"] = 4},
    {["Base.Doll"] = 11},
    {["Base.Bull_Skull"] = 1},
    {["Base.Bull_Skull"] = 1},
    {["Base.Cow_Skull"] = 1},
    {["Base.Cow_Skull"] = 1},
    {["Base.Calf_Skull"] = 1},
    {["Base.Calf_Skull"] = 1},
    {["Base.Hat_Witch"] = 1},
    {["Base.GobletSilver"] = 1},
    {["Base.Necklace_Teeth"] = 1},
    {["Base.Specimen_Brain"] = 3},
    {["Base.Specimen_FetalCalf"] = 2},
    {["Base.Specimen_FetalLamb"] = 2},
    {["Base.Specimen_FetalPiglet"] = 2},
    {["Base.Specimen_MonkeyHead"] = 2},
    {["Base.Specimen_Octopus"] = 2},
    {["Base.Specimen_Tapeworm"] = 4},
    {["Base.Specimen_Tapeworm"] = 3},
    {["Base.Specimen_Tapeworm"] = 2},
    {["Base.Specimen_Centipedes"] = 6},
    {["Base.Specimen_Centipedes"] = 6},
    {["Base.RippedSheets"] = 1},
    {["Base.RippedSheets"] = 3},
    {["Base.RippedSheets"] = 3},
    {["Base.RippedSheets"] = 3},
    {["Base.RippedSheets"] = 1},
    {["Base.Wine2Open"] = 1},
    {["Base.SoupBowl"] = 1},
    {["Base.Bowl"] = 2},
    {["Base.MortarPestle"] = 1},
    {["Base.SpearCrafted"] = 1},
    {["Base.Book_Horror"] = 2},
    {["Base.Book_Occult"] = 2},
    {["Base.BookFancy_Occult"] = 1},
    {["Base.Paperback_Occult"] = 1},
    {["Base.Paperback_Occult"] = 1},
    {["Base.HerbalistMag"] = 1},
    {["Base.Worm"] = 3},
    {["Base.Worm"] = 3},
    {["Base.Worm"] = 3},
    {["Base.Worm"] = 3},
    {["Base.Worm"] = 3},
    {["Base.Worm"] = 3},
    {["Base.Millipede"] = 3},
    {["Base.Millipede"] = 3},
    {["Base.Millipede"] = 3},
    {["Base.Millipede2"] = 3},
    {["Base.Millipede2"] = 3},
    {["Base.Millipede2"] = 3},
    {["Base.Centipede"] = 3},
    {["Base.Centipede"] = 3},
    {["Base.Centipede"] = 3},
    {["Base.Centipede2"] = 3},
    {["Base.Centipede2"] = 3},
    {["Base.Centipede2"] = 3},
    {["Base.Frog"] = 1},
    {["Base.Dung_Rat"] = 1},
    {["Base.Dung_Rat"] = 1},
    {["Base.Dung_Rat"] = 1},
    {["Base.Dung_Rat"] = 1},
    {["Base.NailsBox"] = 1},
    {["Base.Garbagebag"] = 2},
    
}

theme.corpses = {}

BasementThemes["wicked"] = theme
