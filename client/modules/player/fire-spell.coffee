define ->
  class FireSpell
    constructor: ({@trigger, @player, @timer, @util, @input, @level, @projectile}) ->

    onCreated: ->
      @timer.delay = 50

    onMouseDown: (mouse) ->
      #@player.setHealth -5
      @player.setAni 'female-slash'
      @trigger.send
        target: 'slash'
        action: 'meleeAction'
        params:
          direction: @player.getDirection()
          x: @player.getX()
          y: @player.getY()
          reach: 50
          buffer: 10
          health: 5

    onTimer: () ->
      if @input.isKeyDown(32) or @input.isKeyDown(68)
        @player.setAni 'female-slash'
      @timer.delay = 50
