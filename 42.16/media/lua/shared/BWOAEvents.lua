BWOAEvents = BWOAEvents or {}

local function predicateAll(item)
    -- item:getType()
	return true
end

BWOAEvents.FadeOut = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            local playerNum = player:getPlayerNum()
            player:setBlockMovement(true)
            player:setBannedAttacking(true)
            UIManager.setFadeBeforeUI(playerNum, false)
            UIManager.FadeOut(playerNum, params.time)
            if params.mute then
                getSoundManager():setSoundVolume(0)
            end
        end
    end
end

BWOAEvents.FadeIn = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            local playerNum = player:getPlayerNum()
            player:setBlockMovement(false)
            player:setBannedAttacking(false)
            UIManager.FadeIn(playerNum, params.time)
            UIManager.setFadeBeforeUI(playerNum, false)
            if params.unmute then
                getSoundManager():setSoundVolume(params.volume)
            end
            -- BWOASound.PlayPlayer({sound="AmbientHorn"})
        end
    end
end

BWOAEvents.Chapter = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    BWOASound.PlayPlayer({sound="Dream1End"})
    
    BWOATex.tex = getTexture("media/textures/" .. params.tex .. ".png")
    BWOATex.speed = 0.009
    BWOATex.mode = "center"
    BWOATex.alpha = 2.4
end

BWOAEvents.Spooky = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    BWOASound.PlayPlayer({sound=params.sound, volume = params.volume})
    
    BWOATex.tex = getTexture("media/textures/" .. params.tex .. ".png")
    BWOATex.speed = params.speed
    BWOATex.mode = "center"
    BWOATex.alpha = params.alpha
end

BWOAEvents.Teleport = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            player:setX(params.x + i)
            player:setY(params.y + i)
            player:setZ(params.z)
            player:setLastX(params.x + i)
            player:setLastY(params.y + i)
            player:setLastZ(params.z)
        end
    end
    getWorld():update()
end

BWOAEvents.WorldSetup = function(params)
    BWOABuildings.CreateHatches()
end

BWOAEvents.PlayerSetup = function(params)
    local playerList = BanditPlayer.GetPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        if player then
            local gown = BanditCompatibility.InstanceItem("Base.HospitalGown")
            local gownLocation = gown:getBodyLocation()
            local inv = player:getInventory()
            local wornItems = player:getWornItems()
            inv:clear()
            wornItems:clear()
            inv:AddItem(gown)
            wornItems:setItem(gownLocation, gown)
            player:setWornItems(wornItems)

            if isDebugEnabled() or isAdmin() then
                local flashlight = BanditCompatibility.InstanceItem("Base.Torch")
                inv:AddItem(flashlight)
                player:setPrimaryHandItem(flashlight)
            end

            local humanVisual = player:getHumanVisual()
            humanVisual:setHairModel("Bald")
            if not player:isFemale() then
                humanVisual:setBeardModel("")
            end

            player:resetModel()
            player:resetHairGrowingTime()
            player:resetBeardGrowingTime()

            local bodyDamage = player:getBodyDamage()
            local head = bodyDamage:getBodyPart(BodyPartType.Head)
            head:setAdditionalPain(90)
            -- head:setBandaged(true, 1)
            bodyDamage:SetBandaged(head:getIndex(), true, 8, false, "Base.Bandage")
    
            local xp = player:getXp()
            xp:AddXP(PerkFactory.Perks.Strength, -18500)

            local nutrition = player:getNutrition()
            local weight = nutrition:getWeight()
            nutrition:setWeight(weight - 6)

            local stats = player:getStats()
            stats:set(CharacterStat.HUNGER, 50)
            stats:set(CharacterStat.THIRST, 40)
        end
    end
end

BWOAEvents.SayPlayer = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end
    local color = player:getSpeakColour()
    player:addLineChatElement(params.txt, color:getR(), color:getG(), color:getB())
end

-- params: id, txt, anim
BWOAEvents.SayBandit = function(params)
    local player = getSpecificPlayer(0)
    local speaker = BanditZombie.GetInstanceById(params.id)
    if speaker then
        Bandit.ClearTasks(speaker)
        -- print ("SAY: " .. tostring(params.sound))
        local task = {action="Talk", anim=params.anim, txt=params.txt, voice=params.sound, x=player:getX(), y=player:getY(), time=2000}
        Bandit.AddTask(speaker, task)
    end
end

