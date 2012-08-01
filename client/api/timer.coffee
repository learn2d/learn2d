define ->
  class Timer
    constructor: (@timer) ->
      Object.defineProperty this, 'delay',
        get: @getDelay
        set: @setDelay
        enumerable: true
        configurable: false

    getDelay: ->
      @timer.getSeconds()

    setDelay: (seconds) ->
      @timer.setSeconds(seconds)