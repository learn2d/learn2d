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
      window.sgg = @sceneGraph
      @sceneRenderer = new SceneRenderer(@sceneGraph, @loader, @context)

      @input = new Input(@context)
      @scriptingEngine = new ScriptingEngine(@input, @sceneGraph, @network)

    start: ->
      @network.start(this)
      @fw.start()

    draw: ->
      @sceneRenderer.render()

    loop: (timeDelta) =>
      # TODO: handle input here
      @input.loop()

      # TODO: run scripts here
      @scriptingEngine.loop(timeDelta)

      # TODO: handle network updates here

      # Render all cameras
      @draw()

    reset: (data) ->
      @sceneGraph.reset(data)