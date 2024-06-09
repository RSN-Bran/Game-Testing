function createPlayer()
    player = {}

    --Set Player Position
    player.position = {}
    player.position.x = 50
    player.position.y=200

    player.health = 10

    player.isActive=true
    player.modes = {"White", "Red", "Blue"}
    player.modeIndex=2


    player.shotSpeed = 500
    player.speed = 300
    player.facing = "left"

    --Set Player Hurtbox
    player.collider = world:newBSGRectangleCollider(player.position.x, player.position.y, 40, 80, 14)
    player.collider:setFixedRotation(true)
    player.collider:setCollisionClass('Player')

    
    player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png')

    player.grid = anim8.newGrid( 12,18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    player.animations = {}

    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 2), 0.2)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 3), 0.2)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 4), 0.2)

    player.anim = player.animations.left


    function player:getPosition()
        return player.position
    end
    function player:movePlayer()
        local isMoving = false

        local vx = 0
        local vy = 0

        if controls["right"].active then
            vx=player.speed
            player.anim = player.animations.right
            isMoving = true
            player.facing = "right"
        end

        if controls["left"].active then
            vx=player.speed * -1
            player.anim = player.animations.left
            isMoving = true
            player.facing = "left"
        end

        if controls["up"].active then
            vy = player.speed *-1
            player.anim = player.animations.up
            isMoving = true
            player.facing = "up"
        end

        if controls["down"].active then
            vy = player.speed
            player.anim = player.animations.down
            isMoving = true
            player.facing = "down"
        end
        player.collider:setLinearVelocity(vx, vy)

        if isMoving == false then
            player.anim:gotoFrame(2)
        end
    end

    function player:updatePlayerPosition()
        self.position.x = self.collider:getX()
        self.position.y = self.collider:getY()
        
    end

    function player:scrollMode(modeChange)
        if modeChange == -1 and self.modeIndex == 1 then
            self.modeIndex = table.getn(self.modes)
        elseif modeChange == 1 and self.modeIndex == table.getn(self.modes) then
            self.modeIndex = 1
        else
            self.modeIndex = self.modeIndex + modeChange
        end
        self.mode = mode
    end

    function player:draw()
        self.anim:draw(player.spriteSheet, player.position.x, player.position.y, nil, 6, nil, 6, 9)
    end

    function player:warp(newPos)
        self.collider:setX(newPos.x)
        self.collider:setX(newPos.y)
    end

    function player:update(dt)
        self:movePlayer()
        self.anim:update(dt)
        self:updatePlayerPosition()
    end

    return player
end
