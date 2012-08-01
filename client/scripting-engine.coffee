define [
  'cs!api/trigger'
  'cs!api/player'
  'cs!api/timer'

  'cs!modules/default/system'

  'cs!modules/player/movement'
], ->
  Trigger = require 'api/trigger'
  Player = require 'api/player'
  Timer = require 'api/timer'

  # all modules loaded up front for now
  modules =
    default:
      System: require 'cs!modules/default/system'
    player:
      Movement: require 'cs!modules/player/movement'

  class ScriptingEngine
    constructor: (@input, @sceneGraph, @network) ->
      @initialized = false

      @triggerApi = new Trigger(@network)
      @playerApi = new Player(@sceneGraph)
      @timerApi = new Timer()

    addClientModule: (module) ->
      if typeof module.onMouseDown is 'function'
        @mouseDownListeners.push (coords) =>
          @timerCheck module, module.onMouseDown.bind(module, coords)

    loop: (timeDelta) ->
      if @initialized
        # Pre-scripting networking
        player = @sceneGraph.getPlayer()

        @network.beforeScripting player

        # Run timers
        oldTimerCallbacks = @timerCallbacks
        @timerCallbacks = []
        for callback in oldTimerCallbacks
          callback()

      if @input.isMouseDown()
        if not @mouseDown
          @mouseDown = true
          @callMouseDownListeners()
      else
        @mouseDown = false

      if @initialized
        # Post-scripting networking
        @network.afterScripting player

    reset: (type) ->
      @initialized = true

      @mouseDownListeners = []
      @keyDownListeners = []

      @timerCallbacks = []

      @moduleList = []
      for key, Module of modules[type]
        @moduleList.push new Module
          trigger: @triggerApi
          player: @playerApi
          timer: @timerApi

      for module in @moduleList
        @addClientModule(module)

    callMouseDownListeners: ->
      for listener in @mouseDownListeners
        listener
          x: @input.getMouseX()
          y: @input.getMouseY()

    timerCheck: (module, callback) ->
      @timerApi.delay = 0
      callback()
      if @timerApi.delay isnt 0
        if typeof module.onTimer is 'function'
          setTimeout @timerCheck.bind(this, module, module.onTimer.bind(module))
          , @timerApi.delay
        @timerApi.delay = 0