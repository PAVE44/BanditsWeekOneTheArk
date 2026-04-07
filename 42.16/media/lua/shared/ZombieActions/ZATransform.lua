ZombieActions = ZombieActions or {}

ZombieActions.Transform = {}
ZombieActions.Transform.onStart = function(zombie, task)
    return true
end

ZombieActions.Transform.onWorking = function(zombie, task)

    if zombie:getBumpType() ~= task.anim then return true end

    return false

end

ZombieActions.Transform.onComplete = function(zombie, task)
    if task.cid and task.bid then
        local brain = BanditBrain.Get(zombie)
        local data = BanditCustom.GetFromClan(task.cid)[task.bid]
        local general = data.general
        local weapons = data.weapons

        brain.bid = task.bid
        brain.hairType = general.hairType or 1
        brain.hairColor = general.hairColor or 1
        brain.beardType = general.beardType or 1
       
        brain.weapons = {}
        brain.weapons.melee = "Base.BareHands"
        brain.weapons.primary = {["bulletsLeft"] = 0, ["magCount"] = 0}
        brain.weapons.secondary = {["bulletsLeft"] = 0, ["magCount"] = 0}

        if data.weapons then
            if data.weapons.melee then
                brain.weapons.melee = BanditCompatibility.GetLegacyItem(data.weapons.melee)
            end
            for _, slot in pairs({"primary", "secondary"}) do
                brain.weapons[slot].bulletsLeft = 0
                brain.weapons[slot].magCount = 0
                if data.weapons[slot] and data.ammo[slot] then
                    brain.weapons[slot] = BanditWeapons.Make(data.weapons[slot], data.ammo[slot])
                end
            end
        end

        brain.clothing = data.clothing or {}
        brain.tint = data.tint or {}
        brain.bag = data.bag

        zombie:getHumanVisual():setSkinTextureName("x") -- sic!
        Bandit.ApplyVisuals(zombie, brain)

    end
    return true
end