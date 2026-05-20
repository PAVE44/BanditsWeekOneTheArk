require "ClothingSelectionDefinitions"

ClothingSelectionDefinitions = ClothingSelectionDefinitions or {}

for k, v in pairs(ClothingSelectionDefinitions) do
	ClothingSelectionDefinitions[k] = {Female = {}, Male = {}}
end

ClothingSelectionDefinitions.default = {
    Female = {
        LongDress = {
            chance = 100,
            items = {"Base.HospitalGown"}
        }
    },
    Male = {
        LongDress = {
            chance = 100,
            items = {"Base.HospitalGown"}
        }
    }
}
