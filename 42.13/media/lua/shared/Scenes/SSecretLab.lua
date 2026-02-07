require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.SecretLab = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.SecretLab:placeObjects()
end

function BWOAScenes.SecretLab:placeItems()

    -- first room
    local items
    items = {
        ["Base.Book_Bible"] = 1, ["Base.Book_Religion"] = 14
    }
    BWOAPrepareTools.AddItemsToContainer(5563, 12500, -13, items, "Shelves")

    BWOAPrepareTools.AddWorldItem(5565, 12502, -13, "Base.Note", {x=0.31, y=0.75, z=0.35, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(5565, 12502, -13, "Base.Note", {x=0.20, y=0.46, z=0.35, rx=0, ry=0, rz=20})
    BWOAPrepareTools.AddWorldItem(5565, 12502, -13, "Base.Note", {x=0.20, y=0.65, z=0.35, rx=0, ry=0, rz=45})
    BWOAPrepareTools.AddWorldItem(5565, 12502, -13, "Base.Note", {x=0.93, y=0.88, z=0.35, rx=0, ry=0, rz=350})
    BWOAPrepareTools.AddWorldItem(5565, 12502, -13, "Base.Note", {x=0.95, y=0.80, z=0.35, rx=0, ry=0, rz=350})

    local note1 = BanditCompatibility.InstanceItem("Bandits.Note")
    note1:setCanBeWrite(false)
    note1:setName("Cold Passage and The Management of Death")
    note1:getModData().printContent = "cold_passage"

    BWOAPrepareTools.AddWorldItemSpecial(5565, 12502, -13, note1, {x=0.55, y=0.52, z=0.35, rx=0, ry=0, rz=0})

    -- second room
    BWOAPrepareTools.AddWorldItem(5572, 12497, -13, "Base.Book_Science", {x=0.56, y=0.72, z=0.28, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(5572, 12497, -13, "Base.Glasses_Reading", {x=0.41, y=0.46, z=0.28, rx=0, ry=0, rz=0})

    local items2 = {
        ["Base.Book_Science"] = 24
    }
    BWOAPrepareTools.AddItemsToContainer(5572, 12500, -13, items2, "Shelves")

    BWOAPrepareTools.AddWorldItem(5571, 12502, -13, "Base.Note", {x=0.74, y=0.70, z=0.35, rx=0, ry=0, rz=310})
    BWOAPrepareTools.AddWorldItem(5571, 12502, -13, "Base.Note", {x=0.88, y=0.72, z=0.35, rx=0, ry=0, rz=310})

    local note2a = BanditCompatibility.InstanceItem("Bandits.Note")
    note2a:setCanBeWrite(false)
    note2a:setName("On Environmental Determinants of Early Mortuary Practice")
    note2a:getModData().printContent = "early_mortuary_practice"
    BWOAPrepareTools.AddWorldItemSpecial(5571, 12502, -13, note2a, {x=0.66, y=0.40, z=0.35, rx=0, ry=0, rz=0})

    local note2b = BanditCompatibility.InstanceItem("Bandits.Note")
    note2b:setCanBeWrite(false)
    note2b:setName("Report on the Composition of the Paleolithic Survey Group")
    note2b:getModData().printContent = "paleolithic_survey_group"
    BWOAPrepareTools.AddWorldItemSpecial(5571, 12502, -13, note2b, {x=0.79, y=0.40, z=0.35, rx=0, ry=0, rz=0})

    local note2c = BanditCompatibility.InstanceItem("Bandits.Note")
    note2c:setCanBeWrite(false)
    note2c:setName("Supplementary Excavation Log Site C-17 (Substratum)")
    note2c:getModData().printContent = "supplementary_excavation_log"
    BWOAPrepareTools.AddWorldItemSpecial(5571, 12502, -13, note2c, {x=0.94, y=0.47, z=0.35, rx=0, ry=0, rz=0})

    local note2d = BanditCompatibility.InstanceItem("Bandits.NoteBook")
    note2d:setCanBeWrite(false)
    note2d:setName("Kowalska's Diary")
    note2d:getModData().printContent = "diary_kowalska"
    BWOAPrepareTools.AddWorldItemSpecial(5571, 12502, -13, note2d, {x=0.33, y=0.61, z=0.35, rx=0, ry=0, rz=0})

    -- third room
    local note3 = BanditCompatibility.InstanceItem("Bandits.Note")
    note3:setCanBeWrite(false) 
    note3:setName("7-Q-17")
    note3:getModData().printContent = "7Q17"
    BWOAPrepareTools.AddWorldItemSpecial(5583, 12494, -13, note3, {x=0.38, y=0.61, z=0.35, rx=0, ry=0, rz=0})

    -- control room
    local note4 = BanditCompatibility.InstanceItem("Bandits.Note")
    note4:setCanBeWrite(false) 
    note4:setName("Science Team Contact List")
    local md = note4:getModData()
    md.printContent = "science_team"
    md.BWOA = {}
    md.BWOA.accomplishMissionId = 110
    md.BWOA.revealMissionId = 111

    BWOAPrepareTools.AddItemsToContainer(5552, 12488, -13, {note4}, "Cabinet", true)


end

function BWOAScenes.SecretLab:placeCorpses()
end

function BWOAScenes.SecretLab:placeVehicles()
end

function BWOAScenes.SecretLab:populate()
end
