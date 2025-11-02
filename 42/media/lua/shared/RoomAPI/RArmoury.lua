BWOARooms = BWOARooms or {}

BWOARooms.Armoury = {}

BWOARooms.Armoury.Init = function ()
    BWOARooms.Armoury.name = "Armoury"
    BWOARooms.Armoury.x1 = 9973
    BWOARooms.Armoury.x2 = 9978
    BWOARooms.Armoury.y1 = 12614
    BWOARooms.Armoury.y2 = 12617
    BWOARooms.Armoury.z = -4
    BWOARooms.Armoury.ambience = ""

    BWOARooms.Armoury.vents = {
        {x=9973, y=12616.5, z=-4},
    }

    BWOARooms.Armoury.els = {}
    for x=BWOARooms.Armoury.x1, BWOARooms.Armoury.x2 do
        table.insert(BWOARooms.Armoury.els, {dir="N", x=x, y=BWOARooms.Armoury.y1, z=-4})
        table.insert(BWOARooms.Armoury.els, {dir="S", x=x, y=BWOARooms.Armoury.y2, z=-4})
    end

    for y=BWOARooms.Armoury.y1, BWOARooms.Armoury.y2 do
        if y ~= 12615 then
            table.insert(BWOARooms.Armoury.els, {dir="W", x=BWOARooms.Armoury.x1, y=y, z=-4})
        end
        table.insert(BWOARooms.Armoury.els, {dir="E", x=BWOARooms.Armoury.x2, y=y, z=-4})
    end
    
end

BWOARooms.Armoury.Build = function ()
    BWOARooms.Armoury.Init()
    BWOAPrepareTools.DarkenLight(9973, 12614, -4)

    BWOABuildTools.ELS(BWOARooms.Armoury.els)

    BWOABuildTools.EmergencyExitW(9973, 12615, -4)

    BWOABuildTools.LampOvalN(9976, 12614, -4)
    BWOABuildTools.LampOvalS(9976, 12617, -4)

end

BWOARooms.Armoury.SetEmitters = function ()
    BWOARooms.Armoury.Init()
end

BWOARooms.Armoury.SetFlickers = function ()
    BWOARooms.Armoury.Init()

    BWOALights.AddFlicker({x=9976, y=12614, z=-4})
    BWOALights.AddFlicker({x=9976, y=12617, z=-4})
end

BWOARooms.Armoury.Prepare = function ()
    BWOARooms.Armoury.Init()

    local items
    items = {["Base.HazmatSuitCamo"] = 7, ["Base.Hat_GasMask"] = 7}
    BWOAPrepareTools.AddItemsToContainer(9974, 12614, -4, items, "Locker")

    items = {["Base.Pistol"] = 2, ["Base.9mmClip"] = 4, ["Base.Bullets9mmBox"] = 5}
    BWOAPrepareTools.AddItemsToContainer(9975, 12614, -4, items, "Locker")

    items = {["Base.Pistol2"] = 1, ["Base.45Clip"] = 2, ["Base.Bullets45Box"] = 7 }
    BWOAPrepareTools.AddItemsToContainer(9976, 12614, -4, items, "Locker")

    items = {["Base.AssaultRifle2"] = 2, ["Base.M14Clip"] = 6, ["Base.308Box"] = 3 }
    BWOAPrepareTools.AddItemsToContainer(9977, 12614, -4, items, "Locker")

    BWOAPrepareTools.AddWorldItem(9978, 12614, -4, "Base.Bag_ALICEpack", {x=0.5, y=0.72, z=0.27})
    BWOAPrepareTools.AddWorldItem(9978, 12615, -4, "Base.Bag_ALICEpack", {x=0.5, y=0.72, z=0.27})

    BWOAPrepareTools.AddWorldItem(9978, 12616, -4, "Base.HuntingKnife", {x=0.63, y=0.21, z=0.27, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9978, 12616, -4, "Base.HuntingKnife", {x=0.73, y=0.39, z=0.27, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9978, 12616, -4, "Base.HuntingKnife", {x=0.69, y=0.56, z=0.27, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9978, 12616, -4, "Base.HuntingKnife", {x=0.69, y=0.78, z=0.27, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(9978, 12616, -4, "Base.Machete", {x=0.2, y=0.52, z=0.27, rx=0, ry=0, rx=0, ry=0, rz=90})
    BWOAPrepareTools.AddWorldItem(9978, 12616, -4, "Base.Machete", {x=0.38, y=0.53, z=0.27, rx=0, ry=0, ry=0, rx=0, rz=90})

    BWOAPrepareTools.AddWorldItem(9978, 12617, -4, "Base.BatteryBox", {x=0.74, y=0.26, z=0.27})
    BWOAPrepareTools.AddWorldItem(9978, 12617, -4, "Base.WristWatch_Left_ClassicMilitary", {x=0.23, y=0.15, z=0.27})
    BWOAPrepareTools.AddWorldItem(9978, 12617, -4, "Base.WristWatch_Left_ClassicMilitary", {x=0.24, y=0.32, z=0.27})
    BWOAPrepareTools.AddWorldItem(9978, 12617, -4, "Base.HandTorch", {x=0.3, y=0.55, z=0.27})
    BWOAPrepareTools.AddWorldItem(9978, 12617, -4, "Base.HandTorch", {x=0.3, y=0.7, z=0.27})
    BWOAPrepareTools.AddWorldItem(9978, 12617, -4, "Base.FlashLight_AngleHead", {x=0.73, y=0.61, z=0.27})
    BWOAPrepareTools.AddWorldItem(9978, 12617, -4, "Base.FlashLight_AngleHead", {x=0.73, y=0.27, z=0.27})

    items = {["Base.Bag_ALICE_BeltSus_Camo"] = 4, ["Base.Vest_BulletArmy"] = 6, ["Base.Hat_Army"] = 6, ["Base.HolsterSimple_Brown"] = 6 }
    BWOAPrepareTools.AddItemsToContainer(9974, 12617, -4, items, "Locker")

    items = {["Base.Shoes_ArmyBoots"] = 6, ["Base.Gloves_LeatherGlovesBlack"] = 6, ["Base.Hat_BalaclavaFull"] = 6 }
    BWOAPrepareTools.AddItemsToContainer(9975, 12617, -4, items, "Locker")

    items = {["Base.Trousers_CamoGreen"] = 4, ["Base.Shirt_CamoGreen"] = 6, ["Base.Tshirt_CamoGreen"] = 6, ["Base.Jacket_ArmyCamoGreen"] = 6 }
    BWOAPrepareTools.AddItemsToContainer(9976, 12617, -4, items, "Locker")
end


