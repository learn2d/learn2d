define [
  'cs!ani'
  'cs!util'
], ->
  Ani = require 'ani'
  util = require 'util'

  class AniComponent
    constructor: (@entity) ->
      @anis = [
      ]

    getAnis: =>
      @anis

  class Entity
    constructor: ({@x, @y, @aniName, @direction, @id, @visible, @test}) ->
      @ani = new Ani
        entity: this
        x: -8
        y: -32

      console.log "#{@toString()} created"

    getTest: ->
      @test

    getX: ->
      @x
    
    setX: (x) ->
      @x = x

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

    isVisible: ->
      @visible

    toString: ->
      "[Entity:#{@id}]"
