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
    checkInput(key)
    if key == "space" then
        createShot(player)
    elseif key == "a" then
        player:scrollMode(-1)
    elseif key == "s" then
        player:scrollMode(1)
    elseif key == "escape" then
        love.event.push("quit")
    end
end