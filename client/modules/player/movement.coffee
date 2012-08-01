define ->
  class Movement
    constructor: ({@player}) ->

    onMouseDown: (mouse) ->
      @player.x = mouse.x
      @player.y = mouse.y