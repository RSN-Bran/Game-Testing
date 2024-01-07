Enemy = {}

require 'global'
function Enemy.createEnemy(enemyType, position)
    local enemy = {}

    if enemyType == "enemyType1" then
        enemy = createEnemyType1(position)
    elseif enemyType == "enemyType2" then
        enemy = createEnemyType2(position)
    end

    enemy.collider = world:newCircleCollider(enemy.position.x, enemy.position.y, enemy.scale*70)
    enemy.collider:setCollisionClass('Enemy-Hurtbox')
    enemy.collider:setObject(enemy)

    enemy.damageEnemy = function(self,inputDamage)
        self.health = self.health - inputDamage
        self.hurtTimer=self.hurtAnimationLength
        if self.health <= 0 then
            self.alive = false
            self.isActive = false
            self.collider:destroy()
        end
    end

    enemy.behavior = function(self, playerPosition, dt)
        distance = calculateDistance(self.position, playerPosition)
        if distance < self.watchRadius then
            -- angle = math.atan2(self.position.y-playerPosition.y, self.position.x-playerPosition.x)
            -- vx = self.position.x + math.cos(angle)*self.speed*dt
            -- vy= self.position.y + math.sin(angle)*self.speed*dt
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
    

    enemy.draw = function(self)
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

    return enemy
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