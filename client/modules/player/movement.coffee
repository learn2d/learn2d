define ->
  class Movement
    constructor: ({@player, @timer, @util, @input}) ->

    onCreated: ->
      @timer.delay = 50

    onMouseDown: (mouse) ->
      @player.x = mouse.x
      @player.y = mouse.y
      @player.direction = @util.DIR_LEFT

      @timer.delay = 50

    onTimer: ->
      @player.setAni 'female-idle'
      for direction in [0..3]
        if @input.isDirectionKeyDown(direction)
          @player.x += (@util.vectorX direction) * 8
          @player.y += (@util.vectorY direction) * 8
          @player.direction = direction
          @player.setAni 'female-walk'

      @timer.delay = 50