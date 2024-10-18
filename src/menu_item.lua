function createMenuItem(menuItemId)

    local function getMenuItemParams(menuItemId)
        local params = {}
        if menuItemId == PAUSE_MENU_SETTINGS then
            params = {
                id = PAUSE_MENU_SETTINGS,
                name = TEXT["SETTINGS"][language],
                x = 100,
                y=100,
                selectFunction = function()
                    menu = createMenu(MENUS_SETTINGS)
                end
            }
        elseif menuItemId == PAUSE_MENU_QUIT then
            params = {
                id = PAUSE_MENU_QUIT,
                name = TEXT["QUIT"][language],
                x=100,
                y=400,
                selectFunction = function()
                    love.event.quit() 
                end
            }
        elseif menuItemId == SETTINGS_MENU_VOLUME then
            params = {
                id = SETTINGS_MENU_VOLUME,
                name = TEXT["QUIT"][language],
                x=100,
                y=100,
                selectFunction = function()
                    love.event.quit() 
                end
            }
        elseif menuItemId == SETTINGS_MENU_LANGUAGE then
            params = {
                id = SETTINGS_MENU_LANGUAGE,
                name = TEXT["LANGUAGE"][language],
                x=100,
                y=200,
                selectFunction = function()
                    language="es" 
                end
            }
        elseif menuItemId == SETTINGS_MENU_CONTROLS then
            params = {
                id = SETTINGS_MENU_CONTROLS,
                name = TEXT["QUIT"][language],
                x=100,
                y=300,
                selectFunction = function()
                    love.event.quit() 
                end
            }
        end
    
        return params
    end

    menuItem = {}
    menuItem.params = getMenuItemParams(menuItemId)
    menuItem.links = {}

    function menuItem:createLink(dir, itemInd)
        self.links[dir] = itemInd
    end
    
    return menuItem
end
