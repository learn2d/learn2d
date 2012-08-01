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
    constructor: ({@x, @y, @aniName, @direction, @id, @visible}) ->
      @components = {}
      @components.ani = new AniComponent(this)

      console.log "#{@toString()} created"

    getX: ->
      @x

    getY: ->
      @y

    getAniName: ->
      @aniName

    setAniName: (aniName) ->
      @aniName = aniName

    getDirection: ->
      @direction

    setDirection: (direction) ->
      @direction = direction

    isVisible: ->
      @visible

    toString: ->
      "[Entity:#{@id}]"