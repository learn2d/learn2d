define [
  'cs!trigger'

  'cs!modules/default/system'
], ->
  Trigger = require 'trigger'
  modules = {}

  modules.default =
    System: require 'cs!modules/default/system'

  class ScriptingEngine
    constructor: (@input, @sceneGraph, @network) ->
      @trigger = new Trigger(@network)

    addClientModule: (module) ->
      if typeof module.onMouseDown is 'function'
        @mouseDownListeners.push module.onMouseDown.bind(module)

    loop: (timeDelta) ->
      if @input.isMouseDown()
        if not @mouseDown
          @mouseDown = true
          @callMouseDownListeners()
      else
        @mouseDown = false

    reset: (type) ->
      @mouseDown = false
      @keyDown = {}
      @mouseDownListeners = []
      @keyDownListeners = []

      @moduleList = []
      for key, Module of modules[type]
        @moduleList.push new Module
          trigger: @trigger

      for module in @moduleList
        @addClientModule(module)

    callMouseDownListeners: ->
      for listener in @mouseDownListeners
        listener.call(
          null,
          x: @input.getMouseX()
          y: @input.getMouseY()
        )
