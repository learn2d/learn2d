define [
  'cs!ani'
  'cs!util'
], ->
  Ani = require 'ani'
  util = require 'util'

  class AniComponent
    constructor: (@entity) ->
      @anis = [
        new Ani
          entity: @entity
          x: -16
          y: -32
      ]
    getAnis: =>
      @anis

  class Entity
    constructor: ({@x, @y, @aniName, @direction}) ->
      @components = {}
      @components.ani = new AniComponent(this)

    getX: ->
      @x

    getY: ->
      @y

    getAniName: ->
      'walk'

    getDirection: ->
      util.DIR_DOWN