BWOAJukebox = BWOAJukebox or {}

BWOAJukebox.jukeboxes = {}

BWOAJukebox.playlist = {
    {clip = "Jukebox1", title = "Rhythm of 93"},
}

BWOAJukebox.Add = function (x, y, z)
    local id = tostring(x) .. "." .. tostring(y) .. "." .. tostring(z)
    BWOAJukebox.jukeboxes[id] = {
        x = x, 
        y = y, 
        z = z,
        sound = nil,
        on = false
    }
    return BWOAJukebox.jukeboxes[id]
end

BWOAJukebox.FindClosest = function (x, y, z)
    local closest
    local distBest = math.huge
    for id, jukebox in pairs(BWOAJukebox.jukeboxes) do
        if jukebox.on then
            local distSq = ((jukebox.x - x) * (jukebox.x - x)) + ((jukebox.y - y) * (jukebox.y - y)) + ((jukebox.z - z) * (jukebox.z - z))
            if distSq < distBest then
                closest = jukebox
                distBest = distSq
            end
        end
    end
    return closest, math.sqrt(distBest)
end

BWOAJukebox.Remove = function (x, y, z)
    local id = tostring(x) .. "." .. tostring(y) .. "." .. tostring(z)
    BWOAJukebox.jukeboxes[id] = nil
end

BWOAJukebox.Get = function (x, y, z)
    local id = tostring(x) .. "." .. tostring(y) .. "." .. tostring(z)
    return BWOAJukebox.jukeboxes[id]
end

BWOAJukebox.TurnOn = function (x, y, z)
    local jukeboxes = BWOAJukebox.jukeboxes
    local id = tostring(x) .. "." .. tostring(y) .. "." .. tostring(z)
    if jukeboxes[id] then
        jukeboxes[id].on = true
    end
end

BWOAJukebox.TurnOff = function (x, y, z)
    local jukeboxes = BWOAJukebox.jukeboxes
    local id = tostring(x) .. "." .. tostring(y) .. "." .. tostring(z)
    if jukeboxes[id] then
        jukeboxes[id].on = false
    end
end

local function everyOneMinute()
    local jukeboxes = BWOAJukebox.jukeboxes
    local playlist = BWOAJukebox.playlist
    for id, jukebox in pairs(jukeboxes) do
        -- ensure it exists
        local square = getCell():getGridSquare(jukebox.x, jukebox.y, jukebox.z)
        if square then
            local isoJukebox = BWOABaseObjects.GetIsoObject({x = jukebox.x, y = jukebox.y, z = jukebox.z, cn = "Jukebox"})
            if not isoJukebox then
                BWOASound.RemoveFromObject({x = jukebox.x, y = jukebox.y, z = jukebox.z, sound = jukebox.sound})
                BWOAJukebox.Remove(jukebox.x, jukebox.y, jukebox.z)
                return
            end
            if jukebox.on then
                local choice = BanditUtils.Choice(playlist)
                jukebox.sound = choice.clip
                BWOASound.AddToObject({x = jukebox.x, y = jukebox.y, z = jukebox.z, sound = jukebox.sound, maxDist=21, volume = 0.4})
            else
                BWOASound.RemoveFromObject({x = jukebox.x, y = jukebox.y, z = jukebox.z, sound = jukebox.sound})
            end
        end
    end
end

Events.EveryOneMinute.Remove(everyOneMinute)
Events.EveryOneMinute.Add(everyOneMinute)