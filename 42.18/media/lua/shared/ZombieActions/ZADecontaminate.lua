ZombieActions = ZombieActions or {}

ZombieActions.Decontaminate = {}
ZombieActions.Decontaminate.onStart = function(zombie, task)
    task.anim = "NBCSpray"
    zombie:setBumpType(task.anim)

    zombie:playSound("AmbientMist")

    local mx, my = zombie:getX(), zombie:getY()
    local mz = zombie:getZ()
    local tx, ty = task.fx, task.fy
    local dx = tx - mx
    local dy = ty - my
    local length = math.sqrt(dx * dx + dy * dy)
    -- avoid division by zero
    if length > 0 then
        dx = dx / length
        dy = dy / length
    end

    local step = 0.9
    local instances = 5

    if length < step * instances then
        step = length / instances
    end

    local effectName = "mist"

    for i = 1, instances do
        mx = mx + dx * step
        my = my + dy * step
        
        for x = -1, 1 do
            for y = -1, 1 do
                local effect = {
                    x = mx + x,
                    y = my + y,
                    z = mz,
                    size = 160 + (i*30),
                    name = effectName,
                    frameCnt = 40,
                    frameRnd = true,
                    repCnt = 4,
                    fluid = "NBCSolution",
                }
                BWOAEventControl.Add("Effect", effect, 100 + (i * 6))

                print ("Adding decontamination effect at " .. math.floor(mx) .. ", " .. math.floor(my) .. ", " .. math.floor(mz))
            end
        end
        

    end

    return true
end

ZombieActions.Decontaminate.onWorking = function(zombie, task)
    zombie:faceLocationF(task.fx, task.fy)
    local bumpType = zombie:getBumpType()
    if bumpType ~= task.anim then
        zombie:setBumpType(task.anim)
    end
end

ZombieActions.Decontaminate.onComplete = function(zombie, task)
    return true
end