actions = {"up", "down", "left", "right", "cycleleft","cycleright","shoot","pause"}
controls = {
    up={inputs={"up"}, active=false},
    down={inputs={"down"}, active=false},
    left={inputs={"left"}, active=false},
    right={inputs={"right"}, active=false},
    cycleleft={inputs={"a"}, active=false},
    cycleright={inputs={"s"}, active=false},
    shoot={inputs={"space"}, active=false},
    pause={inputs={"escape"}, active=false}
}

function checkInput(key)
    for i, v in ipairs(actions) do
        local controlMapping = controls[v]
        if contains(controlMapping.inputs, key) then
            controlMapping.active=true
        else
            controlMapping.active=false
        end
    end
end