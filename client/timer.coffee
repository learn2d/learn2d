define ->
  class Timer
    constructor: ->
      @reset()

    reset: ->
      @timerDelays = {}
      @moduleId = undefined

    timerCheck: (module, callback) ->
      @setModule module
      callback()

    setModule: (module) ->
      @moduleId = module.id

    getSeconds: ->
      throw new Error 'Getting timer without active module' unless @moduleId

      return 0 unless @timerDelays[@moduleId] isnt undefined

      @timerDelays[@moduleId]

    setSeconds: (seconds) ->
      throw new Error 'Setting timer without active module' unless @moduleId

      @timerDelays[@moduleId] = seconds