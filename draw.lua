function drawAll()
    player:draw()
    base:draw()
    shots:draw()
    enemies:draw()
    treasures:draw()
    warps:draw()
    menu:draw()

    --Temporary to show colliders
    if DEBUG then
        world:draw()
    end
end