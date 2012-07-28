define [
  'cs!level-renderer'
], ->
  LevelRenderer = require 'level-renderer'

  class SceneRenderer
    constructor: (@sceneGraph, @loader, @context) ->
      level = @sceneGraph.getLevel()
      @levelRenderer = new LevelRenderer(level, @loader, @context)

    render: ->
      @levelRenderer.render()