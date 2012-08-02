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
    @sceneGraph.addEntity @defaultEntity

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
      @sceneGraph.addEntity entity

      @grantControl socket, entity
      @resetClient socket

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
      entities: @sceneGraph.getEntities()

    console.log "informing client control of entity: #{entity.id}"
    socket.emit 'controlEntity',
      id: entity.id
      type: entity.type

  entityAdded: (entity) ->
    console.log 'entity added?'
    for own id, socket of @clients
      console.log entity
      socket.emit 'entityAdded', entity

  grantControl: (socket, entity) ->
    @control[socket.id] = entity


module.exports = Game
