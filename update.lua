function updateAll(dt)
    world:update(dt)
    cam:update(dt)
    player:update(dt)
    shots:update(dt)
    enemies:update(dt)
    treasures:update(dt)
    base:update(dt)
end