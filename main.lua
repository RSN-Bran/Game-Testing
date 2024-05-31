require 'global'

function love.load()

    require('/startup')
    startup()

end

function love.update(dt)
    
    player:movePlayer()

    for i, v in ipairs(shots) do
        v:checkCollision()
    end

    for i,v in ipairs(enemies) do
        if v.alive then
            v:behavior(player.position, dt)
        end
    end

    for i,v in ipairs(treasures) do
        v:move(base.position)
    end

    base:checkCollision()

    world:update(dt)
    player:updatePlayerPosition()

    -- --cleanup
    for i,v in ipairs(shots) do
        if not v.isActive then
            table.remove(shots, i)
        end
    end

    for i,v in ipairs(treasures) do
        if not v.isActive then
            table.remove(treasures, i)
        end
    end

    for i, v in ipairs(shots) do
        v.position.x = v.collider:getX()
        v.position.y = v.collider:getY()
    end

    for i, v in ipairs(treasures) do
        v.position.x = v.collider:getX()
        v.position.y = v.collider:getY()
    end

    for i,v in ipairs(enemies) do
        if v.alive then
            v.position.x = v.collider:getX()
            v.position.y = v.collider:getY()
        end
    end

    player.anim:update(dt)

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
        gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
        gameMap:drawLayer(gameMap.layers["trees"])
                
        draw({enemies, shots, treasures})

        --Temporary to show colliders
        if DEBUG then
            world:draw()
        end
        
    cam:detach()

    love.graphics.print(base.money)
    
end

function love.keypressed(key)
    if key == "space" then
        local newShot = Shot.createShot(player)
        table.insert(shots, newShot)
    elseif key == "a" then
        player:scrollMode(-1)
    elseif key == "s" then
        player:scrollMode(1)
    elseif key == "escape" then
        love.event.push("quit")
    end
end