define ->
  class Network
    constructor: ->

    start: (@game) ->
      @socket = io.connect 'http://localhost:3001'
      @socket.on 'connect', (data) ->
        console.log 'socket connected'
      @socket.on 'disconnect', (data) ->
        console.log 'socket disconnected'
      @socket.on 'reset', (data) =>
        @game.reset(data)
      @socket.on 'entityAdded', (data) =>
        @game.sceneGraph.addEntityFromData data
      @socket.on 'controlEntity', (data) =>
        @game.sceneGraph.setPlayerById data.id
        console.log "Server granted control of entity: #{data.id}"
        @game.scriptingEngine.reset(data.type)

    on: (eventName, callback) ->
      @socket.on eventName, callback
    emit: (eventName, params) ->
      @socket.emit eventName, params

    beforeScripting: (player) ->
      @playerCache =
        x: player.getX()
        y: player.getY()
        direction: player.getDirection()
        aniName: player.getAniName()

    afterScripting: (player) ->
      oldCache = @playerCache
      @playerCache =
        x: player.getX()
        y: player.getY()
        direction: player.getDirection()
        aniName: player.getAniName()

      for key, val of @playerCache
        if @playerCache[key] isnt oldCache[key]
          console.log 'need to update:'
          console.log key
          console.log val

      undefined