define [
  'cs!util'
], ->
  util = require 'util'

  class Ani
    constructor: ({@entity, @x, @y}) ->
      @isAnimating = 1
      @lastFrame = 0
      @nextTime = new Date().getTime()
      @delay = 50

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

    getLastFrame: ->
      @lastFrame
    setLastFrame: (frameNum) ->
      @lastFrame = frameNum

    getNextTime: ->
      @nextTime
    setNextTime: () ->
      @nextTime = new Date().getTime() + @delay

    getIsAnimating: ->
      @isAnimating
    setIsAnimating: (isAnimating) ->
      @isAnimating = isAnimating

