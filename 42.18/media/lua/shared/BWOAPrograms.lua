BWOAPrograms = BWOAPrograms or {}

BWOAPrograms.SwitchOutfit = function(bandit, outfit)
    local brain = BanditBrain.Get(bandit)
    local program = brain.program.name
    local gmd = GetBWOAModData()
    local ventilation = gmd.ventilation
    local temp = ventilation.temp
    local co2 = ventilation.co2

    local co2treshold = 6000
    local tempTreshold = 16

    if outfit == "Bunker" then
        if temp < tempTreshold and co2 > co2treshold then
            outfit = "BunkerColdCO2"
        elseif temp < tempTreshold then
            outfit = "BunkerCold"
        elseif co2 > co2treshold then
            outfit = "BunkerCO2"
        end
    end

    if outfit == "Lab" then
        if co2 > co2treshold then
            outfit = "LabCO2"
        end
    end

    if outfit == "Cook" then
        if temp < tempTreshold then
            outfit = "CookCold"
        end
    end

    if outfit == "Defend" then
        if co2 > co2treshold then
            outfit = "DefendCO2"
        end
    end

    local bid = Bandit.banditMap[program][outfit]
    if bid ~= brain.bid then
        print ("Switching outfit to " .. bid)
        local task = {
            action = "Transform", 
            bid = bid,
            cid = Bandit.clanMap[program],
            time = 200,
        }
        return task
    end
end

BWOAPrograms.GoAndDo = function(bandit, point, task, precision, checkCollision)
    local tasks = {}

    if precision == nil then precision = 0.7 end
    if checkCollision == nil then checkCollision = true end

    local square = getCell():getGridSquare(point.x, point.y, point.z)
    if not square then return tasks end

    local asquare = square
    if not square:isNotBlocked(false) then
        asquare = BanditUtils.GetAccessSquare(square, bandit)
    end
    if not asquare then return tasks end

    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local ax, ay, az = asquare:getX(), asquare:getY(), asquare:getZ()

    local collide
    if checkCollision then
        collide = LosUtil.lineClearCollide(
            math.floor(bx), math.floor(by), math.floor(bz),
            math.floor(ax), math.floor(ay), math.floor(az),
            false
        ) 
    else
        collide = false
    end

    local dist = BanditUtils.DistTo(bx, by, ax + 0.5, ay + 0.5)
    if dist > precision or collide then
        table.insert(tasks, BanditUtils.GetMoveTask(0, ax, ay, az, "Walk", dist, false))
        return tasks
    else
        table.insert(tasks, task)
        return tasks
    end
end

BWOAPrograms.Fallen = function(bandit)
    local tasks = {}
    local task = {action="Generic", anim="Fallen", voice=voice, looped=true, time=200}
    table.insert(tasks, task)
    return tasks
end

BWOAPrograms.FollowMaster = function(bandit)
    local tasks = {}
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local master = BanditPlayer.GetMasterPlayer(bandit)
    local mx, my, mz = master:getX(), master:getY(), master:getZ()
    local mid = BanditUtils.GetCharacterID(master)


    -- update walktype
    local walkType = "Walk"
    local endurance = 0.00
    local vehicle = master:getVehicle()
    local dist = BanditUtils.DistTo(bx, by, mx, my)

    if master:isSprinting() or dist > 10 then
        walkType = "Run"
        endurance = 0
    elseif master:isSneaking() and dist < 12 then
        walkType = "SneakWalk"
        endurance = 0
    end

    local outOfAmmo = Bandit.IsOutOfAmmo(bandit)
    if master:isAiming() and not outOfAmmo and dist < 8 then
        walkType = "WalkAim"
        endurance = 0
    end

    if dist < 20 then
        local closestZombie = BanditUtils.GetClosestZombieLocation(bandit)
        local closestBandit = BanditUtils.GetClosestEnemyBanditLocation(bandit)
        local closestEnemy = closestZombie

        if closestBandit.dist < closestZombie.dist and closestBandit.z == bz then 
            closestEnemy = closestBandit
        end

        if closestEnemy.dist < 8 and closestEnemy.z == bz then
            walkType = "WalkAim"
            table.insert(tasks, BanditUtils.GetMoveTaskTarget(endurance, closestEnemy.x, closestEnemy.y, closestEnemy.z, closestEnemy.id, closestEnemy.player, walkType, closestEnemy.dist))
            return tasks
        end
    end

    if dist > 2 or math.abs(mz - bz) >= 1 then
        table.insert(tasks, BanditUtils.GetMoveTaskTarget(endurance, mx, my, mz, mid, true, walkType, dist))
        -- table.insert(tasks, BanditUtils.GetMoveTask(endurance, mx, my, mz, walkType, dist, false))
        return tasks
    end

    return tasks
