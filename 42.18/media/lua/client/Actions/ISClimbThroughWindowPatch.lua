require "TimedActions/ISClimbThroughWindow"

local isValid = ISClimbThroughWindow.isValid

function ISClimbThroughWindow:isValid()

    local md = self.item:getModData()
    if md.climbForbidden then return false end

    return isValid(self)

end