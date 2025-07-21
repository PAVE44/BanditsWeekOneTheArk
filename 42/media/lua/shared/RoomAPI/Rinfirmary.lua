BWOARooms = BWOARooms or {}

BWOARooms.Infirmary = {}

BWOARooms.Infirmary.Init = function ()
    BWOARooms.Infirmary.name = "INFIRMARY"
    BWOARooms.Infirmary.x1 = 9965
    BWOARooms.Infirmary.x2 = 9970
    BWOARooms.Infirmary.y1 = 12621
    BWOARooms.Infirmary.y2 = 12627
    BWOARooms.Infirmary.z = -4
    BWOARooms.Infirmary.ambience = ""

    BWOARooms.Infirmary.els = {}
    for x=BWOARooms.Infirmary.x1, BWOARooms.Infirmary.x2 do
        table.insert(BWOARooms.Infirmary.els, {dir="N", x=x, y=BWOARooms.Infirmary.y1, z=-4})
        table.insert(BWOARooms.Infirmary.els, {dir="S", x=x, y=BWOARooms.Infirmary.y2, z=-4})
    end

    for y=BWOARooms.Infirmary.y1, BWOARooms.Infirmary.y2 do
        table.insert(BWOARooms.Infirmary.els, {dir="W", x=BWOARooms.Infirmary.x1, y=y, z=-4})
        if y ~= BWOARooms.Infirmary.y1 + 3 then
            table.insert(BWOARooms.Infirmary.els, {dir="E", x=BWOARooms.Infirmary.x2, y=y, z=-4})
        end
    end
end

BWOARooms.Infirmary.Build = function ()
    BWOARooms.Infirmary.Init()
    BWOAPrepareTools.DarkenLight(9970, 12625, -4)
    BWOAPrepareTools.DarkenLight(9969, 12627, -4)

    BWOABuildTools.ELS(BWOARooms.Infirmary.els)

    BWOABuildTools.LampOvalW(9965, 12624, -4)
    BWOABuildTools.LampOvalW(9968, 12626, -4)

    BWOABuildTools.Generic(9965, 12623, -4, "location_community_medical_01_24")

    BWOABuildTools.LampDeskYellowS(9970, 12622, -4)
end

BWOARooms.Infirmary.SetEmitters = function ()
    BWOARooms.Infirmary.Init()
end

BWOARooms.Infirmary.SetFlickers = function ()
    BWOARooms.Infirmary.Init()
    BWOALights.AddFlicker({x=9965, y=12624, z=-4})
end

BWOARooms.Infirmary.Prepare = function ()
    BWOARooms.Infirmary.Init()
    BWOAPrepareTools.AddWorldItem(9969, 12622, -4, "Base.Paperwork", {x=0.5, y=0.5, z=0.35})
    BWOAPrepareTools.AddWorldItem(9969, 12622, -4, "Base.BluePen", {x=0.4, y=0.5, z=0.35})
    BWOAPrepareTools.AddWorldItem(9969, 12622, -4, "Base.Stethoscope", {x=0.8, y=0.2, z=0.35})
    
    local note1 = BanditCompatibility.InstanceItem("Bandits.Note")
    note1:setCanBeWrite(false)
    note1:setName("Doctor's note")
    local md = note1:getModData()
    md.printMedia = "Medical1"
    BWOAPrepareTools.AddWorldItemSpecial(9969, 12622, -4, note1, {x=0.6, y=0.6, z=0.35})

    local note2 = BanditCompatibility.InstanceItem("Bandits.Note")
    note2:setCanBeWrite(false)
    note2:setName("Doctor's note")
    local md = note2:getModData()
    md.printMedia = "Medical2"
    BWOAPrepareTools.AddWorldItemSpecial(9970, 12622, -4, note2, {x=0.2, y=0.62, z=0.35})
end


