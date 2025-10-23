require "ISInventoryPaneContextMenu"

local func = ISInventoryPaneContextMenu.readItem

ISInventoryPaneContextMenu.readItem = function(item, player)

	local md = item:getModData()

	if md.printContent then
		local playerObj = getSpecificPlayer(player)
		ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
		local ui = UIPrintMedia:new(md.printContent, playerObj)
		ui:initialise()
		ui:addToUIManager()
	else
		func(self, item, player)
	end

end