end

BWOAPrograms.TagGame = function(bandit)
    local tasks = {}
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    local master = BanditPlayer.GetMasterPlayer(bandit)
    local mx, my, mz = master:getX(), master:getY(), master:getZ()

    local x1, y1, x2, y2 = 9958, 12609, 9971, 12641

    local dx = bx - mx
    local dy = by - my
    local len = math.sqrt(dx*dx + dy*dy)
    if len > 6 then
        Bandit.Say(bandit, "TAGGAME1")
    elseif len > 1 then
        Bandit.Say(bandit, "TAGGAME2")
    end


    if len < 0.6 then 
        Bandit.Say(bandit, "TAGGAME3", true)
        local brain = BanditBrain.Get(bandit)
        BWOANPC.ModBrain(brain.id, "mode", nil)
        len = 0.6
    end

    dx, dy = dx / len, dy / len

    -- If escapee is at a border, adjust flee direction so it stays inside the map
    if bx <= x1 + 1 and dx < 0 then
        dx = 0              -- cannot flee further left → remove horizontal push
    end
    if bx >= x2 - 1 and dx > 0 then
        dx = 0              -- cannot flee further right
    end
    if by <= y1 + 1 and dy < 0 then
        dy = 0              -- cannot flee further up
    end
    if by >= y2 - 1 and dy > 0 then
        dy = 0              -- cannot flee further down
    end

    -- If dx and dy are both canceled (corner), create a sideways escape
    if dx == 0 and dy == 0 then
        -- pick a random sliding direction along the wall
        if bx <= x1 + 1 or bx >= x2 - 1 then
            dx = 0
            dy = (ZombRandFloat(0, 1) < 0.5) and -1 or 1
        else
            dy = 0
            dx = (ZombRandFloat(0, 1) < 0.5) and -1 or 1
        end
    end

    -- Re-normalize the adjusted direction
    len = math.sqrt(dx*dx + dy*dy)
    dx, dy = dx/len, dy/len

    local fleeDistance = 12
    local targetX = bx + dx * fleeDistance
    local targetY = by + dy * fleeDistance

    -- Boundary clamp
    targetX = math.min(math.max(targetX, x1), x2)
    targetY = math.min(math.max(targetY, y1), y2)

    -- update walktype
    local walkType = "Run"
    local endurance = 0.00

    table.insert(tasks, BanditUtils.GetMoveTask(endurance, targetX, targetY, bz, walkType, 10, false))

    return tasks
end

BWOAPrograms.IdleEmma = function(bandit)
    local tasks = {}
    local action = ZombRand(140)
    local player = BanditPlayer.GetMasterPlayer(bandit)
    local px, py = player:getX(), player:getY()

    if action == 0 then
        local task = {action="FaceLocation", x=px, y=py, anim="ShiftWeight", time=200}
        table.insert(tasks, task)
    elseif action == 1 then
        local task = {action="FaceLocation", x=px, y=py, anim="Cough", sound="VoiceFemaleMuffledCough", time=200}
        table.insert(tasks, task)
    elseif action == 2 then
        local task = {action="FaceLocation", x=px, y=py, anim="ChewNails", time=200}
        table.insert(tasks, task)
    elseif action == 3 then
        local task = {action="FaceLocation", x=px, y=py, anim="PullAtCollar", time=200}
        table.insert(tasks, task)
    elseif action == 4 then
        local task = {action="FaceLocation", x=px, y=py, anim="Sneeze", sound="VoiceFemaleSneezeLight", time=200}
        table.insert(tasks, task)
    elseif action == 5 then
        local task = {action="FaceLocation", x=px, y=py, anim="WipeBrow", time=200}
        table.insert(tasks, task)
    elseif action == 6 then
        local task = {action="FaceLocation", x=px, y=py, anim="WipeHead", time=200}
        table.insert(tasks, task)
    elseif action == 7 then
        local task = {action="FaceLocation", x=px, y=py, anim="ChewNails", time=200}
        table.insert(tasks, task)
    else
        local task = {action="FaceLocation", x=px, y=py, anim="IdleFemale", time=200}
        table.insert(tasks, task)
    end
    return tasks
