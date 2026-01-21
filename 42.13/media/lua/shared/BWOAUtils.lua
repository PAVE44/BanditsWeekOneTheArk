BWOAUtils = BWOAUtils or {}

BWOAUtils.CelsiusToFahrenheit = function(celsius)
    local fahrenheit = (celsius * 9 / 5) + 32
    return fahrenheit
end

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

BanditUtils.GetLightSwitch = function(x, y, z)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local objects = square:getObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        if instanceof(object, "IsoLightSwitch") then
            local properties = object:getProperties()
            if not properties:has(IsoFlagType.WallOverlay) then
                return object
            end
        end
    end
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

function BanditUtils.GetClosestBanditLocationProgram(character, programs)
    local result = {}
    local cid = BanditUtils.GetCharacterID(character)

    result.dist = math.huge
    result.x = false
    result.y = false
    result.z = false
    result.id = false

    local cx, cy = character:getX(), character:getY()

    local zombieList = BanditZombie.GetAllB()
    for id, zombie in pairs(zombieList) do
        for _, program in pairs(programs) do
            if zombie.brain.program.name == program then
                if math.abs(zombie.x - cx) < 30 or math.abs(zombie.y - cy) < 30 then
                    local dist = BanditUtils.DistTo(cx, cy, zombie.x, zombie.y)
                    if dist < result.dist and cid ~= id then
                        result.dist = dist
                        result.x = zombie.x
                        result.y = zombie.y
                        result.z = zombie.z
                        result.id = zombie.id
                    end
                end
            end
        end
    end

    return result
end

function BanditUtils.GetClosestBanditLocationProgramStage(character, programs, stage)
    local result = {}
    local cid = BanditUtils.GetCharacterID(character)

    result.dist = math.huge
    result.x = false
    result.y = false
    result.z = false
    result.id = false

    local cx, cy = character:getX(), character:getY()

    local zombieList = BanditZombie.GetAllB()
    for id, zombie in pairs(zombieList) do
        for _, program in pairs(programs) do
            if zombie.brain.program.name == program and zombie.brain.program.stage == stage then
                if math.abs(zombie.x - cx) < 30 or math.abs(zombie.y - cy) < 30 then
                    local dist = BanditUtils.DistTo(cx, cy, zombie.x, zombie.y)
                    if dist < result.dist and cid ~= id then
                        result.dist = dist
                        result.x = zombie.x
                        result.y = zombie.y
                        result.z = zombie.z
                        result.id = zombie.id
                    end
                end
            end
        end
    end

    return result
end

