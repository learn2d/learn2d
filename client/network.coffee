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

      @socket.on 'playerUpdates', (data) =>
        entity = @game.sceneGraph.getEntityById data.id
        unless entity
          throw new Error "Server updated weird entity ID: #{data.id}"

        entity.setX(data.x) if data.x?
        entity.setY(data.y) if data.y?
        entity.setDirection(data.direction) if data.direction?
        entity.setAniName(data.aniName) if data.aniName?

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

      updates = {}
      updatesNeeded = false

      for key, val of @playerCache
        if @playerCache[key] isnt oldCache[key]
          updatesNeeded = true
          updates[key] = val

      if updatesNeeded
        updates.id = player.id
        @socket.emit 'playerUpdates', updates

      undefined