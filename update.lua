function updateAll(dt)
    if state.currentState == STATE_PLAYING then
        updateGameObjects(dt)
    end
end

function updateGameObjects(dt)
    world:update(dt)
    cam:update(dt)
    player:update(dt)
    shots:update(dt)
    enemies:update(dt)
    treasures:update(dt)
    base:update(dt)
    warps:update(dt)
end