BWOAPrograms = BWOAPrograms or {}

BWOAPrograms.FollowMaster = function(bandit)
    local tasks = {}
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local master = BanditPlayer.GetMasterPlayer(bandit)
    local mx, my, mz = master:getX(), master:getY(), master:getZ()

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
            table.insert(tasks, BanditUtils.GetMoveTask(endurance, closestEnemy.x, closestEnemy.y, closestEnemy.z, walkType, closestEnemy.dist))
            return tasks
        end
    end

    if dist > 2 or math.abs(mz - bz) >= 1 then
        table.insert(tasks, BanditUtils.GetMoveTask(endurance, mx, my, mz, walkType, dist, false))
        return tasks
    end

    return tasks
end

BWOAPrograms.IdleEmma = function(bandit)
    local tasks = {}
    local action = ZombRand(100)

    if action == 0 then
        local task = {action="Time", anim="ShiftWeight", time=200}
        table.insert(tasks, task)
    elseif action == 1 then
        local task = {action="Time", anim="Cough", time=200}
        table.insert(tasks, task)
    elseif action == 2 then
        local task = {action="Time", anim="ChewNails", time=200}
        table.insert(tasks, task)
    elseif action == 3 then
        local task = {action="Time", anim="PullAtCollar", time=200}
        table.insert(tasks, task)
    elseif action == 4 then
        local task = {action="Time", anim="Sneeze", time=200}
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

BWOAPrograms.GoAndDo = function(bandit, point, task)
    local tasks = {}

    local square = getCell():getGridSquare(point.x, point.y, point.z)
    if not square then return tasks end

    local asquare = BanditUtils.GetAccessSquare(square, bandit)
    if not asquare then return tasks end

    local dist = BanditUtils.DistTo(bandit:getX(), bandit:getY(), asquare:getX() + 0.5, asquare:getY() + 0.5)
    if dist > 0.70 then
        table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
        return tasks
    else
        table.insert(tasks, task)
        return tasks
    end
end