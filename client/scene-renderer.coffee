define [
  'cs!level-renderer'
], ->
  LevelRenderer = require 'level-renderer'

  class SceneRenderer
    constructor: (@loader, @context) ->
      @levelRenderer = new LevelRenderer(@loader, @context)

    render: ->
      @levelRenderer.render()