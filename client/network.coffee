define ->
  class Network
    constructor: ->

    start: (@game) ->
      @socket = io.connect "#{document.location.protocol}//#{location.hostname}"

      @socket.on 'connect', (data) ->
        console.log 'socket connected'

      @socket.on 'disconnect', (data) ->
        console.log 'socket disconnected'

      @socket.on 'reset', (data) =>
        @game.reset(data)

      @socket.on 'entityAdded', (data) =>
        @game.sceneGraph.addEntityFromData data.ent

      @socket.on 'setPlayerById', (id) =>
        @game.sceneGraph.setPlayerById id

      @socket.on 'updateLevelInfo', (data) =>

        levelName = @game.sceneGraph.getPlayerLevel().name

        if data.levelinfo.newlevel == levelName
          @game.sceneGraph.addEntityFromData data.ent
          return undefined
        if data.levelinfo.oldlevel == levelName
          @game.sceneGraph.removeEntity data.ent.id
         
        undefined

      @socket.on 'healthChanged', (data) =>
        for ent in data
          entity = @game.sceneGraph.getEntityById ent.id
          unless entity
            return
            # @TODO: re-add this once we are compliant
            #throw new Error "Entity on Another Map: #{data.id}"
          console.log ent
          entity.setHealth(ent.health) if ent.health?
          console.log entity.getHealth()


      @socket.on 'playerUpdates', (data) =>
        entity = @game.sceneGraph.getEntityById data.id
        unless entity
            return
            # @TODO: re-add this once we are compliant
            #throw new Error "Entity on Another Map: #{data.id}"

        entity.setX(data.x) if data.x?
        entity.setY(data.y) if data.y?
        entity.setDirection(data.direction) if data.direction?
        entity.setAniName(data.aniName) if data.aniName?
        entity.setHealth(data.health - entity.getHealth()) if data.health?

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
        health: player.getHealth()

    afterScripting: (player) ->
      oldCache = @playerCache
      @playerCache =
        x: player.getX()
        y: player.getY()
        direction: player.getDirection()
        aniName: player.getAniName()
        health: player.getHealth()

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
