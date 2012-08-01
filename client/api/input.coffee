define [
  'util'
], ->
  util = require 'util'

  class Input
    constructor: (@input) ->

    isKeyDown: (keyCode) ->
      @input.isKeyDown keyCode

    isMouseDown: () ->
      @input.isMouseDown()

    isDirectionKeyDown: (direction) ->
      if direction is 0
        @isKeyDown util.KEY_UP
      else if direction is 1
        @isKeyDown util.KEY_LEFT
      else if direction is 2
        @isKeyDown util.KEY_DOWN
      else if direction is 3
        @isKeyDown util.KEY_RIGHT