BWOARecipes = BWOARecipes or {}

BWOARecipes.tab = {
    ["Salad"] = {
        name = "Salad",
        vessel = "Base.Bowl",
        vesselCnt = 2,
        ingredients = {
            "Base.Tomato", 
            "Base.Lettuce", 
            "Base.Cucumber", 
            "Base.BellPepper", 
            "Base.Cabbage", 
            "Base.Carrots", 
            "Base.Leek", 
            "Base.Kale", 
            "Base.Broccoli", 
            "Base.Cauliflower", 
            "Base.Spinach", 
            "Base.Zucchini", 
            "Base.Avocado", 
            "Base.Onion",
            "Base.Turnip",
            "Base.Radish",
            "Base.Peanuts",
            "Base.Corn",
        },
        ingredientsCnt = 2,
        result = "Base.Salad",
        sound = "CraftPrepareCooking"
    },
    ["Oatmeal"] = {
        name = "Oatmeal",
        vessel = "Base.Bowl",
        vesselCnt = 3,
        ingredients = {
            "Base.OatsRaw", 
        },
        ingredientsCnt = 1,
        result = "Base.Oatmeal",
        sound = "CraftPrepareCooking"
    },
    ["BeanBowl"] = {
        name = "BeanBowl",
        vessel = "Base.Bowl",
        vesselCnt = 3,
        ingredients = {
            "Base.TinnedBeans", 
        },
        ingredientsCnt = 1,
        result = "Base.BeanBowl",
        sound = "CraftPrepareCooking"
    },
    ["Roast"] = {
        name = "Roast",
        vessel = "Base.RoastingPan",
        vesselCnt = 1,
        ingredients = {
            "Base.BellPepper", 
            "Base.Onion",
            "Base.Cabbage", 
            "Base.Carrots", 
            "Base.Potato", 
            "Base.Eggplant", 
            "Base.Leek", 
            "Base.Broccoli", 
            "Base.Cauliflower", 
            "Base.SweetPotato", 
            "Base.SugarBeet",
            "Base.Zucchini", 
        },
        ingredientsCnt = 4,
        cook = true,
        result = "Base.PanFriedVegetables2",
        sound = "CraftPrepareCooking"
    }
}

BWOARecipes.GetRecipe = function(recipeName)
    return BWOARecipes.tab[recipeName]
end
