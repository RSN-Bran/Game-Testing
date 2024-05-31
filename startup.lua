function startup()

    loadRequirements()
    
    
    sounds = {}
    sounds.music = love.audio.newSource('sounds/music.mp3', "stream")

    world = wf.newWorld(0, 0)
    
    createCollisionClasses()
    

    cam = camera()

    gameMap = sti('maps/testMap.lua')
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    
    player = Player.createPlayer()

    background = love.graphics.newImage('sprites/background.png')

    -- sounds.music:setLooping(true)
    -- sounds.music:play()

    enemies = {
        Enemy.createEnemy("enemyType1", {x=200, y=300}),
        Enemy.createEnemy("enemyType1", {x=500, y=800}),
        Enemy.createEnemy("enemyType2", {x=1000, y=1000})
    }

    treasures = {
        Treasure.createTreasure({x=500, y=500}),
        Treasure.createTreasure({x=800, y=200}),
        Treasure.createTreasure({x=100, y=800})
    }

    shots = {}

    base = Base.createBase({x= 100, y=100})
end

function loadRequirements()
    require('/src/player')
    require('/src/enemy')
    require('/src/shot')
    require('/src/base')
    require('/src/treasure')

    require('draw')

    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti'
    camera = require 'libraries/camera'
    wf = require "libraries/windfield"
end

function createCollisionClasses()
    world:addCollisionClass('Player')
    world:addCollisionClass('Shot', {ignores = {'Player', 'Shot'}})
    world:addCollisionClass('Enemy-Hurtbox')
    world:addCollisionClass('Treasure')
    world:addCollisionClass('Base', {ignores = {'Player', 'Shot', 'Enemy-Hurtbox', 'Treasure'}})
end