BWOAEvents.HaloPlayer = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    if params.perk and params.xp then
        local xp = player:getXp()
        local perk = PerkFactory.Perks[params.perk]
        xp:AddXPHaloText(perk, params.xp)
    else
        HaloTextHelper.addGoodText(player, params.txt)
    end
end

BWOAEvents.ElecShut = function(params)
    getSandboxOptions():set("ElecShut", 1)
    getSandboxOptions():set("ElecShutModifier", 0)
    if getWorld():isHydroPowerOn() then
        getWorld():setHydroPowerOn(false)
    end
end

-- proxy

BWOAEvents.ClearZombies = function(params)
    BanditUtils.ClearZombies(params.x1, params.x2, params.y1, params.y2)
end

BWOAEvents.DialogueReveal = function(params)
    if params.person and params.key then
        BWOADialogues.Reveal(params.person, params.key)
    end
end


BWOAEvents.EmergencyLights = function(params)
    if params.roomName and params.active ~= nil then
        BWOABaseAPI.EmergencyLights(params.roomName, params.active)
    end
end

BWOAEvents.BuildRoom = function(params)
    if params.roomName then
        BWOARooms[params.roomName].Build()
    end
end

BWOAEvents.PrepareRoom = function(params)
    if params.roomName then
        BWOARooms[params.roomName].Prepare()
        --[[
        if BWOARooms[params.roomName].SetEmitters then
            BWOARooms[params.roomName].SetEmitters()
        end
        if BWOARooms[params.roomName].SetFlickers then
            BWOARooms[params.roomName].SetFlickers()
        end
        if BWOARooms[params.roomName].SetAnims then
            BWOARooms[params.roomName].SetAnims()
        end
        ]]
    end
end

BWOAEvents.SetRoomEmitters = function(params)
    if params.roomName then
        BWOARooms[params.roomName].SetEmitters()
    end
end

BWOAEvents.SetRoomFlickers = function(params)
    if params.roomName then
        BWOARooms[params.roomName].SetFlickers()
    end
end

BWOAEvents.SetRoomAnims = function(params)
    if params.roomName then
        BWOARooms[params.roomName].SetAnims()
    end
end

BWOAEvents.ClearBaseFromZombies = function(params)
    local zombieList = BanditZombie.CacheLightZ
    for id, z in pairs(zombieList) do
        if z.z < 0 then
            local zombie = BanditZombie.GetInstanceById(z.id)
            -- local id = BanditUtils.GetCharacterID(zombie)
            if zombie and zombie:isAlive() then
                -- fixme: zombie:canBeDeletedUnnoticed(float)
                zombie:removeFromSquare()
                zombie:removeFromWorld()
            end
        end
    end

    local cell = getCell()
    local zombieList = cell:getZombieList()
    local zombieListSize = zombieList:size()
    for i = zombieListSize - 1, 0, -1 do
        local zombie = zombieList:get(i)
        if zombie then
            zombie:removeFromSquare()
            zombie:removeFromWorld()
        end
    end
end

BWOAEvents.PlayPlayer = function(params)
    BWOASound.PlayPlayer(params)
end

BWOAEvents.PlayLocation = function(params)
    BWOASound.PlayLocation(params)
end

BWOAEvents.AlarmOn = function(params)
    BWOABaseAPI.AlarmOn()
end

BWOAEvents.Effect = function(params)
    local effect = params
    BWOAEffects.Add(effect)
end

BWOAEvents.Shaker = function(params)
    BWOAShaker.SetStatus(params.status)
end

BWOAEvents.Fire = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local cell = getCell()
    local square = cell:getGridSquare(params.x, params.y, params.z)
    if square then
        IsoFireManager.StartFire(cell, square, true, 500000, 500)
    end
end

BWOAEvents.DecontaminatePre = function(params)
    BWOASound.AddNoah({sound = BWOASound.noahSounds.DECONTAMINATION})


    local gmd = GetBWOAModData()
    local decontaminator = gmd.decontaminator
    if decontaminator.concentration <= 15 then
        BWOASound.AddNoah({sound = BWOASound.noahSounds.ATTENTION})
        BWOASound.AddNoah({sound = BWOASound.noahSounds.DECONTAMINATION_RISK})
    end

    local mx = math.ceil((params.x1 + params.x2) / 2)
    local my = math.ceil((params.y1 + params.y2) / 2)
    local mz = params.z

    for _, lcoords in ipairs(params.lamps) do
        local square = getCell():getGridSquare(lcoords.x, lcoords.y, lcoords.z)
        if square then
            local objects = square:getObjects()
            for i=0, objects:size()-1 do
                local object = objects:get(i)
                if instanceof(object, "IsoLightSwitch") then
                    object:setActive(false)
                    local ls = IsoLightSource.new(lcoords.x, lcoords.y, lcoords.z, 1, 0, 0, 12, 700)
                    getCell():addLamppost(ls)
                end
            end
        end
    end
