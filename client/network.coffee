define ->
  class Network
    constructor: () ->
    start: (@game) ->
      @socket = io.connect 'http://localhost:3001'
      @socket.on 'connect', (data) ->
      @socket.on 'reset', (data) =>
        console.log 'clear game'
        console.log(data)
        @game.reset(data)

    on: (eventName, callback) ->
      @socket.on eventName, callback
    emit: (eventName, params) ->
      @socket.emit eventName, params