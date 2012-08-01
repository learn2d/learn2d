define [
  'flywheel'
  'cs!scene-graph'
  'cs!scene-renderer'
  'cs!input'
  'cs!scripting-engine'
], ->
  flywheel = require 'flywheel'
  SceneGraph = require 'scene-graph'
  SceneRenderer = require 'scene-renderer'
  ScriptingEngine = require 'scripting-engine'
  Input = require 'input'

  class Game
    constructor: (@loader, @context, @network) ->
      @fw = flywheel @loop, @context.canvas
      @timeAccumulator = 0

      @sceneGraph = new SceneGraph(@loader)
      @sceneRenderer = new SceneRenderer(@sceneGraph, @loader, @context)

      @input = new Input(@context)
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

    reset: (data) ->
      @sceneGraph.reset
        levelName: data.level
        entities: data.entities