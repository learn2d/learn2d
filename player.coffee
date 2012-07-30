class Player
  constructor: ({@level, @x, @y}) ->

  getX: ->
    @x
  getY: ->
    @y
  getLevel: ->
    @level

  toJSON: ->
    level: @level
    x: @x
    y: @y

module.exports = Player