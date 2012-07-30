util = require './util'

class Player
  constructor: ({@level, @x, @y}) ->

  getX: ->
    @x
  getY: ->
    @y
  getLevel: ->
    @level

  toJSON: ->
    level: @level.getName()
    x: @x
    y: @y
    direction: util.DIR_RIGHT
    aniName: 'walk-female-male'

module.exports = Player
