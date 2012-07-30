define [
  'cs!trigger'
  'cs!player'
], ->
  player = require 'player'

  class System
    constructor: ({@trigger}) ->
    onMouseDown: (mouse) ->
      window.sgg.moveAni(mouse.x, mouse.y)
      @trigger.send
        target: 'server/modules/system'
        action: 'createPlayer'
        params:
          x: mouse.x
          y: mouse.y
