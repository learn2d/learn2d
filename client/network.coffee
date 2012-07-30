define ->
  class Network
    constructor: () ->
      @socket = io.connect 'http://localhost:3001'
      @socket.on 'connect', (data) ->
        console.log 'connected'
        console.log data