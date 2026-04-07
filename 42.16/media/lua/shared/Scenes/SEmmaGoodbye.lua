require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.EmmaGoodbye = BWOAScenes.Abstract:derive("BWOAScenes.EmmaGoodbye")

function BWOAScenes.EmmaGoodbye:placeItems()
    local note = BanditCompatibility.InstanceItem("Bandits.Note")
    note:setCanBeWrite(false)
    note:setName("Emma's Goodbye Note")
    local md = note:getModData()
    md.printContent = "emma_goodbye"
    md.BWOA = {}
    md.BWOA.onTaken = {}
    md.BWOA.onTaken.revealMissionId = 50

    BWOAPrepareTools.AddWorldItemSpecial(9960, 12630, -4, note, {x=0.45, y=0.30, z=0.31, rx=0, ry=0, rz=0})
end

