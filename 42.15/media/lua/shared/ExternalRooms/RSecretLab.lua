BWOARooms = BWOARooms or {}

BWOARooms.SecretLab = {}

local rotator = 0
local getRotator = function()
    local ret = math.floor(rotator)
    rotator = rotator + 1
    if rotator >= 32 then rotator = 0 end
    return ret
end

BWOARooms.SecretLab.Init = function ()
    BWOARooms.SecretLab.name = "SECRETLAB"

    BWOARooms.SecretLab.vents = {}

    BWOARooms.SecretLab.elr = {}

    local rotator = 0

    for y=12484, 12491 do
        table.insert(BWOARooms.SecretLab.elr, {dir="W", x=5573, y=y, z=-13, tick=dw})
    end

    for x=5572, 5549, -1 do
        if x ~= 5550  and x ~= 5551 and x ~= 5555 and x ~= 5560 and x ~= 5565 and x ~= 5570 then
            table.insert(BWOARooms.SecretLab.elr, {dir="N", x=x, y=12492, z=-13, tick=getRotator()})
        end
    end

    --

    for y=12502, 12496, -1 do
        table.insert(BWOARooms.SecretLab.elr, {dir="W", x=5573, y=y, z=-13, tick=getRotator()})
    end

    --

    table.insert(BWOARooms.SecretLab.elr, {dir="W", x=5542, y=12504, z=-13, tick=getRotator()})
    table.insert(BWOARooms.SecretLab.elr, {dir="W", x=5542, y=12501, z=-13, tick=getRotator()})
    table.insert(BWOARooms.SecretLab.elr, {dir="W", x=5542, y=12500, z=-13, tick=getRotator()})
    table.insert(BWOARooms.SecretLab.elr, {dir="N", x=5542, y=12500, z=-13, tick=getRotator()})
    table.insert(BWOARooms.SecretLab.elr, {dir="N", x=5545, y=12500, z=-13, tick=getRotator()})

    for y=12499, 12474, -1 do
        if y ~= 12476  then
            table.insert(BWOARooms.SecretLab.elr, {dir="W", x=5546, y=y, z=-13, tick=getRotator()})
        end
    end

    for x=5546, 5553 do
        table.insert(BWOARooms.SecretLab.elr, {dir="N", x=x, y=12474, z=-13, tick=getRotator()})
    end



end

BWOARooms.SecretLab.Build = function ()
    BWOARooms.SecretLab.Init()

    BWOABuildTools.Generator(5530, 12475, -13, 100, 100, true, true)

    BWOABuildTools.ELS(BWOARooms.SecretLab.elr)

end

BWOARooms.SecretLab.SetEmitters = function ()
    BWOARooms.SecretLab.Init()
    
    BWOASound.AddToObject({x=5543, y=12475, z=-13, maxDist = 80, sound="AmbientAlarmSecretLab"})
    BWOASound.AddToObject({x=5563, y=12493, z=-13, maxDist = 80, sound="AmbientAlarmSecretLab"})
    BWOASound.AddToObject({x=5538, y=12470, z=-13, sound="AmbientAlarmLocal"})

end


BWOARooms.SecretLab.SetFlickers = function ()
    BWOARooms.SecretLab.Init()

    for _, el in ipairs(BWOARooms.SecretLab.elr) do
        BWOALights.AddRotator({x=el.x, y=el.y, z=el.z, tick=el.tick})
    end

end

