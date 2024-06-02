enemies = {}

function createEnemy(enemyType, position)
    local enemy = {}

    if enemyType == "enemyType1" then
        enemy = createEnemyType1(position)
    elseif enemyType == "enemyType2" then
        enemy = createEnemyType2(position)
    end

    enemy.collider = world:newCircleCollider(enemy.position.x, enemy.position.y, enemy.scale*70)
    enemy.collider:setCollisionClass('Enemy-Hurtbox')
    enemy.collider:setObject(enemy)

    function enemy:damageEnemy(inputDamage)
        self.health = self.health - inputDamage
        self.hurtTimer=self.hurtAnimationLength
        if self.health <= 0 then
            self.alive = false
            self:deactivate()
        end
    end

    function enemy:behavior(dt)
        local playerPosition = player.position
        distance = calculateDistance(self.position, playerPosition)
        if distance < self.watchRadius then

            vx,vy=0,0
            if self.position.x > playerPosition.x then
                vx=self.speed*-1
            else
                vx=self.speed
            end

            if self.position.y > playerPosition.y then
                vy=self.speed*-1
            else
                vy=self.speed
            end

            self.collider:setLinearVelocity(vx, vy)
        else
            self.collider:setLinearVelocity(0, 0)
        end
    end
    

    function enemy:draw()
        if self.health > 0 then
            if self.hurtTimer > 0 then
                love.graphics.setColor(1, 0, 0)
                self.hurtTimer=self.hurtTimer-1
                
            end
            love.graphics.draw(
                self.sprite, 
                self.position.x-(self.sprite:getWidth()/2)*self.scale,
                self.position.y-(self.sprite:getHeight()/2)*self.scale,
                0,
                self.scale
            )
            love.graphics.setColor(1,1,1)

            if DEBUG then
                love.graphics.print(
                    self.health,
                    self.position.x,
                    self.position.y+(self.sprite:getWidth()/2)*self.scale
                )
                love.graphics.circle(
                    "line",
                    self.position.x,
                    self.position.y,
                    self.watchRadius
                )
            end
            
        end
    end

    function enemy:update(dt)
        if self.alive then
            self:behavior(player.position, dt)

            self.position.x = self.collider:getX()
            self.position.y = self.collider:getY()
        end
        
    end

    function enemy:deactivate()
        self.isActive=false
        self.collider:destroy()
        removeValue(enemies, self)
    end

    table.insert(enemies, enemy)

    return enemy
end

function enemies:draw()
    for i, v in ipairs(self) do
        if v.isActive then
            v:draw()
        end
    end
end

function enemies:update(dt)
    for i, v in ipairs(self) do
        v:update()
    end
end

function createEnemyType1(position)
    local params = {
        position=position,
        health=10,
        speed=100,
        alive=true,
        isActive=true,
        scale=1,
        sprite = love.graphics.newImage('sprites/parrot.png'),
        behavior = "watch-and-chase",
        watchRadius = 200,
        hurtAnimationLength=5,
        hurtTimer=0
    }

    return params
end

function createEnemyType2(position)
    return {
        position=position,
        health=20,
        speed=200,
        alive=true,
        isActive=true,
        scale=2,
        watchRadius =20,
        sprite = love.graphics.newImage('sprites/parrot.png'),
        hurtAnimationLength=10,
        hurtTimer=0
    }
end

return Enemy