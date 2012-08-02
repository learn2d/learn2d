define [
  'cs!level-renderer'
  'cs!ani-renderer'
  'cs!viewport'
], ->
  LevelRenderer = require 'level-renderer'
  AniRenderer = require 'ani-renderer'
  Viewport = require 'viewport'

  class SceneRenderer
    constructor: (@sceneGraph, @loader, @context) ->
      @levelRenderer = new LevelRenderer(@loader, @context, @viewport)
      @aniRenderer = new AniRenderer(@loader, @context)
      @viewport = new Viewport()

    render: (timeDelta) ->
      player = @sceneGraph.getPlayer()
      @viewport.setPlayer player

      level = @sceneGraph.getPlayerLevel()
      return unless level.getLevelData()

      @levelRenderer.render(level, "background")

      entities = @sceneGraph.getEntities()
      for entity in entities
        continue unless entity.isVisible()

        getAnis = entity.components.ani?.getAnis

        if typeof getAnis is 'function'
          anis = getAnis()
          for ani in anis
            @aniRenderer.render(ani)
            
      @levelRenderer.render(level, "foreground")

