ZombiePrograms = ZombiePrograms or {}

local function predicateAll(item)
    return true
end

ZombiePrograms.Assault = {}
ZombiePrograms.Assault.Stages = {}

ZombiePrograms.Assault.Init = function(bandit)
end

ZombiePrograms.Assault.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Assault.Main = function(bandit)
    local tasks = {}
    local cell = getCell()
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local baseId, base = BanditPlayerBase.GetBaseClosest(bandit)
    local endurance = 0.00
    local weapons = Bandit.GetWeapons(bandit)
    local health = bandit:getHealth()
    local healthMin = 0.7
    local walkType = "WalkAim"

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

    local config = {}
    config.mustSee = true
    config.hearDist = 5

    if Bandit.HasExpertise(bandit, Bandit.Expertise.Recon) then
        config.hearDist = 13
    elseif Bandit.HasExpertise(bandit, Bandit.Expertise.Tracker) then
        config.hearDist = 55
    end

    local target, enemy = BanditUtils.GetTarget(bandit, config)
    
    -- engage with target
    if target.x and target.y and target.z then
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

        -- local walkType = Bandit.GetCombatWalktype(bandit, enemy, target.dist)

        table.insert(tasks, BanditUtils.GetMoveTaskTarget(endurance, tx, ty, tz, target.id, target.player, walkType, target.dist))
        return {status=true, next="Main", tasks=tasks}
    end

    local task = {action="Time", anim="Shrug", time=200}
    table.insert(tasks, task)

    return {status=true, next="Main", tasks=tasks}
end

