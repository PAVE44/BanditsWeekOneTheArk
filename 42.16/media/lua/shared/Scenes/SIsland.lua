require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Island = BWOAScenes.Abstract:derive("BWOAScenes.Island")

function BWOAScenes.Island:placeObjects()
    local blueprint = BWOALakes.Island()
    BWOABuildTools.LavaLake(1720, 12300, blueprint)
end

function BWOAScenes.Island:populate()
    local player  = getSpecificPlayer(0)
    local params1 = {
        cid = Bandit.clanMap.Demon,
        x = 1720,
        y = 12300,
        z = 0,
        program = "Assault",
        size = 3,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params1)
end
