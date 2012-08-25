Entity = require './../entity'

class System
  constructor: (@game) ->
    console.log "System Initiated!"

  createPlayer: (data) ->
    socket = data.socket

    entity = new Entity
      x: data.params.x
      y: data.params.y
      type: 'player'
    data = 
      ent: entity
      levelinfo:
        oldlevel: "default"
        newlevel: "default"
    @game.sceneGraph.addEntity data
    @game.entityAdded data

    @game.grantControl socket, entity
    @game.resetClient socket

module.exports = System