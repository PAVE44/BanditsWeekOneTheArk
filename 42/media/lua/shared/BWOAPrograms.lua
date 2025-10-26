BWOAPrograms = BWOAPrograms or {}

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