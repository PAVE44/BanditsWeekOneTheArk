ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Emma = {}

ZombiePrograms.name = "Emma Robinson"
ZombiePrograms.Emma.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

local switchStage = function(bandit)
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    if bz > -4 or (bx < 9950 and by > 12621 and by < 12629) then
        if brain.program.stage ~= "Exterior" then
            brain.program.stage = "Exterior"
            return "Exterior"
        end
    elseif BWOABaseAPI.alarm then
        if brain.program.stage ~= "Defend" then
            brain.program.stage = "Defend"
            return "Defend"
        end
    else
        if brain.program.stage ~= "Main" then
            brain.program.stage = "Main"
            return "Main"
        end
    end
end

local switchOutfit = function(bandit, expectedBid)
    local brain = BanditBrain.Get(bandit)
    
    if expectedBid ~= brain.bid then
        local task = {
            action = "Transform", 
            anim = "BandageUpperBody",
            bid = expectedBid,
            cid = Bandit.clanMap.Emma,
            time = 150
        }
        return task
    end
end

ZombiePrograms.Emma.Main = function(bandit)

    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local expectedBid = Bandit.banditMap.Emma.Bunker
    local reoutfitTask = switchOutfit(bandit, expectedBid)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Main", tasks=tasks}
    end

    if brain.follow then
        local subTasks = BWOAPrograms.FollowMaster(bandit)
        if #subTasks > 0 then
            for _, subTask in pairs(subTasks) do
                table.insert(tasks, subTask)
            end
            return {status=true, next="Main", tasks=tasks}
        end
    else
    
        local schedule = {
            --[[
            shower = {
                hourMin = 16,
                hourMax = 16,
                minuteMin = 0,
                minuteMax = 40
            },
            sleep1 = {
                hourMin = 23,
                hourMax = 23,
                minuteMin = 20,
                minuteMax = 60
            },
            ]]
            sleep2 = {
                hourMin = 0,
                hourMax = 6,
                minuteMin = 0,
                minuteMax = 60
            }
        }

        if brain.bladder and brain.bladder > 20 then
            bandit:addLineChatElement("ACTIVITY: TOILET", 0, 0, 1)
            local obj, dist = BWOABaseObjects.FindClosestObject({"Toilet"}, {x=bx, y=by})
            if obj then
                local task = {action="UseToiletStanding", time=300}
                local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                if #subTasks > 0 then
                    for _, subTask in pairs(subTasks) do
                        table.insert(tasks, subTask)
                    end
                    return {status=true, next="Main", tasks=tasks}
                end
            end
        end

        local activity = BanditUtils.GetScheduledActivity(schedule)
        if activity then
            if activity == "shower" then
                bandit:addLineChatElement("ACTIVITY: SHOWER", 0, 0, 1)
                local obj, dist = BWOABaseObjects.FindClosestObject({"Shower"}, {x=bx, y=by})
                if obj then
                    local task = {action="UseToiletStanding", time=300}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                    if #subTasks > 0 then
                        for _, subTask in pairs(subTasks) do
                            table.insert(tasks, subTask)
                        end
                        return {status=true, next="Main", tasks=tasks}
                    end
                end
            elseif activity == "sleep1" or activity == "sleep2" then
                bandit:addLineChatElement("ACTIVITY: SLEEP", 0, 0, 1)
                local obj, dist = BWOABaseObjects.FindClosestObject({"Beds", "Bed"}, {x=bx, y=by})
                if obj then
                    local bed = BWOABaseObjects.GetIsoObject(obj)
                    local facing = bed:getSprite():getProperties():Val("Facing")
                    -- local eoffset = bed:getSprite():getProperties():Val("Eoffset")
                    local task = {action="SleepLong", x=obj.x, y=obj.y, z=obj.z, facing=facing, time=3000}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                    if #subTasks > 0 then
                        for _, subTask in pairs(subTasks) do
                            table.insert(tasks, subTask)
                        end
                        return {status=true, next="Main", tasks=tasks}
                    end
                end
            end
        end

        local config = {}
        config.mustSee = false
        config.hearDist = 50

        if not BWOAMissions.IsAccomplished(1) then
            local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit, config)

            if closestPlayer.x and closestPlayer.y and closestPlayer.z and closestPlayer.dist > 4 then
                Bandit.Say(bandit, "WAITTALK")
                BWOADialogues.Reveal(ZombiePrograms.name, "4")
                table.insert(tasks, BanditUtils.GetMoveTask(0, closestPlayer.x, closestPlayer.y, closestPlayer.z, "Run", closestPlayer.dist, false))
                return {status=true, next="Main", tasks=tasks}
            end
        end
    end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Defend = function(bandit)
    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local expectedBid = Bandit.banditMap.Emma.Defend
    local reoutfitTask = switchOutfit(bandit, expectedBid)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Defend", tasks=tasks}
    end

    if brain.follow then
        local subTasks = BWOAPrograms.FollowMaster(bandit)
        if #subTasks > 0 then
            for _, subTask in pairs(subTasks) do
                table.insert(tasks, subTask)
            end
            return {status=true, next="Defend", tasks=tasks}
        end
    end

    local config = {}
    config.mustSee = false
    config.hearDist = 70
    config.levelDiff = 0

    local target, enemy = BanditUtils.GetTarget(bandit, config)
    
    -- engage with target
    if target.x and target.y and target.z and target.z == -4 then
        local targetSquare = cell:getGridSquare(target.x, target.y, target.z)
        if targetSquare then
            Bandit.SayLocation(bandit, targetSquare)
        end

        local tx, ty, tz = target.x, target.y, target.z
    
        if enemy then
            if target.fx and target.fy and (enemy:isRunning()  or enemy:isSprinting()) then
                tx, ty = target.fx, target.fy
            end
        end

        local walkType = "WalkAim"

        table.insert(tasks, BanditUtils.GetMoveTask(endurance, tx, ty, tz, walkType, target.dist))
        return {status=true, next="Main", tasks=tasks}
    end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Defend", tasks=tasks}
    end

    return {status=true, next="Defend", tasks=tasks}
end

ZombiePrograms.Emma.Exterior = function(bandit)
    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local expectedBid = Bandit.banditMap.Emma.Hazmat
    local reoutfitTask = switchOutfit(bandit, expectedBid)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Exterior", tasks=tasks}
    end

    local subTasks = BWOAPrograms.FollowMaster(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Exterior", tasks=tasks}
    end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Exterior", tasks=tasks}
    end

    return {status=true, next="Exterior", tasks=tasks}
end

ZombiePrograms.Emma.Leisure = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.WaterHunt = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.FoodHunt = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Toilet = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end


