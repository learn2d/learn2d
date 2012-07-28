define [
  'cs!level-renderer'
  'cs!ani-renderer'
], ->
  LevelRenderer = require 'level-renderer'
  AniRenderer = require 'ani-renderer'

  class SceneRenderer
    constructor: (@sceneGraph, @loader, @context) ->
      @levelRenderer = new LevelRenderer(@loader, @context)
      @aniRenderer = new AniRenderer(@loader, @context)

    render: ->
      level = @sceneGraph.getLevel()
      @levelRenderer.render(level)

      ani = @sceneGraph.getAni()
      @aniRenderer.render(ani)