end

BWOAEvents.DecontaminatePost = function(params)
    BWOASound.AddNoah({sound = BWOASound.noahSounds.DECONTAMINATION_COMPLETE})

    local gmd = GetBWOAModData()
    local decontaminator = gmd.decontaminator
    if decontaminator.concentration <= 0 then return end

    decontaminator.concentration = decontaminator.concentration - 5
    if decontaminator.concentration < 0 then decontaminator.concentration = 0 end

    local cell = getCell()
    for y = params.y1, params.y2 do
        for x = params.x1, params.x2 do
            local square = cell:getGridSquare(x, y, params.z)
            if square then
                local player = square:getPlayer()
                if player then
                    local items = ArrayList.new()
                    local inventory = player:getInventory()
                    inventory:getAllEvalRecurse(predicateAll, items)
                    for i=0, items:size()-1 do
                        local item = items:get(i)
                        item:getModData().radiated = false
                    end
                end

                local wobs = square:getWorldObjects()
                for i = 0, wobs:size()-1 do
                    local o = wobs:get(i)
                    local item = o:getItem()
                    item:getModData().radiated = false
                end

                local objects = square:getStaticMovingObjects()
                for i=0, objects:size()-1 do
                    local object = objects:get(i)
                    if instanceof (object, "IsoDeadBody") then
                        local inventory = object:getContainer()
                        if inventory then
                            local items = ArrayList.new()
                            inventory:getAllEvalRecurse(predicateAll, items)
                            for j=0, items:size()-1 do
                                local item = items:get(j)
                                item:getModData().radiated = false
                            end
                        end
                    end
                end

                local chrs = square:getMovingObjects()
                for i=0, chrs:size()-1 do
                    local chr = chrs:get(i)
                    if instanceof(chr, "IsoZombie") then
                        local md = chr:getModData()
                        md.radiated = false
                    end
                end
            end
        end
    end

    for _, lcoords in ipairs(params.lamps) do
        local square = getCell():getGridSquare(lcoords.x, lcoords.y, lcoords.z)
        if square then
            local objects = square:getObjects()
            for i=0, objects:size()-1 do
                local object = objects:get(i)
                if instanceof(object, "IsoLightSwitch") then
                    object:setActive(true)
                    -- getCell():removeLamppost(lcoords.x, lcoords.y, lcoords.z)
                end
            end
        end
    end
end

-- events