end

BWOAPrograms.HealPlayer = function(bandit)
    local tasks = {}
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local master = BanditPlayer.GetMasterPlayer(bandit)
    local mx, my, mz = master:getX(), master:getY(), master:getZ()
    local mid = BanditUtils.GetCharacterID(master)
    local bodyDamage = master:getBodyDamage()

    local bodyPartsByPriority = {
        "Neck",
        "Head",
        "Groin",
        "Torso_Lower",
        "Torso_Upper",
        "UpperArm_R",
        "UpperArm_L",
        "ForeArm_R",
        "ForeArm_L",
        "Hand_R",
        "Hand_L",
        "UpperLeg_L",
        "UpperLeg_R",
        "LowerLeg_L",
        "LowerLeg_R",
        "Foot_L",
        "Foot_R",
    }

    local actionRequired = false
    local actionBodyPart
    for _, bodyPartName in ipairs(bodyPartsByPriority) do
        actionBodyPart = bodyPartName
        local bodyPart = BodyPartType[bodyPartName]
        if bodyDamage:IsBleeding(bodyPart) then
            actionRequired = true
            break
        end                
    end
    if not actionRequired then return tasks end

    local dist = BanditUtils.DistTo(bx, by, mx, my)
    if dist < 2 and math.abs(mz - bz) < 0.4 then
        local task = {action="HealPlayer", part=actionBodyPart, time=1000}
        table.insert(tasks, task)
    end

    if dist > 2 or math.abs(mz - bz) >= 1 then
        table.insert(tasks, BanditUtils.GetMoveTaskTarget(0, mx, my, mz, mid, true, "Run", dist))
        return tasks
    end

    return tasks
end

BWOAPrograms.Chase = function(bandit)
    local tasks = {}
    local config = {}
    config.mustSee = false
    config.hearDist = 50

    local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
    if reoutfitTask then return {reoutfitTask} end

    local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit, config)
    if closestPlayer.x and closestPlayer.y and closestPlayer.z and closestPlayer.dist > 4 then
        Bandit.Say(bandit, "WAITTALK")
        BWOADialogues.Reveal(ZombiePrograms.name, "4")
        table.insert(tasks, BanditUtils.GetMoveTask(0, closestPlayer.x, closestPlayer.y, closestPlayer.z, "Walk", closestPlayer.dist, false))
        return tasks
    else
        local idleTasks = BWOAPrograms.IdleEmma(bandit)
        if #idleTasks > 0 then return idleTasks end
    end
    return tasks
end

BWOAPrograms.Toilet = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    local toilet, dist = BWOABaseObjects.FindClosestObject({"Toilet"}, {x=bx, y=by})
    if toilet then
        local toiletIso = BWOABaseObjects.GetIsoObject(toilet)
        if toiletIso then
            local sittingPos = {
                ["fixtures_bathroom_01_4"] = {ox = 0.50, oy = 0.67, f="S"},
                ["fixtures_bathroom_01_5"] = {ox = 0.57, oy = 0.50, f="E"},
                ["fixtures_bathroom_01_6"] = {ox = 0.50, oy = 0.33, f="W"},
                ["fixtures_bathroom_01_7"] = {ox = 0.33, oy = 0.50, f="N"},
            }
            local spriteName = toiletIso:getSprite():getName()
            local sittingData = sittingPos[spriteName]

            if sittingData then
                local fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), sittingData.f)
                local task = {action="UseToiletStanding", anim="SitInChair1", looped=true, f=sittingData.f, fx = fx, fy = fy, ox = toilet.x + sittingData.ox, oy = toilet.y + sittingData.oy, time=1000}
                local subTasks = BWOAPrograms.GoAndDo(bandit, toilet, task, 1.1, false)
                if #subTasks > 0 then return subTasks end
            end
        end
    end
    return {}
