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
      @sceneGraph.addEntity entity
      @grantControl socket, entity

  resetClient: (socket) ->
    entity = @control[socket.id]

    level = @sceneGraph.getLevel()

    socket.emit 'reset',
      level: level.getName()
      entities: @sceneGraph.getEntities()

    console.log "informing client control of entity: #{entity.id}"
    socket.emit 'controlEntity',
      id: entity.id

  entityAdded: (entity) ->
    console.log 'entity added?'
    for own id, socket of @clients
      console.log entity
      socket.emit 'entityAdded', entity

  grantControl: (socket, entity) ->
    @control[socket.id] = entity


module.exports = Game