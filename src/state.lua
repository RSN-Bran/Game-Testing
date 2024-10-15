function createState()
    state = {}

    --Possible States
    -- - MAINMENU
    -- - PLAYING
    -- - PAUSED
    -- - INVENTORY

    state.currentState = "PLAYING"

    function state:pauseOrUnpause()
        pauseSound = createSound('sounds/pause.wav', 1)
        pauseSound:playSound()
        if state.currentState == "PAUSED" then
            state.currentState = "PLAYING"
            menu:switchActivation()
        else
            state.currentState="PAUSED"
            menu:switchActivation()
        end
    end


    return state
end