end

BWOAPrograms.Eat = function(bandit)
    local tasks = {}
    local bx, by = bandit:getX(), bandit:getY()

    local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
    if reoutfitTask then return {reoutfitTask} end

    local foodConf = BWOAPermaInv.GetClass(bandit, "food")
    if not foodConf then
        foodConf = BWOAPermaInv.GetClass(bandit, "food_packaged")
    end
    if foodConf then
        local task = {action="Eat", time=300}
        table.insert(tasks, task)
        return tasks
    end

    local item, dist = BWOABaseObjects.FindClosestItemClass("food", {x=bx, y=by})
    if not item then
        item, dist = BWOABaseObjects.FindClosestItemClass("food_packaged", {x=bx, y=by})
    end
    if item then
        local task = {action="Collect", time=300, item=item}
        local subTasks = BWOAPrograms.GoAndDo(bandit, item, task)
        if #subTasks > 0 then return subTasks end
    end
    return tasks
end

BWOAPrograms.CleanBlood = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    local blood = BWOABaseObjects.FindFirstBlood()
    if blood then
        print("Found blood to clean at " .. blood.x .. ", " .. blood.y .. ", " .. blood.z)

        local hasBroom = BWOAPermaInv.HasType(bandit, "Base.Mop")
        local hasBleach = BWOAPermaInv.HasType(bandit, "Base.Bleach")
        if hasBroom and hasBleach then
            local task = {action="CleanFloor", time=300, blood=blood, x=blood.x, y=blood.y, z=blood.z, time=240}
            local subTasks = BWOAPrograms.GoAndDo(bandit, blood, task, 0.1)
            if #subTasks > 0 then return subTasks end
        else
            local itemType
            if hasBroom then
                itemType = "Base.Bleach"
            else
                itemType = "Base.Mop"
            end

            local item, dist = BWOABaseObjects.FindClosestItemTypes({itemType}, {x=bx, y=by}, {})
            if item then
                local task = {action="Collect", time=300, item=item}
                local subTasks = BWOAPrograms.GoAndDo(bandit, item, task)
                if #subTasks > 0 then return subTasks end
            end
        end
    end
    return {}
end

BWOAPrograms.Decontaminate = function(bandit)
    local brain = BanditBrain.Get(bandit)
    local program = brain.program.name
    local bx, by = bandit:getX(), bandit:getY()
    local item, dist = BWOABaseObjects.FindClosestRadiated({x=bx, y=by}, 100)
    if item and item.z < -3 then
        local room = BWOAUtils.GetRoom(item.x, item.y, item.z)
        if not room or (room.name ~= "ENTRANCE" and room.name ~= "DECONTAMINATION_CHAMBER") then
            local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Spray")
            if reoutfitTask then return {reoutfitTask} end

            local task = {action="Decontaminate", time=150, fx=item.x, fy=item.y}
            local subTasks = BWOAPrograms.GoAndDo(bandit, item, task, 4)
            if #subTasks > 0 then return subTasks end
        end
    end
    return {}
end

BWOAPrograms.ReturnFood = function(bandit)
    local inv = BWOAPermaInv.GetAll(bandit)
    local returnPosition = {x = 9966, y = 12612, z = -4}
    for _, itemConf in pairs(inv) do
        if itemConf.cooked then
            local task = {
                action = "DropItem", 
                time = 300, 
                x = returnPosition.x, y = returnPosition.y, z = returnPosition.z, 
                xmin = 0, xmax = 1, 
                ymin = 0.6, ymax = 1, 
                item = itemConf,
            }
            local subTasks = BWOAPrograms.GoAndDo(bandit, returnPosition, task)
            if #subTasks > 0 then return subTasks end
            break
        end
    end
    return {}
