BWOAPlaceEvents = BWOAPlaceEvents or {}

BWOAPlaceEvents.events = {
    ["FuelTruck"] = {
        scene = "FuelTruck",
        x = 10600,
        y = 11300,
        z = 0,
        revealDialoguePerson = "Emma Robinson",
        revealDialogueId = "100.1.2.2.1.1.1",
    },
    ["Toolbag"] = {
        scene = "Toolbag",
        x = 10033,
        y = 12733,
        z = 0,
        revealDialoguePerson = "Emma Robinson",
        revealDialogueId = "100.10.1",
    },
    ["Dave"] = {
        scene = "Dave",
        x = 9161,
        y = 12150,
        z = 0,
        accomplishMissionId = 8,
        revealDialoguePerson = "Emma Robinson",
        revealDialogueId = "300.1.1.1",
    }
}

-- event: x, y, z, scene
BWOAPlaceEvents.Render = function(event)
    local scene = BWOAScenes[event.scene]:new(event.x, event.y, event.z)
    if not scene then return false end
    scene:build()

    event.rendered = true
end