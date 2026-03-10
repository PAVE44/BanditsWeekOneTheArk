require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.EkronChurch = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.EkronChurch:placeObjects()
    local x, y, z = self.x, self.y, self.z

    BWOABuildTools.Generic(440, 9925, -2, "location_community_church_small_01_23") -- cross

    BWOABuildTools.LampBattery(441, 9925, -2, "lighting_indoor_01_10")
end

function BWOAScenes.EkronChurch:placeItems()
    local x, y, z = self.x, self.y, self.z

    -- entrance
    BWOAPrepareTools.AddWorldItem(447, 9939, -1, "Base.BucketConcreteFull", {x=0.59, y=0.10, z=0.00, rx=0, ry=0, rz=307})
    BWOAPrepareTools.AddWorldItem(447, 9939, -1, "Base.ClayBrick", {x=0.70, y=0.72, z=0.00, rx=0, ry=0, rz=115})
    BWOAPrepareTools.AddWorldItem(447, 9939, -1, "Base.ClayBrick", {x=0.63, y=0.64, z=0.00, rx=0, ry=0, rz=129})
    BWOAPrepareTools.AddWorldItem(447, 9939, -1, "Base.ClayBrick", {x=0.18, y=0.12, z=0.00, rx=0, ry=0, rz=171})
    BWOAPrepareTools.AddWorldItem(447, 9939, -1, "Base.ClayBrick", {x=0.42, y=0.14, z=0.00, rx=0, ry=0, rz=89})
    BWOAPrepareTools.AddWorldItem(447, 9939, -1, "Base.ClayBrick", {x=0.36, y=0.28, z=0.00, rx=0, ry=0, rz=340})
    BWOAPrepareTools.AddWorldItem(447, 9939, -1, "Base.MasonsTrowel", {x=0.46, y=0.55, z=0.00, rx=0, ry=0, rz=308})

    -- interior
    BWOAPrepareTools.AddWorldItem(439, 9925, -2, "Base.Book_Religion", {x=0.41, y=0.40, z=0.33, rx=0, ry=0, rz=75})
    BWOAPrepareTools.AddWorldItem(439, 9925, -2, "Base.Book_Religion", {x=0.48, y=0.83, z=0.37, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(439, 9925, -2, "Base.Book_Religion", {x=0.48, y=0.48, z=0.38, rx=0, ry=0, rz=81})
    BWOAPrepareTools.AddWorldItem(439, 9925, -2, "Base.Book_Religion", {x=0.44, y=0.44, z=0.40, rx=0, ry=0, rz=75})
    BWOAPrepareTools.AddWorldItem(439, 9925, -2, "Base.Book_Religion", {x=0.45, y=0.80, z=0.33, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(439, 9925, -2, "Base.Book_Religion", {x=0.45, y=0.77, z=0.33, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(439, 9925, -2, "Base.Book_Religion", {x=0.74, y=0.29, z=0.33, rx=0, ry=0, rz=300})

    local note = BanditCompatibility.InstanceItem("Bandits.Note")
    note:setCanBeWrite(false)
    note:setName("Sacred Incense Instructions")
    local md = note:getModData()
    md.printContent = "sacred_incense"
    md.BWOA = {}
    md.BWOA.onTaken = {}
    md.BWOA.onTaken.accomplishMissionId = 101
    md.BWOA.onTaken.revealMissionId = 102
    BWOAPrepareTools.AddWorldItemSpecial(439, 9925, -2, note, {x=0.80, y=0.66, z=0.33})

end

function BWOAScenes.EkronChurch:placeCorpses()
    local x, y, z = self.x, self.y, self.z
    
   
end

function BWOAScenes.EkronChurch:placeVehicles()
    
end

function BWOAScenes.EkronChurch:populate()
    local player = getSpecificPlayer(0)

    BanditUtils.ClearZombies(437, 9925, 446, 9941)

    local params1 = {
        cid = Bandit.clanMap.James,
        x = 439,
        y = 9926,
        z = -2,
        program = "James",
        size = 1,
    }
    sendClientCommand(player, 'Spawner', 'Clan', params1)

end
