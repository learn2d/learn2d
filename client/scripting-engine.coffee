define [
  'cs!modules/default/system'
  'cs!trigger'
], ->
  Trigger = require 'trigger'
  modules = {}
  modules.System = require 'cs!modules/default/system'

  class ScriptingEngine
    constructor: (@input, @sceneGraph, @network) ->
      @reset()

      @trigger = new Trigger(@network)

      @moduleList = []
      @moduleList.push new modules.System
        trigger: @trigger

      for module in @moduleList
        @addClientModule(module)

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

    reset: ->
      @mouseDown = false
      @keyDown = {}
      @mouseDownListeners = []
      @keyDownListeners = []

    callMouseDownListeners: ->
      for listener in @mouseDownListeners
        listener.call(
          null,
          x: @input.getMouseX()
          y: @input.getMouseY()
        )
