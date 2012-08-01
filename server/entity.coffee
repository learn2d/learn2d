uuid = require 'node-uuid'
util = require './util'

class Entity
  constructor: ({@id, @x, @y, @aniName, @direction, @visible, @type}) ->
    @direction ?= util.DIR_UP
    @aniName ?= 'female-walk'
    @id ?= uuid.v1()
    @visible ?= true

  getX: ->
    @x

  setX: (x) ->
    @x

  getY: ->
    @y

  setY: (y) ->
    @y = y

  getAniName: ->
    @aniName

  setAniName: (aniName) ->
    @aniName = aniName

  getDirection: ->
    @direction

  setDirection: (direction) ->
    @direction = direction

  toJSON: ->
    id: @id
    x: @x
    y: @y
    direction: @direction
    aniName: @aniName
    visible: @visible

module.exports = Entity