end

BWOAPrograms.JukeboxDancing = function(bandit)
    local tasks = {}
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local jukebox, dist = BWOAJukebox.FindClosest(bx, by, bz)
    if jukebox and dist < 21 then
        local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Dance")
        if reoutfitTask then return {reoutfitTask} end
        if dist < 6 then
            local anim = BanditUtils.Choice({"Dance1", "Dance2", "Dance3", "Dance4"})
            local task = {action="Single", time=500, anim=anim}
            local subTasks = BWOAPrograms.GoAndDo(bandit, jukebox, task)
            if #subTasks > 0 then return subTasks end
        else
            table.insert(tasks, BanditUtils.GetMoveTask(0, jukebox.x, jukebox.y, jukebox.z, "Walk", dist, false))
            return tasks
        end
    end
    return tasks
end

BWOAPrograms.OvenHandling = function(bandit)
    local ovenList = BWOABaseObjects.FindAllObjects({"Oven"}, {})
    for _, oven in ipairs(ovenList) do
        local items = BWOABaseObjects.GetItemStackAt(oven.x, oven.y, oven.z)
        local empty = true
        for _, item in pairs(items) do
            if item.cooked then
                local task = {action="Collect", time=300, item=item, cooked=true}
                local subTasks = BWOAPrograms.GoAndDo(bandit, oven, task)
                if #subTasks > 0 then return subTasks end
            end
            if item.class == "food" then
                empty = false
            end
        end

        local newActive = false
        if not empty then
            newActive = true
        end

        if oven.active ~= newActive then
            local task = {action="TurnOven", obj=oven, active=newActive, time=300}
            local subTasks = BWOAPrograms.GoAndDo(bandit, oven, task)
            if #subTasks > 0 then return subTasks end
        end
    end
    return {}
end

