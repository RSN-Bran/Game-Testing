require('/global/functions')
require('/global/constants')

function love.load()
    require('/startup')  
    startup()
end

function love.update(dt)
    updateAll(dt)
end

function love.draw()
    
    if state.currentState == STATE_PLAYING then
        drawGame()
    elseif state.currentState== STATE_PAUSED then
        drawMenu()
    end
end

function love.keypressed(key)
    if state.currentState == STATE_PLAYING then
        checkInput(key, true)
        if key == "space" then
            createShot(player)
        elseif key == "a" then
            player:scrollMode(-1)
        elseif key == "s" then
            player:scrollMode(1)
        elseif key == "1" then
            love.event.push("quit")
        elseif key == "escape" then
            state:pauseOrUnpause()
            menu=createMenu()
        end
    elseif state.currentState==STATE_PAUSED then
        --checkInput(key, true)
        if key == "escape" then
            state:pauseOrUnpause()
        end
    end
end

function love.keyreleased(key)
    checkInput(key, false)
end