function loadMap(map)

    gameMap = sti('maps/'..map..'.lua')

    print(gameMap.properties.music)
    if gameMap.properties["music"] then
        gameMusic:playMusic(gameMap.properties["music"])
    end

    if gameMap.layers["warps"] then
        for i, obj in pairs(gameMap.layers["warps"].objects) do
            createWarp(extractWarpProperties(obj))
        end
    end
        
    if gameMap.layers["enemies"] then
        for i, obj in pairs(gameMap.layers["enemies"].objects) do
            createEnemy(obj.type, {x=obj.x, y=obj.y})
        end
    end
    
    if gameMap.layers["treasures"] then
        for i, obj in pairs(gameMap.layers["treasures"].objects) do
            createTreasure({x=obj.x, y=obj.y})
        end
    end

    if gameMap.layers["base"] then
        for i, obj in pairs(gameMap.layers["base"].objects) do
            createBase({x=obj.x, y=obj.y})
        end
    end

    walls = {}
    if gameMap.layers["walls-objects"] then
        for i, obj in pairs(gameMap.layers["walls-objects"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end

end
