uuid = require 'node-uuid'
util = require './util'

class Entity
  constructor: ({@id, @level, @x, @y}) ->
    @id ?= uuid.v1()

  getX: ->
    @x
  getY: ->
    @y
  getLevel: ->
    @level

  toJSON: ->
    id: @id
    x: @x
    y: @y
    direction: util.DIR_UP
    aniName: 'female-walk'

module.exports = Entity
