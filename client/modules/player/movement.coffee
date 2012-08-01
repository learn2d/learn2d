define ->
  class Movement
    constructor: ({@trigger, @player}) ->
    onMouseDown: (mouse) ->
      @player.x = mouse.x
      @player.y = mouse.y