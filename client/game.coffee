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

      @sceneGraph = new SceneGraph()
      @sceneRenderer = new SceneRenderer(@sceneGraph, @loader, @context)

      @input = new Input(@context)
      @scriptingEngine = new ScriptingEngine(@input, @sceneGraph, @network)

    start: ->
      @network.start(this)
      @fw.start()

    loop: (timeDelta) =>
      # Handle input here
      @input.loop()

      player = @sceneGraph.getPlayer()

      # Networking
      @network.beforeScripting player

      # Run scripts here
      @scriptingEngine.loop(timeDelta)

      # Networking
      @network.afterScripting player

      # Render scene
      @sceneRenderer.render(timeDelta)

    reset: (data) ->
      @sceneGraph.reset(data)