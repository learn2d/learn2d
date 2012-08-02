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

    reset: (data) ->
      @sceneGraph.reset
        levelName: data.level
        entities: data.entities