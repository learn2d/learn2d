define ->
  class Timer
    constructor: () ->
      Object.defineProperty this, 'delay',
        get: @getDelay
        set: @setDelay
        enumerable: true
        configurable: false

    getDelay: ->
      @seconds

    setDelay: (@seconds) ->