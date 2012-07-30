define [
  'cs!trigger'
  'cs!player'
], ->
  trigger = require 'trigger'
  player = require 'player'

  class System
    onMouseDown: (mouse) ->
      window.sgg.moveAni(mouse.x, mouse.y)
      #trigger.send
      #  target: 'server/modules/system'
      #  action: 'createPlayer'
      #  params:
      #    x: mouse.x
      #    y: mouse.y