BWOAPrograms.Cook = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    -- check if already have enough cooked
    local enoughPrep = false
    local outputs = BWOARecipes.GetAllOutputs()
    for _, output in pairs(outputs) do
        local item = BWOABaseObjects.FindClosestItemTypes({output}, {x=bx, y=by}, {})
        if item and item.ground then
            enoughPrep = true
        end
    end
    
    local gt = getGameTime()
    local hour = gt:getHour()
    local day = gt:getDay()

    local mealTime = "breakfast"
    if hour >= 11 and hour < 17 then
        mealTime = "lunch"
    elseif hour >= 17 and hour < 24 then
        mealTime = "dinner"
    end
    local options = BWOARecipes.GetOptions(mealTime)
    local option = day % #options + 1
    local recipe = BWOARecipes.GetRecipe(options[option])

    local standPosition = {x = 9964.5, y = 12611.8, z = -4}
    local makePosition = {x = 9964, y = 12612, z = -4}

    -- needs to be cooked in a stove
    if recipe.cook then
        local oven, dist = BWOABaseObjects.FindClosestObject({"Oven"}, {x=bx, y=by})
        if oven then
            local cookable = BWOAPermaInv.GetType(bandit, recipe.result, false)
            if cookable then
                local task = {action="PutContainer", time=300, item=cookable, container=oven}
                local subTasks = BWOAPrograms.GoAndDo(bandit, oven, task)
                if #subTasks > 0 then return subTasks end
            else
                local cookable, dist = BWOABaseObjects.FindClosestItemTypes({recipe.result}, {x=bx, y=by}, {cooked=false})
                if cookable then
                    local hasOven = BWOABaseObjects.EnsureObjectAt("Oven", cookable.x, cookable.y, cookable.z)
                    if not hasOven then
                        local task = {action="Collect", time=300, item=cookable}
                        local subTasks = BWOAPrograms.GoAndDo(bandit, cookable, task)
                        if #subTasks > 0 then return subTasks end
                    end
                end
            end
        end
    end

    -- preparation
    if not enoughPrep then
        local vesselReady = BWOABaseObjects.EnsureItemTypeAt(recipe.vessel, makePosition.x, makePosition.y, makePosition.z, recipe.vesselCnt)
        if not vesselReady then
            local hasVessel = BWOAPermaInv.HasType(bandit, recipe.vessel, recipe.vesselCnt)
            if not hasVessel then
                local item, dist = BWOABaseObjects.FindClosestItemTypes({recipe.vessel}, {x=bx, y=by}, {})
                if item and not (item.ground and math.floor(item.x) == makePosition.x and math.floor(item.y) == makePosition.y) then
                    local task = {action="Collect", time=300, item=item}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, item, task)
                    if #subTasks > 0 then return subTasks end
                end
            else
                local task = {
                    action = "DropItem", 
                    time = 300, 
                    x = makePosition.x, y = makePosition.y, z = makePosition.z, 
                    xmin = 0, xmax = 1, 
                    ymin = 0.6, ymax = 1, 
                    item = {fullType = recipe.vessel}
                }
                local subTasks = BWOAPrograms.GoAndDo(bandit, makePosition, task)
                if #subTasks > 0 then return subTasks end
            end
        else
            local potentialIngredients = recipe.ingredients
            local hasIngredients = {}
            local countIngredients = recipe.ingredientsCnt
            for _, potentialIngredient in ipairs(potentialIngredients) do
                local ing = BWOAPermaInv.HasType(bandit, potentialIngredient)
                if ing then
                    table.insert(hasIngredients, potentialIngredient)
                else
                    local ing, dist = BWOABaseObjects.FindClosestItemTypes({potentialIngredient}, {x=bx, y=by}, {cooked=false})
                    if ing then
                        local task = {action="Collect", time=300, item=ing}
                        local subTasks = BWOAPrograms.GoAndDo(bandit, ing, task)
                        if #subTasks > 0 then return subTasks end
                    end
                end
                if #hasIngredients >= countIngredients then
                    break
                end
            end

            if #hasIngredients >= countIngredients then
                local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Cook")
                if reoutfitTask then return {reoutfitTask} end
                
                local task = {action="Cook", time=800, makePosition=makePosition, ingredients=hasIngredients, recipe=recipe}
                local subTasks = BWOAPrograms.GoAndDo(bandit, standPosition, task, 0.2)
                if #subTasks > 0 then return subTasks end
            end
        end
    end
    return {}
end

BWOAPrograms.Sleep = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()
    local obj, dist = BWOABaseObjects.FindClosestObject({"Beds", "Bed"}, {x=bx, y=by})
    if obj then
        local bed = BWOABaseObjects.GetIsoObject(obj)
        if bed then
            local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
            if reoutfitTask then return {reoutfitTask} end

            local facing = bed:getSprite():getProperties():get("Facing")
            local gridpos = bed:getSprite():getProperties():get("SpriteGridPos")
            if facing == "S" and gridpos == "0,0" then facing = "N" end
            if facing == "E" and gridpos == "0,0" then facing = "W" end

            -- local eoffset = bed:getSprite():getProperties():get("Eoffset")
            local task = {action="SleepLong", x=obj.x, y=obj.y, z=obj.z, facing=facing, time=3000}
            local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
            if #subTasks > 0 then return subTasks end
        end
    end
    return {}
end

BWOAPrograms.Jog = function(bandit)
    local tasks = {}
    
    local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Sport")
    if reoutfitTask then return {reoutfitTask} end

    local bx, by = bandit:getX(), bandit:getY()
    local tx, ty = 0, 0
    if bx >= 9959 and bx < 9973 and by >= 12608 and by < 12610 then
        tx, ty = 9958.5, 12609.5
    elseif bx >= 9957 and bx < 9959 and by >= 12608 and by < 12641 then
        tx, ty = 9958.5, 12641.5
    elseif bx >= 9957 and bx < 9971 and by >= 12641 and by < 12643 then
        tx, ty = 9971.5, 12641.5
    else
        tx, ty = 9971.5, 12609.5
    end

    table.insert(tasks, BanditUtils.GetMoveTask(0, tx, ty, -4, "Run", 10, false))
    return tasks
