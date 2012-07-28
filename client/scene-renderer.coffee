define [
  'cs!level'
  'cs!level-renderer'
], ->
  Level = require 'level'
  LevelRenderer = require 'level-renderer'

  class SceneRenderer
    constructor: (@sceneGraph, @loader, @context) ->
      @level = new Level('test')
      @levelRenderer = new LevelRenderer(@level, @loader, @context)

    render: ->
      @levelRenderer.render()