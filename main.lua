require 'global'

function love.load()

    require('/startup')
    startup()

end

function love.update(dt)

    updateAll(dt)
    
    cam:lookAt(player.position.x, player.position.y)

    local w=love.graphics.getWidth()
    local h=love.graphics.getHeight()

    if cam.x < w/2 then
        cam.x =w/2
    end
    if cam.y < h/2 then
        cam.y =h/2
    end

    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight


    if cam.x > (mapW - w/2) then
        cam.x =(mapW - w/2)
    end
    if cam.y > (mapH - h/2) then
        cam.y =(mapH - h/2)
    end
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