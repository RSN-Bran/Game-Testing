function draw(arrs)
    player:draw()
    base:draw()

    for i1,v1 in ipairs(arrs) do
        for i2, v2 in ipairs(v1) do
            if v2.isActive then
                v2:draw()
            end
        end
    end
end