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

    local itemFullType = item:getFullType()

    local itemConf = {}
    itemConf.fullType = itemFullType
    if item:isFood() and not item:isPoison() then
        itemConf.hc = -math.floor(item:getHungerChange() * 100)
    end
    table.insert(brain.permaInv, itemConf)

    sync(bandit, brain.permaInv)
end

BWOAPermaInv.Remove = function (bandit, itemFullType)
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

BWOAPermaInv.Get = function (bandit)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return {} end

    return brain.permaInv
end

BWOAPermaInv.GetFood = function (bandit)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return false end

    for _, itemConf in pairs(brain.permaInv) do
        if itemConf.hc then
            return itemConf
        end
    end
end

BWOAPermaInv.Has = function (bandit, itemFullType)
    local brain = BanditBrain.Get(bandit)
    if not brain or not brain.permaInv then return false end

    for _, itemConf in pairs(brain.permaInv) do
        if itemConf.fullType == itemFullType then
            return true
        end
    end

    return false
end


