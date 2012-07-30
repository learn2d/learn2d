Player = require './Player'

class Game
  constructor: ->
    @clients = {}

    @level = 'test'
    @entities = []

  addClient: (socket) ->
    console.log 'adding client'
    @clients[socket.id] = socket
    socket.emit 'reset',
      level: 'test'
      entities: @entities
    socket.on 'trigger', ({target, action, params}) =>
      console.log target
      console.log action
      console.log params

      entity = new Player
        level: @level
        x: params.x
        y: params.y
      @entities.push entity


module.exports = Game