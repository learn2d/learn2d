Level = require './level'

class SceneGraph
  constructor: (@game) ->
    @entities = {}
    @level = new Level('default')

  addEntity: (entity) ->
    if @level?
      levelName = @level.getName()
      if not @entities.hasOwnProperty levelName
        @entities[levelName] = []
      @entities[levelName].push entity
      @game.entityAdded(entity)

  getEntities: (levelName) ->
    console.log "Bubbly toast"
    console.log "Bubbly toast"
    console.log levelName = @level.getName()
    console.log @entities["default"].length
    @entities[levelName]
    
  getEntityById: (id) ->
    for key of @entities
      if @entities[key]? and @entities[key].length?
        for entity in @entities[key]
          if (entity.id is id)
            return entity
              
    undefined

  setLevel: (level) ->
    @level = level
  getLevel: ->
    @level

module.exports = SceneGraph
