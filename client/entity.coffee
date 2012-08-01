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
          x: -32
          y: -60
      ]
    getAnis: =>
      @anis

  class Entity
    constructor: ({@x, @y, @aniName, @direction, @id}) ->
      @components = {}
      @components.ani = new AniComponent(this)

      console.log @toString()

    getX: ->
      @x

    getY: ->
      @y

    getAniName: ->
      @aniName

    getDirection: ->
      @direction

    toString: ->
      "[Entity:#{@id}]"