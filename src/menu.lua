menu = {}

function createMenu(params)
    menu = {}

    menu.isActive=false

    menu.selectedAction = "SETTINGS"


    function menu:draw()
        if menu.isActive then
            love.graphics.print(TEXT[self.selectedAction][language], 100, 200)
        end
    end

    -- function warp:update(dt)
    --     self:checkCollision()
    -- end

    function menu:switchActivation()
        menu.selectedAction = "SETTINGS"
        self.isActive = not self.isActive
    end

    return menu
end