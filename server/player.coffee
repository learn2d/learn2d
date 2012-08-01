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
    direction: util.DIR_UP
    aniName: 'explosion-status'

module.exports = Player
