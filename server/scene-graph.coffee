Level = require './level'

class SceneGraph
  constructor: (@game) ->
    @entities = {}
    @sockets = {}
    @level = new Level('fields5')

  addEntity: (data) ->
    entity = data.ent
    levelName = data.levelinfo.newlevel
    if not @entities.hasOwnProperty levelName
      @entities[levelName] = []
    @entities[levelName].push entity
  
  removeEntity: (data) ->
    entity = data.ent
    levelName = data.levelinfo.oldlevel
    index = @getEntityIndex entity.id, levelName
    @entities[levelName].splice(index,1)
    
    undefined

  getEntityIndex: (id, levelName) ->
    for checkid, i in @entities[levelName]
      if id == @entities[levelName][i].id
        return i
        
    undefined

  getEntities: (levelName) ->
    @entities[levelName]

  getLevelNameById: (id) ->
    for key of @entities
      if @entities[key]? and @entities[key].length?
        for entity in @entities[key]
          if (entity.id is id)
            return key
              
    undefined    

  getEntityByLevelName: (data) ->
    for entity in @entities[data.levelName]
      if data.id == entity.id
        return entity
        
    undefined      

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
