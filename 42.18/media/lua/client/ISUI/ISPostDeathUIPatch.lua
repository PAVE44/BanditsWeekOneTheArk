require "ISUI/ISPostDeathUI"

local postDeathUICreateChildren = ISPostDeathUI.createChildren
function ISPostDeathUI:createChildren()

	postDeathUICreateChildren(self)

	self:removeChild(self.buttonRespawn)

end
