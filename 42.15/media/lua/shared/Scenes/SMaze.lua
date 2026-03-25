require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Maze = BWOAScenes.Abstract:derive("BWOAScenes.Maze")

function BWOAScenes.Maze:placeObjects()
    BWOABuildTools.Generator(18007, 3200, -4, 100, 100, true, true, true)

    local data = {r = 255, g = 80, b = 20, d=4}
    BWOABuildTools.LampCustom(18005, 3201, -3, "lighting_outdoor_01_3", data)
    BWOABuildTools.LampCustom(18009, 3201, -3, "lighting_outdoor_01_3", data)
end

function BWOAScenes.Maze:placeItems()
    BWOAPrepareTools.AddWorldItem(18005, 3203, -3, "Base.Roses", {x=0.61, y=0.14, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(18005, 3203, -3, "Base.Roses", {x=0.70, y=0.14, z=0.00, rx=0, ry=0, rz=35})
    BWOAPrepareTools.AddWorldItem(18005, 3203, -3, "Base.Roses", {x=0.60, y=0.15, z=0.00, rx=0, ry=0, rz=310})
    BWOAPrepareTools.AddWorldItem(18005, 3203, -3, "Base.Roses", {x=0.58, y=0.05, z=0.00, rx=0, ry=0, rz=340})
    BWOAPrepareTools.AddWorldItem(18005, 3203, -3, "Base.KatePic", {x=0.89, y=0.36, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(18007, 3203, -3, "Base.Doll", {x=0.53, y=0.01, z=0.04, rx=127, ry=193, rz=10})
    BWOAPrepareTools.AddWorldItem(18009, 3203, -3, "Base.ToyCar", {x=0.37, y=0.05, z=0.00, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(18009, 3203, -3, "Base.ToyCar", {x=0.54, y=0.18, z=0.00, rx=0, ry=0, rz=0})
end

function BWOAScenes.Maze:placeCorpses()
end

function BWOAScenes.Maze:placeVehicles()
end

function BWOAScenes.Maze:populate()
    BanditUtils.ClearZombies(18000, 18060, 3200, 3260)
end
