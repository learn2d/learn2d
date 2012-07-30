Player = require './player'
SceneGraph = require './scene-graph'

class Game
  constructor: ->
    @clients = {}

    @sceneGraph = new SceneGraph(this)

  addClient: (socket) ->
    @clients[socket.id] = socket
    socket.emit 'reset',
      level: 'test'
      entities: @sceneGraph.getEntities()
    socket.on 'trigger', ({target, action, params}) =>
      entity = new Player
        level: @sceneGraph.getLevel()
        x: params.x
        y: params.y
      @sceneGraph.addEntity entity

  entityAdded: (entity) ->
    console.log 'entity added?'
    for own id, socket of @clients
      socket.emit 'entityAdded', entity
  

module.exports = Game