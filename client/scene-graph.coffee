define [
  'cs!level'
  'cs!ani'
  'cs!entity'
  'cs!util'
], ->
  util = require 'util'
  Level = require 'level'
  Ani = require 'ani'
  Entity = require 'entity'

  class SceneGraph
    constructor: ->
      @reset {}

    getPlayer: ->
      @player

    setPlayerById: (id) ->
      @player = @getEntityById id

      throw new Error "Could not set player to #{id}" unless @player

    getLevel: () ->
      @level

    addEntity: (entity) ->
      @entities.push entity
      console.log 'entity added'

    addEntityFromData: (entityData) ->
      entity = new Entity
        x: entityData.x
        y: entityData.y
        aniName: entityData.aniName
        direction: entityData.direction
        id: entityData.id
        visible: entityData.visible
      @addEntity entity

    getEntities: () ->
      @entities

    getEntityById: (id) ->
      for entity in @entities
        if (entity.id is id)
          return entity

      undefined

    reset: ({level, entities}) ->
      @player = undefined
      @entities = []
      if typeof entities is 'object'
        for entityData in entities
          @addEntityFromData entityData

      if level
        @level = new Level(level)
      else
        @level = null