menuItem = {}

function createMenuItem(menuItemId)
    menuItem = {}
    menuItem.params = {}
    if menuItemId == PAUSE_MENU_SETTINGS then
        menuItem.params = getSettingsButtonParams()
    elseif menuItemId == PAUSE_MENU_QUIT then
        menuItem.params = getQuitButtonParams()
    end

    return menuItem
end

function getSettingsButtonParams()
    local params = {
        id = 1,
        name = "Settings",
        x = 100,
        y=100
    }
    return params
end

function getQuitButtonParams()
    local params = {
        id = 2,
        name = "Quit",
        x=100,
        y=400,
        selectFunction = function()
            love.event.quit() 
        end
    }
    return params
end