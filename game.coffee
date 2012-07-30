class Game
  constructor: ->
    @clients = {}
  addClient: (socket) ->
    console.log 'adding client'
    @clients[socket.id] = socket
    socket.emit 'reset',
      level: 'test'

module.exports = Game