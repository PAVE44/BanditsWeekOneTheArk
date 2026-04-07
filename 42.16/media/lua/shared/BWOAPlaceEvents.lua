BWOAPlaceEvents = BWOAPlaceEvents or {}

BWOAPlaceEvents.events = {
    ["FuelTruck"] = {
        scene = "FuelTruck",
        x = 10600,
        y = 11300,
        z = 0,
        revealDialoguePerson = "Emma_Robinson",
        revealDialogueId = "100.1.2.2.1.1.1",
        renderDist = 40,
        music = "MusicFuelTruck",
    },
    ["Toolbag"] = {
        scene = "Toolbag",
        x = 10033,
        y = 12733,
        z = 0,
        revealDialoguePerson = "Emma_Robinson",
        revealDialogueId = "100.10.1",
        renderDist = 30,
    },
    ["Dave"] = {
        scene = "Dave",
        x = 9161,
        y = 12150,
        z = 0,
        accomplishMissionId = 8,
        revealDialoguePerson = "Emma_Robinson",
        revealDialogueId = "300.1.1.1",
        renderDist = 40,
    },
    ["BanditsCar"] = {
        scene = "BanditsCar",
        x = 8318,
        y = 11636,
        z = 0,
        accomplishMissionId = 9,
        revealDialoguePerson = "Emma_Robinson",
        revealDialogueId = "300.2",
        renderDist = 50,
    },
    ["FallasChurch"] = {
        scene = "FallasChurch",
        x = 7386,
        y = 8353,
        -- x = 7219, --7386,
        -- y = 8520, -- 8353,
        z = 0,
        renderDist = 40,
    },
    ["EkronChurch"] = {
        scene = "EkronChurch",
        x = 439,
        y = 9925,
        z = 0,
        renderDist = 40,
        music = "MusicEkronChurch",
    },
    ["Cinema"] = {
        scene = "Cinema",
        x = 10181,
        y = 12634,
        z = 0,
        renderDist = 70,
    },
    ["Hunter"] = {
        scene = "Hunter",
        x = 9814,
        y = 12926,
        z = 0,
        renderDist = 70,
    },
    ["Fisherman"] = {
        scene = "Fisherman",
        x = 8114,
        y = 12226,
        z = 0,
        renderDist = 70,
    },
    ["Plane"] = {
        scene = "Plane",
        x = 8432,
        y = 11765,
        z = 0,
        renderDist = 70,
    },
    ["SecretLab"] = {
        scene = "SecretLab",
        x = 5560,
        y = 12500,
        z = 0,
        renderDist = 40,
    },
    ["Doc"] = {
        scene = "Doc",
        x = 10861,
        y = 10033,
        z = 0,
        renderDist = 20,
    },
    ["Finnegan"] = {
        scene = "Finnegan",
        x = 18030,
        y = 4010,
        z = 0,
        renderDist = 60,
    },
    ["Council"] = {
        scene = "Council",
        x = 18005,
        y = 3007,
        z = 0,
        renderDist = 30,
        music = "MusicCouncil",
    },
    ["Maze"] = {
        scene = "Maze",
        x = 18007,
        y = 3202,
        z = 0,
        renderDist = 20,
    },
    ["FamilyHouse"] = {
        scene = "FamilyHouse",
        x = 18010,
        y = 3410,
        z = 0,
        renderDist = 12,
        music = "MusicFamilyHouse",
    },
    ["MirrorRoom"] = {
        scene = "MirrorRoom",
        x = 18003,
        y = 3603,
        z = -2,
        renderDist = 12,
        music = "MusicMirrorRoom",
    },
    ["Hell"] = {
        scene = "Hell",
        x = 18010,
        y = 3825,
        z = 0,
        renderDist = 30,
        music = "MusicHell",
    },
    ["Breach1"] = {
        scene = "Breach",
        x = 10570 + 30,
        y = 10600 + 30,
        z = 0,
        renderDist = 60,
    },
    ["FinneganReal"] = {
        scene = "FinneganReal",
        x = 13585,
        y = 1700,
        z = 0,
        renderDist = 60,
    },
    ["EmmaGoodbye"] = {
        scene = "EmmaGoodbye",
        x = 9960,
        y = 12630,
        z = 0,
        renderDist = 10,
        hidden = true,
    },
    ["Maniac"] = {
        scene = "Maniac",
        x = 10111,
        y = 11183,
        z = 0,
        renderDist = 60,
    },
}

BWOAPlaceEvents.Reveal = function(name)
    local gmd = GetBWOAModData()
    local placeEvents = gmd.placeEvents
    local event = placeEvents[name]
    if event then
        event.hidden = nil
    end
end

-- event: x, y, z, scene
BWOAPlaceEvents.Render = function(event)
    local scene = BWOAScenes[event.scene]:new(event.x, event.y, event.z)
    if not scene then return false end
    scene:build()

    event.rendered = true
end