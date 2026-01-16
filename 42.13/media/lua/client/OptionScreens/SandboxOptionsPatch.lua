require "SandboxOptionsScreen"

SandboxOptionsScreenOnOptionMouseDown = SandboxOptionsScreen.onOptionMouseDown

function SandboxOptionsScreen:onOptionMouseDown(button, x, y)
    SandboxOptionsScreenOnOptionMouseDown(self, button, x, y)
    if button.internal == "BACK" then
        self:setVisible(false)
        if MainScreen.instance.createWorld or MapSpawnSelect.instance:hasChoices() then
            MapSpawnSelect.instance:setVisible(false, self.joyfocus)
            WorldSelect.instance:setVisible(false, self.joyfocus)
            NewGameScreen.instance:setVisible(true, self.joyfocus)
        end
    end
end
