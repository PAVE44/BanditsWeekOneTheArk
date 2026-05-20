BWOAUtils = BWOAUtils or {}

local function predicateAll(item)
    -- item:getType()
	return true
end


BWOAUtils.CelsiusToFahrenheit = function(celsius)
    local fahrenheit = (celsius * 9 / 5) + 32
    return fahrenheit
end

BWOAUtils.IsInCircle = function(x, y, cx, cy, r)
    local d2 = (x - cx) ^ 2 + (y - cy) ^ 2
    return d2 <= r ^ 2
end

BWOAUtils.GetRoom = function(x, y, z)
    local roomList = BWOARooms
    for _, room in pairs(roomList) do
        if room.x1 and room.x2 and room.y1 and room.y2 and room.z then
            if x >= room.x1 and x <= room.x2 and y >= room.y1 and y <= room.y2 and z == room.z then
                return room
            end
        end
    end
end

BWOAUtils.AddToMap = function(x, y, symbol)
    local newSymbol = {}
	newSymbol.scale = 2
	newSymbol.x = x
	newSymbol.y = y
	newSymbol.symbol = symbol
	newSymbol.r = 1
	newSymbol.g = 0
	newSymbol.b = 0

    local mapItem = MapItem.getSingleton()
    local uiwm = UIWorldMap.new({})
	local mapAPI = uiwm:getAPIv3()
    mapAPI:setMapItem(mapItem)
    local ssapi = mapAPI:getStreetsAPI()
    local sapi = mapAPI:getSymbolsAPIv2()
	local textureSymbol = sapi:addTexture(newSymbol.symbol, newSymbol.x, newSymbol.y)
	textureSymbol:setRGBA(newSymbol.r, newSymbol.g, newSymbol.b, 1.0)
	textureSymbol:setAnchor(0.5, 0.5)
	textureSymbol:setScale(newSymbol.scale)
end

BanditUtils = BanditUtils or {}

BanditUtils.GetTime = function()
    -- the unit is arbitrary but it gives good resolution
    return getGameTime():getWorldAgeHours() * 2500000 / 24
end

BanditUtils.GetLightSwitchMain = function(x, y, z)
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

BanditUtils.GetLightSwitch = function(x, y, z)
    local square = getCell():getOrCreateGridSquare(x, y, z)
    local objects = square:getObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        if instanceof(object, "IsoLightSwitch") then
            return object
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
    local wa = getGameTime():getWorldAgeHours()

    for _, pos in ipairs(schedule) do

        if not pos.hourMin then pos.hourMin = 0 end
        if not pos.hourMax then pos.hourMax = 24 end
        if not pos.minuteMin then pos.minuteMin = 0 end
        if not pos.minuteMax then pos.minuteMax = 60 end
        if not pos.waMin then pos.waMin = 0 end
        if not pos.waMax then pos.waMax = math.huge end

        if hour >= pos.hourMin and hour < pos.hourMax and minute >= pos.minuteMin and minute < pos.minuteMax and wa >= pos.waMin and wa < pos.waMax then
            return pos.activity, pos.activityMode
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
                        result.program = zombie.brain.program.name
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
                        result.program = zombie.brain.program.name
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
        if zombie and not zombie:getVariableBoolean("Bandit") and not zombie:getModData().isDeadBandit then
            if zombie:getX() >= x1 and zombie:getX() <= x2
               and zombie:getY() >= y1 and zombie:getY() <= y2 then
                zombie:removeFromSquare()
                zombie:removeFromWorld()
            end
        end
    end
end