end

BWOAPrograms.RadioCall = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    local obj, dist = BWOABaseObjects.FindClosestObject({"Radio"}, {x=bx, y=by})
    if obj then
        local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
        if reoutfitTask then return {reoutfitTask} end

        local task = {action="UseRadio", time=500, fx=obj.x, fy=obj.y}
        local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
        if #subTasks > 0 then return subTasks end
    end
    return {}
end

BWOAPrograms.ReadBook = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    local obj, dist = BWOABaseObjects.FindClosestObject({"Couch"}, {x=bx, y=by})
    if obj then
        local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
        if reoutfitTask then return {reoutfitTask} end

        local task = {action="SitInChair", anim="SitInChairRead", sound="PageFlipBook", item="Bandits.Book", left=true, x=obj.x, y=obj.y, z=obj.z, facing=obj.f, time=1000}
        local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
        if #subTasks > 0 then return subTasks end
    end
    return {}
end

BWOAPrograms.WatchTV = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    local obj, dist = BWOABaseObjects.FindClosestObject({"Television"}, {x=bx, y=by})
    if obj then
        local tv = BWOABaseObjects.GetIsoObject(obj)
        if tv then

            local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
            if reoutfitTask then return {reoutfitTask} end

            local dd = tv:getDeviceData()
            local md = dd:getMediaData()
            if md then
                if dd:getIsTurnedOn() and dd:isPlayingMedia() then
                    local obj, dist = BWOABaseObjects.FindClosestObject({"Couch"}, {x=bx, y=by})
                    if obj then
                        if dist < 10 then
                            local task = {action="SitInChair", anim="SitInChairTalk", x=obj.x, y=obj.y, z=obj.z, facing=obj.f, time=1000}
                            local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                            if #subTasks > 0 then return subTasks end
                        else
                            bandit:faceLocationF(obj.x, obj.y)
                        end
                    end
                else
                    local task = {action="PlayVHS", time=600, obj=obj}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                    if #subTasks > 0 then return subTasks end
                end
            else
                local hasVHS = BWOAPermaInv.HasType(bandit, "Base.VHS_Retail")
                if hasVHS then
                    local task = {action="InsertVHS", time=600, obj=obj}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                    if #subTasks > 0 then return subTasks end
                else
                    local item, dist = BWOABaseObjects.FindClosestItemTypes({"Base.VHS_Retail"}, {x=bx, y=by}, {})
                    if item then
                        local task = {action="Collect", time=300, item=item}
                        local subTasks = BWOAPrograms.GoAndDo(bandit, item, task)
                        if #subTasks > 0 then return subTasks end
                    end
                end
            end
        end
    end
    return {}
end

BWOAPrograms.PlayPiano = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    local piano, pianoDist = BWOABaseObjects.FindClosestObject({"Piano"}, {x=bx, y=by})
    if piano then

        local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
        if reoutfitTask then return {reoutfitTask} end

        local pianoIso = BWOABaseObjects.GetIsoObject(piano)
        if pianoIso then
            local stoolPos = {
                ["recreational_01_8"] = {x = 1, y = 1, ox = 0.1, oy = 0.27, f="N"},
                ["recreational_01_9"] = {x = 0, y = 1, ox = 0.1, oy = 0.27, f="N"},
                ["recreational_01_28"] = {x = 1, y = -1, ox = 0.1, oy = 0.53, f="S"},
                ["recreational_01_29"] = {x = 0, y = -1, ox = 0.1, oy = 0.53, f="S"},
                ["recreational_01_12"] = {x = 1, y = 0, ox = 0.27, oy = 0.1, f="W"},
                ["recreational_01_13"] = {x = 1, y = 1, ox = 0.27, oy = 0.1, f="W"},
                ["recreational_01_30"] = {x = -1, y = 0, ox = 0.53, oy = 0.1, f="E"},
                ["recreational_01_31"] = {x = -1, y = 1, ox = 0.53, oy = 0.1, f="E"},
            }
            local spriteName = pianoIso:getSprite():getName()
            local stoolData = stoolPos[spriteName]
            local stool = {
                x = piano.x + stoolData.x,
                y = piano.y + stoolData.y,
                z = piano.z,
                cn = "Stool",
            }

            local stoolIso = BWOABaseObjects.GetIsoObject(stool)

            if stoolIso then
                local fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), stoolData.f)
                local task = {action="Generic", anim="SitPiano", looped=true, voice="InstrumentPiano1", fx = fx, fy = fy, ox = stool.x + stoolData.ox, oy = stool.y + stoolData.oy, time=200}
                local subTasks = BWOAPrograms.GoAndDo(bandit, stool, task, 0.7)
                if #subTasks > 0 then return subTasks end
            end
        end
    end
    return {}
