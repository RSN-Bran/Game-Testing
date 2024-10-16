function createState()
    state = {}

    --Possible States
    -- - MAINMENU
    -- - PLAYING
    -- - PAUSED
    -- - INVENTORY

    state.currentState = STATE_PLAYING

    function state:pauseOrUnpause()
        pauseSound = createSound('sounds/pause.wav', 1)
        pauseSound:playSound()
        if state.currentState == STATE_PAUSED then
            state.currentState = STATE_PLAYING
        else
            state.currentState=STATE_PAUSED 
        end
    end


    return state
end
