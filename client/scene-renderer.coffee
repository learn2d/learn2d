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

      entities = @sceneGraph.getEntities()
      for entity in entities
        console.log 'we found an entity'
        getAnis = entity.components.ani?.getAnis

        if typeof getAnis is 'function'
          anis = getAnis()
          for ani in anis
            @aniRenderer.render(ani)