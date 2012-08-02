define [
  'cs!util'
], ->
  util = require 'util'

  class Ani
    constructor: ({@entity, @x, @y}) ->
      @lastFrame = 0
      @nextTime = new Date().getTime()
      @files = @entity.getTest()#["LM_Female/examples/royal_mage.png"]

    getDirection: ->
      @entity.getDirection()

    getX: ->
      @entity.getX() + @x

    getY: ->
      @entity.getY() + @y

    getName: ->
      @entity.getAniName()

    getFiles: ->
      @files

    getLastFrame: ->
      @lastFrame
    setLastFrame: (frameNum) ->
      @lastFrame = frameNum