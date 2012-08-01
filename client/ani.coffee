define [
  'cs!util'
], ->
  util = require 'util'

  class Ani
    constructor: ({@entity, @x, @y}) ->
      @lastFrame = 0
      @nextTime = new Date().getTime()
      @delay = 20
      @files = ["fantasy/spells/explosion_poison.png"]

    getDirection: ->
      @entity.getDirection()

    getX: ->
      @entity.getX() + @x

    getY: ->
      @entity.getY() + @y

    getName: ->
      @entity.getAniName()

    getDelay: ->
      @delay

    getFiles: ->
      @files

    getLastFrame: ->
      @lastFrame
    setLastFrame: (frameNum) ->
      @lastFrame = frameNum

    getNextTime: ->
      @nextTime
    setNextTime: () ->
      @nextTime = new Date().getTime() + @delay
