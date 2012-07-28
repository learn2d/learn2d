define [
  'flywheel',
  'cs!level-renderer',
  'cs!scene-graph'
], ->
  flywheel = require 'flywheel'
  LevelRenderer = require 'level-renderer'
  SceneGraph = require 'scene-graph'

  class Game
    constructor: (@loader, @context) ->
      @fw = flywheel @loop, @context.canvas
      @levelRenderer = new LevelRenderer(@loader, @context)

      @sceneGraph = new SceneGraph()

    init: ->
      @fw.start()

    draw: ->
      @levelRenderer.draw()

    loop: (timeDelta) =>
      # TODO: handle input here

      # TODO: run scripts here

      # TODO: handle network updates here

      # Render all cameras
      @draw()