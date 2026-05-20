require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Shrink = BWOAScenes.Abstract:derive("BWOAScenes.Shrink")

function BWOAScenes.Shrink:placeObjects()
    BWOABuildTools.Generator(18002, 4190, -4, 100, 100, true, true, true)
    BWOASound.AddToObject({x=18001, y=4200, z=-3, sound="AmbientClock"})

    BWOASound.AddToObject({x=18001, y=4200, z=-3, sound="AmbientClock"})
    BWOASound.AddToObject({x=18005, y=4200, z=-3, sound="AmbientCity"})
    BWOASound.AddToObject({x=18000, y=4206, z=-3, sound="AmbientCity"})

end

function BWOAScenes.Shrink:placeItems()

    BWOAPrepareTools.AddWorldItem(18002, 4202, -3, "Base.Notebook", {x=0.80, y=0.39, z=0.33, rx=0, ry=0, rz=355})
    BWOAPrepareTools.AddWorldItem(18002, 4202, -3, "Base.Pen", {x=0.52, y=0.35, z=0.33, rx=0, ry=0, rz=290})
    BWOAPrepareTools.AddWorldItem(18002, 4202, -3, "Base.Teacup", {x=0.31, y=0.34, z=0.33, rx=0, ry=0, rz=325})
    
end

function BWOAScenes.Shrink:populate()
    local player = getSpecificPlayer(0)

    BanditUtils.ClearZombies(17950, 18050, 4150, 4250)

    local params1 = {
        cid = Bandit.clanMap.Noah,
        x = 18003,
        y = 4201,
        z = -3,
        program = "Noah",
        size = 1,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params1)
end