BanditUtils.ClearSpace = function(x, y, z, w, h)
    local cell = getCell()

    for cz=0, 2 do
        for cx=x, x+w do
            for cy=y, y+h do
                local square = cell:getGridSquare(cx, cy, cz)
                if square then
                    local objects = square:getObjects()
                    local destroyList = {}

                    for i=0, objects:size()-1 do
                        local object = objects:get(i)
                        if object then
                            local sprite = object:getSprite()
                            if sprite then 
                                local spriteName = sprite:getName()
                                local spriteProps = sprite:getProperties()

                                local isSolidFloor = spriteProps:has(IsoFlagType.solidfloor)
                                local isAttachedFloor = spriteProps:has(IsoFlagType.attachedFloor)

                                if not isSolidFloor or cz > 0 then
                                    table.insert(destroyList, object)
                                end

                                if isSolidFloor and spriteName:embodies("natural") then
                                    object:clearAttachedAnimSprite()
                                end
                            end
                        end
                    end

                    for k, obj in pairs(destroyList) do
                        if isClient() then
                            sledgeDestroy(obj);
                        else
                            square:transmitRemoveItemFromSquare(obj)
                        end
                    end
                end
            end
        end
    end
end

BWOAUtils.ApplyAcidPlayer = function(player)

    local humanVisuals = player:getHumanVisual()
    local maxIndex = BloodBodyPartType.MAX:index()
    for i = 0, maxIndex - 1 do
        local part = BloodBodyPartType.FromIndex(i)
        if ZombRand(3) == 0 then
            player:addHole(part, false)
        end
        humanVisuals:setBlood(part, 1)
    end

    local bodyParts = player:getBodyDamage():getBodyParts();
    local maxIndex2 = BodyPartType.MAX:index()
    for i = 0, maxIndex2 - 1 do
        local bodyPart = bodyParts:get(i);
        if ZombRand(3) == 0 then
            bodyPart:setBurned()
        end
    end

    local sound = player:getDescriptor():getVoicePrefix() .. "DeathEaten"
    local emitter = player:getEmitter()
    emitter:stopSoundByName("GasMaskSlow")
    emitter:stopSoundByName("GasMaskMedium")
    emitter:stopSoundByName("GasMaskFast")
    if not emitter:isPlaying(sound) then
        emitter:playSound(sound)
    end


end

BWOAUtils.ApplyAcidZombie = function(zombie)
    zombie:setSkeleton(true)
    local visuals = zombie:getHumanVisual()
    visuals:setHairModel("Bald")
    visuals:setBeardModel("")

    local itemVisuals = zombie:getItemVisuals()
    itemVisuals:clear()

    local attachedItems = zombie:getAttachedItems()
    attachedItems:clear()

    local wornItems = zombie:getWornItems()
    wornItems:clear()

    local inventory = zombie:getInventory()
    inventory:clear()
    zombie:clearItemsToSpawnAtDeath()

    zombie:resetModelNextFrame()
    zombie:resetModel()

    local isBandit = zombie:getVariableBoolean("Bandit")
    if isBandit then
        local fakeItem = BanditCompatibility.InstanceItem("Base.Axe")
        local fakeZombie = getCell():getFakeZombieForHit()
        zombie:Hit(fakeItem, fakeZombie, 50, false, 1, false)
        zombie:setHealth(0)
    end
end

