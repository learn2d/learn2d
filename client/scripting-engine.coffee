define [
  'cs!module-system'
  'cs!trigger'
], ->
  ModuleSystem = require 'cs!module-system'

  class ScriptingEngine
    constructor: (@input, @sceneGraph) ->
      @mouseDown = false
      @keyDown = {}
      @mouseDownListeners = []
      @keyDownListeners = []

      @moduleList = []
      @moduleList.push new ModuleSystem()

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

    callMouseDownListeners: ->
      for listener in @mouseDownListeners
        listener.call(
          null,
          x: @input.getMouseX()
          y: @input.getMouseY()
        )
