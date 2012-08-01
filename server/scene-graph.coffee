Level = require './level'

class SceneGraph
  constructor: (@game) ->
    @entities = []
    @level = new Level('default')

  addEntity: (entity) ->
    @entities.push entity
    @game.entityAdded(entity)

  getEntities: ->
    @entities

  getEntityById: (id) ->
    for entity in @entities
      if entity.id is id
        return entity

    undefined

  setLevel: (level) ->
    @level = level
  getLevel: ->
    @level

module.exports = SceneGraph