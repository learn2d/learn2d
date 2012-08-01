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

    render: (timeDelta) ->
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

