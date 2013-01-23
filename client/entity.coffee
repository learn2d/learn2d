define [
  'cs!ani'
  'cs!util'
], ->
  Ani = require 'ani'
  util = require 'util'

  class Entity
    constructor: ({@x, @y, @aniName, @direction, @id, @visible, @SpriteList, @health}) ->
      @ani = new Ani
        entity: this
        x: -8
        y: -32

      @renderedFrames = {}

      console.log "#{@toString()} created"

    getSpriteList: ->
      @SpriteList

    getHealth: ->
      @health
      
    setHealth: (newHealth)->
      @health = newHealth

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
