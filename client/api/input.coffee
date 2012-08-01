define ->
  class Input
    constructor: (@input) ->

    isKeyDown: (keyCode) ->
      @input.isKeyDown keyCode

    isMouseDown: () ->
      @input.isMouseDown()