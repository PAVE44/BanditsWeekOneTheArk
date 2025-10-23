BWOARooms = BWOARooms or {}

BWOARooms.Library = {}

BWOARooms.Library.Init = function ()
    BWOARooms.Library.name = "LIBRARY"
    BWOARooms.Library.x1 = 9959
    BWOARooms.Library.x2 = 9961
    BWOARooms.Library.y1 = 12605
    BWOARooms.Library.y2 = 12607
    BWOARooms.Library.z = -4
    BWOARooms.Library.ambience = ""

    BWOARooms.Library.vents = {
        {x=9961, y=12606.5, z=-4},
    }

    BWOARooms.Library.els = {}
    for x=BWOARooms.Library.x1, BWOARooms.Library.x2 do
        table.insert(BWOARooms.Library.els, {dir="N", x=x, y=BWOARooms.Library.y1, z=-4})
        table.insert(BWOARooms.Library.els, {dir="S", x=x, y=BWOARooms.Library.y2, z=-4})
    end

    for y=BWOARooms.Library.y1, BWOARooms.Library.y2 do
        if y ~= BWOARooms.Library.y1 + 1 then
            table.insert(BWOARooms.Library.els, {dir="W", x=BWOARooms.Library.x1, y=y, z=-4})
        end
        
        table.insert(BWOARooms.Library.els, {dir="E", x=BWOARooms.Library.x2, y=y, z=-4})
    end
end

BWOARooms.Library.Build = function ()
    BWOARooms.Library.Init()

    BWOAPrepareTools.DarkenLight(9959, 12607, -4)

    BWOABuildTools.ELS(BWOARooms.Library.els)
    BWOABuildTools.EmergencyExitW(9959, 12606, -4)

    -- equipment
    BWOABuildTools.RemoveObject(9959, 12605, -4, "Table")
    BWOABuildTools.BookshelfW(9959, 12605, -4)
    BWOABuildTools.RemoveObject(9960, 12605, -4, "Clothing Dryer")
    BWOABuildTools.BookshelfW(9960, 12605, -4)
    BWOABuildTools.RemoveObject(9961, 12605, -4, "Clothing Dryer")
    BWOABuildTools.BookshelfW(9961, 12605, -4)

    BWOABuildTools.RemoveObject(9959, 12607, -4, "Shelves")
    BWOABuildTools.Generic(9959, 12607, -4, "furniture_seating_indoor_03_7")
    BWOABuildTools.RemoveObject(9960, 12607, -4, "Washing Machine")
    BWOABuildTools.Generic(9960, 12607, -4, "furniture_tables_low_01_17")
    BWOABuildTools.LampDeskYellowS(9960, 12607, -4)
    BWOABuildTools.RemoveObject(9961, 12607, -4, "Washing Machine")
    BWOABuildTools.Generic(9961, 12607, -4, "furniture_seating_indoor_03_7")

    BWOABuildTools.LampDeskYellowN(9973, 12613, -4)

    local oasis = BanditCompatibility.InstanceItem("Base.Book")
    oasis:setCanBeWrite(false)
    oasis:setName("Project OASIS by Noah Whitlock")
    local md = oasis:getModData()
    md.printContent = "book_dacr_research"
    BWOAPrepareTools.AddWorldItemSpecial(9960, 12607, -4, oasis, {x=0.35, y=0.45, z=0.19})

    return true
end

BWOARooms.Library.SetEmitters = function ()
    BWOARooms.Library.Init()
end

BWOARooms.Library.Prepare = function ()
    BWOARooms.Library.Init()
end


