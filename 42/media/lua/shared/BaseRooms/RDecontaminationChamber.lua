BWOARooms = BWOARooms or {}

BWOARooms.DecontaminationChamber = {}

BWOARooms.DecontaminationChamber.cooldown = 0

BWOARooms.DecontaminationChamber.Init = function ()
    BWOARooms.DecontaminationChamber.name = "DECONTAMINATION_CHAMBER"
    BWOARooms.DecontaminationChamber.x1 = 9944
    BWOARooms.DecontaminationChamber.x2 = 9949
    BWOARooms.DecontaminationChamber.y1 = 12622
    BWOARooms.DecontaminationChamber.y2 = 12628
    BWOARooms.DecontaminationChamber.z = -4
    BWOARooms.DecontaminationChamber.ambience = ""

    BWOARooms.DecontaminationChamber.vents = {}

    BWOARooms.DecontaminationChamber.els = {}
end

BWOARooms.DecontaminationChamber.Build = function ()
    BWOARooms.DecontaminationChamber.Init()

    BWOAPrepareTools.DarkenLight(9944, 12627, -4)

    BWOABuildTools.ELS(BWOARooms.DecontaminationChamber.els)

    BWOABuildTools.LampOvalW(9948, 12625, -4)
    BWOABuildTools.LampOvalE(9945, 12625, -4)
end

BWOARooms.DecontaminationChamber.SetEmitters = function ()
    BWOARooms.DecontaminationChamber.Init()
end

BWOARooms.DecontaminationChamber.SetFlickers = function ()
    BWOARooms.DecontaminationChamber.Init()
end

BWOARooms.DecontaminationChamber.Prepare = function ()
    BWOARooms.DecontaminationChamber.Init()
end

BWOARooms.DecontaminationChamber.Logic = function ()
    BWOARooms.DecontaminationChamber.Init()

    if BWOARooms.DecontaminationChamber.cooldown > 0 then
        BWOARooms.DecontaminationChamber.cooldown = BWOARooms.DecontaminationChamber.cooldown - 1
        return
    end

    local banditList = BanditZombie.CacheLightB
    local roomNames = {}
    local present = false
    for _, bandit in pairs(banditList) do
        if bandit.brain and not bandit.brain.hostile then
            if bandit.x >= BWOARooms.DecontaminationChamber.x1 and bandit.x < BWOARooms.DecontaminationChamber.x2
                    and bandit.y >= BWOARooms.DecontaminationChamber.y1 and bandit.y < BWOARooms.DecontaminationChamber.y2
                    and bandit.z == BWOARooms.DecontaminationChamber.z then
                present = true
            end
        end
    end

    local player = getSpecificPlayer(0)
    if player then
        local px, py, pz = player:getX(), player:getY(), player:getZ()
        if px >= BWOARooms.DecontaminationChamber.x1 and px < BWOARooms.DecontaminationChamber.x2
                and py >= BWOARooms.DecontaminationChamber.y1 and py < BWOARooms.DecontaminationChamber.y2
                and pz == BWOARooms.DecontaminationChamber.z then
            present = true
        end
    end

    if present then
        BWOARooms.DecontaminationChamber.cooldown = 10
        local params = {
            x1 = BWOARooms.DecontaminationChamber.x1,
            x2 = BWOARooms.DecontaminationChamber.x2,
            y1 = BWOARooms.DecontaminationChamber.y1,
            y2 = BWOARooms.DecontaminationChamber.y2,
            z = BWOARooms.DecontaminationChamber.z,
            lamps = {
                [1] = {x = 9948, y = 12625, z = -4},
                [2] = {x = 9945, y = 12625, z = -4}
            }
        }
        BWOASequence.Decontamination(params)
    end
end