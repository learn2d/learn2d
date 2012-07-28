define [
  'cs!level'
  'cs!ani'
], ->
  Level = require 'level'
  Ani = require 'ani'

  class SceneGraph
    constructor: () ->
      @level = new Level('test')
      @ani = new Ani()

    getLevel: () ->
      @level

    getAni: ->
      @ani