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
        y = 12918,
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
    ["Farmer"] = {
        scene = "Farmer",
        x = 7174,
        y = 9736,
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

}

-- event: x, y, z, scene
BWOAPlaceEvents.Render = function(event)
    local scene = BWOAScenes[event.scene]:new(event.x, event.y, event.z)
    if not scene then return false end
    scene:build()

    event.rendered = true
end