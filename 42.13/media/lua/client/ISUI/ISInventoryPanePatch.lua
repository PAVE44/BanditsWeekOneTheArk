require "ISInventoryPane"

local inventoryPaneRenderDetails = ISInventoryPane.renderdetails

function ISInventoryPane:renderdetails(doDragged)
    inventoryPaneRenderDetails(self, doDragged)

    local y = 0

    local MOUSEX = self:getMouseX()
    local MOUSEY = self:getMouseY()
    local YSCROLL = self:getYScroll()
    local HEIGHT = self:getHeight()

    for k, v in ipairs(self.itemslist) do
        local count = 1;
        for k2, v2 in ipairs(v.items) do
            local item = v2
            local doIt = true;
            local xoff = 0
            local yoff = 0

            local isDragging = false
            if self.dragging ~= nil and self.selected[y+1] ~= nil and self.dragStarted then
                xoff = MOUSEX - self.draggingX;
                yoff = MOUSEY - self.draggingY;
                if not doDragged then
                    doIt = false;
                else
                    self:suspendStencil();
                    isDragging = true
                end
            else
                if doDragged then
                    doIt = false;
                end
            end
            local topOfItem = y * self.itemHgt + YSCROLL
            if not isDragging and ((topOfItem + self.itemHgt < 0) or (topOfItem > HEIGHT)) then
                doIt = false
            end

            if doIt == true then

                if item:getModData().radiated then
                    self:drawRect(1+xoff, (y*self.itemHgt)+self.headerHgt+yoff, self.column4, self.itemHgt, 0.1, 0.25, 1, 0.08)
                    --self:drawRect(1+xoff, (y*self.itemHgt)+self.headerHgt+yoff, self:getWidth()-1, self.itemHgt, 0.1, 0.25, 1, 0.08)
                end
            end

            y = y + 1
            if self.collapsed[v.name] then
                break
            end
        end
    end
end
