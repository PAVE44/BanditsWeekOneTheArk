BWOAPlaceEvents = BWOAPlaceEvents or {}

BWOAPlaceEvents.events = {
    ["FuelTruck"] = {
        scene = "FuelTruck",
        x = 10600,
        y = 11300,
        z = 0
    },
    ["Toolbag"] = {
        scene = "Toolbag",
        x = 10033,
        y = 12733,
        z = 0
    }
}

-- event: x, y, z, scene
BWOAPlaceEvents.Render = function(event)
    local scene = BWOAScenes[event.scene]:new(event.x, event.y, event.z)
    if not scene then return false end
    scene:build()

    event.rendered = true
end