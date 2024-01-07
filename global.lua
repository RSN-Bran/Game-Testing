DEBUG = true

function calculateDistance(position1, position2)
    xDistance = (position2.x - position1.x)^2
    yDistance = (position2.y - position1.y)^2
    return math.sqrt(xDistance+yDistance)
end

function draw(arrs)
    for i1,v1 in ipairs(arrs) do
        for i2, v2 in ipairs(v1) do
            if v2.isActive then
                v2:draw()
            end
        end
    end
end
