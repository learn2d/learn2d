Entity = require './entity'
SceneGraph = require './scene-graph'

class Game
  constructor: ->
    @clients = {}

    @sceneGraph = new SceneGraph(this)

  addClient: (socket) ->
    @clients[socket.id] = socket
    socket.emit 'reset',
      level: @sceneGraph.getLevel().getName()
      entities: @sceneGraph.getEntities()
    socket.on 'trigger', ({target, action, params}) =>
      entity = new Entity
        level: @sceneGraph.getLevel()
        x: params.x
        y: params.y
      @sceneGraph.addEntity entity
      @grantControl socket, entity

  entityAdded: (entity) ->
    console.log 'entity added?'
    for own id, socket of @clients
      console.log entity
      socket.emit 'entityAdded', entity

  grantControl: (socket, entity) ->
    console.log "granting control of entity: #{entity.id}"
    socket.emit 'controlEntity',
      id: entity.id

module.exports = Game