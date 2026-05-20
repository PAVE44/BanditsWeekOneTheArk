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
    },
    ["StirFry"] = {
        name = "StirFry",
        vessel = "Base.Pan",
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
        result = "Base.PanFriedVegetables",
        sound = "CraftPrepareCooking"
    },
    ["Soup"] = {
        name = "Soup",
        vessel = "Base.Pot",
        vesselCnt = 1,
        ingredients = {
            "Base.Onion", 
            "Base.Tomato",
            "Base.Leek",
            "Base.Cabbage", 
            "Base.Carrots", 
            "Base.Eggplant", 
            "Base.Broccoli", 
            "Base.Cauliflower", 
            "Base.SweetPotato", 
            "Base.Zucchini", 
            "Base.Spinach",
            "Base.Pasta", 
            "Base.DriedBlackBeans",
            "Base.DriedChickpeas",
            "Base.DriedKidneyBeans",
            "Base.DriedLentils",
            "Base.DriedSplitPeas",
            "Base.DriedWhiteBeans",
            "Base.BouillonCube",
            "Base.RedRadish",
            "Base.Potato", 
        },
        ingredientsCnt = 5,
        cook = true,
        result = "Base.PotOfSoupRecipe",
        sound = "CraftPrepareCooking"
    },
}

BWOARecipes.options = {
    ["breakfast"] = {"Salad", "Oatmeal"},
    ["lunch"] = {"StirFry", "Salad", "Soup"},
    ["dinner"] = {"Soup", "Roast", "StirFry"},
}

BWOARecipes.GetOptions = function(optionName)
    return BWOARecipes.options[optionName]
end

BWOARecipes.GetRecipe = function(recipeName)
    return BWOARecipes.tab[recipeName]
end

BWOARecipes.GetAllOutputs = function()
    local outputs = {}
    for _, recipe in pairs(BWOARecipes.tab) do
        table.insert(outputs, recipe.result)
    end

    return outputs
end