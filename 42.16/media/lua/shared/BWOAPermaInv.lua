BWOAPermaInv = BWOAPermaInv or {}

local function sync(bandit, permaInv)
    local syncData = {}
    syncData.permaInv = permaInv
    Bandit.ForceSyncPart(bandit, syncData)
end

BWOAPermaInv.Add = function (bandit, item)
    local brain = BanditBrain.Get(bandit)
    if not brain then return end

    brain.permaInv = brain.permaInv or {}

    local itemConf = {}
    itemConf.fullType = item:getFullType()
    itemConf.class = BWOAItems.GetItemClass(item)

    if itemConf.class == "food" then
        itemConf.hc = math.floor(item:getHungerChange() * 100)
    elseif itemConf.class == "drink" then
        itemConf.tc = 100
    elseif itemConf.class == "media" then
        itemConf.mid = item:getMediaData():getId()
    end

    table.insert(brain.permaInv, itemConf)

    sync(bandit, brain.permaInv)
end

BWOAPermaInv.RemoveOneOfType = function (bandit, itemFullType)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return end

    for i, itemConf in pairs(brain.permaInv) do
        if itemConf.fullType == itemFullType then
            table.remove(brain.permaInv, i)
            sync(bandit, brain.permaInv)
            return
        end
    end
end

BWOAPermaInv.GetAll = function (bandit)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return {} end

    return brain.permaInv
end

BWOAPermaInv.GetType = function (bandit, itemFullType)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return nil end

    for i, itemConf in pairs(brain.permaInv) do
        if itemConf.fullType == itemFullType then
            return itemConf
        end
    end

    return nil
end

BWOAPermaInv.HasType = function (bandit, itemFullType)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return false end

    for _, itemConf in pairs(brain.permaInv) do
        if itemConf.fullType == itemFullType then
            return true
        end
    end

    return false
end

BWOAPermaInv.GetClass = function (bandit, class)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return false end

    for _, itemConf in pairs(brain.permaInv) do
        local item = BanditCompatibility.InstanceItem(itemConf.fullType)
        if item then
            local itemClass = BWOAItems.GetItemClass(item)
            if itemClass == class then
                return itemConf
            end
        end
    end
end

BWOAPermaInv.HasClass = function (bandit, class)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return false end

    for _, itemConf in pairs(brain.permaInv) do
        local item = BanditCompatibility.InstanceItem(itemConf.fullType)
        if item then
            local itemClass = BWOAItems.GetItemClass(item)
            if itemClass == class then
                return true
            end
        end
    end

    return false
end


