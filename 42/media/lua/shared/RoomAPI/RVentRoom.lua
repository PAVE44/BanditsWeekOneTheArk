BWOARooms = BWOARooms or {}

BWOARooms.VentRoom = {}

BWOARooms.VentRoom.Init = function ()
    BWOARooms.VentRoom.name = "VENTROOM"
    BWOARooms.VentRoom.x1 = 9966
    BWOARooms.VentRoom.x2 = 9970
    BWOARooms.VentRoom.y1 = 12633
    BWOARooms.VentRoom.y2 = 12636
    BWOARooms.VentRoom.z = -4
    BWOARooms.VentRoom.ambience = ""

    BWOARooms.VentRoom.vents = {
        {x=9969, y=12637.5, z=-4},
    }

    BWOARooms.VentRoom.els = {}
    for x=BWOARooms.VentRoom.x1, BWOARooms.VentRoom.x2 do
        table.insert(BWOARooms.VentRoom.els, {dir="N", x=x, y=BWOARooms.VentRoom.y1, z=-4})
        table.insert(BWOARooms.VentRoom.els, {dir="S", x=x, y=BWOARooms.VentRoom.y2, z=-4})
    end

    for y=BWOARooms.VentRoom.y1, BWOARooms.VentRoom.y2 do
        table.insert(BWOARooms.VentRoom.els, {dir="W", x=BWOARooms.VentRoom.x1, y=y, z=-4})
        if y ~= 12635 then
            table.insert(BWOARooms.VentRoom.els, {dir="E", x=BWOARooms.VentRoom.x2, y=y, z=-4})
        end
    end
end

BWOARooms.VentRoom.Build = function ()
    BWOARooms.VentRoom.Init()

    BWOAPrepareTools.DarkenLight(9970, 12636, -4)

    BWOABuildTools.ELS(BWOARooms.VentRoom.els)

    BWOABuildTools.LampOvalS(9968, 12636, -4)

end

BWOARooms.VentRoom.SetEmitters = function ()
    BWOARooms.VentRoom.Init()
end

BWOARooms.VentRoom.Prepare = function ()
    BWOARooms.VentRoom.Init()

    local items
    items = {["Base.Wrench"] = 1}
    BWOAPrepareTools.AddItemsToContainer(9969, 12633, -4, items, "Shelves")

end


