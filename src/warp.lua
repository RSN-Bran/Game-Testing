warps = {}

function createWarp(params)
    warp = {}
    warp.warpId = params.warpId
    warp.warpTo = params.warpTo
    warp.x=params.x
    warp.y=params.y

    warp.isActive=true
 
    warp.collider = world:newCircleCollider(warp.x, warp.y, 50)
    warp.collider:setCollisionClass('warp')
    warp.collider:setObject(warp)

    function warp:draw()
        love.graphics.circle("line", self.x, self.y, 50)
    end

    function warp:checkCollision()
        if self.collider:enter('Player') and self.isActive then
            newWarp = warps:find(self.warpTo)
            newWarp:switchActivation()
            player:warp({x=newWarp.x,y=newWarp.y})
        end
    end

    function warp:update(dt)
        self:checkCollision()
    end

    function warp:switchActivation()
        self.isActive = not self.isActive
    end

    table.insert(warps, warp)

    return warp
end

function extractWarpProperties(tab)
    params = {
        warpId=tab.properties["warpId"],
        warpTo=tab.properties["warpTo"],
        x=tab.x,
        y=tab.y
    }
    return params
end

function warps:update(dt)
    for i, v in ipairs(self) do
        if v.isActive then
            v:update(dt)
        end
    end
end

function warps:draw()
    for i, v in ipairs(self) do
        if v.isActive then
            v:draw()
        end
    end
end

function warps:find(warpTo)
    for i, v in ipairs(self) do
        if v.warpId==warpTo then
            return v
        end
    end
end