BWOAEvents.WallCrack = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local world = getWorld()
    local cell = getCell()
    local volume = getSoundManager():getSoundVolume()

    local x1 = params.x - 8
    local x2 = params.x + 8
    local y1 = params.y - 8
    local y2 = params.y + 8
    local z = params.z

    local candidates = {}
    for x = x1, x2 do
        for y = y1, y2 do
            local square = cell:getGridSquare(x, y, z)
            if square then
                local wall = square:getWall(true) or square:getWall(false)

                if wall then
                    local sprite = wall:getSprite()
                    if  sprite then 
    
                        local spriteProps = sprite:getProperties()
                        if not spriteProps:has(IsoFlagType.WallNTrans) and not spriteProps:has(IsoFlagType.WallWTrans)
                           and not spriteProps:has(IsoFlagType.WindowN) and not spriteProps:has(IsoFlagType.WindowW) 
                           and not spriteProps:has(IsoFlagType.DoorWallN) and not spriteProps:has(IsoFlagType.DoorWallW)
                           and not spriteProps:has(IsoFlagType.WallSE) then 

                            table.insert(candidates, wall)
                        end
                    end
                end
            end
        end
    end

    if #candidates > 0 then
        local wall = candidates[1 + ZombRand(#candidates)]

        if wall then

            local x, y, z = wall:getX(), wall:getY(), wall:getZ()
            

            if ZombRand(3) == 0 then
                
                local spriteName = "d_wallcracks_1_" .. tostring(1 + ZombRand(70))
                local list = ArrayList.new()
                local attachments = wall:getAttachedAnimSprite()
                if not attachments or attachments:size() == 0 then
                    wall:setAttachedAnimSprite(ArrayList.new())
                end
                wall:getAttachedAnimSprite():add(getSprite(spriteName):newInstance())
                BWOASound.PlayLocation({x = x, y = y, z = z, sound="AmbientWallcrack"})

                local lightSwitch = BanditUtils.GetLightSwitchMain(x, y, z)
                if lightSwitch and lightSwitch:hasLightBulb() then
                    lightSwitch:setActive(false, false, true)
                    lightSwitch:removeLightBulb(cell:getFakeZombieForHit())

                    local tab = {x = x, y = y, z = z, sound = "AmbientBulbFlicker"}
                    BWOASound.PlayLocation(tab)
                end
            end
        end
    end
end

BWOAEvents.SpawnGroup = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local args = params

    sendClientCommand(player, 'Spawner', 'Clan', args)
end

-- params: size, x, y, z, outfit, femaleChance
BWOAEvents.HordeAt = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    for j=1, params.size do
        local zombieList = BanditCompatibility.AddZombiesInOutfit(params.x, params.y, params.z, params.outfit, params.femaleChance, false, false, false, false, false, false, 1)
        for i=0, zombieList:size()-1 do
            local zombie = zombieList:get(i)
            zombie:spotted(player, true)
            zombie:setTarget(player)
            zombie:setAttackedBy(player)
            -- zombie:pathToLocationF(player:getX(), player:getY(), player:getZ())
        end
    end
end

BWOAEvents.SpawnVehicle = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local vtype = "Base.SUV"

    local vehicle = addVehicle(params.vtype, params.x, params.y, 0)
    if not vehicle then return end

    vehicle:setAngles(0, -90, 0) -- to west
    vehicle:setGeneralPartCondition(0.8, 0)
    vehicle:setRust(100)

    for i = 0, vehicle:getPartCount() - 1 do
        local container = vehicle:getPartByIndex(i):getItemContainer()
        if container then
            container:removeAllItems()
        end
    end

    vehicle:addKeyToGloveBox()

    local loot = Bandit.raidCarLootItems
    local container = vehicle:getTrunkPart():getItemContainer()
    if container then
        for _, itemType in ipairs(loot) do
            local rnd = ZombRand(100)
            if rnd > 70 then
                local item = container:AddItem(itemType)
                if item then
                    container:addItemOnServer(item)
                end
            end
        end
    end
end

BWOAEvents.PlaceEvent = function(params)
    BWOAPlaceEvents.Render(params)

    if params.music then
        BWOAMusic.Play(params.music, 0.6, 1)
    end

    if SandboxVars.BWOA.AngelProximity then
        BWOASound.PlayPlayer({sound="AngelProximity"})

        local icon = "media/ui/defend.png"
        local color = {r=0.5, g=0.5, b=1}
        local desc = getText("UI_BWOA_POI")
        BanditEventMarkerHandler.set(getRandomUUID(), icon, 7200, params.x, params.y, color, desc)
    end
end

BWOAEvents.LavaLake = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local blueprint = BWOALakes.Medium1()
    BWOABuildTools.LavaLake(params.x, params.y, blueprint)
end

BWOAEvents.ArkNetworkStatus = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local arkId = params.arkId

    BWOABaseAPI.NetworkArkReveal(arkId)
end

BWOAEvents.GodModSwitch = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    player:setGodMod(params.on, true)
end

BWOAEvents.FinaleStage1 = function(params)
    BWOAMusic.Play("MusicFinale", 1, 1)
end

BWOAEvents.FinaleStage2 = function(params)
    getClimateManager():stopWeatherAndThunder()
end

BWOAEvents.FinaleStage3 = function(params)
    local cm = getWorld():getClimateManager()
    local ambient = cm:getClimateFloat(ClimateManager.FLOAT_AMBIENT)
    local desaturation = cm:getClimateFloat(ClimateManager.FLOAT_DESATURATION)
    local fogIntensity = cm:getClimateFloat(ClimateManager.FLOAT_FOG_INTENSITY)
    local windIntensity = cm:getClimateFloat(ClimateManager.FLOAT_WIND_INTENSITY)

    ambient:setEnableOverride(false)
    desaturation:setEnableOverride(false)
    fogIntensity:setEnableOverride(false)
    windIntensity:setEnableOverride(false)
    ImprovedFog.setEnableEditing(false)

    BWOATex.tex = getTexture("media/textures/rainbow.png")
    BWOATex.speed = 0.000001
    BWOATex.mode = "full"
    BWOATex.alpha = 0.3
end

    
    