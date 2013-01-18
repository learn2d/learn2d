define [
  'cs!level-renderer'
  'cs!ani-renderer'
], ->
  LevelRenderer = require 'level-renderer'
  AniRenderer = require 'ani-renderer'

  class SceneRenderer
    constructor: (@sceneGraph, @loader, @context, @viewport) ->
      @levelRenderer = new LevelRenderer(@loader, @context, @viewport)
      @aniRenderer = new AniRenderer(@loader, @context, @viewport)

    render: (timeDelta) ->
      level = @sceneGraph.getPlayerLevel()
      return if level is null
      return unless level.getLevelData()

      player = @sceneGraph.getPlayer()
      @viewport.setPlayer player
      @viewport.setLevel level

      @levelRenderer.renderLayers(level, "collisions")
      @levelRenderer.renderLayers(level, "background")

      entities = @sceneGraph.getEntities().sort (a, b) ->
        a.y - b.y
      
      for entity in entities
        continue unless entity.visible
        
        @aniRenderer.render(entity.ani, entity.getHealth())
            
      @levelRenderer.renderLayers(level, "foreground")

