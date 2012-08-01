define [
  'cs!util'
], ->
  util = require 'util'

  class Movement
    constructor: ({@player}) ->

    onMouseDown: (mouse) ->
      @player.x = mouse.x
      @player.y = mouse.y
      @player.setAni 'female-idle'
      @player.direction = util.DIR_LEFT