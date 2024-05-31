DEBUG = true

function calculateDistance(position1, position2)
    xDistance = (position2.x - position1.x)^2
    yDistance = (position2.y - position1.y)^2
    return math.sqrt(xDistance+yDistance)
end
