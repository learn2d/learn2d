define [
  'cs!util'
], ->
  util = require 'util'

  class Movement
    constructor: ({@player, @timer}) ->
      @timer.set 50

    onMouseDown: (mouse) ->
      @player.x = mouse.x
      @player.y = mouse.y
      @player.setAni 'female-idle'
      @player.direction = util.DIR_LEFT

      @timer.set 50

    onTimer: ->
      console.log 'timer done'
      @timer.set 50