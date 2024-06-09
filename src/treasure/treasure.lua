treasures = {}

function createTreasure(position)
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

    function treasure:draw()
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


    function treasure:increaseCarry(speed)
        self.speed = self.speed+speed
        self.carrying = self.carrying+1
    end

    function treasure:move(basePosition)
        
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

    function treasure:cash()
        self:deactivate()
    end

    function treasure:update(dt)
        self:move(base.position)
        self.position.x = self.collider:getX()
        self.position.y = self.collider:getY()
    end

    function treasure:deactivate()
        self.isActive=false
        self.collider:destroy()
        removeValue(treasures, self)
    end

    table.insert(treasures, treasure)

    return treasure
end

function treasures:draw()
    for i, v in ipairs(self) do
        if v.isActive then
            v:draw()
        end
    end
end

function treasures:update()
    for i, v in ipairs(self) do
        if v.isActive then
            v:update()
        end
    end
end

return Treasure