ZombiePrograms = ZombiePrograms or {}

local function predicateAll(item)
	return true
end

local function predicateCooked(item)
    if item:isFood() then
        return item:isCooked()
    end
	return true
end

local function predicateFood(item)
    if item:isFood() then
        return true
    end
    return false
end


ZombiePrograms.Emma = {}

ZombiePrograms.name = "Emma_Robinson"
ZombiePrograms.Emma.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.mainSchedule = {
    --[[
    shower = {
        hourMin = 16,
        hourMax = 16,
        minuteMin = 0,
        minuteMax = 40
    },
    sleep1 = {
        hourMin = 23,
        hourMax = 24,
        minuteMin = 20,
        minuteMax = 60
    },    ]]
    {
        activity = "sleep",
        hourMin = 0,
        hourMax = 6,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "jog",
        hourMin = 6,
        hourMax = 7,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "cook",
        activityMode = "breakfast",
        hourMin = 7,
        hourMax = 8,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "lab",
        hourMin = 8,
        hourMax = 11,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "radio",
        hourMin = 11,
        hourMax = 12,
        minuteMin = 0,
        minuteMax = 60,
        waMin = 0.5,
        waMax = 32
    },
    {
        activity = "cook",
        activityMode = "lunch",
        hourMin = 12,
        hourMax = 14,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "readbook",
        hourMin = 14,
        hourMax = 15,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "lab",
        hourMin = 15,
        hourMax = 18,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "cook",
        activityMode = "dinner",
        hourMin = 18,
        hourMax = 20,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "playpiano",
        hourMin = 20,
        hourMax = 21,
        minuteMin = 0,
        minuteMax = 60
    },
    {
        activity = "watchtv",
        hourMin = 21,
        hourMax = 23,
        minuteMin = 0,
        minuteMax = 60
    },
}

local switchStage = function(bandit)
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    if BWOABaseAPI.alarm then
        if bz >= -2 then
            if brain.program.stage ~= "Exterior" then
                brain.program.stage = "Exterior"
                return "Exterior"
            end
        else
            if brain.program.stage ~= "Defend" then
                brain.program.stage = "Defend"
                return "Defend"
            end
        end
    elseif bz > -4 or (bx < 9950 and by > 12621 and by < 12629) then
        if brain.program.stage ~= "Exterior" then
            brain.program.stage = "Exterior"
            return "Exterior"
        end
    elseif brain.sadness and brain.sadness > 50 then
        if brain.program.stage ~= "Cry" then
            brain.program.stage = "Cry"
            return "Cry"
        end
    else
        if brain.program.stage ~= "Main" then
            brain.program.stage = "Main"
            return "Main"
        end
    end
end

