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
    md.BWOA.accomplishMissionId = 101
    md.BWOA.revealMissionId = 102
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
