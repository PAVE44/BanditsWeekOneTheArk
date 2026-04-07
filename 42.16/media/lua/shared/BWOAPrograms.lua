BWOAPrograms = BWOAPrograms or {}

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
    local action = ZombRand(100)

    if action == 0 then
        local task = {action="Time", anim="ShiftWeight", time=200}
        table.insert(tasks, task)
    elseif action == 1 then
        local task = {action="Time", anim="Cough", sound="VoiceFemaleMuffledCough", time=200}
        table.insert(tasks, task)
    elseif action == 2 then
        local task = {action="Time", anim="ChewNails", time=200}
        table.insert(tasks, task)
    elseif action == 3 then
        local task = {action="Time", anim="PullAtCollar", time=200}
        table.insert(tasks, task)
    elseif action == 4 then
        local task = {action="Time", anim="Sneeze", sound="VoiceFemaleSneezeLight", time=200}
        table.insert(tasks, task)
    elseif action == 5 then
        local task = {action="Time", anim="WipeBrow", time=200}
        table.insert(tasks, task)
    elseif action == 6 then
        local task = {action="Time", anim="WipeHead", time=200}
        table.insert(tasks, task)
    elseif action == 7 then
        local task = {action="Time", anim="ChewNails", time=200}
        table.insert(tasks, task)
    else
        local task = {action="Time", anim="IdleFemale", time=200}
        table.insert(tasks, task)
    end
    return tasks
end

BWOAPrograms.GoAndDo = function(bandit, point, task, precision)
    local tasks = {}

    if not precision then precision = 0.7 end

    local square = getCell():getGridSquare(point.x, point.y, point.z)
    if not square then return tasks end

    local asquare = square
    if not square:isNotBlocked(false) then
        asquare = BanditUtils.GetAccessSquare(square, bandit)
    end
    if not asquare then return tasks end

    local dist = BanditUtils.DistTo(bandit:getX(), bandit:getY(), asquare:getX() + 0.5, asquare:getY() + 0.5)
    if dist > precision then
        table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
        return tasks
    else
        table.insert(tasks, task)
        return tasks
    end
end

BWOAPrograms.Jog = function(bandit)
    local tasks = {}
    
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