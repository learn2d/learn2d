define ->
  class FireSpell
    constructor: ({@player, @timer, @util, @input, @level, @projectile}) ->

    onCreated: ->
      @timer.delay = 50

    onMouseDown: (mouse) ->
      @player.setAni 'female-slash'

    onTimer: () ->
      if @input.isKeyDown(32)
        @player.setAni 'female-slash'
      @timer.delay = 50