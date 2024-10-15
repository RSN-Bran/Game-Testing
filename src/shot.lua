shots = {}

function createShot(player)
    shot = shotParams(player.modes[player.modeIndex])
    shot.position = {}
    shot.position.x = player.position.x
    shot.position.y = player.position.y
    shot.collider = world:newCircleCollider(shot.position.x, shot.position.y, 5)
    shot.collider:setCollisionClass('Shot')
    shot.xVelocity, shot.yVelocity = 0, 0
    shot.isActive=true
    if player.facing == "right" then
        shot.xVelocity = shot.shotSpeed
    elseif player.facing == "up" then
        shot.yVelocity = shot.shotSpeed *-1
    elseif player.facing == "left" then
        shot.xVelocity = shot.shotSpeed * -1
    else
        shot.yVelocity = shot.shotSpeed
    end

    shot.sound:playSound()

    function shot:checkCollision()
        if self.collider:enter('Enemy-Hurtbox') then
            local collision_data =self.collider:getEnterCollisionData('Enemy-Hurtbox')
            local enemy = collision_data.collider:getObject()
            enemy:damageEnemy(self.damage)
            self:deactivate()
        elseif self.collider:enter('Treasure') then
            local collision_data =self.collider:getEnterCollisionData('Treasure')
            local treasure = collision_data.collider:getObject()
            treasure:increaseCarry(self.carrySpeed)
            self:deactivate()
        else
            self.collider:setLinearVelocity(self.xVelocity, self.yVelocity)
            
            self.ttl = self.ttl-1
            if self.ttl <= 0 then
                self:deactivate()
            end
        end
    end

    function shot:draw()
        if self.shotType == "White" then
            love.graphics.setColor(1,1,1)
        elseif self.shotType == "Red" then
            love.graphics.setColor(1,0,0)
        elseif self.shotType == "Blue" then
            love.graphics.setColor(0,0,1)
        end
        love.graphics.circle("fill", self.position.x, self.position.y, 5)
        love.graphics.setColor(1,1,1)
    end

    function shot:update(dt)

        self:checkCollision()

        if self.isActive then
            self.position.x = self.collider:getX()
            self.position.y = self.collider:getY()
        end
    end

    function shot:deactivate()
        self.isActive=false
        self.collider:destroy()
        removeValue(shots, self)
    end

    table.insert(shots, shot)

    return shot
end

function shots:draw()
    for i, v in ipairs(self) do
        if v.isActive then
            v:draw()
        end
    end
end

function shots:update(dt)
    for i, v in ipairs(self) do
        v:update(dt)
    end
end

function shotParams(shotType)
    local params = {}
    if shotType == "White" then
        params = {
            ttl = 80,
            shotSpeed = 500,
            damage = 1,
            shotType = "White",
            sound = createSound('sounds/blip.wav', 1),
            carrySpeed=1
        }
    elseif shotType == "Red" then
        params = {
            ttl = 20,
            shotSpeed = 800,
            damage = 2,
            shotType = "Red",
            sound = createSound('sounds/blip.wav', .5),
            carrySpeed=2
        }
    elseif shotType == "Blue" then
        params = {
            ttl = 10,
            shotSpeed = 1000,
            damage = .5,
            shotType = "Blue",
            sound = createSound('sounds/blip.wav', 2),
            carrySpeed=4
        }
    end
    return params
end

return Shot