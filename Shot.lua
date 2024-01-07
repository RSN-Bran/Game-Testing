Shot = {}

function Shot.createShot(player)
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

    shot.checkCollision = function(self)
        if self.collider:enter('Enemy-Hurtbox') then
            local collision_data =self.collider:getEnterCollisionData('Enemy-Hurtbox')
            local enemy = collision_data.collider:getObject()
            enemy:damageEnemy(self.damage)
            self.isActive=false
            self.collider:destroy()
        else
            self.collider:setLinearVelocity(self.xVelocity, self.yVelocity)
            
            self.ttl = self.ttl-1
            if self.ttl <= 0 then
                self.isActive=false
                self.collider:destroy()
            end
        end
    end

    shot.draw = function(self)
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

    return shot
end

function shotParams(shotType)
    local params = {}
    if shotType == "White" then
        params = {
            ttl = 80,
            shotSpeed = 500,
            damage = 1,
            shotType = "White"
        }
    elseif shotType == "Red" then
        params = {
            ttl = 20,
            shotSpeed = 800,
            damage = 2,
            shotType = "Red"
        }
    elseif shotType == "Blue" then
        params = {
            ttl = 10,
            shotSpeed = 1000,
            damage = .5,
            shotType = "Blue"
        }
    end
    return params
end

return Shot