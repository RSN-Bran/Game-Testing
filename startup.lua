function startup()

    loadRequirements()
    
    
    sounds = {}
    sounds.music = love.audio.newSource('sounds/music.mp3', "stream")

    world = wf.newWorld(0, 0)
    
    createCollisionClasses()
    
    loadMap("testMap2")

    cam = camera()

    
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    
    player = Player.createPlayer()

    -- sounds.music:setLooping(true)
    -- sounds.music:play()

    
    base = Base.createBase({x= 100, y=100})
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