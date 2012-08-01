define ->
  class Movement
    constructor: ({@player, @timer, @util, @input}) ->
      @timer.delay = 50

    onMouseDown: (mouse) ->
      @player.x = mouse.x
      @player.y = mouse.y
      @player.setAni 'female-idle'
      @player.direction = @util.DIR_LEFT

      @timer.delay = 50

    onTimer: ->
      console.log @input.isKeyDown(@util.KEY_UP)

      @timer.delay = 50