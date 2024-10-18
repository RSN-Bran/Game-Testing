function drawGame()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["ground"])
        gameMap:drawLayer(gameMap.layers["trees"])
        gameMap:drawLayer(gameMap.layers["walls-sprites"])
                
        drawAll()
        
    cam:detach()
    love.graphics.print(base.money)
end

function drawMenu()
    for index, value in ipairs(menu.items) do
        if value.params.id == menu.selectedAction.params.id then

            love.graphics.print(value.params.name, value.params.x+50, value.params.y)
        else
            love.graphics.print(value.params.name, value.params.x, value.params.y)
        end
    end

end

function drawAll()
    player:draw()
    base:draw()
    shots:draw()
    enemies:draw()
    treasures:draw()
    warps:draw()

    --Temporary to show colliders
    if DEBUG then
        world:draw()
    end
end