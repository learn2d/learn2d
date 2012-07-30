define [
  'cs!level'
  'cs!ani'
], ->
  Level = require 'level'
  Ani = require 'ani'

  class SceneGraph
    constructor: () ->
      @reset {}

    getLevel: () ->
      @level

    getAni: ->
      @ani

    moveAni: (x, y) ->
      @ani.setXpos(x)
      @ani.setYpos(y)

    reset: ({level}) ->
      @players = []
      if level
        @level = new Level(level)
      else
        @level = null