BWOAUtils.ScrubSquare = function(square, fluid)
    if not square then return end

    local applyFoodEffect = function(item)
        local test = item:getDisplayCategory()
        if item:isFood() and item:getDisplayCategory() == "Food" then
            local itemScript = item:getScriptItem()

            local exc = {}
            exc.closed = item:getOpeningRecipe()
            exc.packed = item:getDoubleClickRecipe()
            exc.preserved = item:hasTag(ItemTag.PRESERVED_FOOD)
            exc.sealed = item:hasTag(ItemTag.SEALED_BEVERAGE_CAN)

            local exception = false
            for _, v in pairs(exc) do
                if v then 
                    exception = true 
                    break
                end
            end

            if not exception then
                item:setPoisonPower(7)
                item:setPoisonDetectionLevel(10)
            end
        end
    end

    local cleanup = function(character)
        local humanVisuals = character:getHumanVisual()
        humanVisuals:removeDirt()
        humanVisuals:removeBlood()

        -- Cleanup blood/dirt
        local maxIndex = BloodBodyPartType.MAX:index()
        for i = 0, maxIndex - 1 do
            local part = BloodBodyPartType.FromIndex(i)
            humanVisuals:setBlood(part, 0)
            humanVisuals:setDirt(part, 0)
        end

        -- Cleanup item visuals
        if not instanceof(character, "IsoDeadBody") then
            local itemVisuals = character:getItemVisuals()
            for i = 0, itemVisuals:size() - 1 do
                local item = itemVisuals:get(i)
                if item then
                    for j = 0, maxIndex - 1 do
                        local part = BloodBodyPartType.FromIndex(j)
                        item:setBlood(part, 0)
                        item:setDirt(part, 0)
                    end
                end
            end
        end

        -- Cleanup attached items
        local attachedItems = character:getAttachedItems()
        for i = 0, attachedItems:size() - 1 do
            local item = attachedItems:get(i):getItem()
            if item then
                item:setBloodLevel(0)
            end
        end

        -- Cleanup worn items
        local wornItems = character:getWornItems()
        for i = wornItems:size() - 1, 0, -1 do
            local item = wornItems:get(i):getItem()
            if item then
                for j = 0, maxIndex - 1 do
                    local part = BloodBodyPartType.FromIndex(j)
                    item:setBlood(part, 0)
                    item:setDirt(part, 0)
                end
                if instanceof(item, "Clothing") then -- outermost clothing item
                    item:setDirtiness(0)
                    if item:getWetness() < 30 then
                        item:setWetness(30)
                    end
                    break
                end
            end
        end

        local items = {character:getPrimaryHandItem(), character:getSecondaryHandItem()}
        for _, item in ipairs(items) do
            if item then
                item:setBloodLevel(0)
            end
        end

        if not instanceof(character, "IsoDeadBody") then
            character:resetModelNextFrame()
        end
    end

    local decompose = function(deadbody)
        local wx, wy, wz = deadbody:getX(), deadbody:getY(), deadbody:getZ()
        local angleRad = deadbody:getAngle()

        local cosA = math.cos(angleRad)
        local sinA = math.sin(angleRad)

        local pivot = {x = wx - math.floor(wx), y = wy - math.floor(wy)}

        local bones = {
            {type="Bandits.HumanBone", x=0.27, y=0.35, z=0.00, rx=0, ry=0, rz=320},
            {type="Bandits.HumanBone", x=0.34, y=0.70, z=0.00, rx=0, ry=0, rz=25},
            {type="Bandits.HumanBone", x=0.75, y=0.66, z=0.00, rx=0, ry=0, rz=0},
            {type="Bandits.HumanBone", x=0.76, y=0.40, z=0.00, rx=0, ry=0, rz=345},
            {type="Base.Hominid_Skull", x=0.23, y=0.55, z=0.00, rx=0, ry=0, rz=335},
        }

        for _, b in ipairs(bones) do
            -- shift to pivot
            local dx = b.x - pivot.x
            local dy = b.y - pivot.y

            -- rotate
            local rx = dx * cosA - dy * sinA
            local ry = dx * sinA + dy * cosA

            -- shift back
            local finalX = pivot.x + rx
            local finalY = pivot.y + ry

            -- convert radians → degrees for rz
            local angleDeg = math.deg(angleRad)

            BWOAPrepareTools.AddWorldItem(
                wx,
                wy,
                wz,
                b.type,
                {
                    x = finalX,
                    y = finalY,
                    z = b.z,
                    rx = b.rx,
                    ry = b.ry,
                    rz = (b.rz + angleDeg) % 360
                }
            )
        end
    end

    local player = square:getPlayer()
    if player then
        cleanup(player)
        if fluid == "NBCSolution" then
            local items = ArrayList.new()
            player:getInventory():getAllEvalRecurse(predicateAll, items)
            for i=0, items:size()-1 do
                local item = items:get(i)
                item:getModData().radiated = false
                applyFoodEffect(item)
            end
        elseif fluid == "Acid" then
            BWOAUtils.ApplyAcidPlayer(player)
        end
    end

    local wobs = square:getWorldObjects()
    for i = 0, wobs:size()-1 do
        local item = wobs:get(i):getItem()
        if item then
            item:setBloodLevel(0)
            if fluid == "NBCSolution" then
                item:getModData().radiated = false
                applyFoodEffect(item)

                if instanceof(item, "InventoryContainer") then
                    local inv = item:getInventory()
                    if inv then
                        local contents = ArrayList.new()
                        inv:getAllEvalRecurse(predicateAll, contents)
                        for j = 0, contents:size()-1 do
                            local item = contents:get(j)
                            item:getModData().radiated = false
                            applyFoodEffect(item)
                        end
                    end
                end
            end
        end
    end

    local objects = square:getStaticMovingObjects()
    for i=0, objects:size()-1 do
        local object = objects:get(i)
        if instanceof(object, "IsoDeadBody") then
            cleanup(object)
            if fluid == "NBCSolution" then
                object:getModData().radiated = false
                local inv = object:getContainer()
                if inv then
                    local items = ArrayList.new()
                    inv:getAllEvalRecurse(predicateAll, items)
                    for j=0, items:size()-1 do
                        local item = items:get(j)
                        item:getModData().radiated = false
                        applyFoodEffect(item)
                    end
                end
            elseif fluid == "Acid" and not object:isSkeleton() then
                object:reanimateNow()
                local tab = {
                    x = object:getX(),
                    y = object:getY(),
                    z = object:getZ(),
                }
                BWOAEventControl.Add("Skeleton", tab, 100)
            end
        end
    end

    local chrs = square:getMovingObjects()
    for i=0, chrs:size()-1 do
        local chr = chrs:get(i)
        if instanceof(chr, "IsoZombie") then
            cleanup(chr)
            if fluid == "NBCSolution" then
                chr:getModData().radiated = false
            elseif fluid == "Acid" and not chr:isSkeleton() then
                BWOAUtils.ApplyAcidZombie(chr)
            end
        end
    end

    local plant = SFarmingSystem.instance:getLuaObjectAt(square:getX(), square:getY(), square:getZ())
    if plant then
        if plant.waterNeeded and plant.waterNeeded > 0 and plant.waterLvl and plant.waterLvl <= 90 then
            plant.waterLvl = plant.waterLvl + 10
        end
        if fluid == "NBCSolution" then
            plant:killThis()
        end
    end

    if fluid ~= "Acid" then
        square:removeBlood(false, false)
        square:stopFire()
    end

end

BWOAUtils.ScrubVehicle = function(vehicle)
    if not vehicle then return end
    local ok, nparts = pcall(function() return vehicle:getPartCount() end)
    if not ok or not nparts then return end
    for i = 0, nparts - 1 do
        local okPart, part = pcall(function() return vehicle:getPartByIndex(i) end)
        if okPart and part then
            local okInv, inv = pcall(function() return part:getItemContainer() end)
            if okInv and inv then
                local contents = ArrayList.new()
                inv:getAllEvalRecurse(predicateAll, contents)
                for j = 0, contents:size()-1 do
                    local item = contents:get(j)
                    item:getModData().radiated = false
                    applyFoodEffect(item)
                end
            end
        end
    end
end

BanditUtils.GetCordsByFacing = function(x, y, facing)
    local fx, fy = x, y
    if facing == "N" then
        fy = y - 2
    elseif facing == "S" then
        fy = y + 2
    elseif facing == "E" then
        fx = x + 2
    elseif facing == "W" then
        fx = x - 2
    end

    return fx, fy
end
