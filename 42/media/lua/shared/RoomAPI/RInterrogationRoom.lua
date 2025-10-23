BWOARooms = BWOARooms or {}

BWOARooms.InterrogationRoom = {}

BWOARooms.InterrogationRoom.Init = function ()
    BWOARooms.InterrogationRoom.name = "InterrogationRoom"
    BWOARooms.InterrogationRoom.x1 = 9959
    BWOARooms.InterrogationRoom.x2 = 9965
    BWOARooms.InterrogationRoom.y1 = 12631
    BWOARooms.InterrogationRoom.y2 = 12635
    BWOARooms.InterrogationRoom.z = -4
    BWOARooms.InterrogationRoom.ambience = ""

    BWOARooms.InterrogationRoom.vents = {
        {x=9959, y=12632.5, z=-4},
    }

    BWOARooms.InterrogationRoom.els = {}
    for x=BWOARooms.InterrogationRoom.x1, BWOARooms.InterrogationRoom.x2 do
        table.insert(BWOARooms.InterrogationRoom.els, {dir="N", x=x, y=BWOARooms.InterrogationRoom.y1, z=-4})
        table.insert(BWOARooms.InterrogationRoom.els, {dir="S", x=x, y=BWOARooms.InterrogationRoom.y2, z=-4})
    end

    for y=BWOARooms.InterrogationRoom.y1, BWOARooms.InterrogationRoom.y2 do
        if y ~= BWOARooms.InterrogationRoom.y1 + 2 then
            table.insert(BWOARooms.InterrogationRoom.els, {dir="W", x=BWOARooms.InterrogationRoom.x1, y=y, z=-4})
        end
        table.insert(BWOARooms.InterrogationRoom.els, {dir="E", x=BWOARooms.InterrogationRoom.x2, y=y, z=-4})
    end
    
end

BWOARooms.InterrogationRoom.Build = function ()
    BWOARooms.InterrogationRoom.Init()
    BWOAPrepareTools.DarkenLight(9959, 12634, -4)

    BWOABuildTools.ELS(BWOARooms.InterrogationRoom.els)

    BWOABuildTools.EmergencyExitW(9959, 12633, -4)

    BWOABuildTools.LampOvalN(9960, 12631, -4)
    BWOABuildTools.LampOvalN(9964, 12631, -4)

    BWOABuildTools.RemoveObject(9964, 12633, -4, "Chair")
    BWOABuildTools.Generic(9964, 12633, -4, "appliances_com_01_46")

    BWOABuildTools.Generic(9959, 12632, -4, "furniture_tables_low_01_18")
    BWOABuildTools.TV(9959, 12632, -4, "appliances_television_01_5")



end

BWOARooms.InterrogationRoom.SetEmitters = function ()
    BWOARooms.InterrogationRoom.Init()
end

BWOARooms.InterrogationRoom.SetFlickers = function ()
    BWOARooms.InterrogationRoom.Init()
end

BWOARooms.InterrogationRoom.Prepare = function ()
    BWOARooms.InterrogationRoom.Init()

    local item = BanditCompatibility.InstanceItem("Base.VHS_Home")
    local mediaRecorder = ZomboidRadio.getInstance():getRecordedMedia()
    local mediaData = mediaRecorder:getMediaData("d5fe3df0-5e3b-0146-0001-000000000000")
    item:setRecordedMediaData(mediaData)
    BWOAPrepareTools.AddWorldItemSpecial(9959, 12634, -4, item, {x=0.6, y=0.6, z=0})

end


