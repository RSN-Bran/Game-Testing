Base = {}

function Base.createBase(position)
    base = {}
    base.position = position
    base.money=0

    base.collider = world:newCircleCollider(base.position.x, base.position.y, 5)
    base.collider:setCollisionClass('Base')

    base.draw = function(self)
        love.graphics.circle("line", self.position.x, self.position.y, 50)
    end

    base.checkCollision = function(self)
        if self.collider:enter('Treasure') then
            local collision_data =self.collider:getEnterCollisionData('Treasure')
            local treasure = collision_data.collider:getObject()
            base.money = base.money+treasure.value
            treasure:cash()
        end
    end

    return base
end

return Base