function createSound(source, pitch)
    sound = {}

    sound.source = source
    sound.pitch = pitch

    function sound:playSound()
        soundSource = love.audio.newSource(sound.source, "static")
        soundSource:setPitch(sound.pitch)
        soundSource:play()
    end


    return sound
end
