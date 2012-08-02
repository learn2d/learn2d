define ->
  class FireSpell
    constructor: ({@player, @timer, @util, @input, @level, @projectile}) ->

    onKeyDown: (keyCode) ->
      console.log keyCode

    onMouseDown: (mouse) ->
      @projectile.testing()