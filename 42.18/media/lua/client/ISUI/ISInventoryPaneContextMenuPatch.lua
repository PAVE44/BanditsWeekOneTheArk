require "ISInventoryPaneContextMenu"

local func = ISInventoryPaneContextMenu.readItem
local modal = nil

function ISInventoryPaneContextMenu.readItem(item, player)

    local md = item:getModData()

    if md.printContent then
        local playerObj = getSpecificPlayer(player)
        ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
        if modal then
            modal:removeFromUIManager()
        end

        if md.BWOA and md.BWOA.onRead then 
            local onRead = md.BWOA.onRead
            if onRead.accomplishMissionId then
                BWOAMissions.Accomplish(onRead.accomplishMissionId)
            end
            if onRead.revealMissionId then
                BWOAMissions.Reveal(onRead.revealMissionId)
            end
            if onRead.revealDialogueId and onRead.revealDialoguePerson then
                BWOADialogues.Reveal(onRead.revealDialoguePerson, onRead.revealDialogueId)
            end
            if onRead.hideDialogueId and onRead.hideDialoguePerson then
                BWOADialogues.Hide(onRead.hideDialoguePerson, onRead.hideDialogueId)
            end
            if onRead.progressMissionId then
                BWOAMissions.Progress(onRead.progressMissionId, md.printContent)
            end
        end
        modal = UIPrintMedia:new(md.printContent, playerObj)
        modal:initialise()
        modal:addToUIManager()
    else
        func(item, player)
    end

end