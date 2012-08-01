define [
  'modules/sound/soundmanager2'
], ->
  SoundManager = require 'modules/sound/soundmanager2'

  console.log soundManager

  soundManager.setup (
    url: 'modules/sound/'
    onready: ->
      mySound = soundManager.createSound ( 
        id: 'soundfile'
        url: 'modules/sound/foom_0.wav')
      mySound.play()
      undefined
    )
