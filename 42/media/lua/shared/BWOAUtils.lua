BWOAUtils = BWOAUtils or {}

BWOAUtils.GetRoom = function(x, y, z)
    local roomList = BWOARooms
    for _, room in pairs(roomList) do
        if room.x1 and room.x2 and room.y1 and room.y2 then
            if x >= room.x1 and x <= room.x2 and y >= room.y1 and y <= room.y2 and z == room.z then
                return room
            end
        end
    end
end

BanditUtils = BanditUtils or {}

BanditUtils.GetTime = function()
    -- the unit is arbitrary but it gives good resolution
    return getGameTime():getWorldAgeHours() * 2500000 / 24
end

BanditUtils.HasZoneType = function(x, y, z, zoneType)
    local zones = getZones(x, y, z)
    if zones then
        for i=0, zones:size()-1 do
            local zone = zones:get(i)
            if zone:getType() == zoneType then
                return true
            end
        end
    end
    return false
end

BanditUtils.AddVehicle = function(btype, dir, square)
    local vehicle = addVehicle(btype, square:getX(), square:getY(), square:getZ())
    return vehicle
end

BanditUtils.GetScheduledActivity = function(schedule)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    for activity, boundary in pairs(schedule) do
        if hour >= boundary.hourMin and hour <= boundary.hourMax and minute >= boundary.minuteMin and minute <= boundary.minuteMax then
            return activity
        end
    end
end