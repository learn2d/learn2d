Entity = require './../entity'

class Slash
  constructor: (@game, @sceneGraph) ->
    console.log "Slashing Initiated!"

  inSquare: (data) ->
    ent = data.ent
    square = data.square

    if square.x < ent.x and ent.x < square.x + square.length
      if square.y < ent.y and ent.y < square.y + square.length
        console.log "HEALTH CHANGED  ****************"
        return true
    undefined

  meleeAction: (data) ->
    socket = data.socket
    levelname = @game.sceneGraph.getLevelNameById data.id
    entities = @game.sceneGraph.getEntities levelname

    console.log data.params

    dir = data.params.direction
    buffer = data.params.buffer
    reach = data.params.reach

    square = {}
    square.x = data.params.x
    square.y = data.params.y 
    square.length = reach

    console.log square

    if dir == 0
      square.y -= (buffer + reach)
      square.x -= Math.floor reach/2
    else if dir == 1
      square.x -= (buffer + reach)
      square.y -= Math.floor reach/2
    else if dir == 2
      square.y += (buffer)
      square.x -= Math.floor reach/2
    else if dir == 3 # only buffers
      square.x += (buffer)
      square.y -= Math.floor reach/2

    console.log square

    updates = []
    for entity in entities
      console.log entity.x + " " + entity.y

      if @inSquare({ent: entity, square: square})
        entity.setHealth(data.params.health)
        update =
          id: entity.id
          health: entity.getHealth()
        console.log update
        updates.push update

    if updates.length != 0
      socket.emit 'healthChanged', (updates)
      socket.broadcast.emit 'healthChanged', (updates)

module.exports = Slash