BWOARooms.SecretLab.Prepare = function ()
    BWOARooms.SecretLab.Init()

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
    note2a:getModData().BWOA = {}
    note2a:getModData().BWOA.onTaken = {}
    note2a:getModData().BWOA.onTaken.revealDialogueId = "2000.6.1"
    note2a:getModData().BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"
    BWOAPrepareTools.AddWorldItemSpecial(5571, 12502, -13, note2a, {x=0.66, y=0.40, z=0.35, rx=0, ry=0, rz=0})

    local note2b = BanditCompatibility.InstanceItem("Bandits.Note")
    note2b:setCanBeWrite(false)
    note2b:setName("Report on the Composition of the Paleolithic Survey Group")
    note2b:getModData().printContent = "paleolithic_survey_group"
    note2b:getModData().BWOA = {}
    note2b:getModData().BWOA.onTaken = {}
    note2b:getModData().BWOA.onTaken.revealDialogueId = "2000.6.2"
    note2b:getModData().BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"
    BWOAPrepareTools.AddWorldItemSpecial(5571, 12502, -13, note2b, {x=0.79, y=0.40, z=0.35, rx=0, ry=0, rz=0})

    local note2c = BanditCompatibility.InstanceItem("Bandits.Note")
    note2c:setCanBeWrite(false)
    note2c:setName("Supplementary Excavation Log Site C-17 (Substratum)")
    note2c:getModData().printContent = "supplementary_excavation_log"
    note2c:getModData().BWOA = {}
    note2c:getModData().BWOA.onTaken = {}
    note2c:getModData().BWOA.onTaken.revealDialogueId = "2000.6.2.1"
    note2c:getModData().BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"
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
    note3:getModData().BWOA = {}
    note3:getModData().BWOA.onTaken = {}
    note3:getModData().BWOA.onTaken.revealDialogueId = "2000.6.3"
    note3:getModData().BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"
    BWOAPrepareTools.AddWorldItemSpecial(5583, 12494, -13, note3, {x=0.38, y=0.61, z=0.35, rx=0, ry=0, rz=0})

    -- control room
    local note4 = BanditCompatibility.InstanceItem("Bandits.Note")
    note4:setCanBeWrite(false) 
    note4:setName("Science Team Contact List")
    local md = note4:getModData()
    md.printContent = "science_team"
    md.BWOA = {}
    md.BWOA.onTaken = {}
    md.BWOA.onTaken.accomplishMissionId = 110
    md.BWOA.onTaken.revealDialogueId = "2000.6.4"
    md.BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"

    BWOAPrepareTools.AddItemsToContainer(5552, 12488, -13, {note4}, "Cabinet", true)
end

BWOARooms.SecretLab.PrepareCorpses = function ()
    local soldierClothing = {
        {bl = ItemBodyLocation.UNDERWEAR_BOTTOM, itemType = "Base.Briefs_White"},
        {bl = ItemBodyLocation.TANK_TOP, itemType = "Base.Vest_DefaultTEXTURE_TINT"},
        {bl = ItemBodyLocation.TSHIRT, itemType = "Base.Tshirt_CamoGreen"},
        {bl = ItemBodyLocation.JACKET, itemType = "Base.Jacket_ArmyCamoGreen"},
        {bl = ItemBodyLocation.TORSO_EXTRA_VEST_BULLET, itemType = "Base.Vest_BulletArmy"},
        {bl = ItemBodyLocation.HAT, itemType = "Base.Hat_Army"},
        {bl = ItemBodyLocation.MASK_EYES, itemType = "Base.Hat_GasMask"},
        {bl = ItemBodyLocation.NECKLACE, itemType = "Base.Necklace_DogTag"},
        {bl = ItemBodyLocation.PANTS, itemType = "Base.Trousers_CamoGreen"},
        {bl = ItemBodyLocation.HANDS, itemType = "Base.Gloves_LeatherGlovesBlack"},
        {bl = ItemBodyLocation.BELT_EXTRA, itemType = "Base.HolsterSimple_Black"},
        {bl = ItemBodyLocation.SOCKS, itemType = "Base.Socks_Long_Black"},
        {bl = ItemBodyLocation.SHOES, itemType = "Base.Shoes_ArmyBoots"},
    }

    local soldierInventory = {
        "Base.Pistol2",
        "Base.45Clip",
        "Base.45Clip",
        "Base.AssaultRifle",
        "Base.Bullets45Box",
        "Base.556Clip",
        "Base.556Clip",
        "Base.556Clip",
        "Base.556Box",
        "Base.556Box",
        "Base.GasmaskFilter",
        "Base.HuntingKnife",
    }

    soldierLocations = {
        {x = 5584, y = 12483, z = 0},
        -- {x = 5519, y = 12511, z = 0},
        -- {x = 5517, y = 12513, z = 0},
        -- {x = 5517, y = 12513, z = 0},
        {x = 5545, y = 12468, z = -1},
    }

    for _, loc in ipairs(soldierLocations) do
        BWOAPrepareTools.AddHumanCorpseDetail(loc.x, loc.y, loc.z, true, soldierClothing, soldierInventory)
    end
end
