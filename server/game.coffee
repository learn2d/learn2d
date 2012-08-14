Entity = require './entity'
SceneGraph = require './scene-graph'

class Game
  constructor: ->
    @clients = {}
    @control = {}

    @sceneGraph = new SceneGraph(this)
    @defaultEntity = new Entity
      level: 'default'
      aniName: 'invisible'
      visible: false
      x: 300
      y: 300
      type: 'default'
    data = 
      ent: @defaultEntity
      levelinfo:
        newlevel: "default"
    @sceneGraph.addEntity data

  addClient: (socket) ->
    # save socket variable
    @clients[socket.id] = socket

    # grant control of default entity
    @grantControl socket, @defaultEntity

    # reset client to valid state
    @resetClient socket

    # events from client
    socket.on 'trigger', ({target, action, params}) =>
      entity = new Entity
        x: params.x
        y: params.y
        type: 'player'
      data = 
        ent: entity
        levelinfo:
          oldlevel: "default"
          newlevel: "default"
      @sceneGraph.addEntity data

      @grantControl socket, entity
      @resetClient socket

    socket.on 'updateLevelInfo', (data) =>
      @sceneGraph.addEntity data
      console.log data.levelinfo.oldlevel
      console.log data.levelinfo.newlevel
      console.log data.ent.id
      console.log "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      @sceneGraph.removeEntity data #BROKEN
      
      console.log @sceneGraph.entities
      console.log socket.id
      console.log socket.id
      console.log data.ent.id
      console.log data.ent
      console.log "Orange you glad I didn't say banana again?"
      #@grantControl socket, data.ent
      socket.emit 'reset',
        level: data.levelinfo.newlevel
        entities: @sceneGraph.getEntities data.levelinfo.newlevel
      socket.emit 'controlEntity',
        id: data.ent.id
        type: data.ent.type

      socket.broadcast.emit 'updateLevelInfo', (data)

    socket.on 'playerUpdates', ({id, x, y, direction, aniName}) =>
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

      if aniName is 'female-slash'
        console.log 'we got slashing'

      # broadcast updates to clients in level
      socket.broadcast.emit 'playerUpdates',
        id: id
        x: x
        y: y
        direction: direction
        aniName: aniName

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
      console.log data.ent
      socket.emit 'entityAdded', (data)

  grantControl: (socket, entity) ->
    console.log socket.id
    console.log socket.id
    console.log entity
    console.log "TOASTED BANANAS!"
    @control[socket.id] = entity


module.exports = Game
