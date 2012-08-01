define [
  'uuid'

  'cs!util'
  'cs!timer'

  'cs!api/trigger'
  'cs!api/player'
  'cs!api/timer'
  'cs!api/input'

  'cs!modules/default/system'

  'cs!modules/player/movement'

  #'cs!modules/sound/soundblaster'
], ->
  uuid = require 'uuid'

  util = require 'util'
  Timer = require 'timer'

  Trigger = require 'api/trigger'
  Player = require 'api/player'
  TimerApi = require 'api/timer'
  InputApi = require 'api/input'

  # all modules loaded up front for now
  modules =
    default:
      System: require 'cs!modules/default/system'
    player:
      Movement: require 'cs!modules/player/movement'
    #sound:
      #SoundBlaster: require 'cs!modules/sound/soundblaster'
      #soundManager.sounds.aSound.play()
      
  class ScriptingEngine
    constructor: (@input, @sceneGraph, @network) ->
      @initialized = false

      @timer = new Timer()

      @triggerApi = new Trigger(@network)
      @playerApi = new Player(@sceneGraph)
      @timerApi = new TimerApi(@timer)
      @inputApi = new InputApi(@input)

    addClientModule: (module) ->
      if typeof module.onCreated is 'function'
        @timer.timerCheck module, module.onCreated.bind(module)
      if typeof module.onMouseDown is 'function'
        @mouseDownListeners.push (coords) =>
          @timer.timerCheck module, module.onMouseDown.bind(module, coords)

    loop: (timeDelta) ->
      if @initialized
        # Pre-scripting networking
        player = @sceneGraph.getPlayer()

        @network.beforeScripting player

        # process timeouts
        for moduleId, delay of @timer.timerDelays
          delay -= timeDelta
          if delay <= 0
            delete @timer.timerDelays[moduleId]

            module = null

            for moduleElem in @moduleList
              if moduleElem.id is moduleId
                module = moduleElem
                break

            if module isnt null and typeof module.onTimer is 'function'
              @timer.timerCheck.call(@timer, module, module.onTimer.bind(module))
          else
            @timer.timerDelays[moduleId] = delay

      if @input.isMouseDown()
        if not @mouseDown
          @mouseDown = true
          @callMouseDownListeners() if @initialized
      else
        @mouseDown = false

      if @initialized
        # Post-scripting networking
        @network.afterScripting player

    reset: (type) ->
      @initialized = true

      @mouseDownListeners = []
      @keyDownListeners = []

      @timer.reset()

      @moduleList = []
      for key, Module of modules[type]
        scriptModule = new Module
          trigger: @triggerApi
          player: @playerApi
          timer: @timerApi
          util: util
          input: @inputApi
        scriptModule.id = uuid.v1()
        @moduleList.push scriptModule

      for module in @moduleList
        @addClientModule(module)

      undefined

    callMouseDownListeners: ->
      for listener in @mouseDownListeners
        listener
          x: @input.getMouseX()
          y: @input.getMouseY()