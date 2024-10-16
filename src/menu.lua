menu = {}

function createMenu(params)
    menu = {}

    menu.selectedAction = 1


    menu.items = {createMenuItem(PAUSE_MENU_SETTINGS), createMenuItem(PAUSE_MENU_QUIT)}
    return menu
end