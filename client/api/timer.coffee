define ->
  class Timer
    constructor: () ->
      @milliseconds = 0

    get: ->
      @milliseconds

    set: (@milliseconds) ->