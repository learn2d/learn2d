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
        console.log data
        @game.reset(data)

      @socket.on 'entityAdded', (data) =>
        @game.sceneGraph.addEntityFromData data.ent

      @socket.on 'setPlayerById', (id) =>
        console.log "RESETTING PLAYER BY ID" 
        console.log id
        console.log "Entities:"
        console.log @game.sceneGraph.entities
        @game.sceneGraph.setPlayerById id

      @socket.on 'updateLevelInfo', (data) =>
        levelName = @game.sceneGraph.getPlayerLevel().name
        console.log levelName
        console.log data.levelinfo.oldlevel 
        console.log data.levelinfo.newlevel 
        console.log "UpdatingLevelInformation... Set us up the bomb!"
        if data.levelinfo.oldlevel == levelName
          console.log "Updating to remove"
          @game.sceneGraph.removeEntity data.ent.id
          return undefined
        if data.levelinfo.newlevel == levelName
          console.log "Updating to add"
          @game.sceneGraph.addEntityFromData data.ent
          console.log "Entity added? " + @game.sceneGraph.entities.length
        else
          @game.sceneGraph.removeEntity data.ent.id
          @game.sceneGraph.removeEntity data.ent.id
         
        console.log "End up warp"
        undefined

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

    playerWarped: (data) ->
      @socket.emit "updateLevelInfo", data

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

      updates.levelName = @game.sceneGraph.getPlayerLevel().name

      if updatesNeeded
        updates.id = player.id
        @socket.emit 'playerUpdates', updates

      undefined
