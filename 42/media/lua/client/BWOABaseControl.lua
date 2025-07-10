local function OnGameStart()
    for room, _ in pairs(BWOARooms) do
        BWOARooms[room].Init()
        BWOARooms[room].SetEmitters()
    end
end

local function everyOneMinute()
    
end

local function onNewFire(fire)
    local x, y, z = fire:getX(), fire:getY(), fire:getZ()
    local room = BWOAUtils.GetRoom(x, y, z)
    if room then
        BWOABaseAPI.AlarmOn()
        BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
        BWOASound.AddNoah({sound = BWOASound.noahSounds.FIRE})
        BWOASound.AddNoah({sound = BWOASound.noahSounds[room.name]})
    end
end

Events.OnGameStart.Remove(OnGameStart)
Events.OnGameStart.Add(OnGameStart)

Events.EveryOneMinute.Remove(everyOneMinute)
Events.EveryOneMinute.Add(everyOneMinute)

Events.OnNewFire.Remove(onNewFire)
Events.OnNewFire.Add(onNewFire)
