define ->
  class Network
    constructor: () ->
    start: (@game) ->
      @socket = io.connect 'http://localhost:3001'
      @socket.on 'connect', (data) ->
      @socket.on 'reset', (data) =>
        @game.reset(data)
      @socket.on 'entityAdded', (data) =>
        console.log 'entity added'
        console.log data
        @game.sceneGraph.addEntityFromData data

    on: (eventName, callback) ->
      @socket.on eventName, callback
    emit: (eventName, params) ->
      @socket.emit eventName, params