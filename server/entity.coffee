uuid = require 'node-uuid'
util = require './util'

class Entity
  constructor: ({@id, @level, @x, @y, @aniName, @direction, @visible, @type}) ->
    @direction ?= util.DIR_UP
    @aniName ?= 'female-walk'
    @id ?= uuid.v1()
    @visible ?= true

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
    direction: @direction
    aniName: @aniName
    visible: @visible

module.exports = Entity
