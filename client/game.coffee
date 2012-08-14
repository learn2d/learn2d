define [
  'flywheel'
  'cs!scene-graph'
  'cs!scene-renderer'
  'cs!input'
  'cs!scripting-engine'
  'cs!viewport'
], ->
  flywheel = require 'flywheel'
  SceneGraph = require 'scene-graph'
  SceneRenderer = require 'scene-renderer'
  ScriptingEngine = require 'scripting-engine'
  Input = require 'input'
  Viewport = require 'viewport'

  class Game
    constructor: (@loader, @context, @network) ->
      @fw = flywheel @loop, @context.canvas
      @timeAccumulator = 0

      @sceneGraph = new SceneGraph(@loader)
      @viewport = new Viewport(@context)
      @sceneRenderer = new SceneRenderer(@sceneGraph, @loader, @context, @viewport)

      @input = new Input(@context, @viewport)
      @scriptingEngine = new ScriptingEngine(@input, @sceneGraph, @network)

    start: ->
      @network.start(this)
      @fw.start()

    loop: (timeDelta) =>
      @timeAccumulator += timeDelta
      targetDelta = 50

      while @timeAccumulator >= targetDelta
        @timeAccumulator -= targetDelta

        # Handle input here
        @input.loop()

        # Run scripts here
        @scriptingEngine.loop(targetDelta)

        # Render scene
        @sceneRenderer.render(targetDelta)

        # Check for warps
        @handleWarps()

    handleWarps: ->
      levelData = @sceneGraph.getPlayerLevel()?.getLevelData()
      return unless levelData

      player = @sceneGraph.getPlayer()
      playerX = player.getX()
      playerY = player.getY()
      keepVal = 500

      for warp in levelData.warpData
        unless warp.x <= playerX + 32
          continue
        unless warp.x + warp.width >= playerX
          continue
        unless warp.y <= playerY + 32
          continue
        unless warp.y + warp.height >= playerY
          continue

        if warp.destX == keepVal
          player.setX(playerX)
        else
          player.setX(warp.destX)
        if warp.destY == keepVal
          player.setY(playerY)
        else
          player.setY(warp.destY)

        @sceneGraph.reset
          levelName: warp.destLevelName
          entities: [player]
        @sceneGraph.setPlayerById player.id

        @network.sendLevelName {id: player.id, lvl: warp.destLevelName}
        
    reset: (data) ->
      @sceneGraph.reset
        levelName: data.level
        entities: data.entities