ZombiePrograms.Emma.Main = function(bandit)

    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local gmd = GetBWOAModData()
    local player = getSpecificPlayer(0)
    local px, py, pz = player:getX(), player:getY(), player:getZ()

    bandit:setVariable("RunSpeed", 0.91)
    
    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    -- say hi if haven't seen the player for a while
    local wa = getGameTime():getWorldAgeHours() - 10
    if not brain.timeSinceSeenPlayer then
        brain.timeSinceSeenPlayer = wa
    end
    if bandit:CanSee(player) then
        if brain.timeSinceSeenPlayer < wa - 8 then
            local tab = {}
            tab.id = brain.id
            tab.anim = "WaveHi"
            tab.txt = "Hi!"
            tab.sound = "VoiceFemaleShoutHey"
            BWOAEventControl.Add("SayBandit", tab, 1)
        end
        brain.timeSinceSeenPlayer = wa
    end

    -- #1 player healing
    local subTasks = BWOAPrograms.HealPlayer(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    -- #2 special modes
    if brain.mode and brain.mode == "follow" then
        local subTasks = BWOAPrograms.FollowMaster(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    elseif brain.mode and brain.mode == "taggame" then
        local subTasks = BWOAPrograms.TagGame(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    end

    -- #3 chase player after coma
    if not BWOAMissions.IsAccomplished(1) then
        local subTasks = BWOAPrograms.Chase(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    end

    -- #4 basic needs
    if brain.bladder and brain.bladder > 30 then
        -- bandit:addLineChatElement("ACTIVITY: TOILET", 1, 0, 1)
        local subTasks = BWOAPrograms.Toilet(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    elseif brain.hunger and brain.hunger >= 50 then
        -- bandit:addLineChatElement("ACTIVITY: FOOD HUNT", 1, 0, 1)
        local subTasks = BWOAPrograms.Eat(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    end

    -- handle emma teleports here
    
    if brain.wantToLeave then
        local dist = BanditUtils.DistTo(px, py, bx, by)
        if dist > 50 then
            brain.wantToLeave = false
            brain.program.stage = "Prison"
            Bandit.ForceSyncPart(bandit, brain)
            BWOADialogues.Reveal("Emma_Robinson", "3000.1")
            BWOAPlaceEvents.Reveal("EmmaGoodbye")
            BWOANPC.Teleport("Emma", 10116, 11185, -2)

        end
    end

    -- #5 cleaning radiation
    local subTasks = BWOAPrograms.Decontaminate(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    -- #6 return cooked food
    local subTasks = BWOAPrograms.ReturnFood(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    -- #7 oven handling (must be outside of cooking timeframe to prevent leaving oven on after cooking is over)
    local subTasks = BWOAPrograms.OvenHandling(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    -- #8 jukebox dancing
    local subTasks = BWOAPrograms.JukeboxDancing(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    -- #9 timed activities
    local schedule = ZombiePrograms.Emma.mainSchedule
    local activity, activityMode = BanditUtils.GetScheduledActivity(schedule)
    activity, activityMode = "cook", "dinner" -- test
    if activity then
        if activity == "cook" then
            -- bandit:addLineChatElement("ACTIVITY: COOK " .. activityMode, 1, 0, 1)
            local subTasks = BWOAPrograms.Cook(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        elseif activity == "sleep" then
            bandit:addLineChatElement("ACTIVITY: SLEEP", 1, 0, 1)
            local subTasks = BWOAPrograms.Sleep(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        elseif activity == "jog" then
            bandit:addLineChatElement("ACTIVITY: JOG", 1, 0, 1)
            local subTasks = BWOAPrograms.Jog(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        elseif activity == "radio" then
            -- bandit:addLineChatElement("ACTIVITY: RADIO", 1, 0, 1)
            local subTasks = BWOAPrograms.RadioCall(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        elseif activity == "readbook" then
            bandit:addLineChatElement("ACTIVITY: READ BOOK", 1, 0, 1)
            local subTasks = BWOAPrograms.ReadBook(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        elseif activity == "watchtv" then
            bandit:addLineChatElement("ACTIVITY: WATCH TV", 1, 0, 1)
            local subTasks = BWOAPrograms.WatchTV(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        elseif activity == "playpiano" then
            -- bandit:addLineChatElement("ACTIVITY: PLAY PIANO", 0, 0, 1)
            local subTasks = BWOAPrograms.PlayPiano(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        elseif gmd.research and gmd.research < 100 and BWOABaseControl.power and activity == "lab" then
            -- bandit:addLineChatElement("ACTIVITY: LAB WORK", 1, 0, 1)
            local subTasks = BWOAPrograms.Research(bandit)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        end
    end

    local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Bunker")
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Main", tasks=tasks}
    end

    -- #10 cleaning blood
    local subTasks = BWOAPrograms.CleanBlood(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    -- #11 idleing
    local idleTasks = BWOAPrograms.IdleEmma(bandit)
    if #idleTasks > 0 then return {status=true, next="Main", tasks=idleTasks} end

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Defend = function(bandit)
    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local weapons = Bandit.GetWeapons(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local player = getSpecificPlayer(0)
    local px, py, pz = player:getX(), player:getY(), player:getZ()

    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Defend")
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Defend", tasks=tasks}
    end

    local primary = bandit:getPrimaryHandItem()
    if not primary then
        local itemName
        if weapons.primary and weapons.primary.name then
            itemName = weapons.primary.name
        elseif weapons.secondary and weapons.secondary.name then
            itemName = weapons.secondary.name
        elseif weapons.melee then
            itemName = weapons.melee
        end
        if itemName then
            local new = BanditCompatibility.InstanceItem(itemName)
            if new then
                local sound = new:getEquipSound()
                local task = {action="Equip", sound=sound, itemPrimary=itemName}
                table.insert(tasks, task)
                return {status=true, next="Main", tasks=tasks}
            end
        end
    end

    if brain.mode == "follow" then
        local subTasks = BWOAPrograms.FollowMaster(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
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

            local playerDist = BanditUtils.DistTo(px, py, tx, ty)

            if pz == bz and target.dist > playerDist and target.dist > 4 then
                local walkType = "WalkAim"
                table.insert(tasks, BanditUtils.GetMoveTaskTarget(endurance, tx, ty, tz, target.id, target.player, walkType, target.dist))
                return {status=true, next="Main", tasks=tasks}
            else
                local task = {action="FaceLocation", anim="AimRifle", x = tx, y = ty, time=50}
                table.insert(tasks, task)

                return {status=true, next="Main", tasks=tasks}
            end
        end
    end

    local subTasks = BWOAPrograms.HealPlayer(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

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

    local expectedBid = "Postrad"
    if BWOAClimate.radiation > 0 then
        expectedBid = "Hazmat"
    end
    local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, expectedBid)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Exterior", tasks=tasks}
    end

    local subTasks = BWOAPrograms.HealPlayer(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    local subTasks = BWOAPrograms.FollowMaster(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    return {status=true, next="Exterior", tasks=tasks}
end

ZombiePrograms.Emma.Cry = function(bandit)
    local tasks = {}
    
    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local task = {action="Cry", time=200}
    table.insert(tasks, task)

    return {status=true, next="Cry", tasks=tasks}
end

ZombiePrograms.Emma.Prison = function(bandit)
    local tasks = {}
    
    local reoutfitTask = BWOAPrograms.SwitchOutfit(bandit, "Prison")
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Prison", tasks=tasks}
    end

    local task = {action="Cry", time=200}
    table.insert(tasks, task)

    return {status=true, next="Prison", tasks=tasks}
end



