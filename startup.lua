function startup()

    loadRequirements()
    world = wf.newWorld(0, 0)
    createCollisionClasses()
    
    
    gameMusic = initializeMusic()

    loadMap("testMap2")
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    
    player = createPlayer()

    
end

function loadRequirements()
    require('/src/player')
    require('/src/enemy')
    require('/src/shot')
    require('/src/base')
    require('/src/treasure')

    require('draw')
    require('update')
    require('controlHandling')
    require('loadMap')
    require('cam')
    require('music')

    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti'
    
    wf = require "libraries/windfield"
end

function createCollisionClasses()
    world:addCollisionClass('Player')
    world:addCollisionClass('Shot', {ignores = {'Player', 'Shot'}})
    world:addCollisionClass('Enemy-Hurtbox')
    world:addCollisionClass('Treasure')
    world:addCollisionClass('Base', {ignores = {'Player', 'Shot', 'Enemy-Hurtbox', 'Treasure'}})
end