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
		modal = UIPrintMedia:new(md.printContent, playerObj)
		modal:initialise()
		modal:addToUIManager()
	else
		func(item, player)
	end

end