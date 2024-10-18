menu = {}

function createMenu(menuNum)
    menu = {}
    if menuNum == MENUS_MAIN_PAUSE then
        menu = pauseMenu()
    elseif menuNum == MENUS_SETTINGS then
        menu = settingsMenu()
    end

    function menu:scroll(dir)
        if not isempty(menu.items[self.selectedAction.links[dir]]) then
            self.selectedAction = menu.items[self.selectedAction.links[dir]]
        end
    end

    function menu:select()
        if not isempty(self.selectedAction.params.selectFunction) then
            self.selectedAction.params.selectFunction()
        end
    end

    return menu
end

function pauseMenu()
    menu = {}

    menu.items = {createMenuItem(PAUSE_MENU_SETTINGS), createMenuItem(PAUSE_MENU_QUIT)}
    menu.selectedAction = menu.items[1]

    menu.items[1]:createLink("up", 2)
    menu.items[1]:createLink("down", 2)
    menu.items[2]:createLink("up", 1)
    menu.items[2]:createLink("down", 1)

    return menu
end

function settingsMenu()
    menu = {}

    menu.items = {createMenuItem(SETTINGS_MENU_VOLUME), createMenuItem(SETTINGS_MENU_LANGUAGE), createMenuItem(SETTINGS_MENU_CONTROLS)}
    menu.selectedAction = menu.items[1]

    menu.items[1]:createLink("up", 3)
    menu.items[1]:createLink("down", 2)
    menu.items[2]:createLink("up", 1)
    menu.items[2]:createLink("down", 3)
    menu.items[3]:createLink("up", 2)
    menu.items[3]:createLink("down", 1)

    return menu
end