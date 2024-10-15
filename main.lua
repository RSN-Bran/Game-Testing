require 'global'

function love.load()

    require('/startup')
    startup()

end

function love.update(dt)

    updateAll(dt)
    
end

function love.draw()
    
    cam:attach()
        gameMap:drawLayer(gameMap.layers["ground"])
        gameMap:drawLayer(gameMap.layers["trees"])
        gameMap:drawLayer(gameMap.layers["walls-sprites"])
                
        drawAll()
        
    cam:detach()

    love.graphics.print(base.money)
    
end

function love.keypressed(key)
    if state.currentState == "PLAYING" then
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
        end
    elseif state.currentState=="PAUSED" then
        --checkInput(key, true)
        if key == "escape" then
            state:pauseOrUnpause()
        end
    end
end

function love.keyreleased(key)
    checkInput(key, false)
end