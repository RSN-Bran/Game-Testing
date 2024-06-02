function initializeMusic()
    gameMusic = {}
    gameMusic.music = null

    function gameMusic:playMusic(song)
        self.music = love.audio.newSource('sounds/'..song..'.mp3', "stream")
        self.music:setLooping(true)
        self.music:play()
    end

    function gameMusic:stopMusic()
        self.mustic:stop()
    end

    return gameMusic
end