end

BWOAPrograms.Research = function(bandit)
    local bx, by = bandit:getX(), bandit:getY()

    local computer, computerDist = BWOABaseObjects.FindClosestObject({"Computer"}, {x=bx, y=by})
    local microscope, microscopeDist = BWOABaseObjects.FindClosestObject({"Microscope"}, {x=bx, y=by})
    if computer and microscope then

        local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Lab")
        if reoutfitTask then return {reoutfitTask} end

        local gt = getGameTime()
        local minute = gt:getMinutes()

        if minute < 30 then
            local computerIso = BWOABaseObjects.GetIsoObject(computer)
            if computerIso then
                local chairPos = {
                    ["appliances_com_01_72"] = {x = 0, y = 1, ox = 0.50, oy = 0.23, f="N"},
                    ["appliances_com_01_73"] = {x = 1, y = 0, ox = 0.27, oy = 0.50, f="W"},
                    ["appliances_com_01_74"] = {x = 0, y = -1, ox = 0.50, oy = 0.77, f="S"},
                    ["appliances_com_01_75"] = {x = -1, y = 0, ox = 0.77, oy = 0.50, f="E"},

                }
                local spriteName = computerIso:getSprite():getName()
                local chairData = chairPos[spriteName]
                local chair = {
                    x = computer.x + chairData.x,
                    y = computer.y + chairData.y,
                    z = computer.z,
                    cn = "Chair",
                }

                local chairIso = BWOABaseObjects.GetIsoObject(chair)

                if chairIso then
                    local fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), chairData.f)
                    local task = {action="Research", anim="SitComputer", looped=true, voice="ComputerKeyboard", fx = fx, fy = fy, ox = chair.x + chairData.ox, oy = chair.y + chairData.oy, time=200}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, chair, task, 0.7)
                    if #subTasks > 0 then return subTasks end
                end
            end
        else
            local microscopeIso = BWOABaseObjects.GetIsoObject(microscope)
            if microscopeIso then
                local standingPos = {
                    ["location_community_medical_01_136"] = {x = 0, y = 1, ox = 0.50, oy = 0.10, f="N"},
                    ["location_community_medical_01_137"] = {x = 1, y = 0, ox = 0.10, oy = 0.50, f="W"},
                    ["location_community_medical_01_139"] = {x = 0, y = -1, ox = 0.50, oy = 0.90, f="S"},
                    ["location_community_medical_01_138"] = {x = -1, y = 0, ox = 0.90, oy = 0.50, f="E"},
                }

                local spriteName = microscopeIso:getSprite():getName()
                local standingData = standingPos[spriteName]
                local standing = {
                    x = microscope.x + standingData.x,
                    y = microscope.y + standingData.y,
                    z = microscope.z,
                }

                local fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), standingData.f)
                local task = {action="Research", anim="Microscope", looped=true, fx = fx, fy = fy, ox = standing.x + standingData.ox, oy = standing.y + standingData.oy, time=200}
                local subTasks = BWOAPrograms.GoAndDo(bandit, standing, task, 0.7)
                if #subTasks > 0 then return subTasks end
            end
        end
    end
    return {}
end
   
