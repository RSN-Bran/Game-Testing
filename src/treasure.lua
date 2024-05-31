Treasure = {}

function Treasure.createTreasure(position)
    treasure = {}
    treasure.position = position
    treasure.isActive = true
    treasure.weight = 10
    treasure.carrying=0
    treasure.value =200

    treasure.speed = 0

    treasure.collider = world:newCircleCollider(treasure.position.x, treasure.position.y, 50)
    treasure.collider:setCollisionClass('Treasure')
    treasure.collider:setType("kinematic")
    treasure.collider:setObject(treasure)

    treasure.draw = function(self)
        if(self.carrying >= self.weight) then
            love.graphics.setColor(1,0,0)
        else
            love.graphics.setColor(0,1,0)
        end
        love.graphics.circle("fill", self.position.x, self.position.y, 50)
        love.graphics.setColor(1,1,1)
        love.graphics.print(
                    self.carrying.."/"..self.weight,
                    self.position.x,
                    self.position.y
                )
    end


    treasure.increaseCarry = function(self, speed)
        self.speed = self.speed+speed
        self.carrying = self.carrying+1
    end

    treasure.move = function(self, basePosition)
        
        vx,vy=0,0
        if(self.carrying >= self.weight) then
            if self.position.x > basePosition.x then
                vx=self.speed*-1
            else
                vx=self.speed
            end

            if self.position.y > basePosition.y then
                vy=self.speed*-1
            else
                vy=self.speed
            end
        end
        self.collider:setLinearVelocity(vx, vy)
    end

    treasure.cash = function(self)
        self.isActive = false
        self.collider:destroy()
    end

    return treasure
end

return Treasure