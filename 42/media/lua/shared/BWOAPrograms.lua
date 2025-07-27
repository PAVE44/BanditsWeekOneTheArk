BWOAPrograms = BWOAPrograms or {}

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