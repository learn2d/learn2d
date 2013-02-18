Entity = require './entity'
SceneGraph = require './scene-graph'
System = require './modules/system'
Slash = require './modules/slash'

class Game
  constructor: ->
    @clients = {}
    @control = {}

    @modules = {}

    @sceneGraph = new SceneGraph(this)
    @modules.system = new System(this)
    @modules.slash = new Slash(this)
    @defaultEntity = new Entity
      level: 'fields5'
      aniName: 'invisible'
      visible: false
      x: 300
      y: 300
      type: 'default'
    data = 
      ent: @defaultEntity
      levelinfo:
        oldlevel: null
        newlevel: "fields5"
    @sceneGraph.addEntity data
    @entityAdded data

  addClient: (socket) ->
    # save socket variable
    @clients[socket.id] = socket

    # grant control of default entity
    @grantControl socket, @defaultEntity

    # reset client to valid state
    @resetClient socket

    # events from client
    socket.on 'trigger', ({target, action, params}) =>
      data = 
        params: params
        id: @control[socket.id].id
        socket: socket
      
      @modules[target][action] data

    socket.on 'updateLevelInfo', (data) =>
      entity = new Entity
        SpriteList: data.ent.SpriteList
        health: data.ent.health
        x: data.ent.x
        y: data.ent.y
        type: 'player'
        id: data.ent.id
        direction: data.ent.direction

      @sceneGraph.removeEntity data
      data.ent = entity
      @sceneGraph.addEntity data

      info =
          level: data.levelinfo.newlevel
          entities: @sceneGraph.getEntities data.levelinfo.newlevel
          
      socket.emit 'reset', (info)
      socket.emit 'setPlayerById', (data.ent.id)

      socket.broadcast.emit 'updateLevelInfo', (data)


    socket.on 'playerUpdates', ({id, x, y, direction, aniName, health}) =>
      # find player by id
      player = @sceneGraph.getEntityById id
      unless player
        console.log "Update attempted on invalid entity ID: #{id}"
        return

      # update all attributes
      player.setX(x) if x?
      player.setY(y) if y?
      player.setDirection(direction) if direction?
      player.setAniName(aniName) if aniName?
      player.setHealth(health) if health?

      if aniName is 'female-slash'
        console.log 'we got slashing'

      # broadcast updates to clients in level
      socket.broadcast.emit 'playerUpdates',
        id: id
        x: x
        y: y
        direction: direction
        aniName: aniName
        health: health

  resetClient: (socket) ->
    entity = @control[socket.id]

    level = @sceneGraph.getLevel()

    socket.emit 'reset',
      level: level.getName()
      entities: @sceneGraph.getEntities level.getName()

    console.log "informing client control of entity: #{entity.id}"
    socket.emit 'controlEntity',
      id: entity.id
      type: entity.type

  entityAdded: (data) ->
    console.log 'entity added?'
    for own id, socket of @clients
      socket.emit 'updateLevelInfo', (data)

  grantControl: (socket, entity) ->
    @control[socket.id] = entity


module.exports = Game
