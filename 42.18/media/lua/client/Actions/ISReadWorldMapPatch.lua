require "TimedActions/ISReadWorldMap"

function ISReadWorldMap:isValid()
	local gmd = GetBWOAModData()
    if gmd.nightmares.active then return false end

	return ISWorldMap.IsAllowed()
end
