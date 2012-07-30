Level = require './level'

class SceneGraph
  constructor: ->
    @entities = []
    @level = new Level('test')

  addEntity: (entity) ->
    @entities.push entity

  getEntities: ->
    @entities

  setLevel: (level) ->
    @level = level
  getLevel: ->
    @level

module.exports = SceneGraph