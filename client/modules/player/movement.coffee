define [
  'cs!util'
], ->
  util = require 'util'

  class Movement
    constructor: ({@player, @timer}) ->
      @timer.delay = 50

    onMouseDown: (mouse) ->
      @player.x = mouse.x
      @player.y = mouse.y
      @player.setAni 'female-idle'
      @player.direction = util.DIR_LEFT

      @timer.delay = 50

    onTimer: ->
      console.log 'timer done'
      @timer.delay = 50