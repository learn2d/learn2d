define [
  'flywheel'
  'cs!scene-graph'
  'cs!scene-renderer'
], ->
  flywheel = require 'flywheel'
  SceneGraph = require 'scene-graph'
  SceneRenderer = require 'scene-renderer'

  class Game
    constructor: (@loader, @context) ->
      @fw = flywheel @loop, @context.canvas

      @sceneGraph = new SceneGraph()
      @sceneRenderer = new SceneRenderer(@sceneGraph, @loader, @context)

    start: ->
      @fw.start()

    draw: ->
      @sceneRenderer.render()

    loop: (timeDelta) =>
      # TODO: handle input here

      # TODO: run scripts here

      # TODO: handle network updates here

      # Render all cameras
      @draw()