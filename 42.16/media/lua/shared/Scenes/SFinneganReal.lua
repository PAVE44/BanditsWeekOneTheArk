require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.FinneganReal = BWOAScenes.Abstract:derive("BWOAScenes.FinneganReal")

function BWOAScenes.FinneganReal:placeObjects()
end

function BWOAScenes.FinneganReal:placeItems()
    
    local documents = {
        {
            name = getText("IGUI_Artifact_EmergencyMedicalReport"), 
            content = "emergency_medical_report",
            x = 13566,
            y = 1714,
            z = 3,
        },
        {
            name = getText("IGUI_Artifact_UnregisteredIntervention"), 
            content = "unregistered_intervention",
            x = 13567,
            y = 1717,
            z = 3,
        },
        {
            name = getText("IGUI_Artifact_CCTermination"), 
            content = "cc_termination",
            x = 13568,
            y = 1715,
            z = 3,
        },
        {
            name = getText("IGUI_Artifact_CCAddendum4"), 
            content = "cc_addendum4",
            x = 13570,
            y = 1716,
            z = 3,
        },
        {
            name = getText("IGUI_Artifact_CCDemands"), 
            content = "cc_demands",
            x = 13571,
            y = 1712,
            z = 3,
        },
        {
            name = getText("IGUI_Artifact_FinneganStaffListing"), 
            content = "finnegan_staff_listing",
            x = 13565,
            y = 1717,
            z = 3,
            rdid = "2001.9",
            amid = 120,
        },
    }
    
    for i, doc in ipairs(documents) do
        local note = BanditCompatibility.InstanceItem("Bandits.Note")
        note:setCanBeWrite(false)
        note:setName(doc.name)
        local md = note:getModData()
        md.printContent = doc.content
        md.BWOA = {}
        md.BWOA.onTaken = {}
        if doc.rdid then
            md.BWOA.onTaken.revealDialogueId = doc.rdid
            md.BWOA.onTaken.revealDialoguePerson = "Emma_Robinson"
        end
        if doc.amid then
            md.BWOA.onTaken.accomplishMissionId = doc.amid
        end

        BWOAPrepareTools.AddWorldItemSpecial(doc.x, doc.y, doc.z, note, {x=ZombRandFloat(0.2, 0.8), y=ZombRandFloat(0.2, 0.8), z=0})
    end
end

function BWOAScenes.FinneganReal:placeCorpses()
end

function BWOAScenes.FinneganReal:placeVehicles()
end

function BWOAScenes.FinneganReal:populate()
    BanditUtils.ClearZombies(13570, 13630, 1680, 1720)
end
