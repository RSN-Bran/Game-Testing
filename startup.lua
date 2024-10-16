function startup()

    loadRequirements()
    TEXT = json.decode(love.filesystem.read("text.json"))
    
    world = wf.newWorld(0, 0)
    createCollisionClasses()
    
    
    gameMusic = initializeMusic()

    loadMap("testMap2")
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    
    player = createPlayer()

    state = createState()
    menu = createMenu()
    
    language = "en"

    
end

function loadRequirements()
    require('/src/player')
    require('/src/enemy')
    require('/src/shot')
    require('/src/base')
    require('/src/treasure/treasure')
    require('/src/warp')
    require('/src/state')
    require('/src/sound')
    require('/src/menu')
    require('/src/menu_item')

    require('draw')
    require('update')
    require('controlHandling')
    require('loadMap')
    require('cam')
    require('music')

    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti'
    wf = require "libraries/windfield"
    json = require "libraries/json"
end

function createCollisionClasses()
    world:addCollisionClass('Player')
    world:addCollisionClass('Shot', {ignores = {'Player', 'Shot'}})
    world:addCollisionClass('Enemy-Hurtbox')
    world:addCollisionClass('Treasure')
    world:addCollisionClass('Base', {ignores = {'Player', 'Shot', 'Enemy-Hurtbox', 'Treasure'}})
    world:addCollisionClass('warp', {ignores = {'Player', 'Shot', 'Enemy-Hurtbox', 'Treasure'}})
end