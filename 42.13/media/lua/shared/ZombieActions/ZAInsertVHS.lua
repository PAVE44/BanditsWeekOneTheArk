ZombieActions = ZombieActions or {}

local function predicateAll(item)
    -- item:getType()
	return true
end

ZombieActions.InsertVHS = {}
ZombieActions.InsertVHS.onStart = function(zombie, task)
    task.anim = "Give"
    zombie:setBumpType(task.anim)

    return true
end

ZombieActions.InsertVHS.onWorking = function(zombie, task)
    zombie:faceLocationF(task.obj.x, task.obj.y)
    if zombie:getBumpType() ~= task.anim then return true end
    return false
end

ZombieActions.InsertVHS.onComplete = function(zombie, task)
    local itemConf = BWOAPermaInv.GetType(zombie, "Base.VHS_Retail")
    if not itemConf then return true end

    local tv = BWOABaseObjects.GetIsoObject(task.obj)
    if not tv then return true end

    local dd = tv:getDeviceData()
    if not dd then return true end

    local md = dd:getMediaData()
    if md then return true end

    local mediaRecorder = ZomboidRadio.getInstance():getRecordedMedia()
    local item = BanditCompatibility.InstanceItem("Base.VHS_Retail")
    local mediaData = mediaRecorder:getMediaData(itemConf.mid)
    item:setRecordedMediaData(mediaData)
    dd:addMediaItem(item)

    BWOAPermaInv.Remove(zombie, "Base.VHS_Retail")

    return true
end

