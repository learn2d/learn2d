define [
  'cs!util'
], ->
  util = require 'util'

  class Ani
    constructor: ({@entity, @x, @y}) ->
      @lastFrame = 0
      @nextTime = new Date().getTime()
      @delay = 20
      @SpriteList = @entity.getSpriteList()
      @health = @entity.getHealth()

    getDirection: ->
      @entity.getDirection()

    getX: ->
      @entity.getX() + @x

    getY: ->
      @entity.getY() + @y

    getName: ->
      @entity.getAniName()

    getHealth: ->
      @health

    getSpriteList: ->
      @SpriteList

    getLastFrame: ->
      @lastFrame
    setLastFrame: (frameNum) ->
      @lastFrame = frameNum