BanditUtils.GetBodyLocationsOrdered = function()
    return {
        ItemBodyLocation.UNDERWEAR_BOTTOM, 
        ItemBodyLocation.UNDERWEAR_TOP, 
        ItemBodyLocation.UNDERWEAR_EXTRA1, 
        ItemBodyLocation.UNDERWEAR_EXTRA2, 
        ItemBodyLocation.UNDERWEAR, 
        ItemBodyLocation.TORSO1LEGS1, 
        ItemBodyLocation.LEGS1,
        ItemBodyLocation.EARS, 
        ItemBodyLocation.EAR_TOP, 
        ItemBodyLocation.NOSE, 
        ItemBodyLocation.HAT, 
        ItemBodyLocation.FULL_HAT,
        ItemBodyLocation.MASK, 
        ItemBodyLocation.MASK_EYES, 
        ItemBodyLocation.EYES, 
        ItemBodyLocation.RIGHT_EYE, 
        ItemBodyLocation.LEFT_EYE,
        ItemBodyLocation.NECK, 
        ItemBodyLocation.NECKLACE, 
        ItemBodyLocation.GORGET, 
        ItemBodyLocation.SCARF,
        ItemBodyLocation.TANK_TOP, 
        ItemBodyLocation.TSHIRT, 
        ItemBodyLocation.SHORT_SLEEVE_SHIRT, 
        ItemBodyLocation.SHIRT,
        ItemBodyLocation.VEST_TEXTURE, 
        ItemBodyLocation.SWEATER, 
        ItemBodyLocation.SWEATER_HAT, 
        ItemBodyLocation.TORSO_EXTRA_VEST, 
        ItemBodyLocation.CUIRASS, 
        ItemBodyLocation.TORSO_EXTRA,
        ItemBodyLocation.JACKET, 
        ItemBodyLocation.JACKET_HAT, 
        ItemBodyLocation.JACKET_DOWN, 
        ItemBodyLocation.JACKET_HAT_BULKY, 
        ItemBodyLocation.JACKET_BULKY, 
        ItemBodyLocation.JACKET_SUIT, 
        ItemBodyLocation.FULL_TOP,
        ItemBodyLocation.RIGHT_WRIST, 
        ItemBodyLocation.RIGHT_MIDDLE_FINGER, 
        ItemBodyLocation.RIGHT_RING_FINGER, 
        ItemBodyLocation.LEFT_WRIST, 
        ItemBodyLocation.LEFT_MIDDLE_FINGER, 
        ItemBodyLocation.LEFT_RING_FINGER, 
        ItemBodyLocation.HANDS, 
        ItemBodyLocation.HANDS_RIGHT, 
        ItemBodyLocation.HANDS_LEFT,
        ItemBodyLocation.PANTS, 
        ItemBodyLocation.PANTS_EXTRA, 
        ItemBodyLocation.SHORT_PANTS, 
        ItemBodyLocation.SHORTS_SHORT, 
        ItemBodyLocation.LONG_SKIRT, 
        ItemBodyLocation.SKIRT,
        ItemBodyLocation.DRESS, 
        ItemBodyLocation.LONG_DRESS,
        ItemBodyLocation.BATH_ROBE, 
        ItemBodyLocation.FULL_SUIT, 
        ItemBodyLocation.FULL_SUIT_HEAD, 
        ItemBodyLocation.BOILERSUIT, 
        ItemBodyLocation.TAIL, 
        ItemBodyLocation.TORSO_EXTRA_VEST_BULLET,
        ItemBodyLocation.SHOULDERPAD_RIGHT, 
        ItemBodyLocation.SHOULDERPAD_LEFT, 
        ItemBodyLocation.ELBOW_RIGHT, 
        ItemBodyLocation.ELBOW_LEFT, 
        ItemBodyLocation.FORE_ARM_RIGHT, 
        ItemBodyLocation.FORE_ARM_LEFT,
        ItemBodyLocation.THIGH_RIGHT, 
        ItemBodyLocation.THIGH_LEFT, 
        ItemBodyLocation.KNEE_RIGHT, 
        ItemBodyLocation.KNEE_LEFT, 
        ItemBodyLocation.CALF_RIGHT, 
        ItemBodyLocation.CALF_LEFT,
        ItemBodyLocation.FANNY_PACK_FRONT, 
        ItemBodyLocation.FANNY_PACK_BACK, 
        ItemBodyLocation.WEBBING, 
        ItemBodyLocation.AMMO_STRAP, 
        ItemBodyLocation.ANKLE_HOLSTER, 
        ItemBodyLocation.BELT_EXTRA, 
        ItemBodyLocation.SHOULDER_HOLSTER,
        ItemBodyLocation.SOCKS, 
        ItemBodyLocation.SHOES
    }
end

BanditUtils.ClearZombies = function(x1, x2, y1, y2)
    local cell = getCell()
    local zombieList = cell:getZombieList()
    local zombieListSize = zombieList:size()
    for i = zombieListSize - 1, 0, -1 do
        local zombie = zombieList:get(i)
        if zombie then
            if zombie:getX() >= x1 and zombie:getX() <= x2
               and zombie:getY() >= y1 and zombie:getY() <= y2 then
                zombie:removeFromSquare()
                zombie:removeFromWorld()
            end
        end
    end
end