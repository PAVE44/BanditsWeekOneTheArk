require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.FallasChurch = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.FallasChurch:placeObjects()
    local x, y, z = self.x, self.y, self.z
    local basement = BWOABasements.Generic:new(7383, 8347, 0, "wicked")
    basement:build()
end

function BWOAScenes.FallasChurch:placeItems()
    local x, y, z = self.x, self.y, self.z

    local note = BanditCompatibility.InstanceItem("Bandits.Note")
    note:setCanBeWrite(false)
    note:setName("Church gathering note")
    local md = note:getModData()
    md.printContent = "church_gathering_note"
    md.BWOA = {}
    md.BWOA.accomplishMissionId = 100
    md.BWOA.revealMissionId = 101
    BWOAPrepareTools.AddWorldItemSpecial(7384, 8349, -1, note, {x=0.6, y=0.6, z=0.35})

end

function BWOAScenes.FallasChurch:placeCorpses()
    local x, y, z = self.x, self.y, self.z
    
   
end

function BWOAScenes.FallasChurch:placeVehicles()
    
end

function BWOAScenes.FallasChurch:populate()

end
