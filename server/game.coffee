Player = require './player'
SceneGraph = require './scene-graph'

class Game
  constructor: ->
    @clients = {}

    @sceneGraph = new SceneGraph()

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


module.exports = Game