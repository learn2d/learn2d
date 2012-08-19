define ->
  class FireSpell
    constructor: ({@player, @timer, @util, @input, @level, @projectile}) ->

    onCreated: ->
      @timer.delay = 50

    onMouseDown: (mouse) ->
      @player.setHealth -5
      @player.setAni 'female-slash'

    onTimer: () ->
      if @input.isKeyDown(32) or @input.isKeyDown(68)
        @player.setAni 'female-slash'
      @timer.delay = 50
