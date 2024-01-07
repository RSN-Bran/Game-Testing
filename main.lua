require 'global'

function love.load()
    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti'
    camera = require 'libraries/camera'
    wf = require "libraries/windfield"

    Enemy = require "Enemy"
    Player = require "Player"
    Shot = require "Shot"

    world = wf.newWorld(0, 0)
    world:addCollisionClass('Player')
    world:addCollisionClass('Shot', {ignores = {'Player', 'Shot'}})
    world:addCollisionClass('Enemy-Hurtbox')
    -- world:addCollisionClass('Enemy-Watch-Radius', {ignores = {'Player', 'Shot', 'Enemy-Hurtbox'}})

    cam = camera()

    gameMap = sti('maps/testMap.lua')
    love.graphics.setDefaultFilter("nearest", "nearest")
    

    hurtAnimationLength = 5
    
    player = Player.createPlayer()

    background = love.graphics.newImage('sprites/background.png')


    enemies = {
        Enemy.createEnemy("enemyType1", {x=200, y=300}),
        Enemy.createEnemy("enemyType1", {x=500, y=800}),
        Enemy.createEnemy("enemyType2", {x=1000, y=1000})
    }

    shots = {}
end

function love.update(dt)
    
    player:movePlayer()

    function love.keypressed(key)
        if key == "space" then
            local newShot = Shot.createShot(player)
            table.insert(shots, newShot)
        elseif key == "a" then
            print("hi")

            player:scrollMode(-1)
        elseif key == "s" then
            print("hi")

            player:scrollMode(1)
        elseif key == "escape" then
            love.event.push("quit")
        end
    end

    for i, v in ipairs(shots) do
        v:checkCollision()
    end

    for i,v in ipairs(enemies) do
        if v.alive then
            v:behavior(player.position, dt)
        end
    end

    world:update(dt)
    player:updatePlayerPosition()

    -- --cleanup
    for i,v in ipairs(shots) do
        if not v.isActive then
            table.remove(shots, i)
        end
    end

    for i, v in ipairs(shots) do
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
end

function love.draw()
    
    cam:attach()
        gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
        gameMap:drawLayer(gameMap.layers["trees"])
        
        player:draw()
        draw({enemies, shots})

        --Temporary to show colliders
        if DEBUG then
            world:draw()
        end
        
    cam:detach()
    
end
